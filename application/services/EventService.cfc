/**
* @presideService
*/
component {
	public any function init() {
		return this;
	}

	public query function getAllEventDetails(
		required string listingId
		,        string region    = ""
		,        string category  = ""
	) {

		var filter       = "page.parent_page = :page.parent_page";
		var filterParams = { "page.parent_page"=arguments.listingId }

		if( !isEmpty( arguments.region ) ){
			filter &= " AND region.id IN (:region.id) ";
			filterParams["region.id"] = listToArray( arguments.region );
		}

		if (!isEmpty ( arguments.category ) ){
			filter &= " AND category.id IN (:category.id) ";
			filterParams["category.id"] = listToArray( arguments.category );
		}

		return $getPresideObjectService().selectData(
			filter         = filter
			, groupBy      = "page.id"
			, filterParams = filterParams
			, objectName   = "event_detail"
			, selectFields = [
						"page.id"
					, "page.title"
					, "page.main_content"
					, "category.label as category"
			]
		);
	 }

	public query function getAllEventRegions( string recordId = "" ) {

		var filter = "1=1";

		if( !isEmpty( arguments.recordId ) ){
				filter = { "event_detail.id"=arguments.recordId }
		}

		return $getPresideObjectService().selectData(
			 selectFields = [
				  "region.id"
				, "region.label"
			]
			, objectName   = "event_detail"
			, orderBy      = "region.label asc"
			, filter       = filter
		)
	}

	public query function getAllEventCategories() {
		return $getPresideObjectService().selectData(
				  groupBy      = "category.id"
				, selectFields = [
					"DISTINCT(category.id)"
					, "category.label"
				]
				, objectName   = "event_detail"
				, orderBy      = "category.label asc"
		)
	}

	public query function getFeaturedEvents( required string eventListingPage ) {

		return $getPresideObjectService().selectData(
				selectFields = [
					  "featured_events.id"
					, "featured_events$page.title"
					, "featured_events$page.teaser"
				]
				, objectName = "event_listing"
				, filter     = { "page.id"=arguments.eventListingPage }
		)
	}

	public query function getEventRegionById( required string eventId ) {
		return $getPresideObjectService().selectData(
			  filter       = { event_detail=arguments.eventId }
			, objectName   = "event_detail__join__region"
			, selectFields = [
				  "region.id"
				, "region.label"
			]
			, orderBy      = "sort_order asc"
		)
	}

	public query function getRelatedEventsByRegions(
		  required string regionIds
		, required string eventId ){
			return $getPresideObjectService().selectData(
				  filter       = "event_detail.id != :event_detail.id AND region.id IN (:region.id)"
				, filterParams = {
					  "region.id"       = listToArray( arguments.regionIds )
					, "event_detail.id" = arguments.eventId
				}
				, objectName   = "event_detail"
				, selectFields = [
					  "Distinct( page.id )"
					, "page.title"
				]
			)
		}

	public query function getProgramsByEvent( required string eventId ) {

		return $getPresideObjectService().selectData(
				selectFields = [
					  "program.id"
					, "program.start_time"
					, "program.label as program_label"
				]
				, objectName = "program"
				, filter     = { "program.event_detail"=arguments.eventId }
		)
	}
	public query function getAllEventsWithDate(
		  required date dateNow
		, numeric maxRows = 5
	) {
		return $getPresideObjectService().selectData(

			  objectName   = "event_detail"
			, filter       = "event_detail.start_date >= :event_detail.start_date"
			, filterParams = { "event_detail.start_date" = arguments.dateNow }
			, selectFields = [
				  "event_detail.start_date as start_date"
				, "page.id"
				, "page.title"
			]
			, orderBy       = "start_date ASC"
			, maxRows       = arguments.maxRows
		)
	}
	public boolean function checkBookable( required string eventId ){
		var eventBookableQuery = $getPresideObjectService().selectData(
			  selectFields = [ "bookable" ]
			, objectName   = "event_detail"
			, filter       = "event_detail.id = :event_detail.id"
			, filterParams = { "event_detail.id"=arguments.eventId }
		);
		return eventBookableQuery.bookable
	}
	public numeric function getEventPrice( required string eventId ){
		var eventPriceQuery = $getPresideObjectService().selectData(
			  selectFields = [ "price" ]
			, objectName   = "event_detail"
			, filter       = { "event_detail.id" = arguments.eventId }
		)
		return eventPriceQuery.price
	}
	public struct function saveBooking(
		  required string  firstname
		, required string  lastname
		, required string  email
		, required numeric numberOfSeats
		, required string  session
		,          string  specialRequest
		, required string  event_id
		, required numeric total_price
	) {
		var results = {};
		results.newId  = "";
			try{
				transaction {
					var seatsQuery = $getPresideObjectService().selectData(
						  objectName   = "event_detail"
						, selectFields = [ "seats_allocated", "seats_booked" ]
						, filter       = { "id"=arguments.event_id }
					);

					if ( len ( seatsQuery.seats_allocated ) && len ( seatsQuery.seats_booked ) && ( arguments.numberOfSeats + seatsQuery.seats_booked GT seatsQuery.seats_allocated ) ){
						throw ( message="booking exceed seat allocated" );
					}
					else{
						if ( !len( seatsQuery.seats_booked ) )
						{
							seatsQuery.seats_booked = 0;
						}
						var addSeatsBooked = seatsQuery.seats_booked + arguments.numberOfSeats ;

						$getPresideObjectService().updateData(
							  objectName = "event_detail"
							, filter     = { "id"=arguments.event_id }
							, data       = { "seats_booked"=addSeatsBooked }
						)
					}

					results.newId = $getPresideObjectService().insertData(
						  data = {
							  firstname      = arguments.firstname
							, lastname       = arguments.lastname
							, email          = arguments.email
							, numberOfSeats  = arguments.numberOfSeats
							, session        = arguments.session
							, specialRequest = arguments.specialRequest
							, label          = arguments.firstname & " " & arguments.lastname & " booking on " & dateTimeFormat( now(), "dd mmm yyyy 'at' HH:nn:ss z" )
							, event_detail   = arguments.event_id
							, total_price    = arguments.total_price
						  }
						, insertManyToManyRecords = true
						, objectName              = "event_booking_detail"
					);



					$sendEmail(
						  template = "eventBooking"
						, to       = [ arguments.email ]
						, args     = {
							  firstName      = arguments.firstname
							, lastName       = arguments.lastname
							, numberOfSeats  = arguments.numberOfSeats
							, bookingSession = arguments.session
							, specialRequest = arguments.specialRequest
							, eventId        = arguments.event_id
							, totalPrice     = arguments.total_price
						}
					);
				}

				results.statusCode   = "";
				results.errorMessage = "";

			}catch( e ){
				writeDump(e);abort;
				$raiseError(e);
				results.statusCode   = "ERROR_SAVING";
				results.errorMessage = "Saving error, no email is sent";
			}

		return results
    }
    public query function getBookingList(){

    	return $getPresideObjectService().selectData(
    		  objectName   = "event_booking_detail"
    		, selectFields = [
    			  "event_booking_detail.label as booking_label"
    			, "event_detail$page.title as event_name"
    			, "firstname"
    			, "lastname"
    			, "email"
    			, "numberOfSeats"
    			, "session.label as session_label"
    			, "specialRequest"
    		]
    		, orderBy      = "dateCreated"
    	)
    }
}
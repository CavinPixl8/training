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
		var bookableQuery = $getPresideObjectService().selectData(
			  selectFields = [ "bookable" ]
			, objectName   = "event_detail"
			, filter       = "event_detail.id = :event_detail.id"
			, filterParams = { "event_detail.id"=arguments.eventId }
		);
		return bookableQuery.bookable
	}
	public string function saveBooking(
		  required string firstname
		, required string lastname
		, required string email
		, required string numberOfSeats
		, required string session
		, required string specialRequest
	) {

		return $getPresideObjectService().insertData(
			  data = {
				  firstname      = arguments.firstname
				, lastname       = arguments.lastname
				, email          = arguments.email
				, numberOfSeats  = arguments.numberOfSeats
				, session        = arguments.session
				, specialRequest = arguments.specialRequest
				, label          = arguments.firstname & " " & arguments.lastname & " booking on " & dateTimeFormat( now(), "dd mmm yyyy 'at' HH:nn:ss z" )
			  }
			, insertManyToManyRecords = true
			, objectName              = "event_booking_detail"
		);
    }
    public query function getBookingList(){

    	return $getPresideObjectService().selectData(
    		  objectName   = "event_booking_detail"
    		, selectFields = [
    			  "event_booking_detail.label as booking_label"
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
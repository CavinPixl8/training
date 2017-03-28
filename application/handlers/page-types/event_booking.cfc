component {

	property name="eventService" inject="EventService";

	private function index( event, rc, prc, args={} ) {
		args.eventId = rc.id ?: "";

		if ( len( args.eventId ) ){
			bookable = eventService.checkBookable( eventId=args.eventId );

			if( !bookable ) {
				setNextEvent(  url = event.buildLink( page=getSystemSetting( "default_event_listing", "listing_id", "" ) ) );
			}
		}
		return renderView(
			  view          = 'page-types/event_booking/index'
			, presideObject = 'event_booking'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function addBooking( event, rc, prc, args={} ) {
		var bookingData      = event.getCollectionForForm( "events.event_booking" );
		var validationResult = validateForm( "events.event_booking", bookingData );

		if( len( trim( bookingData.firstname ) )< 6 ){
			validationResult.addError( fieldName="firstname" , message="Must contain at least 6 characters! ");
		}
		if( len( trim( bookingData.lastname ) )< 6 ){
			validationResult.addError( fieldName="lastname" , message="Must contain at least 6 characters! ");
		}

		if( !isValid( "email",bookingData.email ) ){
			validationResult.addError( fieldName="email" , message="Please enter a valid email address. ");
		}

		if( !len( trim( bookingData.number_of_seats ) ) ){
			validationResult.addError( fieldName="number_of_seats" , message="Please choose your number of seats. ");
		}

		if( !len( trim( bookingData.session ) ) ){
			validationResult.addError( fieldName="session" , message="Please select at least one session. ");
		}

		if( !validationResult.validated() ){
			setNextEvent(
				  url           = event.buildLink( page="event_booking" )
				, persistStruct = { validationResult=validationResult, error=true, formData=bookingData }
			 )
		}
		else{
			eventService.saveBooking(
				  firstname      = bookingData.firstname
				, lastname       = bookingData.lastname
				, email          = bookingData.email
				, numberOfSeats  = bookingData.number_of_seats
				, session        = bookingData.session
				, specialRequest = bookingData.special_request
			);
			setNextEvent(
				  url = event.buildLink(page="event_booking")
				, persistStruct = { success=true }
			)
		}
	}

	public function getBookingDetail ( event, rc, prc, args={} ){

		return renderView(
			  view = "page-types/event_booking/_eventBookingDetail"
			, args = {
				  bookingList = eventService.getBookingList()
			}
		);
	}
}


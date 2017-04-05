component {

	property name="eventService" inject="EventService";
	property name="notificationService" inject="notificationService";

	private function index( event, rc, prc, args={} ) {
		args.eventId    = rc.id ?: "";

		if ( len( args.eventId ) ){
			args.eventPrice = eventService.getEventPrice ( eventId=args.eventId );
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
		var bookingForm      = event.getCollectionForForm( "events.event_booking" );
		var validationResult = validateForm( "events.event_booking", bookingForm );

		if( len( trim( bookingForm.firstname ) )< 6 ){
			validationResult.addError( fieldName="firstname" , message="Must contain at least 6 characters! ");
		}
		if( len( trim( bookingForm.lastname ) )< 6 ){
			validationResult.addError( fieldName="lastname" , message="Must contain at least 6 characters! ");
		}

		if( !isValid( "email",bookingForm.email ) ){
			validationResult.addError( fieldName="email" , message="Please enter a valid email address. ");
		}

		if( !len( trim( bookingForm.number_of_seats ) ) OR bookingForm.number_of_seats LT 1 ){
			validationResult.addError( fieldName="number_of_seats" , message="Please choose your number of seats. ");
		}

		if( !len( trim( bookingForm.session ) ) ){
			validationResult.addError( fieldName="session" , message="Please select at least one session. ");
		}

		if( !validationResult.validated() ){
			setNextEvent(
				  url           = event.buildLink( page="event_booking" )
				, persistStruct = { validationResult=validationResult, statusCode="ERROR_INPUT", errorMessage="Incorrect input", formData=bookingForm }
			 )
		}
		else{
			var price = numberFormat( bookingForm.number_of_seats * eventService.getEventPrice ( rc.eventId ?: "" ), "00.00" );

			var bookingData = {
				  firstname      = filterHTML( bookingForm.firstname )
				, lastname       = filterHTML( bookingForm.lastname )
				, email          = filterHTML( bookingForm.email )
				, numberOfSeats  = bookingForm.number_of_seats
				, session        = bookingForm.session
				, specialRequest = filterHTML( bookingForm.special_request ?: "" )
				, event_id       = rc.eventId ?: ""
				, total_price    = price
			}
			var results = eventService.saveBooking(
				  argumentCollection = bookingData
			);
			if ( !len (results.errorMessage) ){
				notificationService.createNotification(
					  topic = "newEventBooked"
					, type  = "ALERT"
					, data  = bookingData
				);
			}
			setNextEvent(
				  url           = event.buildLink( page="event_booking" )
				, persistStruct = {
					  statusCode   = results.statusCode
					, errorMessage = results.errorMessage
					, newID        = results.newID
				}
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


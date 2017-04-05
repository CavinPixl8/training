component {
	private struct function prepareParameters(
		  required string  firstName
		, required string  lastName
		, required numeric numberOfSeats
		, required string  bookingSession
		, required string  specialRequest
		, required string  eventId
		, required numeric totalPrice
	) {
		var bookedSession="";
		var allSessions="";
		loop list=arguments.bookingSession item="bookedSession"{
			allSessions = listAppend( allSessions, renderLabel( "session", bookedSession ) )
		}
		return {
			  first_name      = arguments.firstName
			, last_name       = arguments.lastName
			, number_of_seats = arguments.numberOfSeats
			, booking_session = allSessions
			, special_request = arguments.specialRequest
			, event_name      = renderLabel ( "event_detail", arguments.eventId )
			, total_price     = arguments.totalPrice
		}
	}

	private struct function getPreviewParameters() {
		return {
			  first_name      = "Cavin"
			, last_name       = "Neoh"
			, number_of_seats = 99
			, booking_session = "Midnight"
			, special_request = "for children"
			, event_name      = "Sample Event Name"
			, total_price     = -1
		}
	}

	private string function defaultSubject() {
		return "Thanks for your booking";
	}

	private string function defaultHtmlBody() {
		return renderView( view="/email/templates/eventBooking/defaultHtmlBody" );
	}

	private string function defaultTextBody() {
		return renderView( view="/email/templates/eventBooking/defaultTextBody" );
	}
}
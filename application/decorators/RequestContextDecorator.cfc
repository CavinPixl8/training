component extends="preside.system.coldboxModifications.RequestContextDecorator" {


	public boolean function isUKRegistrant( required string country ){
		return uCase( arguments.country ) == "UK";
	}

	public boolean function isFullyBooked( required string eventId ){

		var eventBookingsQuery = getModel( "presideObjectService" ).selectData(
			  objectName   = "event_detail"
			, selectFields = [ "seats_allocated", "seats_booked" ]
			, filter       = { "id"=arguments.eventId }
		);

		if ( len( eventBookingsQuery.seats_allocated ) && len( eventBookingsQuery.seats_booked ) ){
			if ( eventBookingsQuery.seats_booked GTE eventBookingsQuery.seats_allocated ){
				return true;
			}
		}
		return false;
	}
}
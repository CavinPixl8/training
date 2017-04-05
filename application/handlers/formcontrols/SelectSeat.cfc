component {

	property name="presideObjectService" inject="presideObjectService";

	private function website( event, rc, prc, args={} ) {

		var seatsAvailableQuery = presideObjectService.selectData(
			  objectName   = args.object
			, selectFields = [ "seats_allocated", "seats_booked" ]
			, filter       = { "id"=rc.eventId }
		);

		if ( !len( seatsAvailableQuery.seats_booked ) ){
			seatsAvailableQuery.seats_booked = 0;
		}
		if ( len( seatsAvailableQuery.seats_allocated ) ){
			args.seatsAvailable = seatsAvailableQuery.seats_allocated - seatsAvailableQuery.seats_booked;
		}

		return renderView(
			  view = 'formcontrols/selectSeat/website'
			, args = args
		);
	}
}

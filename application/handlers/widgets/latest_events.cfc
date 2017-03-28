component {
	property name="eventService" inject="EventService";

	private function index( event, rc, prc, args={} ) {
		var maxRows  = args.max_items ?: 10;
		var dateNow  = now();

		args.latestEvents = eventService.getAllEventsWithDate( dateNow=dateNow, maxRows=maxRows );
		return renderView(
			  view          = 'widgets/latest_events'
			, args          = args
		);
	}
}
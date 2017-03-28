component {
	property name="eventService"          inject="EventService";

	private function index( event, rc, prc, args={} ) {

		var region   = rc.region   ?: "";
		var category = rc.category ?: "";

		args.eventList = eventService.getAllEventDetails(
			  listingId = event.getCurrentPageId()
			, region    = region
			, category  = category
		);
		args.eventRegions = eventService.getAllEventRegions();
		args.categories   = eventService.getAllEventCategories();

		return renderView(
			  view          = 'page-types/event_listing/index'
			, args 			= args
		);
	}

	private string function listFeaturedEvents( event, rc, prc, args={} ) {

		return renderView(
			  view = "page-types/event_listing/_featuredEvents"
			, args = {
				  featuredEvents = eventService.getFeaturedEvents( args.eventListingPage )
			}
		);
	}
}

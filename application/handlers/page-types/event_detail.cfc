component {
	
	property name="eventService" inject="EventService";

	private function index( event, rc, prc, args={} ) {

		return renderView(
			  view          = 'page-types/event_detail/index'
			, args          = args
			, presideObject = 'event_detail'
			, id            = event.getCurrentPageId()		
		);
	}
	private string function getRelatedEvents ( event, rc, prc, args={} ) { 
		var eventId = args.eventId ?: "";

		if ( isEmpty(eventId) ) {
			return "";
		}

		regionList    = eventService.getEventRegionById( eventId );
		regionIds = valueList( regionList.id );
		writeDump (regionIds);

		return renderView(
			  view = "page-types/event_detail/_relatedEvents"
			, args = { 
				relatedEvents = eventService.getRelatedEventsByRegions ( eventId ) 
			}
		);
	}

	private string function getEventDetailRegions(){
		var recordId = args.recordId ?: "";

		if( isEmpty( recordId ) ){
			return "";
		}

		args.eventRegions = eventService.getAllEventRegions( recordId=recordId );

		return renderView(
			  view = "page-types/event_detail/_eventRegions"
			, args = args
		);
	}
}

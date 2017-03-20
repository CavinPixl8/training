component {
	property name="newsService" inject="NewsService";

	private function index( event, rc, prc, args={} ) {

		var pageId = event.getCurrentPageId();
		var region = rc.region ?: "";

		args.newsList     = newsService.getAllNewsDetail( listingId=pageId, region=region, maxrows=event.getPageProperty( 'posts_per_page', 10 ) );
		args.newsRegions  = newsService.getAllNewsRegions();

		return renderView(
			  view          = 'page-types/news_listing/index'
			, args          = args
			, presideObject = "news_listing"
			, id            = pageId
		);
	}

	private string function getFeaturedNews( event, rc, prc, args={} ) {
		var newsIds = args.newsIds ?: "";

		if( isEmpty( newsIds ) ){
			return "";
		} 

		return renderView(
			  view = "page-types/news_listing/_featuredNews"
			, args = { 
				  featuredNews = newsService.getFeaturedNewsById( newsIds ) 				
			}
		);
	}

}

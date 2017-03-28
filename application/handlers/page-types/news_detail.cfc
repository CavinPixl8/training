component {

	property name="newsService" inject="NewsService";

	private function index( event, rc, prc, args={} ) {

		var pageId = event.getCurrentPageId();
		var upload = rc.upload ?: "";

		if( len( upload) ){
			writeDump("received file"); abort;
		}

		return renderView(
			  view           = 'page-types/news_detail/index'
			, args           = args
			, presideObject = 'news_detail'
			, id             = pageId
		);
	}

	private string function getNewsRegions( event, rc, prc, args={} ) {
		var newsId     = args.newsId     ?: "";
		var parentPage = args.parentPage ?: "";

		if( isEmpty( newsId ) ){
			return "";
		}

		return renderView(
			  view = "page-types/news_detail/_regions"
			, args = {
				  regions    = newsService.getNewsRegionById( newsId )
				, parentPage = parentPage
			}
		);
	}

	private function getRelatedNews ( event, rc, prc, args={} ) {
		var regions = args.regions ?: "";
	}

	private string function getRelatedNews ( event, rc, prc, args={} ) {
		var regionIds = args.regionIds ?: "";

		if ( isEmpty(regionIds) ) {
			return "";
		}

		return renderView(
			  view = "page-types/news_detail/_relatedNews"
			, args = {
				relatedNews = newsService.getRelatedNewsByRegions (regionIds)
			}
		);
	}
}

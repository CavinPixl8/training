/**
* @presideService
*/
component {
    /**
    * @sitetreeService.inject SitetreeService 
    */

    function init(
        required any sitetreeService
    ){
        _setSiteTreeService( arguments.sitetreeService );
        return this;
    }

    public query function getAllNewsDetail( 
        required string  listingId 
                 string  region  = ""
                 numeric maxRows = 5
    ) { 

        var filter = "page.parent_page = :page.parent_page";
        if( !isEmpty( arguments.region ) ){
            filter &= " AND region.id IN (:region.id) "
        }

        return $getPresideObject( "news_detail" ).selectData( 
              filter       = filter
            , filterParams = { "page.parent_page"=arguments.listingId, "region.id"=listToArray( arguments.region ) }  
            , extraFilters = [ _getSiteTreeService().getActivePageFilter() ]
            , selectFields = [ 
                  "page.id"
                , "page.title"
                , "page.main_content"
                , "news_detail.date_published"
                , "news_detail.news_author"
                , "category.label as category_label"
            ] 
            , orderBy      = "news_detail.date_published desc"
            , maxRows      = arguments.maxRows
        );
    }

    public query function getNewsRegionById( required string newsId ) {
        return $getPresideObjectService().selectData(
              filter       = { news_detail=arguments.newsId }            
            , objectName   = "news_detail__join__region"  
            , selectFields = [
                  "region.id"
                , "region.label"
            ]
            , orderBy       = "sort_order asc"
        )
    }

    public query function getFeaturedNewsById( required string newsIds ){
        return $getPresideObjectService().selectData(
              filter       = { "news_detail.id"=listToArray( arguments.newsIds ) }
            , objectName   = "news_detail"  
            , selectFields = [
                  "page.id"
                , "page.title"
                , "page.teaser"
            ]
            , orderBy       = "FIELD( news_detail.id, #listQualify( arguments.newsIds, '"' )#)"
        )
    }

    public query function getAllNewsRegions() {
        return $getPresideObjectService().selectData(
              objectName   = "news_detail"  
            , groupBy      = "region.id"  
            , selectFields = [
                  "region.id"
                , "region.label"
            ]
            , orderBy       = "region.label asc"
        )
    }

    public query function getRelatedNewsByRegions( required string regionIds ) {
        return $getPresideObjectService().selectData(
              filter       = { "region.id"=listToArray( arguments.regionIds ) }
            , groupBy      = "page.id"   
            , objectName   = "news_detail" 
            , selectFields = [
                  "page.id"
                , "page.title"
            ]
            , orderBy       = "news_detail.date_published desc"
        )
    }


//Setters & Getters
    private any function _getSiteTreeService() {
        return _sitetreeService;
    }

    private void function _setSiteTreeService( required any sitetreeService ) {
        _sitetreeService = arguments.sitetreeService
    } 
}
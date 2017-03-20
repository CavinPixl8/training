/**
* @presideService
*/
component {
    /**
     * @eventListingObject.inject presidecms:object:event_listing
     * @eventObject.inject        presidecms:object:event_detail
     * @programObject.inject      presidecms:object:program
     */
     public any function init( required any eventObject ) {
        _setEventObject( arguments.eventObject );

        return this;
     }

     public query function getAllEventDetails( 
        required string listingId 
        ,        string region    = ""
        ,        string category  = ""
        ) {

            var filter = "page.parent_page = :page.parent_page";
            var filterParams = { "page.parent_page"=arguments.listingId }

            if( !isEmpty( arguments.region ) ){
                filter &= " AND region.id IN (:region.id) ";
                filterParams["region.id"] = listToArray( arguments.region );
            }

            if (!isEmpty ( arguments.category ) ){
                filter &= " AND category.id IN (:category.id) ";
                filterParams["category.id"] = listToArray( arguments.category );
            }

            return _getEventObject().selectData( 
                  filter       = filter 
                , groupBy      = "page.id"   
                , filterParams = filterParams
                , selectFields = [
                      "page.id"
                    , "page.title"
                    , "page.main_content"                   
                    , "category.label as category"
                ] 
            );
     }

    public query function getAllEventRegions( string recordId = "" ) {
        
        var filter = "1=1";
        
        if( !isEmpty( arguments.recordId ) ){
            filter = { "event_detail.id"=arguments.recordId }
        }

        return _getEventObject().selectData(
              objectName   = "event_detail"  
            , selectFields = [
                  "region.id"
                , "region.label"
            ]
            , orderBy      = "region.label asc"
            , filter       = filter
        )
    } 
    public query function getAllEventCategories() {
        return _getEventObject().selectData(
              objectName   = "event_detail"  
            , groupBy      = "category.id"  
            , selectFields = [
                  "DISTINCT(category.id)"
                , "category.label"
            ]
            , orderBy       = "category.label asc"
        )
    }
    public query function getFeaturedEvents() {
        return _getEventObject().selectData(
            objectName     = "event_detail"
            , filter       = "page.id = event_detail__join__event_listing.event_detail "
            , selectFields = [
                  "page.id"
                , "page.title"
                , "page.teaser"
            ]
        )
    }
    public query function getEventRegionById( required string eventId ) {
        return $getPresideObjectService().selectData(
              filter       = { event_detail=arguments.eventId }            
            , objectName   = "event_detail__join__region"  
            , selectFields = [
                  "region.id"
                , "region.label"
            ]
            , orderBy       = "sort_order asc"
        )
    }     
    public query function getRelatedEventsByRegions( required string regionIds ) {
        return $getPresideObjectService().selectData(
              filter       = { "region.id"=listToArray( arguments.regionIds ) }
            , groupBy      = "page.id"   
            , objectName   = "event_detail" 
            , selectFields = [
                  "page.id"
                , "page.title"
            ]
        )
    }      
     // we prefer private getters and setters for accessing private properties, this is our house style
     private any function _getEventObject() {
         return variables._eventObject;
     }
     private void function _setEventObject( required any eventObject ) {
         variables._eventObject = arguments.eventObject;
     }

}
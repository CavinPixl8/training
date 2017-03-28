component {
    /**
     * @websiteUser.inject presidecms:object:website_user
     */
     public any function init( required any websiteUser ) {
        _setWebsiteUser( arguments.websiteUser );

        return this;
     }

     public query function getUser( required string id ) {
        return _getWebsiteUser().selectData( id = arguments.id );
     }

     public string function saveUser( required struct websiteUserData ) {
        return _getWebsiteUser().insertData( data=arguments.websiteUserData , insertManyToManyRecords=true );
     }

     public boolean function checkRecord( required string fieldName, required string value ){
        var filter = {};
        filter[arguments.fieldname] = arguments.value;

        return _getWebsiteUser().dataExists( filter = filter );
     }

     // we prefer private getters and setters for accessing private properties, this is our house style
     private any function _getWebsiteUser() {
         return variables._websiteUser;
     }
     private void function _setWebsiteUser( required any websiteUser ) {
         variables._websiteUser = arguments.websiteUser;
     }
}
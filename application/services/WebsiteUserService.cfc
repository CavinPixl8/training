/**
* @presideService
* @singleton
*/
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

	 public string function saveUser(
	 	   required string login_id
		 , required string email_address
		 , required string display_name
		 ,          string firstname = ""
		 ,          string lastname  = ""
		 ,          string dob       = ""
		 ,          string gender    = ""
		 ,          string address   = ""
		 ,          string country   = ""
		 , required string category
	 ) {
	 	var newId = "";

		newId = _getWebsiteUser().insertData(
			  data                    = {
				  login_id      = arguments.login_id
				, email_address = arguments.email_address
				, display_name  = arguments.display_name
				, firstname     = arguments.firstname
				, lastname      = arguments.lastname
				, dob           = arguments.dob
				, gender        = arguments.gender
				, address       = arguments.address
				, country       = arguments.country
				, category      = arguments.category
			  }
			, insertManyToManyRecords = true
		);

		$sendEmail(
			  template = "memberRegistration"
			, to       = [ arguments.email_address ]
			, args     = {
				  firstName = arguments.firstname
				, lastName  = arguments.lastname
				, userId    = arguments.login_id
			}
		);

		return newID;
	 }

	 public boolean function checkRecord( required string fieldName, required string value ){
		var filter = {};
		filter[ arguments.fieldname ] = arguments.value;

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
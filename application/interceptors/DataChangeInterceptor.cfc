component extends="coldbox.system.Interceptor" {

	property name="presideObjectService" inject="provider:PresideObjectService";
	property name="notificationService"  inject="provider:notificationService";

	public void function preUpdateObjectData( required any event, required struct interceptData ) {
		var objectName       = arguments.interceptData.objectName ?: "";
		var id               = arguments.interceptData.id         ?: "";
		var data             = arguments.interceptData.data;
		var skipInterception = isBoolean( data.skipInterception ?: "" ) && data.skipInterception;

		switch( objectName ){
			case "website_user":
				if( skipInterception ) break;

				var websiteUserQuery = presideObjectService.selectData(
					  objectName   = objectName
					, selectFields = [ "email_address", "login_id", "display_name" ]
					, filter       = { "id"=id }
				);

				if ( websiteUserQuery.recordcount ){
					if ( StructKeyExists( data, "login_id" ) && websiteUserQuery.login_id != data.login_id ){
						data.changedField = "login_id";
					}
					else if ( StructKeyExists( data, "email_address" ) && websiteUserQuery.email_address != data.email_address ){
						data.changedField = "email_address";
					}
					else if ( StructKeyExists( data, "display_name" ) && websiteUserQuery.display_name != data.display_name ){
						data.changedField = "display_name";
					}
				}
				//add login to check if login_id is taken
			break;
		}
	}

	public void function postUpdateObjectData( required any event, required struct interceptData ) {
		var objectName   = arguments.interceptData.objectName ?: "";
		var id           = arguments.interceptData.id         ?: "";
		var data         = arguments.interceptData.data;

		switch( objectName ){
			case "website_user":

				var changedField = data.changedField ?: "";

				if( StructKeyExists( data, "login_id" ) &&  StructKeyExists( data, "email_address" ) && data.login_id != data.email_address ){

					var newData      = {};

					if ( changedField == "login_id" ){
						newData = { "email_address"=data.login_id };
					}
					else if ( changedField == "email_address"){
						newData = { "login_id"=data.email_address };
					}

					if ( !isEmpty( newData ) ){
						newData.skipInterception = true;
						var result = presideObjectService.updateData(
							  objectName = objectName
							, data       = newData
							, filter     = { "id"=id }
						)
					}
				}
				if ( len( changedField ) ){
					notificationService.createNotification(
						topic = "WebsiteUserDataChanged"
						, type  = "Info"
						, data  = { id=id }
					);
				}
			break;
		}
	}


}
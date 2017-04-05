component extends="preside.system.config.Config" {

	public void function configure() {
		super.configure();

		settings.preside_admin_path  = "testsite_admin";
		settings.system_users        = "sysadmin";
		settings.default_locale      = "en";

		settings.default_log_name    = "testsite";
		settings.default_log_level   = "information";
		settings.sql_log_name        = "testsite";
		settings.sql_log_level       = "information";

		settings.ckeditor.defaults.stylesheets.append( "css-bootstrap" );
		settings.ckeditor.defaults.stylesheets.append( "css-layout" );

		settings.features.websiteUsers.enabled = true;

		_setupDerivatives( settings.assetManager.derivatives );
		_setupEmailSettings();

		_setupInterceptors();

		settings.notificationTopics.append( "memberRegistration" );
		settings.notificationTopics.append( "newEventBooked" );
		settings.notificationTopics.append( "websiteUserDataChanged" );

		coldbox.requestContextDecorator = "app.decorators.RequestContextDecorator";
	}

	private void function _setupDerivatives( required struct derivatives ){

		derivatives.listingImage = {
			  permissions     = "inherit"
			, transformations = [
				{ method="resize", args={ width=300, height=120, maintainAspectRatio=true } }
			]
		};

		derivatives.detailImage = {
			  permissions     = "inherit"
			, transformations = [
				{ method="shrinkToFit", args={ width=300, height=120  } }
			]
		};

		derivatives.newsPDFPreview = {
			  permissions     = "inherit"
			, transformations = [
				  { method="pdfPreview" , args={ page=1 }, inputfiletype="pdf", outputfiletype="jpg" }
				, { method="shrinkToFit", args={ width=200, height=200 } }
			]
		};

	}

	private void function _setupEmailSettings(){
		settings.email.templates.memberRegistration = {
			  feature       = "cms"
			, recipientType = "anonymous"
			, parameters    = [
				  { id="first_name", required=true }
				, { id="last_name" , required=true }
				, { id="user_id"   , required=true }
			]
		}
		settings.email.templates.eventBooking = {
			  feature       = "cms"
			, recipientType = "anonymous"
			, parameters    = [
				  { id="first_name"        , required=true }
				, { id="last_name"         , required=true }
				, { id="number_of_seats"   , required=true }
				, { id="booking_session"   , required=true }
				, { id="special_request"   , required=true }
			]
		}
	}

	private void function _setupInterceptors(){

		interceptors.append( { class="app.interceptors.DataChangeInterceptor",       properties={} } );

	}
}

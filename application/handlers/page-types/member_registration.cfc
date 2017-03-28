component {

	property name="formsService"        inject="formsService";
	property name="websiteUserService"  inject="WebsiteUserService";
	property name="websiteLoginService" inject="WebsiteLoginService";


	private function index( event, rc, prc, args={} ) {
		// TODO: create your handler logic here
		return renderView(
			  view          = 'page-types/member_registration/index'
			, presideObject = 'member_registration'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}


	public function signup( event, rc, prc, args={} ) {
		var personalForname = formsService.getMergedFormName("member_registration.personal_detail","member_registration.account_info");

		var personalFormData = event.getCollectionForForm(personalForname);

		var validationResult = validateForm( personalForname, personalFormData );

		if(personalFormData.password != personalFormData.confirmPassword){
			validationResult.addError( fieldName="password" , message="Password must be the same! ");
			validationResult.addError( fieldName="confirmPassword" , message="Password must be the same! ");
		}

		emailExists = websiteUserService.checkRecord( fieldName="email_address", value=personalFormData.email );
		if (emailExists){
			validationResult.addError( fieldName="email" , message="Email address is registered for another account ");
		}
		if( !validationResult.validated() ){
			setNextEvent(
				  url = event.buildLink(page="member_registration")
				, persistStruct = { validationResult=validationResult, error=true, formData=personalFormData }
			 )
		}
		else{
			var websiteUserData = {
				  login_id      = personalFormData.userId
				, email_address = personalFormData.email
				, display_name  = personalFormData.firstname & personalFormData.lastname
				, firstname     = personalFormData.firstname
				, lastname      = personalFormData.lastname
				, dob           = personalFormData.dob
				, gender        = personalFormData.gender
				, address       = personalFormData.address
				, category		= personalFormData.interested_in ?: ""
			}

			var memeberId = websiteUserService.saveUser( websiteUserData );

			websiteLoginService.changePassword( password =personalFormData.password, userId=memeberId )

			setNextEvent(
				  url = event.buildLink(page="member_registration")
				, persistStruct = { success=true }
			 )
		}
	}
}

component {
	private struct function prepareParameters(
		  required firstName
		, required lastName
		, required userId
	) {
		return {
			  first_name = arguments.firstName
			, last_name  = arguments.lastName
			, user_id    = arguments.userId
		}
	}

	private struct function getPreviewParameters() {
		return {
			  first_name = "Cavin"
			, last_name  = "Neoh"
			, user_id    = "cavin.neoh@pixl8.co.uk"
		}
	}

	private string function defaultSubject() {
		return "Thanks for your registration";
	}

	private string function defaultHtmlBody() {
		return renderView( view="/email/templates/memberRegistration/defaultHtmlBody" );
	}

	private string function defaultTextBody() {
		return renderView( view="/email/templates/memberRegistration/defaultTextBody" );
	}
}
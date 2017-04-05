<cf_presideparam name="args.title"        field="page.title"        editable="true" />
<cf_presideparam name="args.main_content" field="page.main_content" editable="true" />
<cfset success              = rc.success ?: false />
<cfset showPromotionMessage = rc.showPromotionMessage ?: false />
<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#
	<cfif !(success)>
		<form id="signup-form" action="#event.buildLink(linkTo="page-types.member_registration.signup")#" class="form form-horizontal" method="POST">
			#renderForm(
				  formName         = "member_registration.personal_detail"
				, context          = "website"
				, formId           = "signup-form"
				, validationResult = rc.validationResult ?: ""
				, savedData        = rc.formData ?: {}
			)#

			#renderForm(
				  formName         = "member_registration.account_info"
				, context          = "website"
				, formId           = "signup-form"
				, validationResult = rc.validationResult ?: ""
				, savedData        = rc.formData ?: {}
			)#
			<input type="submit" value="Register" />
		</form>
	<cfelse>
		<h2>Input Success </h2>
		<cfif showPromotionMessage>
			<p>Grab your promotion purchase for UK members.</p>
		</cfif>
	</cfif>


</cfoutput>
<cfoutput>
	A new member has registered. Here are the details
	---
	   Member Login ID : #args.login_id#
	   Email Address   : #args.email_address#
	   Display Name    : #args.display_name#
	   First Name      : #args.firstname#
	   Last Name       : #args.lastname#
	   Date Of Birth   : #args.dob#
	   Gender          : #args.gender#
	   Address         : #args.address#
	   Interests       :
		<cfloop list="#args.category#" item="cat">
			#renderLabel( "category" , cat )# |
		</cfloop>
</cfoutput>
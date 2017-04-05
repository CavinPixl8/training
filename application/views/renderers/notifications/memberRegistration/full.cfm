<cfparam name="args.login_id"      type="string" />
<cfparam name="args.email_address" type="string" />
<cfparam name="args.display_name"  type="string" />
<cfparam name="args.firstname"     type="string" />
<cfparam name="args.lastname"      type="string" />
<cfparam name="args.dob"           type="date" />
<cfparam name="args.gender"        type="string" />
<cfparam name="args.address"       type="string" />
<cfparam name="args.category"      type="string"/>

<cfoutput>
	<h2>A new member has registered on your website!</h2>
	<table border="1">
		<tr>
			<td> Member login ID </td>
			<td> #args.login_id# </td>
		</tr>
		<tr>
			<td> Email address </td>
			<td> #args.email_address# </td>
		</tr>
		<tr>
			<td> Display name </td>
			<td> #args.display_name# </td>
		</tr>
		<tr>
			<td> First Name </td>
			<td> #args.firstname# </td>
		</tr>
		<tr>
			<td> Last Name </td>
			<td> #args.lastname# </td>
		</tr>
		<tr>
			<td> Date of Birth </td>
			<td> #args.dob#</td>
		</tr>
		<tr>
			<td> Gender </td>
			<td> #args.gender# </td>
		</tr>
		<tr>
			<td> Address </td>
			<td> #args.address# </td>
		</tr>
		<tr>
			<td> Interests </td>
			<td>
				<cfloop list="#args.category#" item="cat">
					#renderLabel( "category" , cat )# |
				</cfloop>
			</td>
		</tr>
	</table>
</cfoutput>
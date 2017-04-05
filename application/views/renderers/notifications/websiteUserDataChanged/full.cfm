<cfparam name="args.id"            type="string"  default=""/>
<cfparam name="args.login_id"      type="string"  default=""/>
<cfparam name="args.email_address" type="string"  default=""/>
<cfparam name="args.display_name"  type="string" default=""/>

<cfoutput>
	<div class="alert alert-danger">
	<h2>Updated website user details</h2>
		<table border="1">
			<tr>
				<td> User ID </td>
				<td> #args.id# </td>
			</tr>
			<tr>
				<td> Login ID </td>
				<td> #args.login_id# </td>
			</tr>
			<tr>
				<td> Email Address </td>
				<td> #args.email_address#</td>
			</tr>
			<tr>
				<td> Display Name </td>
				<td> #args.display_name# </td>
			</tr>
		</table>
	</div>
</cfoutput>

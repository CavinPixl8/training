<cfparam name="args.firstname"      type="string"  default=""/>
<cfparam name="args.lastname"       type="string"  default=""/>
<cfparam name="args.email"          type="string"  default=""/>
<cfparam name="args.numberOfSeats"  type="numeric" default=0/>
<cfparam name="args.session"        type="string"  default=""/>
<cfparam name="args.specialRequest" type="string"  default=""/>
<cfparam name="args.event_id"       type="string"  default=""/>
<cfparam name="args.total_price"    type="numeric" default=1/>

<cfoutput>
	<div class="alert alert-danger">
	<h2>Event Booking for #renderLabel( "event_detail" , args.event_id )#</h2>
		<table border="1">
			<tr>
				<td> Booking Made by </td>
				<td> #args.firstname# #args.lastname# </td>
			</tr>
			<tr>
				<td> Booking email </td>
				<td> #args.email# </td>
			</tr>
			<tr>
				<td> Seats Booked </td>
				<td> #args.numberOfSeats#</td>
			</tr>
			<tr>
				<td> Booking Session(s)</td>
				<td>
					<cfloop list="#args.session#" item="item">
						#renderLabel( "session" , item )# |
					</cfloop>
				</td>
			</tr>
			<tr>
				<td> Special Request </td>
				<td> #args.specialRequest# </td>
			</tr>
		</table>
	</div>
</cfoutput>

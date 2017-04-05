<cfoutput>
	Booking made for : [#renderLabel( "event_detail" , args.event_id )#]
	Booking made by  :  #args.firstname# #args.lastname#
	Booking email    :  #args.email#
	Seats Booked     :  #args.numberOfSeats#
	Booking Session:
	<cfloop list="#args.session#" item="item">
		#renderLabel( "session" , item )# |
	</cfloop>
	Special Request  :  #args.specialRequest#
	=========================================

	TOTAL AMOUND DUE : RM#args.total_price#

	....
	This is a computer generated email. No signature required
</cfoutput>
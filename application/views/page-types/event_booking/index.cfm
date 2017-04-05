<cf_presideparam name="args.title"        field="page.title"        editable="true" />
<cf_presideparam name="args.main_content" field="page.main_content" editable="true" />
<cf_presideparam name="args.id"           field="page.id"/>
<cfset eventId = args.eventId ?: "" />
<cfset rc.eventId = eventId />

<cfscript>
	statusCode   = rc.statusCode   ?: "";
	errorMessage = rc.errorMessage ?: "";
	newID        = rc.newID        ?: "";
	eventPrice   = args.eventPrice ?: 0
</cfscript>
<cfoutput>

	<cfif !len( eventId ) >
		<cfif !isEmpty( statusCode )>
			<p>#errorMessage#</p>
		<cfelseif !isEmpty( newId )>
			<p>Booking is done successfully, Your booking id is #newID# </p>
		</cfif>
		<h2>This is the event booking list</h2>
		#renderViewlet( event="page-types.event_booking.getBookingDetail" )#
	<cfelse>
		<h1>#args.title#</h1>
		<h4>#eventId#</h4>
		<h6>#eventPrice# </h6>

		<cfif event.isFullyBooked( eventId ) >
			<h1>Sorry, event is fully booked</h1>
		<cfelse>
			<h1>Booking still available</h1>
			<form id="booking-form" action="#event.buildLink(linkTo="page-types.event_booking.addBooking")#" class="form form-horizontal" method="POST">
				#renderForm(
					  formName         = "events.event_booking"
					, context          = "website"
					, formId           = "booking-form"
					, validationResult = rc.validationResult ?: ""
					, savedData        = rc.formData ?: {}
				)#
				<p>Total price for booking is RM<span id="price-display"></span></p>
				<script>
					var seats = document.getElementById('number_of_seats');
					seats.onchange = updatePrice;

					function updatePrice(){
						var price = this.value * #eventPrice#;
						price = price.toFixed(2);
						document.getElementById("price-display").innerHTML = price;
					}
				</script>
				<input type="hidden" value="#eventId#" name="eventId"/>
				<input type="submit" value="Submit" />
			</form>
		</cfif>

	</cfif>
</cfoutput>
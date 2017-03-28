<cf_presideparam name="args.id"           field="page.id"  />
<cf_presideparam name="args.title"        field="page.title"              editable="true" />
<cf_presideparam name="args.main_content" field="page.main_content"       editable="true" />
<cf_presideparam name="args.start_date"   field="event_detail.start_date"/>
<cf_presideparam name="args.organiser"    editable="true" />
<cf_presideparam name="args.location"     editable="false" />
<cf_presideparam name="args.category"     editable="false" />
<cf_presideparam name="args.bookable" />

<cfoutput>
	<h1>#args.title# </h1>
	<h6>#args.id#</h6>
	#args.main_content#

	<cfif args.bookable>
		<p>
			<a href="#event.buildLink(page="event_booking",querystring="id=#args.id#")#">Book now</a>
		</p>
	</cfif>


	#renderViewlet( event='page-types.event_detail.getRelatedEvents', args={ eventId=args.id } )#
	#renderViewlet( event='page-types.event_detail.getPrograms', args={ eventId=args.id } )#

	<cfif args.start_date < now() >
		<b>Expired event, therefore showing Disqus comments below</b>
		<hr/>
		#renderView( 'general/_disqus' )#
	<cfelse>
		<i>Upcoming event, no Disqus comments to show</i>
	</cfif>
</cfoutput>
<cf_presideparam name="args.id"            field="page.id"  />
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cf_presideparam name="args.organiser"     editable="true" />
<cf_presideparam name="args.location"      editable="false" />
<cf_presideparam name="args.category"      editable="false" />
<cf_presideparam name="args.start_date"    editable="true" />

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#
	#renderViewlet( event='page-types.event_detail.getRelatedEvents', args={ eventId=args.id } )#
</cfoutput>
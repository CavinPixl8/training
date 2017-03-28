<cfscript>
	latestEvents = args.latestEvents ?: queryNew('');
</cfscript>
<h3>Upcoming events</h3>
<cfif !empty(args.latestEvents)>
	<cfoutput query="args.latestEvents">
		<p>
			<a href="#event.buildLink( page= args.latestEvents.id )#">#args.latestEvents.title#</a>
			(#dateTimeFormat( args.latestEvents.start_date, "dd mmm yyyy" )#)
		</p>
	</cfoutput>
<cfelse>
	<cfoutput>
		No Upcoming events
	</cfoutput>
</cfif>
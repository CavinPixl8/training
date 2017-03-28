<cfscript>
	args.relatedEvents = args.relatedEvents ?: queryNew('');
</cfscript>

<cfif !Empty("args.relatedEvents")>
	<h3>Related regional Events</h3>
	<cfoutput query="args.relatedEvents">
		<p>
			<a href="#event.buildLink( page=args.relatedEvents.id )#">#args.relatedEvents.title#</a>
		</p>
	</cfoutput>
</cfif>

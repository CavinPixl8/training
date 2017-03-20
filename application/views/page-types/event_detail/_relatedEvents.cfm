<cfscript>
	args.relatedEvents = args.relatedEvents ?: queryNew('');
</cfscript> 
<h3>Related regional Events</h3>
<cfdump var = "#args.relatedEvents#" >
<cfoutput query="args.relatedEvents">
	<p>
		<a href="#event.buildLink( page=args.relatedEvents.id )#">#args.relatedEvents.title#</a>
	</p>
</cfoutput>
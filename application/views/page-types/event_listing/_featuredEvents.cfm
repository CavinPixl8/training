<cfscript>
	args.featuredEvents = args.featuredEvents ?: queryNew('');
</cfscript> 
<h3>Featured Events</h3>
<cfoutput query="args.featuredEvents">
	<h2>
		<a href="#event.buildLink( page=args.featuredEvents.id )#">#args.featuredEvents.title#</a>
	</h2>
	<p>
		<cfif not len(args.featuredEvents.teaser)>
			Event has no teaser. Showing default
		<cfelse>
			#args.featuredEvents.teaser#
		</cfif>
	<p>
</cfoutput>
<hr />
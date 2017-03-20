<cfscript>
	args.eventRegions = args.eventRegions ?: queryNew('');
</cfscript> 
<cfoutput query="args.eventRegions">
	<a href="#event.buildLink( queryString='region=#args.eventRegions.id#' )#">#args.eventRegions.label#</a> 
</cfoutput>
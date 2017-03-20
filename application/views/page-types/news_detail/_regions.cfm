<cfscript>
	args.regions    = args.regions    ?: queryNew('');
	args.parentPage = args.parentPage ?: "";
</cfscript> 
<ul>
	<h4>This article is tagged in region(s):</h4>
	<cfoutput query="args.regions">
		<p>
			<a href="#event.buildLink( page=args.parentPage, queryString='region=#args.regions.id#' )#">#args.regions.label#</a>
	    </p>
	</cfoutput>
	<cfset regionList = valueList("args.regions.id") />
	<cfoutput>
		#renderViewlet( event='page-types.news_detail.getRelatedNews', args={ regionIds=regionList } )#
	</cfoutput>	
</ul>
<cfscript>
	args.relatedNews = args.relatedNews ?: queryNew('');
</cfscript>
<h3>Related regional news</h3>
<cfoutput query="args.relatedNews">
	<p>
		<a href="#event.buildLink( page=args.relatedNews.id )#">#args.relatedNews.title#</a>
	</p>
</cfoutput>

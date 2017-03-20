<cfscript>
	args.featuredNews = args.featuredNews ?: queryNew('');
</cfscript> 
<h3>Featured news</h3>
<cfoutput query="args.featuredNews">
	<p>
		<a href="#event.buildLink( page=args.featuredNews.id )#">#args.featuredNews.title#</a>
	</p>
	<p>
		#args.featuredNews.teaser#
	</p>
</cfoutput>
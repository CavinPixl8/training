<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cf_presideparam name="args.parent_page"   field="page.parent_page" />
<cf_presideparam name="args.date_published"  />
<cf_presideparam name="args.id"              />
<cf_presideparam name="args.news_author"    editable="true" />

<cfoutput>
	<h1>#args.title#</h1>
	<p>
		#DateFormat( args.date_published, "dd mmmm yyyy" )#<br/>
		#args.news_author#
		#args.main_content#
		#renderViewlet( event='page-types.news_detail.getNewsRegions', args={ newsId=args.id, parentPage=args.parent_page } )#
	</p>
	#args.main_content#
</cfoutput>
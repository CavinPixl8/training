<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cf_presideparam name="args.parent_page"   field="page.parent_page" />
<cf_presideparam name="args.main_image"    field="page.main_image" />
<cf_presideparam name="args.date_published"  />
<cf_presideparam name="args.id"              />
<cf_presideparam name="args.news_author"   editable="true" />
<cf_presideparam name="args.document"/>
<cfset document = args.document ?: "" />

<cfoutput>
	<h1>#args.title#</h1>
	<img src="#event.buildLink( assetId=args.main_image, derivative="detailImage" )#" />
	<p>
		#DateFormat( args.date_published, "dd mmmm yyyy" )#<br/>
		#args.news_author#
		#args.main_content#
		#renderViewlet( event='page-types.news_detail.getNewsRegions', args={ newsId=args.id, parentPage=args.parent_page } )#
	</p>
	#args.main_content#
	<cfif !empty(document)>
		This news is available in as PDF : <a href="#event.buildLink( assetId=document)#"><img src="#event.buildLink( assetId=document, derivative='newsPDFPreview'  )#" /></a>
	</cfif>
	#renderView( 'general/_addThis' )#
	#renderView( 'general/_disqus' )#
</cfoutput>
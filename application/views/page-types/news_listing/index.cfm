<cf_presideparam name="args.title"          field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"   field="page.main_content" editable="true" />
<cf_presideparam name="args.posts_per_page" editable="false" />
<cf_presideparam name="args.featured_news"  field="group_concat( distinct featured_news.id order by news_detail__join__news_listing.sort_order )"/>

<cfscript>
	newsList       = args.newsList     ?: queryNew('');
	newsRegions    = args.newsRegions  ?: queryNew('');
	featuredNews   = args.featuredNews ?: queryNew('');
	selectedRegion = rc.region ?: "";

</cfscript>

<cfset newsFilter ={  "page.parent_page" = event.getCurrentPageID() }  >

<cfif len(rc.category?:"")>
	<cfset newsFilter["news_detail.news_category"] = rc.category?:"">
</cfif>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#
	#renderViewlet( event='page-types.news_listing.getFeaturedNews', args={ newsIds=args.featured_news } )#
<!---
	<cfloop list="#args.featured_news#" item="itemNews">
		<h3><a href="#event.buildLink(page=itemNews)#">#renderLabel( 'news_detail', itemNews )#</a></h2>
	</cfloop> --->

	<cfif newsRegions.recordCount>
		<form name="filter" action="#event.buildLink()#">
			<select name="region">
				<option value="">All</option>
				<cfloop query="newsRegions">
					<option value="#newsRegions.id#" <cfif selectedRegion == newsRegions.id>selected</cfif>>#newsRegions.label#</option>
				</cfloop>
			</select>
			<input type="submit" value="Filter" />
		</form>
	</cfif>

	<cfloop query="newsList">
		<li>
			<img src="#event.buildLink( assetId=newsList.main_image, derivative="listingImage" )#" />
			<a href="#event.buildLink(page=newsList.id)#">#newsList.title# </a>
			<cfif isDate( newsList.date_published ?: "" )>
				<p>Published #dateFormat( newsList.date_published, "dd mmmm, yyyy" )#</p>
			</cfif>
		</li>
	</cfloop>


</cfoutput>
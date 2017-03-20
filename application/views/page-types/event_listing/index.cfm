<cfscript>
	category         = args.categories     ?: queryNew('');
	eventRegions     = args.eventRegions ?: queryNew('');
	eventList        = args.eventList    ?: queryNew('');		
	selectedRegion   = rc.region         ?: "";
	selectedCategory = rc.category       ?: "";
</cfscript>

<cfoutput>
	#renderViewlet( event='page-types.event_listing.listFeaturedEvents' )#	

	<cfloop query="#args.eventList#">
		<h4><a href="#event.buildLink( page=args.eventList.id )#">#args.eventList.title#</a></h4>
		<h6>#args.eventList.main_content#</h6>	
		<h5>
		 #renderViewlet( event="page-types.event_detail.getEventDetailRegions", args={ recordId=args.eventList.id } )#
		| Category : #args.eventList.category#</h5>	
	</cfloop>

	<cfif eventRegions.recordCount and category.recordCount>		
		<form name="filter" action="#event.buildLink()#">
			<select name="region">
				<option value="">All</option>
				<cfloop query="eventRegions">															
					<option value="#eventRegions.id#" <cfif selectedRegion == eventRegions.id>selected</cfif>>#eventRegions.label#</option>
				</cfloop>
			</select>
			<select name="category">
				<option value="">All</option>
				<cfloop query="category">															
					<option value="#category.id#" <cfif selectedCategory == category.id>selected</cfif>>#category.label#
					</option>
				</cfloop>
			<input type="submit" value="Filter" />
		</form>
	</cfif>
	
</cfoutput>
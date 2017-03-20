/**
* @showInSiteTree           false
* @allowedParentPageTypes   news_listing
* @allowedChildPageTypes    none
* @siteTreeGridFields       page.title,date_published,news_author
**/
component  {
	property name="date_published" type="date"    dbtype="date";
	property name="news_author"    type="string"  dbtype="varchar";
	property name="category" relationship="many-to-one"  relatedTo="category";	
	property name="regions"  relationship="many-to-many" relatedTo="region";
}
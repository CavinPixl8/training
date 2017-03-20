/**
* @allowedParentPageTypes   *
* @allowedChildPageTypes    news_detail
*/
component  {
	property name="posts_per_page" dbtype="integer" type="numeric" default=6;
	property name="featured_news"  relationship="many-to-many" relatedTo="news_detail";
	property name="region"         relationship="many-to-one"  relatedTo="region";
	property name="categories"     relationship="many-to-many" relatedTo="category";
}
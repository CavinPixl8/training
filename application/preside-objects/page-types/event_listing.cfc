/**
 * @allowedChildPageTypes  event_detail
 * @allowedParentPageTypes *
 */

component  {
	property name="posts_per_page"  type="numeric" dbtype="integer"; 
	property name="featured_events" relationship="many-to-many" relatedTo="event_detail";
	property name="region"          relationship="many-to-one"  relatedTo="region";
	property name="categories"      relationship="many-to-many"  relatedTo="category";	
}
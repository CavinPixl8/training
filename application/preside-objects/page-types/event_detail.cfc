/**
* @allowedParentPageTypes event_listing
* @allowedChildPageTypes  none
**/
component  {
	property name="organiser"  type="string" dbtype="varchar" maxlength=200;
	property name="location"   type="string" dbtype="varchar" maxlength=200;
	property name="start_date" type="date"   dbtype="date" ;
	property name="regions"    relationship="many-to-many" relatedTo="region";
	property name="category"   relationship="many-to-one"  relatedTo="category" required=true;
	property name="program"    relationship="one-to-many"  relatedTo="program"  relationshipKey="event_detail";
	property name="bookable"   type="boolean" dbtype="boolean";
	property name="price"      type="numeric" dbtype="double" required=true;
	property name="session"    relationship="one-to-many"  relatedTo="session"  relationshipKey="event_detail";
}
/**
*
* @dataManagerGroup Lookups
*
**/
component  {
	property name="event_detail" relationship="many-to-one"  relatedTo="event_detail";
	property name="start_time"   type="datetime" dbtype="datetime" required=true;
}
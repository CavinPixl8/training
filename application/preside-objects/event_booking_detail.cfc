/**
*
* @dataManagerGroup      Events
* @dataManagerGridFields event_detail,email,numberOfSeats,datecreated,datemodified
**/
component  {
	property name="firstname"      type="string"  dbtype="varchar";
	property name="lastname"       type="string"  dbtype="varchar";
	property name="email"          type="string"  dbtype="varchar";
	property name="numberOfSeats"  type="numeric" dbtype="int";
	property name="session"        relationship="many-to-many" relatedTo="session";
	property name="specialRequest" type="string"  dbtype="varchar";
	property name="event_detail"      relationship="many-to-one"  relatedTo="event_detail";
 }
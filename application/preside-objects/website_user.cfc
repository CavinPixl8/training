 component output="false" {

	property name="firstname"  type="string" dbtype="varchar" maxlength=200;

	property name="lastname"   type="string" dbtype="varchar" maxlength=200;

	property name="dob"        type="date" dbtype="datetime";

	property name="gender"     type="string" dbtype="varchar" maxlength=200;

	property name="address"    type="string" dbtype="text";

	property name="category"   relationship="many-to-many"  relatedTo="category" required=true;

}
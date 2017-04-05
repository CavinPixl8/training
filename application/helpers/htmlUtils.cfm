<cfscript>
	private string function FilterHtml( required string input ) output=false {

		return REReplaceNoCase(arguments.input, "<[^[:space:]][^>]*>", "", "ALL");
	}

</cfscript>
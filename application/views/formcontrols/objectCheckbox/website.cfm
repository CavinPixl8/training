<cfscript>
	inputName    = args.name         ?: "";
	inputId      = args.id           ?: "";
	defaultValue = args.defaultValue ?: "";
	placeholder  = args.placeholder  ?: "";
	tabindex     = getNextTabIndex();

	value  = event.getValue( name=inputName, defaultValue=defaultValue );
	if ( not IsSimpleValue( value ) ) {
		value = "";
	}
	value = HtmlEditFormat( value );
</cfscript>

<cfoutput>
	<!--- TODO, your form control HTML here --->
	<p>objectCheckbox form control view not yet implemented</p>
</cfoutput>
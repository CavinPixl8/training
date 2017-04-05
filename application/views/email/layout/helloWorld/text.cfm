<cfscript>
	param name="args.subject"        type="string" default="";
	param name="args.body"           type="string" default="";
	param name="args.viewOnlineLink" type="string" default="";
</cfscript>
<cfoutput>
Hello new layout

#args.body#
View in browser: #args.viewOnlineLink#
</cfoutput>
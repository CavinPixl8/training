<cfscript>
	param name="args.subject" type="string" default="";
	param name="args.body"    type="string" default="";
</cfscript>
<cfoutput>
	<html>
		<head>
			<title>#args.subject#</title>
		</head>
		<body>
			<table>
				<tr>
					<td>Hello new layout</td>
				</tr>
				<tr>
					<td>#args.body#</td>
				</tr>
				<tr>
					<td>View in browser: #args.viewOnlineLink#</td>
				</tr>
			</table>
		</body>
	</html>
</cfoutput>
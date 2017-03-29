<cfscript>
	param name="args.subject" type="string" default="";
	param name="args.body"    type="string" default="";
</cfscript>
<cfoutput>
	<html>
		<head>
			<title>#args.subject#</title>
		</head>
		<h1>My Layout Activated</h1>
		<body>
			<table>
				<tr>
					<td>layout created by Cavin</td>
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
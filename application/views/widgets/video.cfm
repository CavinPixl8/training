<cfparam name="args.width" default="800" />
<cfparam name="args.height" default="500" />
<cfparam name="args.url" default=""/>

<cfset regex = "^(?:[^?]+\?v=|[^v]+/v/)([^&##/]+).*|http://youtu.be/" />
<cfset videoId = rereplace( args.url, regex, "\1" ) />
<cfoutput>
	<h3>Youtube Video Widget</h3>
	<iframe width="#args.width#"
			height="#args.height#"
			src="http://www.youtube.com/embed/#videoId#?autoplay='1' frameborder='0'"
			frameborder="0"
			allowfullscreen>
	</iframe>
</cfoutput>
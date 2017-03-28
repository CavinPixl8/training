<cfscript>
	body     = renderView();
	mainNav  = renderViewlet( "core.navigation.mainNavigation" );
	metaTags = renderView( "/general/_pageMetaForHtmlHead" );
	adminBar = renderView( "/general/_adminToolbar"        );

	event.include( "css-bootstrap" )
	     .include( "css-layout"    )
	     .include( "js-bootstrap"  )
	     .include( "js-jquery"     );
</cfscript>

<cfoutput><!DOCTYPE html>
<html>
	<head>
		#metaTags#

		<meta name="viewport" content="width=device-width, initial-scale=1.0">

		#event.renderIncludes( "css" )#

		<!--[if lt IE 9]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	</head>
	<body>
		<div class="container">
			<div class="header">
				<ul class="nav nav-pills pull-right">
					#mainNav#
				</ul>
				<h3 class="text-muted"><a href="/">Preside CMS</a></h3>
			</div>

			#body#

			<div class="footer">
				<p>&copy; Pixl8 2013-#Year( Now() )#</p>
			</div>
		</div>

		#adminBar#

		<!-- Go to www.addthis.com/dashboard to customize your tools --> <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js##pubid=#getSystemSetting( 'addthis', 'addthis_account', 'ra-5892d392d648a7e1' )#"></script>
		<script>
		var disqus_config = function () {
			this.page.url        = "#event.buildLink( page=event.getCurrentPageID() )#";
			this.page.identifier = "#event.getCurrentPageID()#";
		};

		(function() { // DON'T EDIT BELOW THIS LINE
			var d = document, s = d.createElement('script');
			s.src = 'https://#getSystemSetting( "disqus", "shortname", "test-site-cpon2qkxci" )#.disqus.com/embed.js';
			s.setAttribute('data-timestamp', +new Date());
			(d.head || d.body).appendChild(s);
		})();
		</script>
		<noscript>
			Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a>
		</noscript>
		#event.renderIncludes( "js" )#
	</body>
</html></cfoutput>
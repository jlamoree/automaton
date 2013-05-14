<cfsilent>
	<cfset siteTitle = getSetting("site").title/>
	<cfset pageTitle = event.getValue("pageTitle", "")/>
	<cfif len(pageTitle)>
		<cfset pageTitle = siteTitle & " : " & pageTitle/>
	<cfelse>
		<cfset pageTitle = siteTitle/>
	</cfif>	
	<cfset release = getSetting("release")/>
	<cfset version = getSetting("version")/>
	<cfset environment = getSetting("environment")/>

	<cfif environment eq "development">
		<cfset devMode = true/>
	<cfelse>
		<cfset devMode = false/>
	</cfif>

	<cfset user = event.getValue("user", "", true)/>
</cfsilent>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=device-width"/>

	<cfoutput>
	<title>#pageTitle#</title>
	#renderView(view="fragments/stylesheets", cache=true)#
	</cfoutput>
</head>
<body>
	<cfoutput>
	#renderView("fragments/header")#
	<div class="container">
		<div class="row">
			#renderView()#
		</div>
	</div>
	<div class="container">
		<div class="row">
			#renderView(view="fragments/footer", cache=true)#
		</div>
	</div>
	#renderView(view="fragments/scripts")#
	</cfoutput>
</body>
</html>
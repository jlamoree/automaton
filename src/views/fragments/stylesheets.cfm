<cfsilent>
	<cfset reslease = getSetting("release")/>
	<cfset environment = getSetting("environment")/>
</cfsilent>
<cfoutput>
	<cfif environment eq "development">
		<link rel="stylesheet" type="text/css" href="/css/bootstrap-2.3.1.css?v=#release#"/>
		<link rel="stylesheet" type="text/css" href="/css/style.css?v=#release#"/>
	<cfelse>
		<link rel="stylesheet" type="text/css" href="/css/bootstrap-2.3.1.min.css?v=#release#"/>
		<link rel="stylesheet" type="text/css" href="/css/style.min.css?v=#release#"/>
	</cfif>
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=IM+Fell+DW+Pica+SC">
</cfoutput>
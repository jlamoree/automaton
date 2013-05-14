<cfsilent>
	<cfset siteTitle = getSetting("site").title/>
	<cfset version = getSetting("version")/>
	<cfset release = getSetting("release")/>
	<cfset environment = getSetting("environment")/>
</cfsilent>
<cfoutput>
	<hr/>
	<footer>
		<p class="muted">
			<small>
			#siteTitle# #version# r#release#
			<cfif structKeyExists(server, "railo")>
				on Railo #server.railo.version#
			<cfelseif structKeyExists(server, "bluedragon")>
				on Open BlueDragon #replace(server.bluedragon.productversion, ",", ".", "all")#
			<cfelseif structKeyExists(server, "coldfusion")>
				on Adobe ColdFusion #replace(server.coldfusion.productversion, ",", ".", "all")#
			</cfif>
			<cfif structKeyExists(request, "connection")>
				at #request.connection.node.name#
				<cfif request.connection.node.address neq "0.0.0.0">
					(#request.connection.node.address#:#request.connection.node.port#)
				</cfif>
			</cfif>
			running in #environment# mode
			</small>
		</p>
	</footer>
</cfoutput>
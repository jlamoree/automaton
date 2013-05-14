<cfcomponent extends="coldbox.system.Interceptor" output="false">

	<cfproperty name="sessionStorage" inject="coldbox:plugin:sessionStorage"/>
	<cfproperty name="log" inject="logbox:logger:{this}"/>

	<cffunction name="preEvent" access="public" returntype="void" output="false" >
		<cfargument name="event" required="true" type="coldbox.system.web.context.RequestContext"/>
		<cfargument name="interceptData" required="true" type="struct"/>

		<cfset var _event = arguments.event/>

		<cfif structKeyExists(variables, "log") and variables.log.canDebug()>
			<cfif structKeyExists(session, "sessionId")>
				<cfset variables.log.debug("SessionID: " & session.sessionid)/>
			<cfelse>
				<cfset variables.log.debug("SessionID: undefined")/>
			</cfif>
		</cfif>
		<cfif _event.getCurrentHandler() eq "Auth">
			<!--- Authentication is in progress --->
			<cfreturn/>
		</cfif>
		
		<cfif variables.sessionStorage.exists("user")>
			<cfif structKeyExists(variables, "log") and variables.log.canInfo()>
				<cfset variables.log.info("User exists in sessionStorage. Copied to event as private value.")/>
			</cfif>
			<cfset _event.setValue(name="user", value=variables.sessionStorage.getVar("user"), private=true)/>
		</cfif>
	</cffunction>

</cfcomponent>
<cfcomponent extends="coldbox.system.Interceptor" output="false">

	<cfproperty name="nodeName" inject="coldbox:setting:nodeName"/>
	<cfproperty name="log" inject="logbox:logger:{this}"/>

	<cffunction name="postEvent" access="public" returntype="void" output="false" >
		<cfargument name="event" required="true" type="coldbox.system.web.context.RequestContext"/>
		<cfargument name="interceptData" required="true" type="struct"/>

		<cfset var _event = arguments.event/>

		<cfif structKeyExists(variables, "log") and variables.log.canDebug()>
			<cfset variables.log.debug("Adding HTTP header X-Node=" & variables.nodeName)/>
		</cfif>
		<cfset _event.setHTTPHeader(name="X-Node", value=variables.nodeName)/>
	</cffunction>

</cfcomponent>
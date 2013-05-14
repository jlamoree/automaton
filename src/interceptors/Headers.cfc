<cfcomponent extends="coldbox.system.Interceptor" output="false">

	<cfproperty name="nodeName" inject="coldbox:setting:nodeName"/>
	<cfproperty name="log" inject="logbox:logger:{this}"/>

	<cffunction name="preEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var headers = "null"/>
		<cfset var item = "null"/>
		
		<cfif not structKeyExists(variables, "log") or not variables.log.canDebug()>
			<!--- No need to continue if nothing will be output to the log --->
			<cfreturn/>
		</cfif>
		
		<cfset headers = getHTTPRequestData().headers/>
		<cfloop collection="#headers#" item="item">
			<cfset variables.log.debug("Header #item#=#headers[item]#")/>
		</cfloop>
		<cfloop collection="#cookie#" item="item">
			<cfset variables.log.debug("Cookie #item#=#cookie[item]#")/>
		</cfloop>
	</cffunction>

	<cffunction name="postEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>
		<cfargument name="interceptData" type="struct" required="false"/>

		<cfset var _event = arguments.event/>

		<cfif structKeyExists(variables, "log") and variables.log.canDebug()>
			<cfset variables.log.debug("Adding HTTP header X-Node=" & variables.nodeName)/>
		</cfif>
		<cfset _event.setHTTPHeader(name="X-Node", value=variables.nodeName)/>
	</cffunction>

</cfcomponent>
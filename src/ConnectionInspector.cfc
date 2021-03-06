<cfcomponent output="false">

	<cffunction name="init" returntype="ConnectionInspector" access="public" output="false">
		<cfargument name="options" type="struct" required="false"/>

		<cfif structKeyExists(arguments, "options")>
			<cfset variables.defaults = arguments.options/>
		<cfelse>
			<cfset variables.defaults = structNew()/>
			<cfset variables.defaults.appProxyServerHostHeaderName = "@APP_PROXY_SERVER_HOST_HEADER_NAME@"/>
			<cfset variables.defaults.appProxyServerAddressHeaderName = "@APP_PROXY_SERVER_ADDRESS_HEADER_NAME@"/>
			<cfset variables.defaults.appProxyServerPortHeaderName = "@APP_PROXY_SERVER_PORT_HEADER_NAME@"/>
			<cfset variables.defaults.appProxyClientAddressHeaderName = "@APP_PROXY_CLIENT_ADDRESS_HEADER_NAME@"/>
			<cfset variables.defaults.appProxySchemeHeaderName = "@APP_PROXY_SCHEME_HEADER_NAME@"/>
			<cfset variables.defaults.geoIpCountryHeaderName = "@GEOIP_COUNTRY_HEADER_NAME@"/>
			<cfset variables.defaults.geoIpRegionCodeHeaderName = "@GEOIP_REGION_CODE_HEADER_NAME@"/>
			<cfset variables.defaults.geoIpRegionNameHeaderName = "@GEOIP_REGION_NAME_HEADER_NAME@"/>
			<cfset variables.defaults.geoIpCityHeaderName = "@GEOIP_CITY_HEADER_NAME@"/>
			<cfset variables.defaults.geoIpCoordsHeaderName = "@GEOIP_COORDS_HEADER_NAME@"/>
			<cfset variables.defaults.geoIpDmaCodeHeaderName = "@GEOIP_DMA_CODE_HEADER_NAME@"/>
		</cfif>

		<cfif structKeyExists(arguments, "options") and structKeyExists(arguments.options, "nodeName")>
			<cfset variables.nodeName = arguments.options.nodeName/>
		<cfelse>
			<cfset variables.nodeName = resolveNodeName()/>
		</cfif>
		<cfreturn this/>
	</cffunction>

	<cffunction name="getConnectionMemento" returntype="struct" access="public" output="false">
		<cfset var memento = structNew()/>
		<cfset var headers = getHttpRequestData().headers/>
		<cfset var d = variables.defaults/>

		<cfset memento.node = structNew()/>
		<cfset memento.node.name = variables.nodeName/>
		<cfset memento.node.host = structValue(cgi, "SERVER_NAME", "unknown")/>
		<cfset memento.node.address = structValue(cgi, "SERVER_ADDR", "0.0.0.0")/> <!--- TODO: See if we can obtain this from the JEE container --->
		<cfset memento.node.port = structValue(cgi, "SERVER_PORT", "0")/>

		<cfset memento.server = structNew()/>
		<cfset memento.client = structNew()/>
		<cfset memento.client.geoip = structNew()/>

		<cfset memento.server.host = structValue(headers, d.appProxyServerHostHeaderName, "unknown")/>
		<cfset memento.server.address = structValue(headers, d.appProxyServerAddressHeaderName, "0.0.0.0")/>
		<cfset memento.server.port = structValue(headers, d.appProxyServerPortHeaderName, "0")/>
		<cfset memento.client.address = structValue(headers, d.appProxyClientAddressHeaderName, "0.0.0.0")/>
		<cfset memento.client.geoip.country = structValue(headers, d.geoIpCountryHeaderName, "")/>
		<cfset memento.client.geoip.regionCode = structValue(headers, d.geoIpRegionCodeHeaderName, "")/>
		<cfset memento.client.geoip.regionName = structValue(headers, d.geoIpRegionNameHeaderName, "")/>
		<cfset memento.client.geoip.city = structValue(headers, d.geoIpCityHeaderName, "")/>
		<cfset memento.client.geoip.coords = structValue(headers, d.geoIpCoordsHeaderName, "")/>
		<cfset memento.client.geoip.dmaCode = structValue(headers, d.geoIpDmaCodeHeaderName, "")/>
		<cfreturn memento/>
	</cffunction>

	<cffunction name="structValue" returntype="any" access="private" output="false">
		<cfargument name="struct" type="struct" required="true"/>
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="default" type="any" required="false"/>

		<cfif structKeyExists(arguments.struct, arguments.name)>
			<cfreturn arguments.struct[arguments.name]/>
		<cfelseif structKeyExists(arguments, "default")>
			<cfreturn arguments.default/>
		<cfelse>
			<cfreturn/>
		</cfif>
	</cffunction>

	<cffunction name="resolveNodeName" returntype="string" access="private" output="false">
		<cfset var name = ""/>

		<cftry>
			<cfset name = createObject("java", "java.net.InetAddress").getLocalHost().getHostName()/>
			<cfcatch>
				<cfset name = "unknown"/>
			</cfcatch>
		</cftry>
		<cfreturn name/>
	</cffunction>

</cfcomponent>

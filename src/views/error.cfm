<cfsilent>

	<cfset bean = event.getValue("exceptionBean", "")/>
	<cfif not isObject(bean)>
		<!--- Probably some mischief going on here. --->
		<cfabort/>
	</cfif>
	
	<cfset tagContext = bean.getTagContext()/>
	
</cfsilent>
<cfoutput>
	<cfif not devMode>
		<p>The server has experienced an error processing your request. Our staff has been notified and will work to resolve the problem. Thanks for your patience.</p>
	<cfelse>
		<h2>#bean.getExtraMessage()#</h2>
		
		<cfif len(bean.getType())>
			<p>
				<strong>Error Type:</strong> #bean.getType()#:
				<cfif not len(bean.getErrorCode())>[N/A]<cfelse>#bean.getErrorCode()#</cfif>
			</p>
		</cfif>

		<cfif isStruct(bean.getExceptionStruct())>
			<p><strong>Error Messages:</strong> #bean.getMessage()#</p>
			<cfif len(bean.getExtendedInfo())>
				<p>#bean.getExtendedInfo()#</p>
		 	</cfif>
		 	<cfif len(bean.getDetail())>
			 	<p>#bean.getDetail()#</p>
			 </cfif>
		</cfif>

		<cfif arrayLen(tagContext)>
			<table class="table condensed">
				<!---
			<thead>
				<tr>
					<th>ID</th>
					<th>Line</th>
					<th>File</th>
				</tr>
			</thead>
			--->
			<tbody>
			<cfloop array="#tagContext#" index="item">
				<tr>
					<td class="text-right">ID:</td>
					<td><cfif structKeyExists(item, "id")>#item.id#<cfelse>??</cfif></td>
				</tr>
				<tr>
					<td class="text-right">Line:</td>
					<td><cfif structKeyExists(item, "line")>#item.line#<cfelse>??</cfif></td>
				</tr>
				<tr>
					<td class="text-right">Template:</td>
					<td><cfif structKeyExists(item, "template")>#item.template#<cfelse>??</cfif></td>
				</tr>
			</cfloop>
			</tbody>
			</table>
		</cfif>
		
	</cfif>
</cfoutput>
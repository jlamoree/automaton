<cfsilent>
	<cfset siteTitle = getSetting("site").title/>
	<cfset pageId = event.getValue("pageId", "")/>
	<cfset user = event.getValue(name="user", private="true", defaultValue="")/>
</cfsilent>
<cfoutput>
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="/Home/index">#siteTitle#</a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">
						<cfif isObject(user)>
							Hello, #user.getFirstName()# #user.getLastName()#. <a href="/Auth/logout" id="logoutLink" class="navbar-link">Logout</a>
						<cfelseif not event.getCurrentHandler() eq "Auth">
							<a href="/Auth/index" id="loginLink" class="navbar-link">Login</a>
						</cfif>
					</p>
					<ul class="nav">
						<li class="#iif(pageId eq 'home', de('active'), de(''))#"><a href="/Home/index">Home</a></li>
						<li class="#iif(pageId eq 'media', de('active'), de(''))#"><a href="/Home/media">Media</a></li>
						<li class="#iif(pageId eq 'about', de('active'), de(''))#"><a href="/Home/about">About</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
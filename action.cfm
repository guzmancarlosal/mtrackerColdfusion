<cfparam name="form.mode" default="">
<cfparam name="request.ODBC" default="cc_mtracker">

<cfif form.mode eq "orgAction">
	<cfparam name="form.orgID" default="">
	<cfset orgObj = createObject("component","library.cfc.org").init(odbc=request.ODBC)>
	<cfif form.name neq "">
		<cfif form.orgID eq "">
			<cfset qOrgs = orgObj.addOrg(name="#form.name#", status="#form.active#")>
		<cfelse>
			<cfset qOrgs = orgObj.updateOrg(name="#form.name#", status="#form.active#", orgID="#form.orgID#")>
		</cfif>
		
	</cfif>
<cfelseif form.mode eq "siteAction">
	<cfparam name="form.siteID" default="">
	<cfset siteObj = createObject("component","library.cfc.loc").init(odbc=request.ODBC)>
	<cfif form.name neq "">
		<cfif form.siteID eq "">
			<cfset qSite = siteObj.addLoc(name="#form.name#", status="#form.active#",orgid="#form.orgid#", country="#form.country#")>
		<cfelse>
			<cfset qSite = siteObj.updateLoc(name="#form.name#", status="#form.active#", siteID="#form.siteID#",orgID="#form.orgID#", country="#form.country#")>
		</cfif>
	</cfif>
<cfelseif form.mode eq "userAction">
	<cfparam name="form.userID" default="">
	<cfset userObj = createObject("component","library.cfc.user").init(odbc=request.ODBC)>
	<cfif form.name neq "">
		<cfif form.userID eq "">
			<cfset qUser = userObj.addUser()>
		<cfelse>
			<cfset qUser = userObj.updateUser()>
		</cfif>
	</cfif>
<cfelseif form.mode eq "mAction">
	<cfparam name="form.mID" default="">
	<cfset mObj = createObject("component","library.cfc.machine").init(odbc=request.ODBC)>
	<cfif form.name neq "">
		<cfif form.mID eq "">
			<cfset qUser = mObj.addm()>
		<cfelse>
			<cfset qUser = mObj.updatem()>
		</cfif>
	</cfif>
</cfif>
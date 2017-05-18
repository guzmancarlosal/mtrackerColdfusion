<cfparam name="form.mode" default="">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfsetting showdebugoutput="true">
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
	<cfparam name="form.username" default="">
	<cfset userObj = createObject("component","library.cfc.user").init(odbc=request.ODBC)>
	<cfif form.username neq "">
		<cfif form.userID eq "">
			<cfset qUser = userObj.addUser(username=form.username, password=form.username, type=form.type, password=form.password, status=form.status, locList= form.locList, machineList=form.machineList)>
			
		<cfelse>
			<cfset qUser = userObj.updateUser(userID=form.userID,username=form.username, password=form.username, type=form.type, password=form.password, status=form.status, locList= form.locList, machineList=form.machineList)>
		</cfif>
	</cfif>
<cfelseif form.mode eq "mAction">
	<cfparam name="form.mID" default="">
	<cfset mObj = createObject("component","library.cfc.machine").init(odbc=request.ODBC)>
	<cfif form.name neq "">
		<cfif form.mID eq "">
			<cfset qUser = mObj.addm(name=form.name, status=form.status, idLoc=form.idLoc, type=form.type)>
		<cfelse>
			<cfset qUser = mObj.updatem(name=form.name, status=form.status, idLoc=form.idLoc, type=form.type,machineid=form.mID, capacity=form.capacity)>
		</cfif>
	</cfif>
</cfif>
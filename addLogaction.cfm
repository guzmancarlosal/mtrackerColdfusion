<cfparam name="form.machineStatus" default="">
<cfparam name="form.date" default="">
<cfparam name="form.pie1" default="">
<cfparam name="form.pie2" default="">
<cfparam name="form.idMachine" default="">
<cfparam name="form.comments" default="">
<cfparam name="form.idUser" default="">
<cfparam name="form.machineName" default="">
<cfparam name="form.notificationEmail" default="">
<cfparam name="variables.EmailSender" default="mTracker@xikmaapps.com">
<cfparam name="form.iscustomDate" default="false">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfparam name="form.day" default="">
<cfparam name="form.hour" default="">

<cfprocessingdirective pageencoding = "utf-8">
<cfset lObj = createObject("component","library.cfc.report").init(odbc=request.ODBC)>
<cfif form.iscustomDate eq "true" and form.hour neq "" and form.day neq "">
		<cfset local.DateRecorded = dateformat(form.day,"yyyy-mm-dd") & " " &form.hour> yes thing
	<cfelse>
		<cfset local.DateRecorded = now()>
</cfif>
<cfdump var="#form#">

<cfset qSite = lObj.addLog(machineStatus=form.machineStatus, date=local.DateRecorded, pie1=form.pie1, pie2=form.pie2, idMachine=form.idMachine,comments=form.comments, userID=form.idUser)>
<cfif isdefined("form.notification") and form.notification eq 1 and isdefined("form.notificationEmail")>
	<cfset local.thismachineStatus ="">
	<cfif form.machineStatus eq 1><cfset local.thismachineStatus ="Activo"><cfelse><cfset local.thismachineStatus ="Inactivo"></cfif>
	<cfmodule TEMPLATE="library\customtags\Email.cfm" 
		TO="#form.notificationEmail#"
		FROM="#variables.EmailSender#"
		SUBJECT="[#local.thismachineStatus#] #form.machineName# #dateformat( local.DateRecorded,"dd-mmm-yyyy")# a las #TimeFormat(local.DateRecorded, "hh:mm:sstt")#"
		mode="addLog"
		struct="#form#">

</cfif>
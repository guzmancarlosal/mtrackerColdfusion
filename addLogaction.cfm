<cfparam name="form.machineStatus" default="">
<cfparam name="form.date" default="">
<cfparam name="form.pie1" default="">
<cfparam name="form.pie2" default="">
<cfparam name="form.idMachine" default="">
<cfparam name="form.comments" default="">
<cfparam name="form.idUser" default="">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfset lObj = createObject("component","library.cfc.report").init(odbc=request.ODBC)>
<cfset qSite = lObj.addLog(machineStatus=form.machineStatus, date=form.date, pie1=form.pie1, pie2=form.pie2, idMachine=form.idMachine,comments=form.comments, userID=form.idUser)>
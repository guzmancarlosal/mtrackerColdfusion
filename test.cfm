<cfparam name="form.idUser" default="1">
<cfparam name="form.machineName" default="2">
<cfparam name="form.notificationEmail" default="carlosaguzman@gmail.com">
<cfparam name="variables.EmailSender" default="MTracker@xikmaapps.com">
<cfprocessingdirective pageencoding = "utf-8">

 testing email
<cfmodule TEMPLATE="library\customtags\Email.cfm" 
	TO="#form.notificationEmail#"
	FROM="#variables.EmailSender#"
	SUBJECT="Última Actualización de la máquina #form.machineName# #dateformat(now())# a las #TimeFormat(now(), "hh:mm:sstt")#"
	mode="addLog"
	onScreen="false"
	struct="#form#">

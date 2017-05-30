<cfprocessingdirective pageencoding = "utf-8">

<cfparam name="attributes.to" default="">
<cfparam name="attributes.from" default="">
<cfparam name="attributes.subject" default="">
<cfparam name="attributes.mode" default="">

<cfmail 
	to="#attributes.to#" 
	from="#attributes.from#" 
	subject="#attributes.subject#"
	type="html">
	<cfoutput>
		<html>
			<head>
            <style>

                .bg-inverse {
                    background-color: ##005e85 !important;
                }
                b {
                     font-size: 18px  !important;
                }
                table { border-collapse: collapse; }
                table td {
				    border-top: thin solid; 
				    border-bottom: thin solid;
				}

				table td:first-child {
				    border-left: thin solid;
				}

				table td:last-child {
				    border-right: thin solid;
				}
            </style>
            </head>
            Este email ha sido generado automáticamente por la Aplicación MTracker, favor de no responderlo.<br><br>
        	<table width ="100%" border=1 style="font-size: 14px">
        		<tr><td colspan="2" style="background-color:##005e85">&nbsp;<img src="http://mtracker-webxikma-com.securec102.ezhostingserver.com/img/mTrackericonsmal.png"><span style="color:white"><b>MTracker<b></span></td><tr>

		        <cfif attributes.mode eq "addLog">
		        	<cfparam name="attributes.struct.machineName" default="">
		        	<cfparam name="attributes.struct.machineStatus" default="1">
		        	<cfparam name="attributes.struct.pie1" default="">
		        	<cfparam name="attributes.struct.pie2" default="">
		        	<cfparam name="attributes.struct.comments" default="">
		        	<cfparam name="attributes.struct.machineCapacity" default="">
		        	<tr><td colspan="2">Se ha actualizado la maquina <b>#attributes.struct.machineName#</b> con fecha <b>#dateformat(now())#</b> a las <b>#TimeFormat(now(), "hh:mm:sstt")#</b>
		        	<tr><td>Estatus de la Máquina : </td><td><b><cfif attributes.struct.machineStatus eq 1><span style="color:green;">Activo</span><cfelse><span style="color:red;">Inactivo</span></cfif></b></td></tr>
		        	<tr><td>Capacidad de Producción : </td><td><b> #machineCapacity#</b></td></tr>
		        	<tr><td>Piezas producidas : </td><td><b> #attributes.struct.pie1#</b></td></tr>
		        	<tr><td>Piezas buenas : </td><td><b> #attributes.struct.pie2#</b></td></tr>
		        	<tr><td>Comentarios : </td><td><b>#attributes.struct.comments#</b></td></tr>
		        	<tr><td colspan="2">Últimas 24 horas:</tr>
		        	<tr><td colspan="2">[Grafica aquí]</td> </tr>

		        </cfif>
	        </table>
	    </html>
        </cfoutput>
</cfmail>

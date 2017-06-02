<cfprocessingdirective pageencoding = "utf-8">

<cfparam name="attributes.to" default="">
<cfparam name="attributes.from" default="">
<cfparam name="attributes.subject" default="">
<cfparam name="attributes.mode" default="">
<cfparam name="attributes.onScreen" default="false">

<cfsavecontent variable="emailoutput">
	

	<cfoutput>
		<html>
			<head>
				<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
			    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
			    <script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
			    <script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js"></script>
			    <script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/vfs_fonts.js"></script> 
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
           <script type="text/javascript">
		      google.charts.load('current', {'packages':['corechart']});
		      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Hora', 'Máquina1', 'Máquina2',  'Máquina3'],
          <cfloop from="00" to="22" index="i">
            ['#i#', #randRange(800, 1000)#, #randRange(200, 500)#,  #randRange(0, 80)#],
          </cfloop>
      		['23',  880,       70,  10 ]
        ]);

        var options = {
          title: 'Producción por Máquina en las últimas 24 horas',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
        google.visualization.events.addListener(chart, 'ready', function () {
        curve_chart.innerHTML = '<img src="' + chart.getImageURI() + '">';
            console.log(curve_chart.innerHTML);
          });

        chart.draw(data, options);

     }
    </script>
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
		        	<cfparam name="attributes.struct.machineID" default="1">
		        	<tr><td colspan="2">Se ha actualizado la maquina <b>#attributes.struct.machineName#</b> con fecha <b>#dateformat(now())#</b> a las <b>#TimeFormat(now(), "hh:mm:sstt")#</b>
		        	<tr><td>Estatus de la Máquina : </td><td><b><cfif attributes.struct.machineStatus eq 1><span style="color:green;">Activo</span><cfelse><span style="color:red;">Inactivo</span></cfif></b></td></tr>
		        	<tr><td>Capacidad de Producción : </td><td><b> #machineCapacity#</b></td></tr>
		        	<tr><td>Piezas producidas : </td><td><b> #attributes.struct.pie1#</b></td></tr>
		        	<tr><td>Piezas buenas : </td><td><b> #attributes.struct.pie2#</b></td></tr>
		        	<tr><td>Comentarios : </td><td><b>#attributes.struct.comments#</b></td></tr>
		        	<!---<tr><td colspan="2">Últimas 24 horas:</tr>
		        	<tr>
		        		<td colspan="2">
		        			 <div id="curve_chart" style="height:400px" ></div>
		        		</td> 
		        	</tr>--->

		        </cfif>
	        </table>
	    </html>
        </cfoutput>
</cfsavecontent>
<cfif attributes.onScreen>
	<cfoutput>#emailoutput#</cfoutput>
<cfelse>
	<cfmail 
		to="#attributes.to#" 
		from="#attributes.from#" 
		subject="#attributes.subject#"
		type="html">
		<cfoutput>#emailoutput#</cfoutput>
	</cfmail>
</cfif>

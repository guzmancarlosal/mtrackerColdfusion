<Cfif #GetUserRoles()#  neq 4 and #GetUserRoles()#  neq 1>
	<cfinclude template="deny.cfm">
	<cfabort>
</Cfif>
<cfparam name="request.ODBC" default="cc_mtracker">
<cfset uObj = createObject("component","library.cfc.machine").init(odbc=request.ODBC)>
<cfset qMachine = uObj.getAllm()>

<cfoutput>
  <!DOCTYPE html>
  <html>
    <head>
      <cfprocessingdirective pageencoding = "utf-8">
      <title>MTracker</title>
      <link href="css/justified-nav.css" rel="stylesheet">
      <link rel="icon" href="img/mTrackericonsmal.png">
    </head>
    <body>
    	<div class="container">
			
		 	<h2><i class="fa fa-cog" aria-hidden="true"></i>  Lista de Máquinas</h2>
		  	<p><a class="btn btn-success" href="machineAdd.cfm" role="button" id="startBtn">Agregar una Máquina</a> <a class="btn btn-danger" href="admin.cfm" role="button" id="startBtn">Regresar</a></p>  
		  
		  	<p>Selecciona una Máquina a editar, eliminarla con el boton X</p>         
			<table class="table">
			    <thead>
			      <tr>
			        
			        <th>Nombre</th>
			        <th>tipo</th>
			        <th>Estatus</th>
			        <th>Sitio</th>
			        <th>Capacidad por hora</th>
			      </tr>
			    </thead>
			    <tbody>
			    <cfloop query="qMachine">
			     	<tr>
			     		<td><a  href="machineAdd.cfm?mID=#qMachine.id#" role="button" id="startBtn"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> #qMachine.name# </a></td>
			     		<td>#qMachine.type#</td>
			     		<td><cfif qMachine.status eq 1>Activo<cfelse>Inactivo</cfif></td>
			     		<td>#qMachine.loc#</td>
			     		<td>#qMachine.capacity#</td>
			     	<tr>
			     </cfloop>
			    </tbody>
			</table>
		</div>

		<div class="container">
			<footer class="footer">
	    		<p>&copy; Xikma Apps #year(now())#</p>
	    	</footer>
		</div>
		
	      <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	      <script src="js/ie10-viewport-bug-workaround.js"></script>
    </body>
  </html>
</cfoutput>
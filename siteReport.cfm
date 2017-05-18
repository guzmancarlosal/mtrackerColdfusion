<Cfif #GetUserRoles()#  neq 4>
	<cfinclude template="deny.cfm">
	<cfabort>
</Cfif>
<cfparam name="request.ODBC" default="cc_mtracker">
<cfset locObj = createObject("component","library.cfc.loc").init(odbc=request.ODBC)>
<cfset qLocs = locObj.getAllLocs()>

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
			
		 	<h2><i class="fa fa-area-chart" aria-hidden="true"></i> Lista de Sitios</h2>
		  	<p><a class="btn btn-success" href="siteAdd.cfm" role="button" id="startBtn">Agregar un Sitio</a> <a class="btn btn-danger" href="admin.cfm" role="button" id="startBtn">Regresar</a></p>  
		  
		  	<p>Selecciona un Sitio a editar, eliminala con el boton X</p>         
			<table class="table">
			    <thead>
			      <tr>
			        <th>ID</th>
			        <th>Organizacion</th>
			        <th>Estatus</th>
			        <th>Fecha Creado</th>
			        <th>Pais</th>
			      </tr>
			    </thead>
			    <tbody>
			    <cfloop query="qLocs">
			     	<tr>
			     		<td><a  href="siteAdd.cfm?siteID=#qLocs.id#" role="button" id="startBtn"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> #qLocs.name#</a></td>
			     		<td>#qlocs.orgid#</td>
			     		<td><cfif qLocs.status eq 1>Activo<cfelse>Inactivo</cfif></td>
			     		<td>#qLocs.dateCreated#</td>
			     		<td>#qLocs.country#</td>
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
<cfparam name="request.ODBC" default="cc_mtracker">
<cfset orgObj = createObject("component","library.cfc.org").init(odbc=request.ODBC)>
<cfset qOrgs = orgObj.getAllOrgs()>
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
			
		 	<h2><i class="fa fa-sitemap" aria-hidden="true"></i> Lista de Organizaciones</h2>
		  	<p><a class="btn btn-success" href="orgAdd.cfm" role="button" id="startBtn">Agregar una Organización</a> <a class="btn btn-danger" href="admin.cfm" role="button" id="startBtn">Regresar</a></p>  
		  
		  	<p>Selecciona una organización a editar</p>         
			<table class="table">
			    <thead>
			      <tr>
			        <th>Nombre</th>
			        <th>Estatus</th>
			        <th>Fecha Creada</th>
			      </tr>
			    </thead>
			    <tbody>
			    <cfloop query="qOrgs">
			     	<tr>
			     		<td><a  href="orgAdd.cfm?orgID=#qOrgs.id#" role="button" id="startBtn">#qOrgs.name# <i class="fa fa-pencil-square-o" aria-hidden="true"></a></td>
			     		<td><cfif qOrgs.status eq 1>Activa<cfelse>Inactiva</cfif></td>
			     		<td>#dateformat(qOrgs.dateCreated,"dd-mmm-yyyy")#</td>
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
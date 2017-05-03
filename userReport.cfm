<cfparam name="request.ODBC" default="cc_mtracker">
<cfset userObj = createObject("component","library.cfc.user").init(odbc=request.ODBC)>
<cfset qUsers = userObj.getAllUsers()>

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
			
		 	<h2>Lista de Usuarios</h2>
		  	<p><a class="btn btn-success" href="userAdd.cfm" role="button" id="startBtn">Agregar un Usuario</a> <a class="btn btn-danger" href="admin.cfm" role="button" id="startBtn">Regresar</a></p>  
		  
		  	<p>Selecciona un Usuario a editar, eliminala con el boton X</p>         
			<table class="table">
			    <thead>
			      <tr>
			        <th>ID</th>
			        <th>Nombre</th>
			        <th>Password</th>
			        <th>Estatus</th>
			        <th>Tipo</th>
			      </tr>
			    </thead>
			    <tbody>
			    <cfloop query="qUsers">
			     	<tr>
			     		<td><a  href="userAdd.cfm?userID=#qUsers.id#" role="button" id="startBtn">#qUsers.id#</a></td>
			     		<td>#qUsers.username#</td>
			     		<td><cfif qUsers.password neq "">***********<cfelse>sin Password</cfif></td>
			     		<td>#qUsers.status#</td>
			     		<td>#qUsers.type#</td>
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
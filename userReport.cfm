<cfparam name="request.ODBC" default="cc_mtracker">
<cfset userObj = createObject("component","library.cfc.user").init(odbc=request.ODBC)>
<cfset qUsers = userObj.getAllUsers()>
<cfquery name="qRole" datasource="#request.odbc#">
	Select * from role where status=1
</cfquery>

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
			
		 	<h2><i class="fa fa-users" aria-hidden="true"></i> Lista de Usuarios</h2>
		  	<p><a class="btn btn-success" href="userAdd.cfm" role="button" id="startBtn"> Agregar un Usuario</a> <a class="btn btn-danger" href="admin.cfm" role="button" id="startBtn">Regresar</a></p>  
		  
		  	<p>Selecciona un Usuario a editar</p>         
			<table class="table">
			    <thead>
			      <tr>
			        <th>Nombre</th>
			        <th>Password</th>
			        <th>Estatus</th>
			        <th>Tipo</th>
			      </tr>
			    </thead>
			    <tbody>
			    <cfloop query="qUsers">
			     	<tr>
			     		<td><a  href="userAdd.cfm?userID=#qUsers.id#" role="button" id="startBtn">#qUsers.username# <i class="fa fa-pencil-square-o" aria-hidden="true"></a></td>
			     		<td><cfif qUsers.password neq "">***********<cfelse>sin Password</cfif></td>
			     		<td><cfif qUsers.status eq 1 >Activo<cfelse>Inactivo</cfif></td>
			     		<td>
			     			<cfloop query="#qRole#">
			     				<cfif qRole.id eq qUsers.type>
			     					#qRole.name#
			     				</cfif>
			     			</cfloop>
			     		</td>
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
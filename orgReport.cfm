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
    </head>
    <body>
    	<div class="container">
			
		 	<h2>Lista de Organizaciones</h2>
		  	<p><a class="btn btn-success" href="orgAdd.cfm" role="button" id="startBtn">Agregar una Organización</a></p>  
		  	<p>Selecciona una organización a editar, eliminala con el boton X</p>         
			<table class="table">
			    <thead>
			      <tr>
			        <th>ID</th>
			        <th>Nombre</th>
			        <th>Estatus</th>
			        <th>Fecha Creada</th>
			        <th>Eliminar</th>
			      </tr>
			    </thead>
			    <tbody>
			    <cfloop query="qOrgs">
			     	<tr>
			     		<td>#qOrgs.id#<td>
			     		<td>#qOrgs.name#<td>
			     		<th>#qOrgs.dateCreated#</th>
			     		<td>#qOrgs.active#<td>
			     		<td><span class="glyphicon glyphicon-remove"></span><td>
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
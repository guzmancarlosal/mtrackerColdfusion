<Cfif #GetUserRoles()#  neq 4 and #GetUserRoles()#  neq 1>
	<cfinclude template="deny.cfm">
	<cfabort>
</Cfif>
<cfoutput>

  <!DOCTYPE html>
  <html>
    <head>
      <cfprocessingdirective pageencoding = "utf-8">
      <title>MTracker</title>
      <link href="css/justified-nav.css" rel="stylesheet">
      <style>
       button { 
		  width: 100%;
		}
      </style>
    </head>
    <body>
    	<div class="container">
	    	<!-- Jumbotron -->
	    	
	    	<div class="jumbotron">
		    	<h1>#application.applicationname# Administración</h1>
		    	<p class="lead">Selecciona el modulo a Administrar</p>
	   		</div>
		    <div class="row">
				<div class="col-sm-3 text-center">
					<p><a class="btn btn-lg btn-success" href="userReport.cfm" role="button" id="startBtn"><i class="fa fa-users" aria-hidden="true"></i> Usuario</a></p>
				</div>
				<div class="col-sm-3 text-center">
					<p>Agregar, modificar, eliminar datos de usuarios</p>
				</div>
				<div class="col-sm-3 text-center">
					<p><a class="btn btn-lg btn-success" href="machineReport.cfm" role="button" id="startBtn"><i class="fa fa-cog" aria-hidden="true"></i> Máquina</a></p>
				</div>
				<div class="col-sm-3 text-center">
					<p>Agregar, modificar, eliminar Máquinas</p>
				</div>
				
			</div>
			<Cfif #GetUserRoles()#  eq 4>
				<div class="row">
					<div class="col-sm-3 text-center">
						<p><a class="btn btn-lg btn-success " href="orgReport.cfm" role="button" id="startBtn"><i class="fa fa-sitemap" aria-hidden="true"></i> Organización</a></p>
					</div>
					<div class="col-sm-3 text-center">
						<p>Agregar, modificar, eliminar datos de Organización</p>
					</div>
					<div class="col-sm-3 text-center">
						<p><a class="btn btn-lg btn-success" href="siteReport.cfm" role="button" id="startBtn"><i class="fa fa-area-chart" aria-hidden="true"></i> Sitio</a></p>
					</div>
					<div class="col-sm-3 text-center">
						<p>Agregar, modificar, eliminar datos de Sitios</p>
					</div>
				</div>
			</Cfif>
			
		</div>
		<div class="container">
			<div class="col-sm-4 text-center">&nbsp;</div>
		</div>
		<div class="container">
			<div class="col-sm-4 text-center">&nbsp;</div>
		</div>
		<div class="container">
			<div class="col-sm-4 text-center">&nbsp;</div>
		</div>
		<div class="container">
			<div class="col-sm-4 text-center">&nbsp;</div>
		</div>
		<div class="container">
			<footer class="footer">
	    		<p>&copy; Xikma Apps #year(now())#</p>
	    	</footer>
		</div>
		<!---<div class="container">
			<div class="alert alert-danger text-center" role="alert">
				<div class="row">
					<div class="col-sm-12 text-center">
			   			<p class="lead" style="color:red">Zona de peligro</p>
				    </div>
				    </div>
				<div class="row">
					<div class="col-sm-6 text-center">
						<p><a class="btn btn-lg btn-danger" href="##" role="button" id="startBtn">Eliminar Usuario</a></p>
					</div> 
					<div class="col-sm-6 text-center">
						<p><a class="btn btn-lg btn-danger" href="##" role="button" id="startBtn">Eliminar Maquina</a></p>
					</div>
				</div>
			</div>
	    	<!-- Site footer -->
	    	<footer class="footer">
	    		<p>&copy; Xikma Apps #year(now())#</p>
	    	</footer>
	    </div> <!-- /container -->--->
	      <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	      <script src="js/ie10-viewport-bug-workaround.js"></script>
    </body>
  </html>
</cfoutput>

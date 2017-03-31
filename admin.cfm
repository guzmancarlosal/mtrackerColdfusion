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
	    	<!-- Jumbotron -->
	    	<div class="jumbotron">
		    	<h1>Bienvenido a #application.applicationname# Administración</h1>
		    	<p class="lead">Selecciona el elemento a Administrar</p>
	   		</div>
		    <div class="row">
				<div class="col-sm-4 text-center">
					<p><a class="btn btn-lg btn-success" href="##" role="button" id="startBtn">Alta Usuarios</a></p>
				</div>
				<div class="col-sm-4 text-center">
					<p><a class="btn btn-lg btn-success" href="##" role="button" id="startBtn">Alta Máquinas</a></p>
				</div>
				<div class="col-sm-4 text-center">
					<p><a class="btn btn-lg btn-success" href="##" role="button" id="startBtn">Asignar Usuario a Maquina</a></p>
				</div>
			</div>
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
			<div class="col-sm-4 text-center">&nbsp;</div>
		</div>
		<div class="container">
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
	    </div> <!-- /container -->
	      <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	      <script src="js/ie10-viewport-bug-workaround.js"></script>
    </body>
  </html>
</cfoutput>

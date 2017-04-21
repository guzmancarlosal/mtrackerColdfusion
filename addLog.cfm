<cfparam name="url.machineid" default="">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfquery name="qGetMachine" datasource="#request.ODBC#">
  SELECT name 
  FROM machine 
  WHERE id='#url.machineid#'
  	AND status = 1
</cfquery>
<!DOCTYPE html>
<html>
<head>
  <cfprocessingdirective pageencoding = "utf-8">
  <link rel="icon" href="../../favicon.ico">

  <title>Log Machine Status</title>
  <!-- Custom styles for this template -->
  <script>
	function startTime() {
		var today = new Date();
		var h = today.getHours();
		var m = today.getMinutes();
		var s = today.getSeconds();
		m = checkTime(m);
		s = checkTime(s);
		document.getElementById('txt').innerHTML =
		h + ":" + m + ":" + s;
		var t = setTimeout(startTime, 500);
	}
    function checkTime(i) {
      if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
      return i;
    }
  </script>
</head>


<body  onload="startTime()">
	<cfif url.machineID eq "" or qGetMachine.recordcount eq 0>
		<div class="container">
			Invalid Access
		</div>
		<cfabort>
	</cfif>
	<cfoutput>
	<div class="container">
		<!---<form name="addLog" id="addLog" class="form-horizontal">--->
			<h1 class="text-center">#qGetMachine.name#</h1>
			<h5 class="text-center">#dateformat(now(),"dd-mmm-yyyy")#</h5>
			<h1 class="text-center"><div id="txt"></div></h1>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="sel1" placeholder="Status">
					<option value="" selected disabled>Selecciona el estatus de la máquina</option>
					<option>Activo</option>
					<option>Inactivo</option>
				</select>
				<input type="hidden" id="date" name="date">
				<input type="hidden" id="idMachine" name="idMachine" value="#url.machineID#">
			</div>
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="pie1" placeholder="Numero de Piezas:Objetivo 50 piezas" type="">
			</div>
			<div class="form-group form-group-lg ">
				<textarea class="form-control input-lg" placeholder="Comentarios"></textarea>
			</div>
			
			<div class="form-group form-group-lg text-center">
				<button class="btn btn-success btn-lg" data-toggle="modal" data-target="##myModal">
					Actualizar
				</button>
			</div>
			<div class="alert alert-danger text-center" role="alert">
				Última Actualización fue enviada #dateformat(now())# a las #TimeFormat(now(), "hh:mm:sstt")#
			</div>
		<!---</form>--->
		</div>
		<!-- Modal content-->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					Alerta
				</div>
				<div class="modal-body">
					<p>La información ha sido guardad exitosamente.</p>
				</div>

				<div class="modal-footer ">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				</div>
			</div>

		</div>
	</div>
	</cfoutput>
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

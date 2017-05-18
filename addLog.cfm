<cfparam name="url.machineid" default="">
<cfparam name="url.idUser" default="">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfquery name="qGetMachine" datasource="#request.ODBC#">
  SELECT name, capacity 
  FROM machine 
  WHERE id='#url.machineid#'
  	AND status = 1
</cfquery>
<cfset lObj = createObject("component","library.cfc.report").init(odbc=request.ODBC)>
<cfset qgetLastLog =lObj.getLastLog(id=url.machineid)>

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
    $(document).ready(function(){
		$("#sbmBtn").click(function(){
			if(validateForm()){
	        	$.ajax({
		           type: "POST",
		           url: "addLogaction.cfm",
		           data:  { 
                    	machineStatus : $('#machineStatus').val(), 
                    	date: $('#date').val(), 
                    	idMachine : $('#idMachine').val(), 
                    	pie1 : $('#pie1').val(), 
                    	pie2 : $('#pie2').val(), 
                    	comments : $('#comments').val(),
                    	idUser : $('#idUser').val()
                   },
		           success: function(data)
		           {
		               $("#myModal").modal();
		           }
		        });
	        }
	    });
	    $('#backBtn').click(function(){
	    	$(location).attr('href', 'index.cfm');
	    });
	     $('#closeBtn, #closeBtn2').click(function(){
	    	location.reload();
	    });
	    
	});
	function validateForm() {
		if(!$('#machineStatus').val()) {
			alert('El campo ESTATUS DE LA MAQUINA es requerido');
			$('#machineStatus').focus(function() {
  				
			});
			return false;	
		}
		if(!$('#pie1').val()) {
			alert('Debes de introducir el NUMERO DE PIEZAS PRODUCIDAS');
			$('#pie1').focus(function() {
  				
			});
			return false;	
		}
		if(!$('#pie2').val()) {
			alert('Debes de introducir el NUMERO DE PIEZAS DEFECTUOSAS');
			$('#pie2').focus(function() {
  				
			});
			return false;	
		}
		    return true;
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
				<select class="form-control input-lg" id="machineStatus" placeholder="Status">
					<option value="" selected disabled>Selecciona el estatus de la máquina</option>
					<option value ="1">Activo</option>
					<option value ="0">Inactivo</option>
				</select>
				<input type="hidden" id="date" name="date" value="#now()#">
				<input type="hidden" id="idMachine" name="idMachine" value="#url.machineID#">
				<input type="hidden" id="idUser" name="idUser" value="#url.userid#">
			</div>
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="pie1" placeholder="Numero de Piezas:Objetivo <cfif qGetMachine.capacity neq "">#qGetMachine.capacity#<cfelse>0</cfif> piezas"  type="number" min="0" step="1" />
			</div>
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="pie2" placeholder="Numero de Piezas Defectuosas"  type="number" min="0" step="1" />
			</div>
			<div class="form-group form-group-lg ">
				<textarea class="form-control input-lg" placeholder="Comentarios" id="comments"></textarea>
			</div>
			<div class="form-group form-group-lg text-center">
				<button class="btn btn-success btn-lg" data-toggle="modal" id="sbmBtn">
					Actualizar
				</button>
				
			</div>
			<cfif qgetLastLog.recordcount>
				<div class="alert alert-danger text-center" role="alert">
					Última Actualización fue enviada #dateformat(qgetLastLog.time)# a las #TimeFormat(qgetLastLog.time, "hh:mm:sstt")#<br>

				</div>
			</cfif>
			<div class="form-group form-group-lg text-center">
				<button class="btn btn-danger btn-lg" id="backBtn">
					Regresar
				</button>
			</div>
		<!---</form>--->
		</div>
		<!-- Modal content-->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeBtn2">×</button>
					Alerta
				</div>
				<div class="modal-body">
					<p>La información ha sido guardado exitosamente.</p>
				</div>

				<div class="modal-footer ">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeBtn">Cerrar</button>
				</div>
			</div>

		</div>
	</div>
	</cfoutput>
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

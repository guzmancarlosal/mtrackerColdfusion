<Cfif #GetUserRoles()#  neq 4 and #GetUserRoles()#  neq 1>
	<cfinclude template="deny.cfm">
	<cfabort>
</Cfif>
<cfparam name="url.mID" default="">
<cfparam name="variables.machineName" default="Agregar una Máquina">
<cfparam name="variables.name" default="">
<cfparam name="variables.machineID" default="">
<cfparam name="variables.type" default="">
<cfparam name="variables.status" default="">
<cfparam name="variables.idLoc" default="">
<cfparam name="variables.capacity" default="0">
<cfparam name="request.ODBC" default="cc_mtracker">

<!DOCTYPE html>

<html>
<head>
  <cfprocessingdirective pageencoding = "utf-8">
  <link rel="icon" href="img/mTrackericonsmal.png">

  <title>Machine</title>
	<script>
	$(document).ready(function(){
		$("#sbmBtn").click(function(){
			if(validateForm()){
	        	$.ajax({
		           type: "POST",
		           url: "action.cfm",
		           data:  { 
                    	mID : $('#machineID').val(), 
                    	name : $('#name').val(), 
                    	type : $('#type').val(), 
                    	status : $('#status').val(), 
                    	capacity : $('#capacity').val(),
                    	idLoc : $('#idLoc').val(), 
                    	mode: "mAction"
                   },
		           success: function(data)
		           {
		               $("#myModal").modal();
		           }
		        });
	        }
	    });
	    $('#backBtn').click(function(){
	    	$(location).attr('href', 'machineReport.cfm');
	    });
	      $('#closeBtn').click(function(){
	    	$(location).attr('href', 'machineReport.cfm');
	    });
	});
	function validateForm() {
		if($('#name').val()=="") {
			alert('El campo NOMBRE DE LA MÁQUINA es requerido');
			$('#name').focus(function() {
  				
			});
			return false;	
		}
		if($('#type').val()=="") {
			alert('El campo TIPO es requerido');
			$('#type').focus(function() {
  				
			});
			return false;	
		}
		if($('#status').val()=="") {
			alert('El campo ESTATUS es requerido');
			$('#status').focus(function() {
  				
			});
			return false;	
		}
		if($('#idLoc').val()=="") {
			alert('El campo SITIO es requerido');
			$('#idLoc').focus(function() {
  				
			});
			return false;	
		}
		
		var r = confirm("ATENCIÓN! Los cambios que estas apunto de guardar tendrán gran efecto en sus reportes. Si usted no sabe lo que esta haciendo precione Cancel y consulte a su administrador.");
		if (r == true) {
		    return true;
		} else {
		    return false;
		}
	}
	</script>

</head>
<cfif url.mID neq "" and isnumeric(url.mID)>
	<cfset mObj = createObject("component","library.cfc.machine").init(odbc=request.ODBC)>
	<cfset qMachine = mObj.getM(id=url.mID)>
	<cfset variables.machineName =qMachine.name>
	<cfset variables.machineID = qMachine.id>
	<cfset variables.name = qMachine.name>
	<cfset variables.type = qMachine.type>
	<cfset variables.status = qMachine.status>
	<cfset variables.capacity = qMachine.capacity>
	<cfset variables.idLoc = qMachine.idLoc>
</cfif>
<cfset locObj = createObject("component","library.cfc.loc").init(odbc=request.ODBC)>
<cfset qLocs = locObj.getAllActiveLocs()>

<body >
	<cfoutput>
	<div class="container">
		<form name="addLog" id="addLog" class="form-horizontal">
			<h1 class="text-center"><i class="fa fa-cog" aria-hidden="true"></i> #variables.machineName#</h1>
		
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="name" placeholder="Nombre de la Máquina" type="text" value ="#variables.name#" required>
			</div>
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="type" placeholder="Tipo de Máquina" type="text" value ="#variables.type#" required>
			</div>
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="capacity" placeholder="Capacidad" type="text" value ="#variables.capacity#" required>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="status" placeholder="Status" required>
					<option value="" selected disabled <cfif variables.status eq "">selected</cfif>>Estatus</option>
					<option value="1" <cfif variables.status eq "1">selected</cfif>>Activo</option>
					<option value="0" <cfif variables.status eq "0">selected</cfif>>Inactivo</option>
				</select>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="idLoc" placeholder="Sitio" required>
					<option value="" selected disabled <cfif variables.idLoc eq "">selected</cfif>>Sitio</option>
					<cfloop query="qLocs">
						<option value="#qLocs.id#"  <cfif variables.idLoc eq qLocs.id >selected</cfif>>#qLocs.name#</option>
					</cfloop>
					
				</select>
			</div>
			<div class="form-group form-group-lg text-center">
				<input type="hidden" value="#url.mID#" id="machineID">
				<input type="button" class="btn btn-success" id="sbmBtn" value="<cfif url.mID neq "">Actualizar<cfelse>Agregar</cfif>"/>
				<button class="btn btn-danger" id="backBtn">
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
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					Alerta
				</div>
				<div class="modal-body">
					<p>La Organizacion ha sido guardada exitosamente.</p>
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

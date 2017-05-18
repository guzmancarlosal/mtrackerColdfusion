<Cfif #GetUserRoles()#  neq 4>
	<cfinclude template="deny.cfm">
	<cfabort>
</Cfif>
<cfparam name="url.siteID" default="">
<cfparam name="variables.name" default="">
<cfparam name="variables.active" default="">
<cfparam name="variables.siteName" default="Agregar un Sitio">
<cfparam name="variables.orgID" default="">
<cfparam name="variables.country" default="">
<cfparam name="request.ODBC" default="cc_mtracker">

<!DOCTYPE html>

<html>
<head>
  <cfprocessingdirective pageencoding = "utf-8">
  <link rel="icon" href="img/mTrackericonsmal.png">

  <title>Sitio</title>
	<script>
	$(document).ready(function(){
		$("#sbmBtn").click(function(){
			if(validateForm()){
	        	$.ajax({
		           type: "POST",
		           url: "action.cfm",
		           data:  { 
                    	name : $('#name').val(), 
                    	siteID : $('#siteID').val(), 
                    	orgID : $('#orgID').val(), 
                    	country : $('#country').val(), 
                    	active : $('#active').val(), 
                    	mode: "siteAction"
                   },
		           success: function(data)
		           {
		               $("#myModal").modal();
		           }
		        });
	        }
	    });
	    $('#backBtn').click(function(){
	    	$(location).attr('href', 'siteReport.cfm');
	    });
	      $('#closeBtn').click(function(){
	    	$(location).attr('href', 'siteReport.cfm');
	    });
	});
	function validateForm() {
		if(!$('#name').val()) {
			alert('El campo NOMBRE DEL SITIO es requerido');
			$('#name').focus(function() {
  				
			});
			return false;	
		}
		if(!$('#orgID').val()) {
			alert('El campo ORGANIZACIÓN es requerido');
			$('#orgID').focus(function() {
  				
			});
			return false;	
		}
		if(!$('#country').val()) {
			alert('El campo PAÍS es requerido');
			$('#country').focus(function() {
  				
			});
			return false;	
		}
		if(!$('#active').val()) {
			alert('El campo ESTATUS DEL SITIO es requerido');
			$('#name').focus(function() {
  				
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
<cfif url.siteID neq "" and isnumeric(url.siteID)>
	<cfset siteObj = createObject("component","library.cfc.loc").init(odbc=request.ODBC)>
	<cfset qLoc = siteObj.getLoc(id=url.siteID)>
	<cfset variables.siteName = qLoc.name>
	<cfset variables.name = qLoc.name>
	<cfset variables.active = qLoc.status>
	<cfset variables.country = qLoc.country>
	<cfset variables.orgID = qLoc.orgID>
</cfif>
<cfset orgObj = createObject("component","library.cfc.org").init(odbc=request.ODBC)>
<cfset qOrgs = orgObj.getAllOrgs()>
<body >
	<cfoutput>
	<div class="container">
		<form name="addLog" id="addLog" class="form-horizontal">
			<h1 class="text-center"><i class="fa fa-area-chart" aria-hidden="true"></i> #variables.siteName#</h1>
		
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="name" placeholder="Nombre del Sitio" type="text" value ="#variables.name#" required>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="orgID" placeholder="Organización" required>
					<option value="" selected disabled <cfif variables.active eq "">selected</cfif>>Organización</option>
					<cfloop query="qOrgs">
						<option value="#qOrgs.id#" <cfif variables.orgID eq qOrgs.id>selected</cfif>>#qOrgs.name#</option>
					</cfloop>
					
				</select>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="country" placeholder="País" required>
					<option value="" selected disabled <cfif variables.active eq "">selected</cfif>>País</option>
					<option value="MX" <cfif variables.country eq "MX">selected</cfif>>México</option>
					<option value="US" <cfif variables.country eq "US">selected</cfif>>Estados Unidos</option>
				</select>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="active" placeholder="Status" required>
					<option value="" selected disabled <cfif variables.active eq "">selected</cfif>>Selecciona el estatus del Sitio</option>
					<option value="1" <cfif variables.active eq "1">selected</cfif>>Activo</option>
					<option value="0" <cfif variables.active eq "0">selected</cfif>>Inactivo</option>
				</select>
			</div>
			<div class="form-group form-group-lg text-center">
				<input type="hidden" value="#url.siteID#" id="siteID">
				<input type="button" class="btn btn-success" id="sbmBtn" value="<cfif url.siteID neq "">Actualizar<cfelse>Agregar</cfif>"/>
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
					<p>El sitio ha sido guardado exitosamente.</p>
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

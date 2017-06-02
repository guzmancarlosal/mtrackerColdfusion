<cfparam name="url.pdfReport" default="0">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfparam name="url.machineid" default="">
<cfquery name="qGetMachine" datasource="#request.ODBC#">
  select machine.id as mid, machine.name, u.id as uid, l.name as locationname
  From machine with (nolock)
  inner join loc l on machine.idLoc = l.id
  inner join user_machine with (nolock) on machine.id = user_machine.machineID
  inner join [user] u  with (nolock) on u.id=user_machine.userid
  where u.username='#GetAuthUser()#'
</cfquery>

<cfset lObj = createObject("component","library.cfc.report").init(odbc=request.ODBC)>
<cfset qgetLastLog =lObj.getLastLog(id=url.machineid)>
<cfset headersArray = ArrayNew(1)>
<cfset arrayAppend(headersArray,"Hora")>
<cfloop query="qGetMachine">
    <cfset thisValuearr = '#trim(qGetMachine.name)#'>
    <cfset arrayAppend(headersArray,thisValuearr)>
</cfloop>
  <html>
  <head>
    <title>MTracker</title>

    <Cfoutput>
    <cfprocessingdirective pageencoding = "utf-8">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
    <script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js"></script>
    <script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/vfs_fonts.js"></script> 
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);
       /* var d = new Date();
        var n = d.getHours();*/
       
        function drawChart() {
        }
        <cfset local.dayToday = day(now())>
        <cfset local.yearToday = year(now())>
        <cfset local.monthToday = month(now())-1>

        <cfset local.dayYesterday = day(DateAdd('d', -1, now()))>
        <cfset local.yearYesterday = year(DateAdd('d', -1, now()))>
        <cfset local.monthYesterday = month(DateAdd('d', -1, now()))-1>
        $(document).ready(function() {
          $('##machineid').change(function(e){
             $.ajax({
                type: "POST",
                url: 'dataJSON.cfm?mode=getMachineByHour&machineid='+$("##machineid").val(),
                success: function(json) {
                  var res = json.replace('"', '');
                  var thisJson = eval(json);
                  var data = new google.visualization.arrayToDataTable(thisJson);
                  //data.addRows(thisJson);
                  var options = {
                    title: 'Producción por Máquina en las últimas 24 horas',
                    width: 900,
                    height: 500,
                    enableInteractivity: false,
                    chartArea: {
                      width: '90%'
                    }
                  };

                  var chart = new google.visualization.LineChart(
                    document.getElementById('curve_chart'));
                  
                  chart.draw(data, options);
                  document.getElementById('png').outerHTML = '<a href="' + chart.getImageURI() + '">Printable version</a>';
                  $('##png').text("");
                   $('##png').innerHTML('<a href="' + chart.getImageURI() + '">Guardar como Imagen</a>');
                }
            });
          });

        } );
    </script>
  </head>
 

  <body>
  <div class="container">
    <div class="row">
        <div class="col-sm-12 text-center">
            <h2><i class="fa fa-cog" aria-hidden="true"></i> Producción por Máquina en las últimas 24 horas</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-4 text-center"></div>
        <div class="col-sm-4 text-center"><br>
            
             <cfif qGetMachine.recordcount>
              <select id="machineid" name="machineid" class="form-control">
                <option value="">Selecciona una maquina
                <cfloop query="#qGetMachine#">
                  <option value="#qGetMachine.mid#">#qGetMachine.name#
                </cfloop>
              </select><br>
            <cfelse>
              <br>
              <div style="color:red">No hay máquina asignada, contacta al administrador.</div>
              <br>
            </cfif>
        </div>
    </div>

    <div class="row">
      <div class="col-sm-12 text-center">
          <div id="curve_chart" ></div>
        </div>
      
      </div>
         
    </div>
    <br><Br>
    <div class="row">
      <div class="col-sm-12 text-center">
        <div id='png'></div>
      </div>
      
    </div>

   
  </body>
  </Cfoutput>

<cfoutput>
    <cfabort>
    <cfif url.pdfReport eq 1>
        <cfdocument backgroundvisible="yes" encryption="none" format="PDF" fontembed="yes" orientation="landscape">
            TEST
             #testEmailOutput#
        </cfdocument>
    <cfelse>
        #testEmailOutput#

    </cfif>
    
   
</cfoutput>
<cfif url.pdfReport eq 0>
    

<div class="row">
    <div class="col-sm-12 text-center">
        <p><a class="btn btn-success" href="reports.cfm?pdfReport=1" role="button" id="startBtn">Descarga PDF</a></p>
    </div>
</div>
</cfif>
</html>


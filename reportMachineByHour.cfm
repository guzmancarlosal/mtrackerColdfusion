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
        var d = new Date();
        var n = d.getHours();

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
              ["Hora","IXRN-29"], [0, 5], [1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [6, 5], [7, 5], [8, 5], [9, 5], [10, 5], [11, 5], [12, 5], [13, 5], [14, 5], [15, 5], [16, 5], [17, 5], [18, 5], [19, 5], [20, 5], [21, 5], [22, 5], [23,5]
            ]);

            var options = {
              curveType: 'function',
              legend: { position: 'bottom' }
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
            google.visualization.events.addListener(chart, 'ready', function () {
                curve_chart.innerHTML = '<img src="' + chart.getImageURI() + '">';
                //console.log(curve_chart.innerHTML);
            });
            chart.draw(data, options);
            //starting png
            document.getElementById('png').outerHTML = '<a href="' + chart.getImageURI() + '">Printable version</a>';


        }
        /*function drawChart(chart_data, chart1_main_title, chart1_vaxis_title) {
          var chart1_data = new google.visualization.arrayToDataTable(chart_data);
          var chart1_options = {
              title: chart1_main_title,
              vAxis: {title: chart1_vaxis_title,  titleTextStyle: {color: 'red'}}
          };

          var chart1_chart = new google.visualization.BarChart(document.getElementById('curve_chart'));
          chart1_chart.draw(chart1_data, chart1_options);
      }*/

        $(document).ready(function() {
          $('##machineid').change(function(e){
             $.ajax({
                type: "POST",
                url: 'dataJSON.cfm?mode=getMachineByHour&machineid='+$("##machineid").val(),
                //dataType: "json",
                success: function(json) {
                  debugger;
                  var data = google.visualization.arrayToDataTable(json);
                  /*var data = google.visualization.DataTable();
                   data.addColumn('datetime', 'Time of Day');
                    data.addColumn('number', 'Motivation Level');**/
                  if(data){
                      //drawChart(data, "My Chart", "Data");
                      
                      var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
                      google.visualization.events.addListener(chart, 'ready', function () {
                          curve_chart.innerHTML = '<img src="' + chart.getImageURI() + '">';
                          //console.log(curve_chart.innerHTML);
                      });
                       var options = {
                        curveType: 'function',
                        legend: { position: 'bottom' }
                      };
                      chart.draw(data, options);
                  }
                 // console.log(json);
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
            <h4>Selecciona una máquina</h4>
             <cfif qGetMachine.recordcount>
              <select id="machineid" name="machineid" class="form-control">
                <option value="">Todas
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
          <div id="curve_chart" style="height:400px" ></div>
        </div>
      
      </div>
         <div id='png'></div>
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


/**
 * 
 */

$("#accordion_1").bwlAccordion({
	theme:'theme-blue',
	pagination: false,
	limit: 6,
	toggle: true
});


$(document).ready(function() {
	   var weeklyDataDashboard = $('#weeklyDataTable').DataTable({
	    	"bSort" : true,
	    	"paging" : true,
	    	"order": [[ 1, "desc" ]]/*,
	    	"pageLength": 15,
	    	"aLengthMenu": [[10, 15, 25, 35, 50, 100], [10, 15, 25, 35, 50, 100]]*/,
	    	"columnDefs": [
	                       { "targets": [0], "visible": false, "searchable": false }
	                     ],
	    });
	   
	   $('#newWeeklyData').click(function(){
		   openWeeklyDataFancyBox(0, 'newWeeklyData', this);
		});
	   
	   $( "#week" ).datepicker({
			changeMonth: true,
		    changeYear: true,
		    dateFormat: 'yy-mm-dd',
		    maxDate: new Date(),
		    firstDay: 1,
		   /* onSelect: function(date){
			        var d = new Date(date);
			        var index = d.getDay();
		          // console.log(index)
		           if(index == 0) {
		            d.setDate(d.getDate() - 6);   
		           }
		           else if(index == 1) {
		            d.setDate(d.getDate());
		           }
		           else if(index != 1 && index > 0) {
		             d.setDate(d.getDate() - (index - 1));
		               //console.log(d.getDate() - (index - 1))        
		           }
		           
		           var weekYear = $.datepicker.iso8601Week(new Date(d)) + '' + new Date(d).getFullYear() % 100;
		           $('#weekYear').val(weekYear);
		           $(this).val($.datepicker.formatDate("yy-mm-dd", new Date(d)));

		           //console.log('Week number::'+$.datepicker.iso8601Week(new Date(d)));
		           //console.log("start date::"+d)
		           //$(this).val(d);
		       }*/
		});
	   
	   $( "#endweek" ).datepicker({
			changeMonth: true,
		    changeYear: true,
		    dateFormat: 'yy-mm-dd',
		    maxDate: new Date(),
		    firstDay: 1,
		    /*onSelect: function(date){
			        var d = new Date(date);
			        var index = d.getDay();
		          // console.log(index)
		           if(index == 0) {
		            d.setDate(d.getDate() - 6);   
		           }
		           else if(index == 1) {
		            d.setDate(d.getDate());
		           }
		           else if(index != 1 && index > 0) {
		             d.setDate(d.getDate() - (index - 1));
		               //console.log(d.getDate() - (index - 1))        
		           }
		           
		           var weekYear = $.datepicker.iso8601Week(new Date(d)) + '' + new Date(d).getFullYear() % 100;
		           $('#weekYear').val(weekYear);
		           $(this).val($.datepicker.formatDate("yy-mm-dd", new Date(d)));

		           //console.log('Week number::'+$.datepicker.iso8601Week(new Date(d)));
		           //console.log("start date::"+d)
		           //$(this).val(d);
		       }
*/		});
	   
	   $("#patientAmount").keydown(function (event) {
		   return validateFloatKeyDown(event);
	   });
	   
	   $("#patientAmount").keypress(function (event) {
		   return validateFloatKeyPress(event)
	   });
	   
	   $("#patientAmountClaim").keydown(function (event) {
		   return validateFloatKeyDown(event);
	   });
	   
	   $("#patientAmountClaim").keypress(function (event) {
		   return validateFloatKeyPress(event)
	   });
	   
	   $("#patientAmountNonClaim").keydown(function (event) {
		   return validateFloatKeyDown(event);
	   });
	   
	   $("#patientAmountNonClaim").keypress(function (event) {
		   return validateFloatKeyPress(event)
	   });
	   
	   $('img[name=editWeeklyCounts]').click(function(e){
		   updateWeeklyCounts(this);
		});
	   	   
	} );

function openWeeklyDataFancyBox(weeklyCountId, menuType, obj){
	
	var paramMap = new Map();
	
	var url, btnObj;
	
	url = contextPath + '/pages/doctor/createWeeklyCounts.jsp?menuRequired=false&weeklyCountId=' + weeklyCountId;
	
	paramMap.put(URL, url);
	paramMap.put(WIDTH, '70%');
	paramMap.put(HEIGHT, '80%');
	
	openFancyBox(obj, paramMap);
}

function validateWeeklyCountsForm(){
	
	var elementIds = [
	                  ['week','Week'],
	                  ['patientCount','Patient Count'], ['patientAmount','Patient amount'], ['patientCountClaim', 'With Claim Patient Count'], 
	                  ['patientAmountClaim','With Claim Patient Amount'],
	                  ['patientCountNonClaim', 'With Non Claim Patient Count'], ['patientAmountNonClaim', 'With Non Claim Patient Amount']
                 ];
var errorFound = false;
var paramMap = new Map();
$.each(elementIds, function( index, value ) {
	if($('#' + value[0]).val() == ''){
		  paramMap.put(MSG, 'Please enter ' + value[1]);
		  errorFound = true;
		  return false;
	  }
	});
if(errorFound){
	displayNotification(paramMap);
	return false;
}else{
	
	/*var weekYear = $('#weekYear').val();
	
	if(weekYear.toLowerCase() !== oldWeekYear.toLowerCase()){
		var weekYearArray = parent.$('#weeklyDataTable').DataTable().column(0).data();	
		weekYearArray = convertCaseArray(weekYearArray, LOWER_CASE);
		
		if(weekYearArray.includes(weekYear.toLowerCase())){
			paramMap.put(MSG, 'Data for the selected week is already exist.');
			displayNotification(paramMap);
			return false;
		}
	}
	*/
}
	
}

function updateWeeklyCounts(imgObj){
	
	var weeklyCountId =  imgObj.id;
	openWeeklyDataFancyBox(weeklyCountId, 'updateWeeklyCounts', imgObj);
}


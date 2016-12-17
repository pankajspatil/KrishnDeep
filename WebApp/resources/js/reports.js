/**
 * 
 */

function validateStatusForm(){
	
	var paramMap = new Map();
	
	var fromDate = $('#fromDate').val();
	var toDate = $('#toDate').val();
	var reportType = $('input[name=reportType]:checked').val();
	
	if(fromDate === ''){
		paramMap.put(MSG, 'Please enter from date');
		displayNotification(paramMap);
		return false;
	}else if(toDate === ''){
		paramMap.put(MSG, 'Please enter to date');
		displayNotification(paramMap);
		return false;
	}else if(reportType === undefined){
		paramMap.put(MSG, 'Please select report type');
		displayNotification(paramMap);
		return false;
	}
	
}


$( "#fromDate" ).datepicker({
	changeMonth: true,
    changeYear: true,
    dateFormat:'yy-mm-dd',
    onSelect: function (date) {
    	$( "#toDate" ).datepicker( "option", "minDate", date );
    }
});

$( "#toDate" ).datepicker({
	changeMonth: true,
    changeYear: true,
    dateFormat:'yy-mm-dd',
    onSelect: function (date) {
    	$( "#fromDate" ).datepicker( "option", "maxDate", date );
    }
});
/**
 *@author : Kiran
 * This JS contains JavaScripts methods required on expense and invoices pages.
 * 
 */

$(document).ready(function() {
	   var orderDashboard = $('#expenseTable').DataTable({
	    	"bSort" : true,
	    	"paging" : true,
	    	"order": [[ 1, "desc" ]]/*,
	    	"pageLength": 15,
	    	"aLengthMenu": [[10, 15, 25, 35, 50, 100], [10, 15, 25, 35, 50, 100]]*/	
	    });
	   
	   $('#newExpense').click(function(){
		   openExpenseFancyBox(0, 'newExpense', this);
		});
	   
	} );

function openExpenseFancyBox(expenseId, menuType, obj){
	
	var paramMap = new Map();
	
	var url, btnObj;
	
	url = contextPath + '/pages/doctor/createExpense.jsp?menuRequired=false&expenseId=' + expenseId;
	
	paramMap.put(URL, url);
	paramMap.put(WIDTH, '70%');
	paramMap.put(HEIGHT, '80%');
	
	openFancyBox(obj, paramMap);
}
/**
 * 
 */

$(document).ready(function() {
	   var invoiceTable = $('#invoiceTable').DataTable({
	    	"bSort" : true,
	    	"paging" : true,
	    	"order": [[ 1, "desc" ]]/*,
	    	"pageLength": 15,
	    	"aLengthMenu": [[10, 15, 25, 35, 50, 100], [10, 15, 25, 35, 50, 100]]*/	
	    });
	   
	   $('#newInvoice').click(function(){
		   openInvoiceFancyBox(0, 'newInvoice', this);
		});
	   
	   $('#vendorInvoice').click(function(){
		   displayExpenseTable();
		});
	   
});

function openInvoiceFancyBox(invoiceId, menuType, obj){
	
	var paramMap = new Map();
	
	var url, btnObj;
	
	url = contextPath + '/pages/invoice/createInvoice.jsp?menuRequired=false&invoiceId=' + invoiceId;
	
	paramMap.put(URL, url);
	paramMap.put(WIDTH, '70%');
	paramMap.put(HEIGHT, '95%');
	
	openFancyBox(obj, paramMap);
}

function displayExpenseTable(){
	var vendorId = $('#vendorInvoice').val();
	var expenseExist = $('#expenseExist').val();
	
	if(vendorId != '' && expenseExist != ''){
		
	}
} 
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
	   var invoiceExpenseTable = $('#invoiceExpenseTable').DataTable({
	    	"bSort" : true,
	    	"paging" : true,
	    	"order": [[ 1, "desc" ]],
	    	"pageLength": 5,
	    	"aLengthMenu": [[5, 10, 15, 25, 35, 50, 100], [10, 15, 25, 35, 50, 100]]	
	    });
	   
	   $('#newInvoice').click(function(){
		   openInvoiceFancyBox(0, 'newInvoice', this);
		});
	   
	   $('#vendorInvoice').change(function(){
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
	var expenseExist = $('#expenseExist').is(":checked");
	
	if(vendorId != '' && expenseExist){
		
			  $('#invoiceExpenseTable').LoadingOverlay("show");
			  
			  var parameters = {};
			  parameters.vendorId = vendorId;
			  
			  var postData = {
						"action" : "fetchExpenseByVendor",
						"data" : JSON.stringify(parameters)
				};
			  
			  $.ajax({
			      type: 'POST',
			      url: "/Krishnadeep/pages/ajax/postAjaxData.jsp",
			      data: postData, 
			      dataType: 'json',
			      success: function(resultData) {
			    	  //alert("Save Complete" + resultData)
			    	  console.log('resultData = ' + resultData);
			    	  
			    	  var tableObj = $('#invoiceExpenseTable');
			    	  $(tableObj).DataTable().rows().remove().draw();
			    	  
			    	  $.each(resultData, function(key, value) {
			    		  
			    		  var rowObj = $("<tr align = 'center' id = '"+value.expenseId+"'></tr>");
			    		  
			    		  rowObj.append($("<td><input type='checkbox' name='selectedExpenses' id='select_'"+value.expenseId+" /></td>"));
			    		  
			    		  rowObj.append($("<td>"+value.expenseId+"</td>"));
			    		  rowObj.append($("<td>"+value.expenseItem.expenseItemName+"</td>"));
			    		  rowObj.append($("<td>"+value.vendor.vendorName+"</td>"));
				    		  
			    		  rowObj.append($("<td>"+value.expenseQty+"</td>"));
			    		  rowObj.append($("<td>"+value.expenseAmt+"</td>"));
			    		  rowObj.append($("<td>"+value.paidAmt+"</td>"));
			    		  rowObj.append($("<td><input type='text' name='paidValues' id='paid_'"+value.expenseId+" value=''/> </td>"));
			    		  
						$(tableObj).DataTable().row.add(
							rowObj
			    		  ).draw();
			    	  });
			    	  
			    	  $('#invoiceExpenseTable').LoadingOverlay("hide");
			    	  
			    	 },
			    	 error: function (xhr, status) { 
			    		 $('#invoiceExpenseTable').LoadingOverlay("hide");
			    		 console.log('ajax error = ' + xhr.statusText);
			    		 	Lobibox.alert("error",{
			    				msg : 'Something went wrong. Please relogin again.'
			    			});
			            } 
			});
		
	}
} 
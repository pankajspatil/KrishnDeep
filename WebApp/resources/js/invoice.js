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
	   
	   $('a[name=editInsurance]').click(function(e){
		   openInvoiceFancyBox($(this).id, 'updateInvoice', this);
		});
	   
	   $('#vendorInvoice').change(function(){
		   displayExpenseTable();
		});
	   
	   $('#expenseExist').change(function(){
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
			    		  
			    		  rowObj.append($("<td><input style='width: 100%; height:100%' class='fullRowElement' type='checkbox' name='selectedExpenses' id='select_"+value.expenseId+"' value='"+value.expenseId+"'  /></td>"));
			    		  
			    		  rowObj.append($("<td>"+value.expenseId+"</td>"));
			    		  rowObj.append($("<td>"+value.expenseItem.expenseItemName+"</td>"));
			    		  rowObj.append($("<td>"+value.vendor.vendorName+"</td>"));
				    		  
			    		  rowObj.append($("<td>"+value.expenseQty+"</td>"));
			    		  rowObj.append($("<td>"+value.expenseAmt+"</td>"));
			    		  rowObj.append($("<td>"+value.paidAmt+"</td>"));
			    		  rowObj.append($("<td><input class='fullRowElement paidAmt' type='text' name='paid_"+value.expenseId+"' id='paid_"+value.expenseId+"' value=''/> </td>"));
			    		  
						$(tableObj).DataTable().row.add(
							rowObj
			    		  ).draw();
						
						$(".paidAmt").keydown(function (event) {
							   return validateFloatKeyDown(event);
						   });
						   
						   $(".paidAmt").keypress(function (event) {
							   return validateFloatKeyPress(event);
						   });
						
			    	  });
			    	  
			    	  $('#invoiceExpenseTable').LoadingOverlay("hide");
			    	  
			    	 },
			    	 error: function (xhr, status) { 
			    		 $('#invoiceExpenseTable').LoadingOverlay("hide");
			    		 console.log('ajax error = ' + xhr.statusText);
			    		 	Lobibox.alert("error",{
			    				msg : 'Something went wrong.'
			    			});
			            } 
			});
		
	}
} 

function validateCreateInvoice(){
	
	var vendorId = $('#vendorInvoice').val();
	var expenseExist = $('#expenseExist').is(":checked");
	var invoiceAmount = $('#invoiceAmount').val();
	
	var errorFound = false;
	
	var paramMap = new Map();
	  if(vendorId == -1){
		  paramMap.put(MSG, 'Please select vendor.');
		  displayNotification(paramMap);
		  return false;
	  }else if(!expenseExist && invoiceAmount === ''){
		  paramMap.put(MSG, 'Invoice amount can not be blank if there is no expense exist.');
			displayNotification(paramMap);
		  return false;
	  }
	
	if(expenseExist){
		//var selected = [];
		if($('#invoiceExpenseTable input:checked').length == 0){
			paramMap.put(MSG, 'Please select atleast one expense from expense table.');
			displayNotification(paramMap);
			return false;
		}
		
		$('#invoiceExpenseTable input:checked').each(function() {
		    //selected.push($(this).attr('name'));
			
			var paidObj = $('#paid_' + $(this).attr('id').replace(/^select_/g,''));
			
			if($(paidObj).val() == ''){
				$(paidObj).focus();
				errorFound = true;
				return false;
			}else{
				var rowObj = $(paidObj).closest('tr');
				var totalAmount = rowObj.find('td').eq(5).text();
				var totalPaid = rowObj.find('td').eq(5).text() == '' ? 0 : rowObj.find('td').eq(5).text();
				
				var remainingAmt = totalAmount - totalPaid;
				
				if($(paidObj).val() > remainingAmt){
					$(paidObj).focus();
					errorFound = true;
					return false;
				}
			}
			
		});
		
		if(errorFound){
			paramMap.put(MSG, 'Invoice amount can not be blank or more than payable amount for any selected expense.');
			displayNotification(paramMap);
			return false;
		}
	}
	
}

$(document).ready(function() {
	$('img[name=print]').click(function(e){
		printVendorReceipt(this);
	});
});

function printVendorReceipt(imgObj){
	
	var invoiceId = imgObj.id.replace(/print_/g,'');
	var paramMap = new Map();
	var url = contextPath + '/pages/invoice/printVendorReceipt.jsp?invoiceId=' + invoiceId;
	
	paramMap.put(URL, url);
	paramMap.put(WIDTH, '70%');
	paramMap.put(HEIGHT, '80%');
	
	openFancyBox(imgObj, paramMap);
}
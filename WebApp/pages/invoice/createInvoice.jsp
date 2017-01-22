<%@page import="com.org.krishnadeep.modules.Invoice"%>
<%@page import="com.org.krishnadeep.models.InvoiceModel"%>
<%@page import="com.org.krishnadeep.models.ExpenseItem"%>
<%@page import="com.org.krishnadeep.masters.Masters"%>
<%@page import="com.org.krishnadeep.models.Vendor"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.models.ExpenseModel_old"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.org.krishnadeep.modules.Expense"%>
<%@page import="com.org.krishnadeep.models.ExpenseModel"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ include file="/pages/common/validateSession.jsp"%>
 <%@ include file="/pages/common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
	Masters masters = new Masters();
	Invoice invoice = new Invoice();
	
	List<Vendor> vendorList = masters.getAllVendors(true);
	List<ExpenseItem> itemList = masters.getAllExpenseItems(true);
	
	List<ExpenseModel> expenseList = new ArrayList<ExpenseModel>();
	
		Integer userId = Integer.parseInt(session.getAttribute(Constants.USER_ID).toString());
		String page1 = Utils.getString(request.getParameter("page1"));
		Integer vendorId = Utils.getInt(request.getParameter("vendorInvoice"));
		Double invoiceAmount = Utils.getDouble(request.getParameter("invoiceAmount"));
		String invoiceDesc = Utils.getString(request.getParameter("invoiceDesc"));
		Boolean expenseExist = Boolean.parseBoolean(Utils.getString(request.getParameter("expenseExist")));
		Integer invoiceId = Utils.getInt(request.getParameter("invoiceId"));
		InvoiceModel invoiceModel;
		
		if(invoiceId != 0 && page1.equals("")){
			invoiceModel = invoice.getInvoice(invoiceId);
			
			if(invoiceModel != null){
				vendorId = invoiceModel.getVendor().getVendorId();
				invoiceAmount = invoiceModel.getAmount();
				invoiceDesc = invoiceModel.getComments();
				expenseExist = invoiceModel.getExpenseExist();
				expenseList = invoiceModel.getExpenseList();
			}
			//out.println("invoiceModel===>" + invoiceModel);
		}
		
		if(!page1.equals("")){
			
			invoiceModel = new InvoiceModel();
			invoiceModel.setCreatedBy(userId);
			invoiceModel.setComments(invoiceDesc);
			invoiceModel.setAmount(invoiceAmount);
			invoiceModel.setExpenseExist(expenseExist);
			
			Vendor vendor = new Vendor();
			vendor.setVendorId(vendorId);
			
			invoiceModel.setVendor(vendor);
						
			Integer[] selectedExpenses = Utils.getIntegerArray(request.getParameterValues("selectedExpenses"));
			
			if(selectedExpenses.length > 0){
				ExpenseModel expenseModel;
				Double paidAmount;
				expenseList = new ArrayList<ExpenseModel>();
				for(Integer expenseId : selectedExpenses){
					if(request.getParameter("paid_"+expenseId) != null){
						expenseModel = new ExpenseModel();
						expenseModel.setPaidAmt(Double.parseDouble(request.getParameter("paid_"+expenseId)));
						expenseModel.setExpenseId(expenseId);
						expenseList.add(expenseModel);
					}
				}
				invoiceModel.setExpenseList(expenseList);
			}
			
			invoice.addInvoice(invoiceModel);
			
			%><script type="text/javascript">
			var msg = "Invoice added successfully.";
			Lobibox.alert("success",{
				msg : msg,
				beforeClose: function(lobibox){
		        	parent.location.reload();
		        }
			});
			</script><%
		}
	%>

<form method="post" action="#" style="text-align: center;">
<h1 align="center"><%=invoiceId == 0 ? "New" : "View" %> Invoice</h1>

<table class="mainTable" align="center" width="50%" id="invoiceDetails" border="1" style="border: 0px solid">
	<tr>
		<th class="headerTR">Vendor</th>
		<td>
			<select id="vendorInvoice" name="vendorInvoice" class="fullRowElement">
				<option value="-1">Please Select</option>
				<%String selected = "";
				for(Vendor vendor : vendorList){
					if(vendor.getVendorId() == vendorId){
						selected = "selected";
					}
					%><option <%=selected %> value="<%=vendor.getVendorId()%>"><%=vendor.getVendorName() %></option><%
				}%>
			</select>
	</tr>
	<tr>
		<th class="headerTR">Amount</th>
		<td><input type="text" id="invoiceAmount" name="invoiceAmount" class="fullRowElement" value="<%=invoiceAmount%>"></td>
	</tr>
	<tr>
		<th class="headerTR">Expense Exist</th>
		<td align="left">
			<input style="width: 10%" type="checkbox" id="expenseExist" name="expenseExist" class="fullRowElement" value="true"
			<%=expenseExist ? "checked=checked" : "" %>>
		</td>
	</tr>
	<tr>
		<th class="headerTR">Remarks</th>
		<td>
			<textarea rows="4" cols="" name="invoiceDesc" id="invoiceDesc" class="fullRowElement" <%=invoiceDesc %>></textarea>
		</td>
	</tr>
	<%if(invoiceId == 0){
		%>
		<tr>
			<td colspan=2 align="center"><input class="btn btn-main btn-2g" type="Submit" id="createInvoice" name="page1" 
			value="Submit" onclick="return validateCreateInvoice()"></td>
		</tr>
		<%
	}%>
	
</table>
<table border="1" class="mainTable" width="100%" id="invoiceExpenseTable">
<thead>
	<tr class="headerTR">
		<th>Select</th>
		<th width="10%">No.</th>
		<th width="20%">Item</th>
		<th width="20%">Vendor</th>
		<th>Qty</th>
		<th>Amount</th>
		<th>Paid</th>
		<th>Pay</th>
	</tr>
</thead>
<tbody>
<%if(expenseList.size() > 0 ){
	
	System.out.println("expenseList==>" + expenseList);
	
	for(ExpenseModel expenseModel : expenseList){
	%><tr>
		<td>-</td>
		<td><%=expenseModel.getExpenseId() %></td>
		<td><%=expenseModel.getExpenseItem() != null ? expenseModel.getExpenseItem().getExpenseItemName() : "" %></td>
		<td><%=expenseModel.getVendor() != null ? expenseModel.getVendor().getVendorName() : ""%></td>
		<td><%=expenseModel.getExpenseQty() %></td>
		<td>-</td>
		<td><%=expenseModel.getPaidAmt() %></td>
		<td>-</td>
	</tr><%
	}
}
%>
</tbody>
</table>
<div id="dialog-confirm"></div>
<script type="text/javascript" src="<%=contextPath%>/resources/js/expense.js"></script>
<script type="text/javascript" src="<%=contextPath%>/resources/js/invoice.js"></script>
<script>
	if(<%=invoiceId%> != ''){
		$('input[type=text], textarea, select, input[type=checkbox]').attr('disabled', true);
	}
</script>
</form>
</body>
</html>
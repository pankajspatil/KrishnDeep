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
	
	List<Vendor> vendorList = masters.getAllVendors(true);
	List<ExpenseItem> itemList = masters.getAllExpenseItems(true);
	
		Integer userId = Integer.parseInt(session.getAttribute(Constants.USER_ID).toString());
		String page1 = Utils.getString(request.getParameter("page1"));
		Integer vendorId = Utils.getInt(request.getParameter("vendorId"));
		Integer itemId = Utils.getInt(request.getParameter("expenseItem"));
		Integer expQuantity = Utils.getInt(request.getParameter("expenseQty"));
		Double expAmount = Utils.getDouble(request.getParameter("expenseAmount"));
		Double expenseVat = Utils.getDouble(request.getParameter("expenseVat"));
		String expenseDesc = Utils.getString(request.getParameter("expenseDesc"));
		
		if(!page1.equals("")){
			
			
			ExpenseModel expenseModel = new ExpenseModel();
			
			Vendor vendor = new Vendor();
			vendor.setVendorId(vendorId);
			expenseModel.setVendor(vendor);

			ExpenseItem expenseItem = new ExpenseItem();
			expenseItem.setExpenseItemId(itemId);
			expenseModel.setExpenseItem(expenseItem);
			
			expenseModel.setExpenseQty(expQuantity);
			expenseModel.setExpenseAmt(expAmount);
			expenseModel.setExpenseVat(expenseVat);
			expenseModel.setExpenseRemark(expenseDesc);
			expenseModel.setCreatedBy(userId);
			
			Expense expense = new Expense();
			
			expense.addExpense(expenseModel);
			
		}
	%>

<form method="post" action="#" style="text-align: center;">
<h1 align="center">New Invoice</h1>

<table class="mainTable" align="center" width="50%" id="invoiceDetails" border="1" style="border: 0px solid">
	<tr>
		<th class="headerTR">Vendor</th>
		<td>
			<select id="vendorInvoice" name="vendorInvoice" class="fullRowElement">
				<option value="-1">Please Select</option>
				<%
				for(Vendor vendor : vendorList){
					%><option value="<%=vendor.getVendorId()%>"><%=vendor.getVendorName() %></option><%
				}%>
			</select>
	</tr>
	<tr>
		<th class="headerTR">Amount</th>
		<td><input type="text" id="invoiceAmount" name="invoiceAmount" class="fullRowElement"></td>
	</tr>
	<tr>
		<th class="headerTR">Expense Exist</th>
		<td align="left"><input style="width: 10%" type="checkbox" id="expenseExist" name="expenseExist" class="fullRowElement" value="true"></td>
	</tr>
	<tr>
		<th class="headerTR">Remarks</th>
		<td>
			<textarea rows="4" cols="" name="invoiceDesc" id="invoiceDesc" class="fullRowElement"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan=2 align="center"><input class="btn btn-main btn-2g" type="Submit" id="page1" name="page1" value="Submit" onclick="return validateCreateExpense()"></td>
	</tr>
	
</table>
<table border="1" class="mainTable" width="100%" id="expenseTable">
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
	
</tbody>
</table>
<div id="dialog-confirm"></div>
<script type="text/javascript" src="<%=contextPath%>/resources/js/expense.js"></script>
<script type="text/javascript" src="<%=contextPath%>/resources/js/invoice.js"></script>
</form>
</body>
</html>
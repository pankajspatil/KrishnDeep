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
			
			
		}
		
		if (request.getParameter("expenseDesc") != null) {
			ExpenseModel_old expenseModel = new ExpenseModel_old();
			expenseModel.setVendor_id(Integer.parseInt(request
					.getParameter("vendorId")));
			expenseModel.setExpense_invoice_no((request
					.getParameter("expenseInvoiceNo")));
			expenseModel.setAccount_id(Integer.parseInt(request
					.getParameter("accountId")));
			expenseModel.setExpenses_item_id(Integer.parseInt(request
					.getParameter("expenseItem")));
			expenseModel.setExpense_desc(request
					.getParameter("expenseDesc"));
			expenseModel.setExpense_qty(Integer.parseInt(request
					.getParameter("expenseQty")));
			expenseModel.setExpense_amount(Double.parseDouble(request
					.getParameter("expenseAmount")));
			expenseModel.setExpense_vat(Float.parseFloat(request
					.getParameter("expenseVat")));
			expenseModel.setUser_id(userId);
			
			Expense.addExpense(expenseModel);

		}
	%>

<form method="post" action="#" style="text-align: center;">
<h1 align="center">New Expense</h1>

<table class="mainTable" align="center" width="50%" id="expenseDetails" border="1" style="border: 0px solid">
	<tr>
		<th class="headerTR">Vendor</th>
		<td>
			<select id="vendorId" name="vendorId" class="fullRowElement">
				<option value="-1">Please Select</option>
				<%
				for(Vendor vendor : vendorList){
					%><option value="<%=vendor.getVendorId()%>"><%=vendor.getVendorName() %></option><%
				}%>
			</select>
	</tr>
	<tr>
		<th class="headerTR">Item</th>
		<td>
			<select id="expenseItem" name="expenseItem" class="fullRowElement">
				<option value="-1">Please Select</option>
				<%
				for(ExpenseItem item : itemList){
					%><option value="<%=item.getExpenseItemId()%>"><%=item.getExpenseItemName() %></option><%
				}%>
			</select>
		</td>
	</tr>
	<tr>
		<th class="headerTR">Qty</th>
		<td><input type="text" id="expenseQty" name="expenseQty" class="fullRowElement"></td>
	</tr>
	<tr>
		<th class="headerTR">Amount</th>
		<td><input type="text" id="expenseAmount" name="expenseAmount" class="fullRowElement"></td>
	</tr>
	<tr>
		<th class="headerTR">Vat</th>
		<td><input type="text" id="expenseVat" name="expenseVat" class="fullRowElement"></td>
	</tr>
	<tr>
		<th class="headerTR">Expense description</th>
		<td>
			<textarea rows="4" cols="" name="expenseDesc" id="expenseDesc" class="fullRowElement"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan=2 align="center"><input class="btn btn-main btn-2g" type="Submit" id="page1" name="page1" value="Submit"></td>
	</tr>
	
</table>
<div id="dialog-confirm"></div>
</form>
</body>
</html>
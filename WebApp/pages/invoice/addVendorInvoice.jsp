<%@page import="com.org.krishnadeep.models.InvoiceModel"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.modules.Invoice"%>
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
Invoice invoice = new Invoice();
List<InvoiceModel> invoiceList = invoice.getInvoiceList();

%>

<h1 align="center">Add Invoice</h1>
<div style="float: right;padding-right: 11%; padding-bottom: 0.3%">
	<!-- <input type="button" name="newExpense" id="newExpense" value=""> -->
	<button class="btn btn-main btn-2g" name="newInvoice" id="newInvoice" onclick="openInvoiceFancyBox(0, 'newInvoice', this);">New Invoice</button>
</div><br />
<table width="100%" border="1" id="invoiceTable">
<thead>
	<tr class="headerTR">
		<th width="20%">Invoice No</th>
		<th width="20%">Vendor Name</th>
		<th width="10%">Amount</th>
		<th>Comments</th>
		<th width="10%">Action</th>
	</tr>
</thead>
<tbody>
<%
if(invoiceList.size() > 0){
	for(InvoiceModel invoiceModel : invoiceList){
		%><tr align="center">
			<th>
				<a href="#" name="editInsurance" id="<%=invoiceModel.getInvoiceId() %>" 
				style="text-decoration: none; color: #2d9fd0"
				onclick="openInvoiceFancyBox(<%=invoiceModel.getInvoiceId() %>, 'newInvoice', this);"><%=invoiceModel.getInvoiceId() %>
				</a>
			</th>
			<td><%=invoiceModel.getVendor().getVendorName() %></td>
			<td><%=invoiceModel.getAmount() %></td>
			<td align="left"><%=invoiceModel.getComments() %></td>
			<td><img height="18%" name="print" src="<%=contextPath %>/resources/images/print.png"
							onclick="printVendorReceipt(this)" id="print_<%=invoiceModel.getInvoiceId()%>"></td>
		</tr>
		<%
	}
}
%>
</tbody>
</table>
<script type="text/javascript" src="<%=contextPath%>/resources/js/invoice.js"></script>
</body>
</html>
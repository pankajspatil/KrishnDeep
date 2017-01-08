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
<h1 align="center">Add Invoice</h1>
<div style="float: right;padding-right: 11%">
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
	</tr>
</thead>
<tbody>

</tbody>
</table>
<script type="text/javascript" src="<%=contextPath%>/resources/js/invoice.js"></script>
</body>
</html>
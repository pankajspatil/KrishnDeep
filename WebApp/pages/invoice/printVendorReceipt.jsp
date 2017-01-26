<%@page import="com.org.krishnadeep.models.ExpenseModel"%>
<%@page import="com.org.krishnadeep.models.InvoiceModel"%>
<%@page import="com.org.krishnadeep.modules.Invoice"%>
<%@page import="com.org.krishnadeep.models.UserVisit"%>
<%@page import="com.org.krishnadeep.modules.Visit"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.generic.EnglishNumberToWords"%>
<%@page import="java.util.Date"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/Krishnadeep/resources/css/print.css" media="print">
<style type="text/css" media="print">
@page {
    size: auto;   /* auto is the initial value */
    margin: 0;  /* this affects the margin in the printer settings */
}
</style>
</head>
<body>
<%

Integer invoiceId = Utils.getInt(request.getParameter("invoiceId"));
Invoice invoice = new Invoice();

InvoiceModel invoiceModel = invoice.getInvoice(invoiceId);
double totalAmount = 0;

if(invoiceModel != null){
	
	//String patientName =  userVisit.getPatient().getFirstName().toUpperCase() + " " + userVisit.getPatient().getLastName().toUpperCase();
	//String doctorName =  userVisit.getDoctor().getFirstName().toUpperCase() + " " + userVisit.getDoctor().getLastName().toUpperCase();
%>
<center>
	<div style="font-size: xx-large; font-weight: bolder;">KRISHNADEEP HOSPITAL</div>
	<div style="font-size: larger; font-weight: bold;">MATERNITY &amp; EYE CARE CENTER</div>
	<span>Kini Arcade, C Wing, 2<sup>nd</sup> Floor, Near Stella Petrol Pump, Stella, Vasai(W).</span><br/>
	Mobile : 9960509773 / 7507119030
</center>
<!-- <hr/> --> <br />

<table width="100%" border="1" style="border: 1px solid gray; border-collapse: collapse;">
	<tr>
		<th width="15%">Invoice No : </th>
		<td width="50%"><%=invoiceModel.getInvoiceId() %></td>
		<td width="35%"><b>Date : </b><%=invoiceModel.getCreatedOn() %></td>
	</tr>
	<tr>
		<th>Vendor Name : </th>
		<td colspan="2"><%=invoiceModel.getVendor().getVendorName() %></td>
	</tr>
	<tr style="background-color: #D3D3D3; -webkit-print-color-adjust: exact;">
		<th colspan="2">PERTICULARS</th>
		<th>RS.</th>
	</tr>
	<%if(invoiceModel.getExpenseList().size() > 0){
		
		for(ExpenseModel expenseModel : invoiceModel.getExpenseList()){
		%><tr>
			<th colspan="2"><%=expenseModel.getExpenseItem().getExpenseItemName() %></th>
			<th><%=expenseModel.getPaidAmt() %></th>
		</tr><%
		totalAmount += expenseModel.getPaidAmt();
		}
		%><tr>
			<th align="right" colspan="2" style="background-color: #D3D3D3; -webkit-print-color-adjust: exact;">Total</th>
			<th><%=totalAmount %></th>
	</tr><%
	}%>
	
</table><br />
<%-- <table width="100%" border="1" style="border: 1px solid gray; border-collapse: collapse;">
	<tr>
			<th align="right" width="65%" style="background-color: #D3D3D3; -webkit-print-color-adjust: exact;">Total : </th>
			<th><%=totalAmount %></th>
	</tr>
</table> --%>


<script type="text/javascript">
var w = window.print();
//debugger;
//this.close();

/* window.onbeforeprint = function() {
    alert('This will be called before the user prints.');
};
window.onafterprint = function() {
	alert('This will be called after the user prints');   
}; */
</script>
<%} %>
</body>
</html>
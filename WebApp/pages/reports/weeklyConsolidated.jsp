<%@page import="com.org.krishnadeep.models.WeeklyData"%>
<%@page import="com.org.krishnadeep.masters.Masters"%>
<%@page import="com.org.krishnadeep.models.ExpenseModel"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.modules.Expense"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/validateSession.jsp"%>
<%@ include file="/pages/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="<%=contextPath%>/resources/js/reports.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('img[name=print]').click(function(e){
		printWeeklyReceipt(this);
	});
});
</script>
<script type="text/javascript">

function printWeeklyReceipt(btnObj){
	
	var fromdate = document.getElementById( 'week' ).value;
	var todate = document.getElementById( 'endweek' ).value;
	
	var paramMap = new Map();
	
	var url = contextPath + '/pages/invoice/printWeeklyReceipt.jsp?fromdate=' + fromdate+'&toDate='+todate;
	
	paramMap.put(URL, url);
	paramMap.put(WIDTH, '70%');
	paramMap.put(HEIGHT, '80%');
	
	openFancyBox(btnObj, paramMap);
}

</script>
</head>
<body>
	<%
		String fromDate = Utils.getString(request.getParameter("week"));
		String toDate = Utils.getString(request.getParameter("endweek"));
		String page1 = Utils.getString(request.getParameter("page1"));

		if (fromDate.equals("") && page1.equals("")) {
			String pattern = "yyyy-MM-dd";
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
					pattern);
			String date = simpleDateFormat.format(new Date());
			fromDate = date;
			toDate = date;
		}
	%>
	<h2 align="center">Consolidated Weekly Report</h2>
	<form action="" method="post">
		<table align="center" border="0" width="30%">
			<tr align="center">
				<th>Select Start Week : <input style="height: 33px;"
					type="text" name="week" id="week" readonly="readonly" value="<%=fromDate %>">
				</th>
				
				<th>Select End Week : <input style="height: 33px;" type="text"
					name="endweek" id="endweek" readonly="readonly" value="<%=toDate %>"> 
				</th>
				
			</tr>

			<tr align="center">
				<td colspan="2"><input class="btn btn-main btn-2g"
					type="submit" name="page1" id="page1" value="Submit"
					onclick="return validateWeeklyStatusForm()"></td>
			</tr>
		</table>
	</form>
	<%
	if (!page1.equals("")){
		
	
		Masters master = new Masters();
		List<WeeklyData> weeklyDataList = master
				.getConsolidatedWeeklyCountsData(0, false, null,fromDate,toDate);

		Integer totalPatientCount = 0, totalPatientsCalim = 0, totalPatientsNonCalim = 0;
		Double totalPatientAmount = 0.0, totalAmountPatientsCalim = 0.0, totalAmountPatientsNonCalim = 0.0;
	%>

	<div style="float: right; padding-right: 11%">
		<!-- <input type="button" name="newExpense" id="newExpense" value=""> -->
		<img height="10%" name="print" src="<%=contextPath %>/resources/images/print.png" name="print"
			id="print" onclick="printWeeklyReceipt(this);"/>
	</div>
	<table border="1" class="mainTable" width="100%" id="weeklyDataTable">
		<thead>
			<tr class="headerTR">
				<th>weekYear</th>
				<th width="10%">Week</th>
				<th width="15%">Doctor</th>
				<th width="15%">Patients</th>
				<th width="15%">Amount</th>
				<th width="15%">Patients-Claim</th>
				<th width="15%">Amount-Claim</th>
				<th width="15%">Patients-NonClaim</th>
				<th width="15%">Amount-NonClaim</th>

			</tr>
		</thead>
		<tbody>
			<%
				for (WeeklyData weeklyData : weeklyDataList) {
			%>
			<tr>
				<td><%=weeklyData.getWeekYearNo()%></td>
				<td align="center"><%=Utils.getFormattedDate(Utils.parseDate(
						weeklyData.getWeekStartDate(), "yy-MM-dd"), "")%></td>
				<td><%=weeklyData.getDoctorName()%></td>
				<td><%=weeklyData.getPatientCount()%></td>
				<td><%=weeklyData.getPatientAmount()%></td>
				<td><%=weeklyData.getPatientCountClaim()%></td>
				<td><%=weeklyData.getPatientAmountClaim()%></td>
				<td><%=weeklyData.getPatientCountNonClaim()%></td>
				<td><%=weeklyData.getPatientAmountNonClaim()%></td>

				<%
					totalPatientCount += weeklyData.getPatientCount();
						totalPatientAmount += weeklyData.getPatientAmount();
						totalPatientsCalim += weeklyData.getPatientCountClaim();
						totalAmountPatientsCalim += weeklyData.getPatientAmountClaim();
						totalPatientsNonCalim += weeklyData.getPatientCountNonClaim();
						totalAmountPatientsNonCalim += weeklyData
								.getPatientAmountNonClaim();
				%>
			</tr>
			<%
				}
			%>


		</tbody>
	</table>
	<table border="1" align="center" class="mainTable" width="80%">
		<tr>
			<th width="15%">Total Patient</th>
			<th width="15%">Total Amount</th>
			<th width="15%">Total Patients-Claim</th>
			<th width="15%">Total Amount-Claim</th>
			<th width="15%">Total Patients-NonClaim</th>
			<th width="15%">Total Amount-NonClaim</th>

		</tr>
		<tr>
			<td><%=totalPatientCount%></td>
			<td><%=totalPatientAmount%></td>
			<td><%=totalPatientsCalim%></td>
			<td><%=totalAmountPatientsCalim%></td>
			<td><%=totalPatientsNonCalim%></td>
			<td><%=totalAmountPatientsNonCalim%></td>			
		</tr>
	</table>
	<% } %>
	<script type="text/javascript"
		src="<%=contextPath%>/resources/js/weeklyData.js"></script>
</body>
</html>
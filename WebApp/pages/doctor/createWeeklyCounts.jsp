<%@page import="com.mysql.jdbc.Util"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.masters.Masters"%>
<%@page import="com.org.krishnadeep.models.WeeklyData"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/pages/common/validateSession.jsp"%>
<%@ include file="/pages/common/header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
h2.theme-blue-title-bar a{
	z-index: 1;
}
</style>

</head>
<body>
<%
SessionModel sessionModel = null;
sessionModel = (SessionModel)session.getAttribute(Constants.SESSION_MODEL);
Integer weeklyCountId = Utils.getInt(request.getParameter("weeklyCountId"));
Integer userId = Integer.parseInt(session.getAttribute(Constants.USER_ID).toString());

Integer patientCount = 0, patientCountClaim = 0, patientCountNonClaim = 0;
Double patientAmount = 0.0, patientAmountClaim = 0.0, patientAmountNonClaim = 0.0,patientChequeAmountClaim = 0.0, patientChequeAmountNonClaim = 0.0;
Integer weekYear = 0;
String weekStartDate = "";

String page1 = Utils.getString(request.getParameter("page1"));
String submitText = weeklyCountId == 0 ? "ADD" : "UPDATE";

WeeklyData weeklyData;
Masters master = new Masters();

if(page1.equals("") && weeklyCountId != 0){
	
	
	List<WeeklyData> weeklyDataList = master.getWeeklyCountsData(weeklyCountId, false,sessionModel);
	
	if(!weeklyDataList.isEmpty()){
		
		weeklyData = weeklyDataList.get(0);
		
		patientCount = Utils.getInt(weeklyData.getPatientCount());
		//patientCountClaim = Utils.getInt(weeklyData.getPatientCountClaim());
		//patientCountNonClaim = Utils.getInt(weeklyData.getPatientCountNonClaim());

		patientAmount = Utils.getDouble(weeklyData.getPatientAmount());
		patientAmountClaim = Utils.getDouble(weeklyData.getPatientAmountClaim());
		patientAmountNonClaim = Utils.getDouble(weeklyData.getPatientAmountNonClaim());
		patientChequeAmountClaim = Utils.getDouble(weeklyData.getPatientChequeAmountClaim());
		patientChequeAmountNonClaim = Utils.getDouble(weeklyData.getPatientChequeAmountNonClaim());
		weekYear = Utils.getInt(weeklyData.getWeekYearNo());
		
		weekStartDate = Utils.getString(weeklyData.getWeekStartDate());
	}
	
}else{
	
	String message = "Record Added Successfully.";
	
	patientCount = Utils.getInt(request.getParameter("patientCount"));
	//patientCountClaim = Utils.getInt(request.getParameter("patientCountClaim"));
	//patientCountNonClaim = Utils.getInt(request.getParameter("patientCountNonClaim"));

	patientAmount = Utils.getDouble(request.getParameter("patientAmount"));
	patientAmountClaim = Utils.getDouble(request.getParameter("patientAmountClaim"));
	patientAmountNonClaim = Utils.getDouble(request.getParameter("patientAmountNonClaim"));
	patientChequeAmountClaim = Utils.getDouble(request.getParameter("patientChequeAmountClaim"));
	patientChequeAmountNonClaim = Utils.getDouble(request.getParameter("patientChequeAmountNonClaim"));
	weekYear = Utils.getInt(request.getParameter("weekYear"));
	weekStartDate = Utils.getString(request.getParameter("week"));
	
	weeklyData = new WeeklyData();	
	weeklyData.setPatientCount(patientCount);
	weeklyData.setPatientAmount(patientAmount);
	//weeklyData.setPatientCountClaim(patientCountClaim);
	//weeklyData.setPatientCountNonClaim(patientCountNonClaim);
	weeklyData.setPatientAmountClaim(patientAmountClaim);
	weeklyData.setPatientChequeAmountClaim(patientChequeAmountClaim);	
	weeklyData.setPatientChequeAmountNonClaim(patientChequeAmountNonClaim);
	weeklyData.setPatientAmountNonClaim(patientAmountNonClaim);
	weeklyData.setWeekYearNo(weekYear);
	weeklyData.setWeekStartDate(weekStartDate);
	weeklyData.setCreatedBy(userId);
	weeklyData.setWeeklyDataId(weeklyCountId);
	
	if(page1.equals("ADD")){
		master.insertWeeklyData(weeklyData);		
	}else if(page1.equals("UPDATE")){
		master.updateWeeklyData(weeklyData);
		message = "Record Updated Successfully.";
	}
	if(!page1.equals("")){
		
	%>
	<script type="text/javascript">
	Lobibox.alert("success",{
		msg : '<%=message%>',
		beforeClose: function(lobibox){
        	parent.location.reload();
        }
	});
	</script>
	<%
	}
	
}
%>

<form name="weeklyCountForm" id="weeklyCountForm" method="post">
<h1 align="center">Add Weekly Patient Data</h1>
<table border="0" width="70%" align="center">
<tr>
	<th align="left" colspan="2">Select Week : <input style="height: 33px;" type="text" name="week" id="week" value="<%=weekStartDate %>" readonly="readonly"> </th>
</tr>
	<tr align="center">
		<td width="30%" valign="top">
			<h3>No. of patient's seen</h3>
			<table width="100%" border="1" class="mainTable" border="1" style="border: 0px solid">
				<tr>
					<th class="headerTR">No of patients : </th>
					<td>
						<input class="fullRowElement" type="text" name="patientCount" id="patientCount" 
						value="<%=patientCount%>" onkeyup="validateNumbersKeyPress(this)"> 
					</td>
				</tr>
				<tr>
					<th class="headerTR">Amount</th>
					<td>
						<input class="fullRowElement" type="text" name="patientAmount" id="patientAmount" 
						value="<%=patientAmount%>" >
					</td>
				</tr>
			</table>
		</td>
		<td width="40%" valign="top">
			<h3>No. of operations</h3>
			<div class="bwl_acc_container scroll accordionDiv" id="accordion_1" style="width: 98%; /* border:1px solid black; */">
					<section>
					<h2 class="acc_title_bar">
						<a href="#">Medical Claims</a>
					</h2>
					<div class="acc_container">
						<table width="100%" border="1" class="mainTable" border="1" style="border: 0px solid">
							<tr>
								<th class="headerTR">Cheque Amount</th>
								<td>
									<input class="fullRowElement" type="text" name="patientChequeAmountClaim" id="patientChequeAmountClaim" 
									value="<%=patientChequeAmountClaim%>">
								</td>
							</tr>
							<tr>
								<th class="headerTR">Cash Amount</th>
								<td>
									<input class="fullRowElement" type="text" name="patientAmountClaim" id="patientAmountClaim" 
									value="<%=patientAmountClaim%>">
								</td>
							</tr>
						</table>
					</div>
					</section>
					<section>
					<h2 class="acc_title_bar">
						<a href="#">Non Medical Claims</a>
					</h2>
					<div class="acc_container">
						<table width="100%" border="1" class="mainTable" border="1" style="border: 0px solid">
							<tr>
								<th class="headerTR">Cheque Amount</th>
								<td>
									<input class="fullRowElement" type="text" name="patientChequeAmountNonClaim" id="patientChequeAmountNonClaim" 
									value="<%=patientChequeAmountNonClaim%>">
								</td>
							</tr>
							<tr>
								<th class="headerTR">Cash Amount</th>
								<td>
									<input class="fullRowElement" type="text" name="patientAmountNonClaim" id="patientAmountNonClaim" 
									value="<%=patientAmountNonClaim%>">
								</td>
							</tr>
						</table>
					</div>
					</section>

				</div>
		</td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr align="center">
		<td colspan="2">
			<input type="submit" value="<%=submitText %>" class="btn btn-main btn-2g" 
			name="page1" id="page1" onclick="return validateWeeklyCountsForm()">
		</td>
	</tr>
</table>
<input type="hidden" name="weekYear" id="weekYear" value="">
<script type="text/javascript">
var oldWeekYear = '<%=weekYear.equals("0") ? "0" :  weekYear%>';
</script>
<script type="text/javascript" src="<%=contextPath %>/resources/js/weeklyData.js"></script>
</form>
</body>
</html>
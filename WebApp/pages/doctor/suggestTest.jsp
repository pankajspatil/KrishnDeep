<%@page import="com.org.krishnadeep.generic.Constants"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.org.krishnadeep.modules.Visit"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="/pages/common/validateSession.jsp"%>
<%@ include file="/pages/common/header.jsp"%>

<style type="text/css">
		/*this is just to organize the demo checkboxes*/
		label {margin-right:20px;}
</style>
<script type="text/javascript"
	src="<%=contextPath %>/resources/js/visit.js"></script>
</head>
<body>

<%
	Visit visit = new Visit();
	LinkedHashMap<String, Object> medicalTestMap = visit.getMedicalTests();
	LinkedHashMap<String, String> childMap = null;
	String medicalTestLabel = "";
	Integer numberOfTests = Integer.parseInt(medicalTestMap.get(Constants.NUMBER_OF_ROWS).toString()), 
			maxCount = configLookup.get(Constants.MAX_ROWS_MEDICAL_TEST) != null ? Integer.parseInt(configLookup.get(Constants.MAX_ROWS_MEDICAL_TEST).toString()) : 10, 
			maxRows = maxCount;
			medicalTestMap.remove(Constants.NUMBER_OF_ROWS);
	//out.println("numberOfTests===>" + numberOfTests + maxCount);
			
	if(numberOfTests > 0){
		int numberOfTableColumns = (numberOfTests % maxCount != 0) ? (numberOfTests / maxCount ) + 1 : (numberOfTests / maxCount );
		//out.println("numberOfTableColumns===>" + numberOfTableColumns);
		%>
		<h1 align="center">Medical Tests</h1>
		<table>
			<tr>
				<td valign="top" class="width<%=numberOfTableColumns%>">
					<table>
					<%
					for(String parentKey : medicalTestMap.keySet()){
						//out.println("maxRows == >" + maxRows);
						if(maxRows == 0){
							maxRows = maxCount;
							%></table></td><td valign="top" class="width<%=numberOfTableColumns%>"><table><%
						}
						childMap = (LinkedHashMap<String, String>)medicalTestMap.get(parentKey);
						%><tr><td><b>
							<%=parentKey.split("##")[1] %></b></td></tr><%
						maxRows = maxRows - 1;
						for(String medicalTestId : childMap.keySet()){
							//out.println("maxRows Ineer == >" + maxRows);
							if(maxRows == 0){
								maxRows = maxCount;
								%></table></td><td valign="top" class="width<%=numberOfTableColumns%>"><table><%
							}
							medicalTestLabel = childMap.get(medicalTestId);
							maxRows = maxRows - 1;
							%><tr><td>
								<input class="css-checkbox" type="checkbox" name="medicalTestId" value="<%=medicalTestId%>" 
								id="checkboxG<%=medicalTestId%>">
								<label for="checkboxG<%=medicalTestId%>" class="css-label"><%=medicalTestLabel %></label>
								</td></tr><%
						}
					}%>
					</table>
				</td>
			</tr>
		</table><br/><br/><br/>
		<table align="center">
		<tr align="center">
				<td align="center">
					<input type="button" id="submitTests" onclick="submitTests()" value="Submit">
				</td>
			</tr>
		</table>
		<%
		
	}else{
		%><h1>No Test Setup. Please contact administrator.</h1><%
	}
	
%>
<script>updateMedicalTests()</script>
</body>
</html>
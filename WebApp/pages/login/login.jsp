<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.org.krishnadeep.generic.Constants"%>
<%@page import="com.org.krishnadeep.login.Login"%>
<%@page import="com.org.krishnadeep.models.SessionModel"%>

<%@page import="java.sql.Connection,java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/header.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en"> 
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <link rel="stylesheet" href="/Krishnadeep/resources/css/style.css">
</head>
<body>

<%
	if(session.getAttribute(Constants.USER_ID) != null){
		response.sendRedirect(request.getContextPath()+"/pages/common/home.jsp");
	}
	
	String userName = request.getParameter("userName") == null ? "" : request.getParameter("userName");
	String password = request.getParameter("password") == null ? "" : request.getParameter("password") ;
	String page1 = request.getParameter("page1");
	Integer userId = null;
	LinkedHashMap<String, String> userDispensaryMap = null;

	if(page1 != null && page1.equals("submit")){ 
		Login login = new Login();
		userId = login.verifyUser(userName, password);	
		if(userId != 0){
			userDispensaryMap = login.getDispensarys(userId);			
			if(userDispensaryMap.size() == 1){
				
				for(String userDispensaryId : userDispensaryMap.keySet()){
					session.setAttribute(Constants.USER_ID, userDispensaryId);
					String dispensaryDetails = userDispensaryMap.get(userDispensaryId);
					session.setAttribute(Constants.DISPENSARY_ID, dispensaryDetails.split("##")[0]);
					
					List<String> list = login.getUserMenu(userDispensaryId);
					session.setAttribute("menu", list);
					
					SessionModel sessionModel = new SessionModel(); 
					sessionModel.setSessionDipensaryId(Integer.parseInt(dispensaryDetails.split("##")[0]));
					sessionModel.setSessionUserId(userId);
					session.setAttribute(Constants.SESSION_MODEL, sessionModel);
				}
				response.sendRedirect(request.getContextPath()+"/pages/common/home.jsp");
			}else if(userDispensaryMap.size() > 1){
				session.setAttribute(Constants.USER_DISPENSARY_DETAILS, userDispensaryMap);
				response.sendRedirect(request.getContextPath()+"/pages/login/selectDispensary.jsp");
			}
		}		
	}
%>

  <section class="container">
    <div class="login">
      <h1>Login</h1>
      <form method="post" action="">
        <p><input type="text" name="userName" value="<%=userName %>" placeholder="Username"></p>
        <p><input type="password" name="password" value="<%=password %>" placeholder="Password"></p>
        <%	
        	if(userId != null && userId == 0){
        	%><p><label>Wrong username or password</label></p><% 
        	}
        	if(userDispensaryMap != null && userDispensaryMap.size() == 0){
        	%><p><label>No Dispensary Mapping Exist</label></p><% 
        	}
        %>
        
        <p class="remember_me">
          <label>
            <input type="checkbox" name="remember_me" id="remember_me">
            Remember me on this computer
          </label>
        </p>
        <p class="submit">
        	<input type="submit" name="commit" value="Login">&nbsp;&nbsp;
        	<input style="float: right; text-align: right;" type="button" class="button"  name="signUP" value="SignUp" onclick="location.href='/ResourcePlan/pages/login/createUser.jsp'">
        </p>
        <input type="hidden" name="page1" value="submit" />
      </form>
    </div>

    <div class="login-help">
      <p>Forgot your password? <a href="/Krishnadeep/pages/login/forgotPassword.jsp">Click here to reset it.</a></p>
    </div>
  </section>
  
  <%
  	userId = null;
  	finalize();
  %>
</body>
<%@ include file="/pages/common/footer.jsp" %>
</html>

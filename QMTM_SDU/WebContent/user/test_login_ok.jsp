<%@ page 
		language="java" 
		contentType="text/html;charset=utf-8"
%>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, etest.User_QmTm, org.apache.commons.codec.binary.Base64" %>
<%@ page import="etest.LoginManager" %>
<%!
	LoginManager loginManager = LoginManager.getInstance();
%>
<%
  String userid = "715650";
  String userName = "715650";
  

	if(userName == null) {
%>
	<script type="text/javascript">
		alert("데이터베이스에 존재하지 않는 회원입니다.");
		top.window.close();
	</script>
<%
		if(true) return;
	} else {		
	
		// 세션 설정
		session.setAttribute("current_userid", userid);
		session.setAttribute("current_username", userName);
		session.setMaxInactiveInterval(60*60*4);
		
		if(loginManager.isUsing(userid)) {
			loginManager.removeSession(userid);
			
			loginManager.setSession(session, userid);
		} else {
			loginManager.setSession(session, userid);
		}		
%>
	<script type="text/javascript">
		alert("[<%= userName %>] 님의 방문을 환영합니다.");
		top.location.href = "./main.jsp";
	</script>
<%
		if(true) return;
	}
%>
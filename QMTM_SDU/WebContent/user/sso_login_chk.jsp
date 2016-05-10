<%@ page 
		language="java" 
		contentType="text/html;charset=utf-8"
		import="java.io.*,
						java.util.*,
						java.net.*,
						sun.misc.*,
						javax.servlet.http.HttpSession"
%>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, etest.User_QmTm, org.apache.commons.codec.binary.Base64" %>
<%@ page import="etest.LoginManager" %>
<%!
	LoginManager loginManager = LoginManager.getInstance();
%>
<%
  String sso_id = request.getHeader("iv-user");
  String system_id = request.getHeader("employeenumber");
  String userid = "";
  String userName = "";
  
  if(sso_id.length() > 0 && system_id.length() > 0) {
	  userid = system_id;
  } else {
	  %>
		<Script type="text/javascript">
			alert("로그인후 접속해주시기 바랍니다.")
			top.window.close();
		</Script>
	<%
		if(true) return;	  
  }

	// 사용자 인증
	try {
		userName = User_QmTm.getNameBySSO(userid);
  } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));
		
	    if(true) return;
  }

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
		
		// 이미 접속한 아이디인지 체크한다.
		if(loginManager.isUsing(userid)) {
			// 기존 접속자를 로그아웃 시킨다.
			loginManager.removeSession(userid);
			
			// 새로운 세션을 등록한다. setSession함수를 수행하면 valueBound()함수가 호출된다.
			loginManager.setSession(session, userid);
		} else {
			loginManager.setSession(session, userid);
		}		
%>
	<script type="text/javascript">
		alert("[<%= userName %>] 님의 방문을 환영합니다.");
		top.location.href = "./default.jsp";
	</script>
<%
		if(true) return;
	}
%>
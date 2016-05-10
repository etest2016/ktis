<%
//******************************************************************************
//   프로그램 : login_ok.jsp
//   모 듈 명 : 로그인 처리
//   설    명 : 로그인 처리
//   테 이 블 : qt_workerid, qt_settings
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProc
//   작 성 일 : 2008-06-26
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>         
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProc, qmtm.AdminProc" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	String pwd = request.getParameter("pwd");
	if (pwd == null) { pwd = ""; } else { pwd = pwd.trim(); }
	
	if (userid == "" || pwd == "") {	
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}

	String name = "";

	// 비밀번호 암호화.
	/*try {
		pwd = CommonUtil.encrypt(pwd);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }*/

	// 사용자 인증
	try {
	    name = LoginProc.getLoginChk(userid, pwd);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));
		
	    if(true) return;
    }


	if(name == null) {
		// 중간관리자인지 확인합니다.
		try {
			name = AdminProc.getLoginChk(userid, pwd);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}

		if(name == null) {
%>
	<script type="text/javascript">
		alert("아이디 또는 비밀번호를 확인하세요.");
		history.back();
	</script>
<%
			if(true) return;
		} else {
			// 세션 설정
			session.setAttribute("userid", userid);
			session.setAttribute("username", name);
			session.setAttribute("usergrade", "M");
			
%>
			<script type="text/javascript">
				location.href = 'default.jsp';
			</script>
<%
            if(true) return;
		}

	} else {
		// 세션 설정
		session.setAttribute("userid", userid);
		session.setAttribute("username", name);
		
		if(userid.equals("qmtm")) {
			session.setAttribute("usergrade", "S");
		} else {
			session.setAttribute("usergrade", "C");
		}
%>

	<script type="text/javascript">
		location.href = "default.jsp";
	</script>
<%
		if(true) return;
	}
%>

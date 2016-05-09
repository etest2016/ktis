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
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProc, qmtm.ExamManager" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	String pwd = request.getParameter("pwd");
	if (pwd == null) { pwd = ""; } else { pwd = pwd.trim(); }
	
	if (userid == "") {	
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}

	String name = "";
	String pwd2 = "";

	
	if(userid.equals("qmtm")) {

	// 비밀번호 암호화.
	try {
		pwd2 = CommonUtil.encrypt(pwd);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	} else {
		pwd2 = pwd;
	}

	// 사용자 인증
	try {
	    name = LoginProc.getLoginChk(userid, pwd2);
    } catch(Exception ex) {
	    //out.println(ComLib.getExceptionMsg(ex, "back"));
		out.println(ex.getMessage());	
	    if(true) return;
    }

	if(name == null) {
		// 채점자인지 확인합니다.
		try {
			name = ExamManager.getLoginChk(userid, pwd);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}

		if(name == null) {
%>
	<script language="javascript">
		alert("아이디 또는 비밀번호를 확인하세요.");
		history.back();
	</script>
<%
			if(true) return;
		} else {
			// 쿠키 설정
			session.setAttribute("userid", userid);
			session.setAttribute("username", name);
%>

			<script language="javascript">
				location.href = 'manager.jsp';
			</script>
<%
            if(true) return;
		}

	} else {
		// 쿠키 설정
		session.setAttribute("userid", userid);
		session.setAttribute("username", name);
		
%>

	<script language="javascript">
		location.href = 'default.jsp';
	</script>
<%
		if(true) return;
	}
%>

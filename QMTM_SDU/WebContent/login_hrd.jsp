<%
//******************************************************************************
//   프로그램 : login_hrd.jsp
//   모 듈 명 : HRD에서 로그인 처리
//   설    명 : HRD에서 로그인 처리
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
		
	if (userid == "") {	
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	String name = "";

	/* 아이디 복호화.
	try {
		userid = LoginProc.getUseridDecode(userid);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	*/

	// 사용자 인증
	try {
	    name = LoginProc.getLoginName(userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));
		
	    if(true) return;
    }

	if(name == null) {
		// 중간관리자인지 확인합니다.
		try {
			name = AdminProc.getLoginName(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

		    if(true) return;
		}

		if(name == null) {
%>
	<script language="javascript">
		alert("해당 화면에 권한이 없습니다.");
		window.close();
	</script>
<%
			if(true) return;
		} else {
			// 세션 설정
			session.setAttribute("userid", userid);
			session.setAttribute("username", name);
			session.setAttribute("usergrade", "M");
%>

			<script language="javascript">
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

	<script language="javascript">
		location.href = 'default.jsp';
	</script>
<%
		if(true) return;
	}
%>

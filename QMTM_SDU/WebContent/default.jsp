<%
//******************************************************************************
//   프로  그램 : default.jsp
//   모  듈  명 : QMTM 초기 페이지
//   설      명 : QMTM 초기 페이지
//   테 이   블 : t_worker_subj, c_course, q_worker_subj, q_subject
//   자바  파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerTUtil
//   작  성  일 : 2010-05-30
//   작  성  자 : 이테스트 석준호
//   수  정  일 : 
//   수  정  자 : 
//	 수정  사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.PwdChange, qmtm.CommonUtil, qmtm.admin.manager.ManagerTUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String userid = "";

	userid = (String)session.getAttribute("userid"); // 권한
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
%>
	<Script type="text/javascript">
		location.href = "login.jsp";
	</Script>
<%
		if(true) return;
	}

	String usergrade = (String)session.getAttribute("usergrade"); // 권한

	if(usergrade.equals("M") || usergrade.equals("S")) {
		int day_diff = 0;

		try {
			day_diff = PwdChange.getPwdChange(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

		    if(true) return;
		}

		if(day_diff > 30) {
			String msg_notice = ""; 
%>
	<Script language="JavaScript">
		var diff_date = <%=day_diff%>;
		alert(diff_date + "일동안 비밀번호를 변경하지 않았습니다.\n비밀번호는 보안상 30일 주기로 변경해주시기 바랍니다.\n\n확인을 클릭한 후 상단에 비밀번호변경버튼을 통해 \n비밀번호를 변경해주세요.");
	</Script>
<%
		}		
	}

	int qcnt = 0; 
	int tcnt = 0;  
		
	if(userid.length() > 0 && !(userid.equals("qmtm"))) {

		// 권한 여부 체크하기
		try {
			tcnt = ManagerTUtil.getBeanCnt(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

      	    if(true) return;
		}
	}

	if(!(userid.equals("qmtm") || usergrade.equals("M"))) {	
		if(tcnt == 0) {
			out.println(ComLib.getAlertMsg("권한이 등록된 과정이 없습니다. 관리자에게 권한요청 후 이용하시기 바랍니다.", "close"));

			if(true) return;
		}
	}
	
	if(tcnt > 0) {
		qcnt = tcnt;
	}
	
%>
<HTML>      
<HEAD>
<TITLE> 온라인평가 관리자 시스템 </TITLE>
</HEAD>
<%
	/*로그인 하지 않은 경우 로그인 페이지로 이동*/
	if(userid.length() == 0){
%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		location.href = "login.jsp";
	//-->
	</SCRIPT>
<% } else { %>
	<frameset rows="30,*" frameborder="NO" framespacing="0" border="1">
		<frame id="top" name="top" src="top.jsp" noresize scrolling="no">
		<% if(userid.equals("qmtm") || usergrade.equals("M")) { %>             
		<frame id="main" name="main" src="admin/index.jsp?userid=<%=userid%>&qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" noresize scrolling="yes">
		<%
		   } else {
				if(qcnt == 0) { 
		%>
			<frame id="main" name="main" src="tman/index.jsp?userid=<%=userid%>&qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" noresize scrolling="yes">
			<% } else { %>
			<frame id="main" name="main" src="qman/index.jsp?userid=<%=userid%>&qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" noresize scrolling="yes">
		<% 
			   } 
		   }
		%>
	</frameset>
<% 
   } 
%>
</HTML>

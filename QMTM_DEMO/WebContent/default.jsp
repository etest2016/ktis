<%
//******************************************************************************
//   프로  그램 : default.jsp
//   모  듈  명 : QMTM 초기 페이지
//   설      명 : QMTM 초기 페이지
//   테 이   블 : t_worker_subj, c_course, q_worker_subj, q_subject
//   자바  파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerQUtil, 
//               qmtm.admin.manager.ManagerTUtil
//   작  성  일 : 2010-05-30
//   작  성  자 : 이테스트 석준호
//   수  정  일 : 
//   수  정  자 : 
//	 수정  사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerQUtil, qmtm.admin.manager.ManagerTUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String userid = "";

	userid = (String)session.getAttribute("userid"); // 권한
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	int qcnt = 0; 
	int tcnt = 0; 
		
	if(userid.length() > 0) {
		// QMAN 권한 여부 체크하기
		try {
			qcnt = ManagerQUtil.getBeanCnt(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}

		// TMAN 권한 여부 체크하기
		try {
			tcnt = ManagerTUtil.getBeanCnt(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

      	    if(true) return;
		}
	}
	
%>
<HTML>      
<HEAD>
<TITLE> 온라인평가 관리자 시스템 </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
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
		<frame name="top" src="top.jsp" noresize scrolling="no">
		<% if(userid.equals("qmtm")) { %>             
		<frame name="main" src="admin/index.jsp?userid=<%=userid%>&qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" noresize scrolling="yes">
		<%
		   } else {
				if(qcnt == 0) { 
		%>
			<frame name="main" src="tman/index.jsp?userid=<%=userid%>&qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" noresize scrolling="yes">
			<% } else { %>
			<frame name="main" src="qman/index.jsp?userid=<%=userid%>&qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" noresize scrolling="yes">
		<% 
			   } 
		   }
		%>
	</frameset>
<% 
   } 
%>
</HTML>

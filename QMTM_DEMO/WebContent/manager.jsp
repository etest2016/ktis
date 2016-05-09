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

	userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
%>
<HTML>      
<HEAD>
<TITLE> KT 인재개발원 온라인 평가시스템 </TITLE>
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
		<frame name="main" src="tman/manager.jsp?userid=<%=userid%>" noresize scrolling="yes">		
	</frameset>
<% 
   } 
%>
</HTML>

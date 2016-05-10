<%
//******************************************************************************
//   프로그램 : f_top.asp
//   모 듈 명 : 시험관리 상단 프레임
//   설    명 : 시험관리 상단 프레임
//   테 이 블 : 
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib
//   작 성 일 : 2010-06-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 :   
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib" %>
<%@ include file = "/common/login_chk.jsp" %>
<%     
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // 사용자 아이디
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {            
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int qcnt = Integer.parseInt(request.getParameter("qcnt"));
	int tcnt = Integer.parseInt(request.getParameter("tcnt"));

	String usergrade = (String)session.getAttribute("usergrade"); // 권한
%>

<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>

  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="../js/jquery.js"></script>
  <script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
  <script language="javascript">
	function admin_static() {
		$.posterPopup("static/static_exam_list.jsp","admin_static","width=1100,height=700");
    }
  </script>

 </HEAD>

 <BODY id="tman">

 <table width="100%" cellpadding="0" cellspacing="0" height="40" border="0"> 
	<tr>
		<td width="400" valign="top" align="center" style="background-image: url(img/bg_logo.gif)"><img src="img/logo.gif"></td>
		<td align="right" valign="middle" style="padding-right: 40px; background-color: #000000;">
			<INPUT TYPE="hidden" NAME="" value="<%=userid%>">

			<div style="float: right;">
				<% if(tcnt!=0 || userid.equals("qmtm") || usergrade.equals("M")) { %><a href="../tman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/tman.gif"></a><% } %><% if(tcnt!=0 || userid.equals("qmtm") || usergrade.equals("M")) { %><a href="../qman/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/qman.gif"></a><% } %><% if(userid.equals("qmtm") || usergrade.equals("M")) { %><a href="../admin/index.jsp?qcnt=<%=qcnt%>&tcnt=<%=tcnt%>" target="main" onfocus="this.blur();"><img src="img/admin.gif"></a><% } %>
			</div>
			
		</td>
	</tr>
</table>

 </BODY>
</HTML>

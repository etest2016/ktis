<%
//******************************************************************************
//   ����  �׷� : default.jsp
//   ��  ��  �� : QMTM �ʱ� ������
//   ��      �� : QMTM �ʱ� ������
//   �� ��   �� : t_worker_subj, c_course, q_worker_subj, q_subject
//   �ڹ�  ���� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerQUtil, 
//               qmtm.admin.manager.ManagerTUtil
//   ��  ��  �� : 2010-05-30
//   ��  ��  �� : ���׽�Ʈ ����ȣ
//   ��  ��  �� : 
//   ��  ��  �� : 
//	 ����  ���� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerQUtil, qmtm.admin.manager.ManagerTUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String userid = "";

	userid = (String)session.getAttribute("userid"); // ����
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	int qcnt = 0; 
	int tcnt = 0; 
		
	if(userid.length() > 0) {
		// QMAN ���� ���� üũ�ϱ�
		try {
			qcnt = ManagerQUtil.getBeanCnt(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}

		// TMAN ���� ���� üũ�ϱ�
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
<TITLE> �¶����� ������ �ý��� </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
</HEAD>
<%
	/*�α��� ���� ���� ��� �α��� �������� �̵�*/
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

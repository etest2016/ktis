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

	userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
%>
<HTML>      
<HEAD>
<TITLE> KT ���簳�߿� �¶��� �򰡽ý��� </TITLE>
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
		<frame name="main" src="tman/manager.jsp?userid=<%=userid%>" noresize scrolling="yes">		
	</frameset>
<% 
   } 
%>
</HTML>

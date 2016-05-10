<%
//******************************************************************************
//   ����  �׷� : default.jsp
//   ��  ��  �� : QMTM �ʱ� ������
//   ��      �� : QMTM �ʱ� ������
//   �� ��   �� : t_worker_subj, c_course, q_worker_subj, q_subject
//   �ڹ�  ���� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerTUtil
//   ��  ��  �� : 2010-05-30
//   ��  ��  �� : ���׽�Ʈ ����ȣ
//   ��  ��  �� : 
//   ��  ��  �� : 
//	 ����  ���� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.PwdChange, qmtm.CommonUtil, qmtm.admin.manager.ManagerTUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String userid = "";

	userid = (String)session.getAttribute("userid"); // ����
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
%>
	<Script type="text/javascript">
		location.href = "login.jsp";
	</Script>
<%
		if(true) return;
	}

	String usergrade = (String)session.getAttribute("usergrade"); // ����

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
		alert(diff_date + "�ϵ��� ��й�ȣ�� �������� �ʾҽ��ϴ�.\n��й�ȣ�� ���Ȼ� 30�� �ֱ�� �������ֽñ� �ٶ��ϴ�.\n\nȮ���� Ŭ���� �� ��ܿ� ��й�ȣ�����ư�� ���� \n��й�ȣ�� �������ּ���.");
	</Script>
<%
		}		
	}

	int qcnt = 0; 
	int tcnt = 0;  
		
	if(userid.length() > 0 && !(userid.equals("qmtm"))) {

		// ���� ���� üũ�ϱ�
		try {
			tcnt = ManagerTUtil.getBeanCnt(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

      	    if(true) return;
		}
	}

	if(!(userid.equals("qmtm") || usergrade.equals("M"))) {	
		if(tcnt == 0) {
			out.println(ComLib.getAlertMsg("������ ��ϵ� ������ �����ϴ�. �����ڿ��� ���ѿ�û �� �̿��Ͻñ� �ٶ��ϴ�.", "close"));

			if(true) return;
		}
	}
	
	if(tcnt > 0) {
		qcnt = tcnt;
	}
	
%>
<HTML>      
<HEAD>
<TITLE> �¶����� ������ �ý��� </TITLE>
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

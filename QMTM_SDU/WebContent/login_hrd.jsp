<%
//******************************************************************************
//   ���α׷� : login_hrd.jsp
//   �� �� �� : HRD���� �α��� ó��
//   ��    �� : HRD���� �α��� ó��
//   �� �� �� : qt_workerid, qt_settings
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProc
//   �� �� �� : 2008-06-26
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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

	/* ���̵� ��ȣȭ.
	try {
		userid = LoginProc.getUseridDecode(userid);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	*/

	// ����� ����
	try {
	    name = LoginProc.getLoginName(userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));
		
	    if(true) return;
    }

	if(name == null) {
		// �߰����������� Ȯ���մϴ�.
		try {
			name = AdminProc.getLoginName(userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

		    if(true) return;
		}

		if(name == null) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ������ �����ϴ�.");
		window.close();
	</script>
<%
			if(true) return;
		} else {
			// ���� ����
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
		// ���� ����
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

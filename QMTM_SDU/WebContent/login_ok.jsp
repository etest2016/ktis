<%
//******************************************************************************
//   ���α׷� : login_ok.jsp
//   �� �� �� : �α��� ó��
//   ��    �� : �α��� ó��
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
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProc, qmtm.AdminProc, org.apache.commons.codec.binary.Base64" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	String pwd = request.getParameter("pwd");
	if (pwd == null) { pwd = ""; } else { pwd = pwd.trim(); }
	
	if (userid == "" || pwd == "") {	
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	userid = new String(Base64.decodeBase64(userid.getBytes()));
	pwd = new String(Base64.decodeBase64(pwd.getBytes()));	

	String name = "";

	// ��й�ȣ ��ȣȭ.
	try {
		pwd = CommonUtil.encrypt(pwd);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	

	// ����� ����
	try {
	    name = LoginProc.getLoginChk(userid, pwd);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));
		
	    if(true) return;
    }

	if(name == null) {
		// �߰����������� Ȯ���մϴ�.
		try {
			name = AdminProc.getLoginChk(userid, pwd);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}

		if(name == null) {
%>
	<script type="text/javascript">
		alert("���̵� �Ǵ� ��й�ȣ�� Ȯ���ϼ���.");
		location.href = 'login.jsp';
	</script>
<%
			if(true) return;
		} else {
			// ���� ����
			session.setAttribute("userid", userid);
			session.setAttribute("username", name);
			session.setAttribute("usergrade", "M");
			session.setMaxInactiveInterval(60*60*4);
		
%>
			<script type="text/javascript">
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
		session.setMaxInactiveInterval(60*60*4);
%>

	<script type="text/javascript">
		location.href = "default.jsp";
	</script>
<%
		if(true) return;
	}
%>

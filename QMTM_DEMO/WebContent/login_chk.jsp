<%
//******************************************************************************
//   ���α׷� : login_chk.jsp
//   �� �� �� : �α��� ���� ó��
//   ��    �� : �α��� ���� ó��
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
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProc, qmtm.ExamManager" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
	
	String userid = request.getParameter("user_id");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	String pwd = request.getParameter("user_id");
	if (pwd == null) { pwd = ""; } else { pwd = pwd.trim(); }
	
	if (userid == "") {	
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}

	String name = "";
	String pwd2 = "";

	
	if(userid.equals("qmtm")) {

	// ��й�ȣ ��ȣȭ.
	try {
		pwd2 = CommonUtil.encrypt(pwd);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	} else {
		pwd2 = pwd;
	}

	// ����� ����
	try {
	    name = LoginProc.getLoginChk(userid, pwd2);
    } catch(Exception ex) {
	    //out.println(ComLib.getExceptionMsg(ex, "back"));
		out.println(ex.getMessage());	
	    if(true) return;
    }

	if(name == null) {

%>
	<script language="javascript">
		alert("���̵� �Ǵ� ��й�ȣ�� Ȯ���ϼ���.");
		history.back();
	</script>
<%
		if(true) return;
		
	} else {
		// ��Ű ����
		CommonUtil.set_Cookie(response, "userid",userid);
		CommonUtil.set_Cookie(response, "username",name);
%>

	<script language="javascript">
		location.href = 'default.jsp';
	</script>
<%
		if(true) return;
	}
%>
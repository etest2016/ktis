<%
//******************************************************************************
//   ���α׷� : member_insert_ok.jsp
//   �� �� �� : ����� �������
//   ��    �� : ����� �������
//   �� �� �� : qt_userid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ReceiptBean, qmtm.tman.exam.ReceiptUtil
//   �� �� �� : 2013-02-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ReceiptBean, qmtm.tman.exam.ReceiptUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_chk = "false";
	
	// ���̵� �ߺ�üũ
	try {
	    id_chk = ReceiptUtil.getIdChk(userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	if(id_chk.equals("true")) {
%>
<script language="javascript">
	alert("�ߺ��� ���̵� �����մϴ�.");
	history.back();
</script>
<%
	} else {
	
		String password = request.getParameter("userid");
		String name = request.getParameter("name");
		String sosok1 = request.getParameter("sosok1");
		String sosok2 = request.getParameter("sosok2");
		String home_phone = request.getParameter("home_phone");
		String mobile_phone = request.getParameter("mobile_phone");
		String level = request.getParameter("level");
		String email = request.getParameter("email");

		ReceiptBean bean = new ReceiptBean();

		bean.setUserid(userid);
		bean.setPassword(userid);
		bean.setName(name);
		bean.setSosok1(sosok1);
		bean.setSosok2(sosok2);
		bean.setHome_phone(home_phone);
		bean.setMobile_phone(mobile_phone);
		bean.setLevel(level);
		bean.setEmail(email);
		
		// ����� ���
		try {
			ReceiptUtil.getMCnt(id_exam, userid, bean);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}
%>

	<script language="javascript">
		alert("���������� ��ϵǾ����ϴ�.");
		window.opener.location.reload();
		window.close();
	</script>

<%
	}
%>
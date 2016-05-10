<%
//******************************************************************************
//   ���α׷� : time_extend.jsp
//   �� �� �� : ���ѽð� ����
//   ��    �� : ���ѽð� ����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2013-03-09
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	String extend_time = request.getParameter("extend_time");
	if (extend_time == null) { extend_time = ""; } else { extend_time = extend_time.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0 || extend_time.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	try {
		ExtendTime.delete(id_exam, userid, Integer.parseInt(extend_time));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	StringBuffer bigos2 = new StringBuffer();

	bigos2.append("����� : ");
	bigos2.append(userid);
	bigos2.append(", ����ð� : ");
	bigos2.append(extend_time);
	bigos2.append("��");
	
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("���ѽð�����");
	logbean.setId_q("");
	logbean.setBigo(bigos2.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
	    out.println(ex.getMessage());

	    if(true) return;
    }
%>
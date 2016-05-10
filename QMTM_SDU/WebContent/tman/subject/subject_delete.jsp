<%
//******************************************************************************
//   ���α׷� : subject_delete.jsp
//   �� �� �� : ���� ����
//   ��    �� : ������� ���� �����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil,
//              qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog
//   �� �� �� : 2013-02-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course"); // ���� ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // ���� ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String bigo = request.getParameter("bigo"); 

    // �������� ���� üũ 
	boolean down_YN = false;

	try {
	    down_YN = SubjectTmanUtil.getDownCnt2(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
	if(down_YN) {
	
		// �������� ����
		try {
			SubjectTmanUtil.delete(id_course, id_subject);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "close"));

		    if(true) return;
	    }

		StringBuffer bigos = new StringBuffer();

		bigos.append("�����ڵ� : ");
		bigos.append(id_course);
		bigos.append(", �����ڵ� : ");
		bigos.append(id_subject);
		
		WorkExamLogBean logbean = new WorkExamLogBean();

		logbean.setId_exam("���»���");	
		logbean.setUserid(userid);
		logbean.setGubun("���»���");
		logbean.setId_q("");
		logbean.setBigo(bigos.toString());

		try {
			WorkExamLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
%>

<script language="javascript">	
	alert("���������� �����Ǿ����ϴ�.");
	opener.parent.fraLeft.location.reload(); 	
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>

<%
		if(true) return;
	} else {
%>
<script language="javascript">
	alert("������ ������ �־ ������ �� �����ϴ�. \n\n���� ������ ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
	window.close();
</script>
<%
		if(true) return;
	}
%>
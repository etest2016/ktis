<%
//******************************************************************************
//   ���α׷� : t_manager_insert_ok.jsp
//   �� �� �� : ����� �������
//   ��    �� : ����� ��������ϴ� ������
//   �� �� �� : t_worker_subj
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil
//   �� �� �� : 2010-06-10
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String[] courses = request.getParameterValues("courses");
	
	String q_edit2 = "";
	String q_del2 = "";
	String exam_edit2 = "";
	String exam_del2 = "";
	String answer_edit2 = "";
	String score_edit2 = "";
	String static_edit2 = "";
	
    if(courses != null) {
		for(int i = 0; i < courses.length; i++) {

			q_edit2 = request.getParameter("q_edit"+courses[i]);
			q_del2 = request.getParameter("q_del"+courses[i]);
			exam_edit2 = request.getParameter("exam_edit"+courses[i]);
			exam_del2 = request.getParameter("exam_del"+courses[i]);
			answer_edit2 = request.getParameter("answer_edit"+courses[i]);
			score_edit2 = request.getParameter("score_edit"+courses[i]);
			static_edit2 = request.getParameter("static_edit"+courses[i]);
			
			if(q_edit2 == null) {
				q_edit2 = "N";
			}

			if(q_del2 == null) {
				q_del2 = "N";
			}

			if(exam_edit2 == null) {
				exam_edit2 = "N";
			}

			if(exam_del2 == null) {
				exam_del2 = "N";
			} 

			if(answer_edit2 == null) {
				answer_edit2 = "N";
			} 

			if(score_edit2 == null) {
				score_edit2 = "N";
			} 

			if(static_edit2 == null) {
				static_edit2 = "N";
			} 

			// ����� ������� ���ѵ��
			try {
				ManagerTUtil.insert(userid, courses[i], exam_edit2, exam_del2, answer_edit2, score_edit2, static_edit2);
		    } catch(Exception ex) {
			    out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}

			// ����� ������� ���ѵ��
			try {
				ManagerQUtil.insert(userid, courses[i], q_edit2, q_del2);
		    } catch(Exception ex) {
			    out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		}
	}
%>

<script language="javascript">
	alert("���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>
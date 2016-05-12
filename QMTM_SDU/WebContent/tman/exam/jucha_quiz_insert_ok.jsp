<%
//******************************************************************************
//   ���α׷� : jucha_quiz_insert_ok.jsp
//   �� �� �� : �������� ���� ���
//   ��    �� : �������� ���� ���
//   �� �� �� : exam_m, exam_paper2, exam_q
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamList, qmtm.tman.exam.ExamUtil
//   �� �� �� : 2016-05-10
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.common.*, qmtm.CommonUtil, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%   
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	
	
	String term_id = request.getParameter("term_id");
	if (term_id == null) { term_id = ""; } else { term_id = term_id.trim(); }

	String jucha = request.getParameter("jucha");
	if (jucha == null) { jucha = ""; } else { jucha = jucha.trim(); }
	
	if (id_course.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;	
	}

	String yn_enable = request.getParameter("yn_enable");
	
	
	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	
	String[] arrTerm_id;
	arrTerm_id = term_id.split("-");	
	
	String course_year = arrTerm_id[0];
	String course_no = arrTerm_id[1];	
	
	
	String title = request.getParameter("title");
	String limittime = request.getParameter("limittime");
	String qcntperpage = request.getParameter("qcntperpage");
	
	String id_exam = CommonUtil.getMakeID("E");
	
	QuizSimpleBean bean = new QuizSimpleBean();
	
	bean.setId_exam(id_exam);
	bean.setId_course(id_course);
	bean.setCourse_year(course_year);
	bean.setCourse_no(course_no);
	bean.setJucha(Integer.parseInt(jucha));
	bean.setTitle(title);
	//���ѽð��� �ʷ� ���� �ϹǷ� 60�� ���� �ش�
	bean.setLimittime(Integer.parseInt(limittime)*60);
	bean.setQcntperpage(Integer.parseInt(qcntperpage));
	bean.setUserid(userid);
	bean.setYn_enable(yn_enable);
	
	try {
	    QuizJucha.saveSimpleExam(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
	<script language="JavaScript">
		alert("������ ���������� ��� �Ǿ����ϴ�.");
		opener.parent.fraLeft.location.reload();
		opener.parent.fraMain.location.reload();
		window.close();
	</script>
	
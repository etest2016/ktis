<%
//******************************************************************************
//   프로그램 : jucha_quiz_insert_ok.jsp
//   모 듈 명 : 주차퀴즈 간편 등록
//   설    명 : 주차퀴즈 간편 등록
//   테 이 블 : exam_m, exam_paper2, exam_q
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamList, qmtm.tman.exam.ExamUtil
//   작 성 일 : 2016-05-10
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
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
	//제한시간은 초로 들어가야 하므로 60을 곱해 준다
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
		alert("시험이 정상적으로 등록 되었습니다.");
		opener.parent.fraLeft.location.reload();
		opener.parent.fraMain.location.reload();
		window.close();
	</script>
	
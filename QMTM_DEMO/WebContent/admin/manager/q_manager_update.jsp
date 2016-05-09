<%
//******************************************************************************
//   프로그램 : t_manager_update.jsp
//   모 듈 명 : 담당자 담당과정 수정
//   설    명 : 담당자 담당과정 수정하기
//   테 이 블 : t_worker_subj
//   자바파일 : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil
//   작 성 일 : 2010-06-10
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.* " %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid"); 
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	if (userid.length() == 0 || id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String q_edit = request.getParameter("q_edit");
	if (q_edit == null) { q_edit= "N"; }
	String q_del = request.getParameter("q_del");
	if (q_del == null) { q_del= "N"; }
	String exam_edit = request.getParameter("exam_edit");
	if (exam_edit == null) { exam_edit= "N"; }
	String exam_del = request.getParameter("exam_del");
	if (exam_del == null) { exam_del= "N"; }
	String answer_edit = request.getParameter("answer_edit");
	if (answer_edit == null) { answer_edit= "N"; }
	String score_edit = request.getParameter("score_edit");
	if (score_edit == null) { score_edit= "N"; }
	String static_edit = request.getParameter("static_edit");
	if (static_edit == null) { static_edit= "N"; }

    // 담당자 수정
	try {
	    ManagerTUtil.update(userid, id_course, exam_edit, exam_del, answer_edit, score_edit, static_edit);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	// 담당자 수정
	try {
	    ManagerQUtil.update(userid, id_course, q_edit, q_del);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 수정되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
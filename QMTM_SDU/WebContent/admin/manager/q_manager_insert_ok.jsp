<%
//******************************************************************************
//   프로그램 : t_manager_insert_ok.jsp
//   모 듈 명 : 담당자 과정등록
//   설    명 : 담당자 과정등록하는 페이지
//   테 이 블 : t_worker_subj
//   자바파일 : qmtm.ComLib, qmtm.admin.manager.ManagerTUtil
//   작 성 일 : 2010-06-10
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.manager.ManagerTUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

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

	String all_course = "";
	
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

			// 담당자 시험관리 권한등록
			try {
				ManagerTUtil.insert(userid, courses[i], exam_edit2, exam_del2, answer_edit2, score_edit2, static_edit2, q_edit2, q_del2);
		    } catch(Exception ex) {
			    out.println(ComLib.getExceptionMsg(ex, "close"));

			    if(true) return;
			}

			all_course = all_course + " " + courses[i];

		}

		StringBuffer bigos = new StringBuffer();

		bigos.append("과정코드 : ");
		bigos.append(all_course);
				
		WorkAdminLogBean logbean = new WorkAdminLogBean();

		logbean.setUserid(adm_userid);
		logbean.setGubun("담당과정등록");
		logbean.setBigo(bigos.toString());

		try {
			WorkAdminLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
	}
%>

<script language="javascript">
	alert("정상적으로 등록되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
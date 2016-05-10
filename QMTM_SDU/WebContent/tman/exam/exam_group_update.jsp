<%
//******************************************************************************
//   프로그램 : exam_group_update.jsp
//   모 듈 명 : 시험 수정
//   설    명 : 시험 수정
//   테 이 블 : exam_m
//   자바파일 : qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamCreateBean
//   작 성 일 : 2008-04-17
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0 ) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String userid = request.getParameter("userid");
	String course_year = request.getParameter("course_year");
	if (course_year == null) { course_year = "-1"; } else { course_year = course_year.trim(); }
	String course_no = request.getParameter("course_no");
	if (course_no == null) { course_no = "-1"; } else { course_no = course_no.trim(); }
	int id_exam_kind = Integer.parseInt(request.getParameter("id_exam_kind"));
	String yn_sametime = request.getParameter("yn_sametime");
	String login_start1 = request.getParameter("login_start1");
	String login_start2 = request.getParameter("login_start2");
	String login_start3 = request.getParameter("login_start3");
	String login_start4 = request.getParameter("login_start4");
	String login_end1 = request.getParameter("login_end1");
	String login_end2 = request.getParameter("login_end2");
	String login_end3 = request.getParameter("login_end3");
	String login_end4 = request.getParameter("login_end4");
	String exam_start1 = request.getParameter("exam_start1");
	String exam_start2 = request.getParameter("exam_start2");
	String exam_start3 = request.getParameter("exam_start3");
	String exam_start4 = request.getParameter("exam_start4");
	String exam_end1 = request.getParameter("exam_end1");
	String exam_end2 = request.getParameter("exam_end2");
	String exam_end3 = request.getParameter("exam_end3");
	String exam_end4 = request.getParameter("exam_end4");
	int id_exam_type = Integer.parseInt(request.getParameter("id_exam_type"));
	int id_auth_type = Integer.parseInt(request.getParameter("id_auth_type"));
	String str_limittime = request.getParameter("limittime");
	long limittime = 60;
	if(str_limittime != null) {
		limittime = Long.parseLong(str_limittime) * 60;
	} else {
		limittime = limittime * 60;
	}

	String yn_viewas = "Y";

	double allotting = Double.parseDouble(request.getParameter("allotting"));
	int qcount = Integer.parseInt(request.getParameter("qcount"));
	int qcntperpage = Integer.parseInt(request.getParameter("qcntperpage"));
	String id_movepage = request.getParameter("id_movepage");
	String id_randomtype = request.getParameter("id_randomtype");
	String yn_open_score_direct = request.getParameter("yn_open_score_direct");

	if(yn_open_score_direct == null) {
		yn_open_score_direct = "N";
	}

	String yn_open_qa = request.getParameter("yn_open_qa");
	String stat_start1 = request.getParameter("stat_start1");
	String stat_start2 = request.getParameter("stat_start2");
	String stat_start3 = request.getParameter("stat_start3");
	String stat_start4 = request.getParameter("stat_start4");
	String stat_end1 = request.getParameter("stat_end1");
	String stat_end2 = request.getParameter("stat_end2");
	String stat_end3 = request.getParameter("stat_end3");
	String stat_end4 = request.getParameter("stat_end4");
	String yn_stat = request.getParameter("yn_stat");

	if(yn_stat == null) {
		yn_stat = "N";
	}

	int paper_type = Integer.parseInt(request.getParameter("paper_type"));
	int id_exlabel = Integer.parseInt(request.getParameter("id_exlabel"));
	String fontname = request.getParameter("fontname");
	int fontsize = Integer.parseInt(request.getParameter("fontsize"));
	String web_window_mode = request.getParameter("web_window_mode");

	int web_window_mode2 = 0;
	
	if(web_window_mode == null) {
		web_window_mode2 = 0;
	} else {	
		web_window_mode2 = Integer.parseInt(web_window_mode);
	}

	String log_option = request.getParameter("log_option");
	
	if(log_option == null) {
		log_option = "N";
	}

	String guide = request.getParameter("guide");

	if(guide == null) {
		guide = "";
	}
	String yn_enable = request.getParameter("yn_enable");

	String exam_pwd_yn = request.getParameter("exam_pwd_yn");	
	if (exam_pwd_yn == null) { exam_pwd_yn = "N"; } else { exam_pwd_yn = exam_pwd_yn.trim(); }

	String exam_pwd_str = "";
	
	if(exam_pwd_yn.equals("Y")) {
		exam_pwd_str = request.getParameter("exam_pwd_str");
		if (exam_pwd_str == null) { exam_pwd_str = ""; } else { exam_pwd_str = exam_pwd_str.trim(); }
	} else {
		exam_pwd_str = "";
	}

	String yn_stat_r = request.getParameter("yn_stat_r");
	if (yn_stat_r == null) { yn_stat_r = "N"; } else { yn_stat_r = yn_stat_r.trim(); }
	
	Timestamp login_start = null;
	Timestamp login_end = null;
	Timestamp exam_start = null;
	Timestamp exam_end = null;
	Timestamp stat_start = null;
	Timestamp stat_end = null;
	
	if(login_start1 == null) {
		login_start = new Timestamp(System.currentTimeMillis());
	} else { 
		login_start = Timestamp.valueOf(login_start1+" "+login_start2+":"+login_start3+":"+login_start4+".0");
	}

	if(login_end1 == null) {
		login_end = new Timestamp(System.currentTimeMillis());
	} else { 
		login_end = Timestamp.valueOf(login_end1+" "+login_end2+":"+login_end3+":"+login_end4+".0");
	} 

	if(exam_start1 == null) {
		exam_start = new Timestamp(System.currentTimeMillis());
	} else {
		exam_start = Timestamp.valueOf(exam_start1+" "+exam_start2+":"+exam_start3+":"+exam_start4+".0");
	}

	if(exam_end1 == null) {
		exam_end = new Timestamp(System.currentTimeMillis());
	} else {
		exam_end = Timestamp.valueOf(exam_end1+" "+exam_end2+":"+exam_end3+":"+exam_end4+".0");
	}

	if(stat_start1 == null) {
		stat_start = new Timestamp(System.currentTimeMillis());
	} else {
		stat_start = Timestamp.valueOf(stat_start1+" "+stat_start2+":"+stat_start3+":"+stat_start4+".0");
	}

	if(stat_end1 == null) {
		stat_end = new Timestamp(System.currentTimeMillis());
	} else {
		stat_end = Timestamp.valueOf(stat_end1+" "+stat_end2+":"+stat_end3+":"+stat_end4+".0");
	}

	String time_setting = request.getParameter("time_setting2");
	if (time_setting == null) { time_setting = ""; } else { time_setting = time_setting.trim(); }

	if(yn_sametime.equals("Y") && time_setting.equals("Y")) {
		login_start.setTime(exam_start.getTime()-600000);
		login_end = exam_end;
	}

	ExamCreateBean bean = new ExamCreateBean();

	bean.setCourse_year(course_year);
	bean.setCourse_no(course_no);
	bean.setGuide(guide);
	bean.setId_exam_kind(id_exam_kind);
	bean.setYn_enable(yn_enable);
	bean.setExam_start1(exam_start);
	bean.setExam_end1(exam_end);
	bean.setYn_enable(yn_enable);
	
	bean.setLogin_start(login_start);
	bean.setLogin_end(login_end);
	bean.setId_exam_type(id_exam_type);
	bean.setId_auth_type(id_auth_type);
	bean.setYn_stat(yn_stat);
	bean.setStat_start(stat_start);
	bean.setStat_end(stat_end);
	bean.setYn_open_qa(yn_open_qa);

	bean.setYn_open_score_direct(yn_open_score_direct);
	bean.setLog_option(log_option);
	bean.setWeb_window_mode(web_window_mode2);
	bean.setYn_sametime(yn_sametime);
	bean.setLimittime(limittime);
	bean.setQcount(qcount);
	bean.setAllotting(allotting);

	bean.setId_randomtype(id_randomtype);
	bean.setId_movepage(id_movepage);
	bean.setYn_viewas(yn_viewas);
	bean.setQcntperpage(qcntperpage);
	bean.setId_exlabel(id_exlabel);
	bean.setFontname(fontname);
	bean.setFontsize(fontsize);
	bean.setPaper_type(paper_type);
	bean.setUserid(userid);
	bean.setExam_pwd_yn(exam_pwd_yn);
	bean.setExam_pwd_str(exam_pwd_str);
	bean.setYn_stat_r(yn_stat_r);

	String[] arrId_exam = id_exam.split(",");

	for(int k=0; k<arrId_exam.length; k++) {

		// 시험 수정
		try {
			ExamUtil.group_update(bean, arrId_exam[k]);
		} catch(Exception ex) {
			//out.println(ComLib.getExceptionMsg(ex, "back"));
			out.println(ex.getMessage());

			if(true) return;
		}
	
	}
%>

<script language="javascript">	
	alert("시험이 정상적으로 일괄 수정되었습니다.");
	opener.opener.parent.fraMain.location.reload(); 
	window.close();
	opener.window.close();
</script>

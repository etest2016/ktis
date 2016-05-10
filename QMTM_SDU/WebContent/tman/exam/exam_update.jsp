<%
//******************************************************************************
//   프로그램 : exam_update.jsp
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
<%@ page import="qmtm.*, qmtm.common.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_exam.length() == 0 || id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String userid = request.getParameter("userid");
	String course_year = request.getParameter("course_year");
	if (course_year == null) { course_year = "-1"; } else { course_year = course_year.trim(); }
	String course_no = request.getParameter("course_no");
	if (course_no == null) { course_no = "-1"; } else { course_no = course_no.trim(); }
	
	String exam_method = request.getParameter("exam_method");
	if (exam_method == null) { exam_method = "exam1"; } else { exam_method = exam_method.trim(); }

	String title = request.getParameter("title");
	int id_exam_kind = 1;
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
		if (exam_pwd_str == null || exam_pwd_str.equals("")) { exam_pwd_str = ""; } else { exam_pwd_str = exam_pwd_str.trim(); }
	} else {
		exam_pwd_str = "";
	}
	
	String s_score = request.getParameter("success_score");
	if (s_score == null || s_score.equals("")) { s_score = "0"; } else { s_score = s_score.trim(); }

	double success_score = Double.parseDouble(s_score);

	String yn_success_score = request.getParameter("yn_success_score");
	if (yn_success_score == null) { yn_success_score = "N"; } else { yn_success_score = yn_success_score.trim(); }
	
	String yn_activex = request.getParameter("yn_activex");
	if (yn_activex == null) { yn_activex = "N"; } else { yn_activex = yn_activex.trim(); }
	
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
	
	ExamCreateBean bean = new ExamCreateBean();

	bean.setId_exam(id_exam);
	bean.setCourse_year(course_year);
	bean.setCourse_no(course_no);
	bean.setTitle(title);
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
	bean.setSuccess_score(success_score);
	bean.setYn_success_score(yn_success_score);
	bean.setYn_activex(yn_activex);
	bean.setExam_method(exam_method);
	
    // 시험 수정
	try {
	    ExamUtil.update(bean);
    } catch(Exception ex) {
	    //out.println(ComLib.getExceptionMsg(ex, "back"));
		out.println(ex.getMessage());

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("시험명 : ");
	bigos.append(title);

	bigos.append("년도 : ");
	bigos.append(course_year);

	bigos.append("회차 : ");
	bigos.append(course_no);

	bigos.append(", 평가유형 : ");

	if(yn_sametime.equals("Y")) {
		bigos.append("동시평가");
		bigos.append(", 시험입장시작시간 : ");
		bigos.append(login_start.toString());
		bigos.append(", 시험입장종료시간 : ");
		bigos.append(login_end.toString());
	} else {
		bigos.append("비동시평가");
	}

	bigos.append(", 시험시작시간 : ");
	bigos.append(exam_start.toString());
	bigos.append(", 시험종료시간 : ");
	bigos.append(exam_end.toString());
	bigos.append(", 제한시간 : ");
	bigos.append(limittime/60);

	bigos.append(", 답안지에서득점공개유무 : ");
	bigos.append(yn_open_score_direct);

	bigos.append(", 성적공개옵션 : ");
	if(yn_open_qa.equals("A")) {
		bigos.append("정답 및 해설 공개하지 않음");
	} else if(yn_open_qa.equals("B")) {
		bigos.append("답안 제출 직후 점수만 공개");
	} else if(yn_open_qa.equals("C")) {
		bigos.append("답안 제출 직후 점수 및 정답해설 공개");
	} else if(yn_open_qa.equals("D")) {
		bigos.append("성적 조회 기간에 점수만 공개");
	} else if(yn_open_qa.equals("E")) {
		bigos.append("성적 조회 기간에 점수 및 정답해설 공개");
	} 

	if(yn_open_qa.equals("D") || yn_open_qa.equals("E")) {
		bigos.append(", 성적조회시작시간 : ");
		bigos.append(stat_start.toString());
		bigos.append(", 성적조회종료시간 : ");
		bigos.append(stat_end.toString());
	}

	bigos.append(", 응시자에게 기본성적통계 제공 : ");
	bigos.append(yn_stat);
	
	bigos.append(", 응시자로그기능유무 : ");
	bigos.append(log_option);

	bigos.append(", 시험지에 ActiveX 기능 설정유무 : ");
	bigos.append(yn_activex);
	
	bigos.append(", 공개유무 : ");
	bigos.append(yn_enable);

	bigos.append(", 출제문제수 : ");
	bigos.append(qcount);

	bigos.append(", 화면당문제수 : ");
	bigos.append(qcntperpage);

	bigos.append(", 배점 : ");
	bigos.append(allotting);

	bigos.append(", 출제유형 : ");	
	if(id_randomtype.equals("NN")) { 
		bigos.append("섞지않음");
	} else if(id_randomtype.equals("NQ")) { 
		bigos.append("문제섞기");
	} else if(id_randomtype.equals("NT")) { 
		bigos.append("문제 및 보기섞기");
	} else if(id_randomtype.equals("YQ")) { 
		bigos.append("문제추출=>문제섞기");
	} else if(id_randomtype.equals("YT")) { 
		bigos.append("문제추출=>문제 및 보기섞기");
	} 

	bigos.append(", 페이지이동방식 : ");
	if(id_movepage.equals("F")) { 
		bigos.append("이전, 다음 자유이동");
	} else {
		bigos.append("다음만 이동가능");
	}
	
	bigos.append(", 비밀번호 설정여부 : ");
	bigos.append(exam_pwd_yn);

	if(exam_pwd_yn.equals("Y")) {
		bigos.append(", 설정 비밀번호 : ");
		bigos.append(exam_pwd_str);
	}
	
	bigos.append(", 합격점수 설정여부 : ");
	bigos.append(yn_success_score);

	if(yn_success_score.equals("Y")) {
		bigos.append(", 합격점수 : ");
		bigos.append(success_score);
	}
	
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(userid);
	logbean.setGubun("시험수정");
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
	opener.parent.fraLeft.location.reload(); 
	alert("시험이 정상적으로 수정되었습니다.");	
	//opener.parent.fraLeft.oc('<%=id_course%>',0,'C1');
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>

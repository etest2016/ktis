<%
//******************************************************************************
//   ���α׷� : exam_update.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���� ����
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamCreateBean
//   �� �� �� : 2008-04-17
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
	
    // ���� ����
	try {
	    ExamUtil.update(bean);
    } catch(Exception ex) {
	    //out.println(ComLib.getExceptionMsg(ex, "back"));
		out.println(ex.getMessage());

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("����� : ");
	bigos.append(title);

	bigos.append("�⵵ : ");
	bigos.append(course_year);

	bigos.append("ȸ�� : ");
	bigos.append(course_no);

	bigos.append(", ������ : ");

	if(yn_sametime.equals("Y")) {
		bigos.append("������");
		bigos.append(", ����������۽ð� : ");
		bigos.append(login_start.toString());
		bigos.append(", ������������ð� : ");
		bigos.append(login_end.toString());
	} else {
		bigos.append("�񵿽���");
	}

	bigos.append(", ������۽ð� : ");
	bigos.append(exam_start.toString());
	bigos.append(", ��������ð� : ");
	bigos.append(exam_end.toString());
	bigos.append(", ���ѽð� : ");
	bigos.append(limittime/60);

	bigos.append(", ��������������������� : ");
	bigos.append(yn_open_score_direct);

	bigos.append(", ���������ɼ� : ");
	if(yn_open_qa.equals("A")) {
		bigos.append("���� �� �ؼ� �������� ����");
	} else if(yn_open_qa.equals("B")) {
		bigos.append("��� ���� ���� ������ ����");
	} else if(yn_open_qa.equals("C")) {
		bigos.append("��� ���� ���� ���� �� �����ؼ� ����");
	} else if(yn_open_qa.equals("D")) {
		bigos.append("���� ��ȸ �Ⱓ�� ������ ����");
	} else if(yn_open_qa.equals("E")) {
		bigos.append("���� ��ȸ �Ⱓ�� ���� �� �����ؼ� ����");
	} 

	if(yn_open_qa.equals("D") || yn_open_qa.equals("E")) {
		bigos.append(", ������ȸ���۽ð� : ");
		bigos.append(stat_start.toString());
		bigos.append(", ������ȸ����ð� : ");
		bigos.append(stat_end.toString());
	}

	bigos.append(", �����ڿ��� �⺻������� ���� : ");
	bigos.append(yn_stat);
	
	bigos.append(", �����ڷαױ������ : ");
	bigos.append(log_option);

	bigos.append(", �������� ActiveX ��� �������� : ");
	bigos.append(yn_activex);
	
	bigos.append(", �������� : ");
	bigos.append(yn_enable);

	bigos.append(", ���������� : ");
	bigos.append(qcount);

	bigos.append(", ȭ��繮���� : ");
	bigos.append(qcntperpage);

	bigos.append(", ���� : ");
	bigos.append(allotting);

	bigos.append(", �������� : ");	
	if(id_randomtype.equals("NN")) { 
		bigos.append("��������");
	} else if(id_randomtype.equals("NQ")) { 
		bigos.append("��������");
	} else if(id_randomtype.equals("NT")) { 
		bigos.append("���� �� ���⼯��");
	} else if(id_randomtype.equals("YQ")) { 
		bigos.append("��������=>��������");
	} else if(id_randomtype.equals("YT")) { 
		bigos.append("��������=>���� �� ���⼯��");
	} 

	bigos.append(", �������̵���� : ");
	if(id_movepage.equals("F")) { 
		bigos.append("����, ���� �����̵�");
	} else {
		bigos.append("������ �̵�����");
	}
	
	bigos.append(", ��й�ȣ �������� : ");
	bigos.append(exam_pwd_yn);

	if(exam_pwd_yn.equals("Y")) {
		bigos.append(", ���� ��й�ȣ : ");
		bigos.append(exam_pwd_str);
	}
	
	bigos.append(", �հ����� �������� : ");
	bigos.append(yn_success_score);

	if(yn_success_score.equals("Y")) {
		bigos.append(", �հ����� : ");
		bigos.append(success_score);
	}
	
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(userid);
	logbean.setGubun("�������");
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
	alert("������ ���������� �����Ǿ����ϴ�.");	
	//opener.parent.fraLeft.oc('<%=id_course%>',0,'C1');
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>

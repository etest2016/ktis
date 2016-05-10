<%
//******************************************************************************
//   프로그램 : user_time_change_ok.jsp
//   모 듈 명 : 개인 시간 변경 처리
//   설    명 : 개인 시간 변경 처리
//   테 이 블 : personal_time
//   자바파일 : qmtm.ComLib, qmtm.tman.answer.ExtendTimeBean, qmtm.tman.answer.ExtendTime, java.sql.Timestamp
//   작 성 일 : 2013-02-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.*, qmtm.tman.answer.ExtendTimeBean, qmtm.tman.answer.ExtendTime, java.sql.Timestamp" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
		
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String yn_sametime = request.getParameter("yn_sametime");

	String login_start1 = request.getParameter("login_start1");
	String login_start2 = request.getParameter("login_start2");
	String login_start3 = request.getParameter("login_start3");
	String login_start4 = "00";
	String login_end1 = request.getParameter("login_end1");
	String login_end2 = request.getParameter("login_end2");
	String login_end3 = request.getParameter("login_end3");
	String login_end4 = "00";
	String exam_start1 = request.getParameter("exam_start1");
	String exam_start2 = request.getParameter("exam_start2");
	String exam_start3 = request.getParameter("exam_start3");
	String exam_start4 = "00";
	String exam_end1 = request.getParameter("exam_end1");
	String exam_end2 = request.getParameter("exam_end2");
	String exam_end3 = request.getParameter("exam_end3");
	String exam_end4 = "00";
	
	Timestamp login_start = null;
	Timestamp login_end = null;
	Timestamp exam_start = null;
	Timestamp exam_end = null;
	
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

	ExtendTimeBean bean = new ExtendTimeBean();
	
	bean.setId_exam(id_exam);
	bean.setUserid(userid);
	bean.setYn_sametime(yn_sametime);
	bean.setExam_start1(exam_start);
	bean.setExam_end1(exam_end);
	bean.setLogin_start(login_start);
	bean.setLogin_end(login_end);
		
    // 시험 등록
	try {
	    ExtendTime.pDelete(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));
				
	    if(true) return;
    }

	StringBuffer bigos2 = new StringBuffer();

	bigos2.append("대상자 : ");
	bigos2.append(userid);

	if(yn_sametime.equals("Y")) {
		bigos2.append(", 평가유형 : ");
		bigos2.append("동시평가");
		bigos2.append(", 입장시작시간 : ");
		bigos2.append(login_start.toString());
		bigos2.append(", 입장종료시간 : ");
		bigos2.append(login_end.toString());
	} else {
		bigos2.append(", 평가유형 : ");
		bigos2.append("비동시평가");
	}

	bigos2.append(", 시험시작시간 : ");
	bigos2.append(exam_start.toString());
	bigos2.append(", 시험종료시간 : ");
	bigos2.append(exam_end.toString());

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("개인시간변경");
	logbean.setId_q("");
	logbean.setBigo(bigos2.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
	    out.println(ex.getMessage());

	    if(true) return;
    }
%>

<script language="javascript">		
	alert("개인시간 변경이 완료되었습니다.");
	location.href="user_time_change.jsp?id_exam=<%=id_exam%>&userid=<%=userid%>";
</script>
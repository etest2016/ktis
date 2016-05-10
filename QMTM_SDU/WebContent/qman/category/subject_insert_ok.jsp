<%
//******************************************************************************
//   프로그램 : subject_insert_ok.jsp
//   모 듈 명 : 과목 등록
//   설    명 : 문제은행 과목 등록하기
//   테 이 블 : q_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.SubjectBean, 
//              qmtm.qman.category.SubjectUtil, java.util.Calendar
//   작 성 일 : 2013-02-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.CommonUtil, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil, java.util.Calendar " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
    
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String subject = request.getParameter("q_subject");
	if (subject == null) { subject= ""; } else { subject = subject.trim(); }

	if (subject.length() == 0 || id_course.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	
	String subject_order = request.getParameter("subject_order");
	if (subject_order == null) { subject_order = ""; } else { subject_order = subject_order.trim(); }

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);

	String years = String.valueOf(year);
 	
	String id_subject = CommonUtil.getMakeID("S1");

	SubjectBean bean = new SubjectBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setYears(years);
	bean.setSubject_order(Integer.parseInt(subject_order));

    // 과목등록
	try {
	    SubjectUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();
	
	bigos.append("과목코드 : ");
	bigos.append(id_subject);

	bigos.append(", 과목명 : ");
	bigos.append(subject);
	
	bigos.append(", 공개여부 : ");
	bigos.append("공개");

	bigos.append(", 정렬순서 : ");
	bigos.append(subject_order);

	// 로그정보 등록 시작
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter("0");
	logbean.setId_chapter2("-1");
	logbean.setId_chapter3("-1");
	logbean.setId_chapter4("-1");
	logbean.setUserid(userid);
	logbean.setGubun("과목등록");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkQLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// 로그정보 등록 종료
%>

<script language="javascript">
	alert("정상적으로 등록되었습니다.");
	opener.parent.fraLeft.location.reload(); 
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>
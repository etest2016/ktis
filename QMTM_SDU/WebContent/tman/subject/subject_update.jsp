<%
//******************************************************************************
//   프로그램 : subject_update.jsp
//   모 듈 명 : 과목 수정
//   설    명 : 시험관리 과목정보 수정하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, 
//              qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog 
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // 과정 ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_subject = request.getParameter("id_subject"); // 과목 ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    String subject = request.getParameter("subject"); // 과목명
	String yn_valid = request.getParameter("yn_valid"); // 공개여부
	String subject_order = request.getParameter("subject_order"); // 정렬순서
	String open_year = request.getParameter("open_year");
	String open_month = request.getParameter("open_month");

	SubjectTmanBean bean = new SubjectTmanBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(Integer.parseInt(subject_order));
	bean.setYn_valid(yn_valid);
	bean.setOpen_year(open_year);
	bean.setOpen_month(open_month);

	// 과목정보 수정
    try {
	    SubjectTmanUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("과정코드 : ");
	bigos.append(id_course);
	bigos.append(", 강좌코드 : ");
	bigos.append(id_subject);
	bigos.append(", 강좌명 : ");
	bigos.append(subject);
	bigos.append(", 정렬순서 : ");
	bigos.append(subject_order);
	bigos.append(", 유효여부 : ");
	bigos.append(yn_valid);
	bigos.append(", 교육시작연도 : ");
	bigos.append(open_year);
	bigos.append(", 교육시작월 : ");
	bigos.append(open_month);

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam("강좌수정");	
	logbean.setUserid(userid);
	logbean.setGubun("강좌수정");
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
	alert("정상적으로 수정되었습니다.");
	opener.parent.fraLeft.location.reload();
	opener.parent.fraMain.location.reload();
	window.close();
</script>
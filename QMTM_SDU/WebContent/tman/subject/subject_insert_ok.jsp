<%
//******************************************************************************
//   프로그램 : subject_insert_ok.jsp
//   모 듈 명 : 강좌 등록
//   설    명 : 시험관리 강좌 등록하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanBean, 
//              qmtm.admin.tman.SubjectTmanUtil, qmtm.common.WorkExamLogBean, qmtm.common.WorkExamLog
//   작 성 일 : 2013-02-12
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

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String subject = request.getParameter("subject");

	String id_subject = CommonUtil.getMakeID("S1");

	String subject_order = request.getParameter("subject_order");

	String open_year = request.getParameter("open_year");
	String open_month = request.getParameter("open_month");

	SubjectTmanBean bean = new SubjectTmanBean();

	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setSubject_order(Integer.parseInt(subject_order));
	bean.setYn_valid("Y");
	bean.setOpen_year(open_year);
	bean.setOpen_month(open_month);

    // 강좌등록
	try {
	    SubjectTmanUtil.insert(bean);
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
	bigos.append("Y");
	bigos.append(", 교육시작연도 : ");
	bigos.append(open_year);
	bigos.append(", 교육시작월 : ");
	bigos.append(open_month);

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam("강좌등록");	
	logbean.setUserid(userid);
	logbean.setGubun("강좌등록");
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
	opener.parent.fraMain.location.reload();
	alert("정상적으로 등록되었습니다.");	
	window.close();
</script>
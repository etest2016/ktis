<%
//******************************************************************************
//   프로그램 : subject_update.jsp
//   모 듈 명 : 과목 수정완료
//   설    명 : 과목 수정완료 페이지
//   테 이 블 : q_subject
//   자바파일 : qmtm.ComLib, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject"); // 과목 코드
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }

	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    String userid = (String)session.getAttribute("userid");
	
	String subject = request.getParameter("q_subject"); // 과목명
	String yn_valid = request.getParameter("yn_valid"); 
	String subject_order = request.getParameter("subject_order"); // 정렬순서

	SubjectBean bean = new SubjectBean();

	bean.setId_subject(id_subject);
	bean.setSubject(subject);
	bean.setYn_valid(yn_valid);
	bean.setSubject_order(Integer.parseInt(subject_order));
	
	// 과목 수정
    try {
	    SubjectUtil.update(bean);
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
	if(yn_valid.equals("Y")) {
		bigos.append("공개");
	} else {
		bigos.append("비공개");
	}

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
	logbean.setGubun("과목수정");
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
	alert("정상적으로 수정되었습니다.");
	opener.parent.fraLeft.location.reload(); 
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>
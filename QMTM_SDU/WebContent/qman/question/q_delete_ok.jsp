<%
//******************************************************************************
//   프로그램 : q_delete_ok.jsp
//   모 듈 명 : 문제 삭제
//   설    명 : 출제되지 않은 문제 삭제
//   테 이 블 : q
//   자바파일 : qmtm.ComLib, qmtm.qman.question.QListUtil
//   작 성 일 : 2013-02-09
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.*, qmtm.qman.question.QListUtil" %> 
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%
	}

	String userid = (String)session.getAttribute("userid");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = "-1"; } else { id_subject = id_subject.trim(); }

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = "-1"; } else { id_chapter = id_chapter.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2");
	if (id_chapter2 == null) { id_chapter2 = "-1"; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("id_chapter3");
	if (id_chapter3 == null) { id_chapter3 = "-1"; } else { id_chapter3 = id_chapter3.trim(); }

	String id_chapter4 = request.getParameter("id_chapter4");
	if (id_chapter4 == null) { id_chapter4 = "-1"; } else { id_chapter4 = id_chapter4.trim(); }

	try {
		QListUtil.deletes(id_qs);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	StringBuffer bigos = new StringBuffer();

	bigos.append("삭제문제코드 : ");
	bigos.append(id_qs);

	// 로그정보 등록 시작
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_chapter);
	logbean.setId_chapter2(id_chapter2);
	logbean.setId_chapter3(id_chapter3);
	logbean.setId_chapter4(id_chapter4);
	logbean.setUserid(userid);
	logbean.setGubun("문제삭제");
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

<script language="JavaScript">
	alert("문제가 정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
<%
//******************************************************************************
//   프로그램 : q_copy_ok.jsp
//   모 듈 명 : 문제복사 완료페이지
//   설    명 : 문제복사 완료페이지
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-07-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.qman.question.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR"); 

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;	
	}

	String userid = (String)session.getAttribute("userid");
	
	String id_subject = request.getParameter("id_subject");

	String id_chapter1 = request.getParameter("chapter1");
	if (id_chapter1 == null || id_chapter1.equals("") || id_chapter1.equals(" ")) { id_chapter1 = "0"; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("chapter2");
	if (id_chapter2 == null || id_chapter2.equals("") || id_chapter2.equals(" ")) { id_chapter2 = "-1"; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("chapter3");
	if (id_chapter3 == null || id_chapter3.equals("") || id_chapter3.equals(" ")) { id_chapter3 = "-1"; } else { id_chapter3 = id_chapter3.trim(); }

	String id_chapter4 = request.getParameter("chapter4");
	if (id_chapter4 == null || id_chapter4.equals("") || id_chapter4.equals(" ")) { id_chapter4 = "-1"; } else { id_chapter4 = id_chapter4.trim(); }

	try {
		QListUtil.qcopys(id_qs, id_subject, id_chapter1, id_chapter2, id_chapter3, id_chapter4);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	StringBuffer bigos = new StringBuffer();

	bigos.append("복사문제코드 : ");
	bigos.append(id_qs);

	// 로그정보 등록 시작
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_chapter1);
	logbean.setId_chapter2(id_chapter2);
	logbean.setId_chapter3(id_chapter3);
	logbean.setId_chapter4(id_chapter4);
	logbean.setUserid(userid);
	logbean.setGubun("문제복사");
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
		alert("문제복사 작업이 완료되었습니다.");
		window.opener.location.reload();
		window.close();
	</script>

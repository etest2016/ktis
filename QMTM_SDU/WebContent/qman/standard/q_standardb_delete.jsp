<%
//******************************************************************************
//   프로그램 : q_standardb_delete.jsp
//   모 듈 명 : 소분류구분 삭제
//   설    명 : 소분류구분 삭제하기
//   테 이 블 : q_standard_b
//   자바파일 : qmtm.ComLib, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }

	String id_standarda = request.getParameter("id_standarda"); // 분류구분 코드
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	String id_standardb = request.getParameter("id_standardb");
	if (id_standardb == null) { id_standardb= ""; } else { id_standardb = id_standardb.trim(); }
	
	if (id_subject.length() == 0 || id_chapter.length() == 0 || id_standarda.length() == 0 || id_standardb.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	
	// 소분류구분 정보 삭제
	try {
		QstandardBUtil.delete(id_standardb);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	StringBuffer bigos = new StringBuffer();
	
	bigos.append("과목코드 : ");
	bigos.append(id_subject);

	bigos.append(", 단원코드 : ");
	bigos.append(id_chapter);

	bigos.append(", 대분류코드 : ");
	bigos.append(id_standarda);

	bigos.append(", 소분류코드 : ");
	bigos.append(id_standardb);
		
	// 로그정보 등록 시작
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_chapter);
	logbean.setId_chapter2("-1");
	logbean.setId_chapter3("-1");
	logbean.setId_chapter4("-1");
	logbean.setUserid(userid);
	logbean.setGubun("소분류삭제");
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
	alert("정상적으로 삭제되었습니다.");
	window.opener.location.reload();
	window.close();
</script>

<%
//******************************************************************************
//   프로그램 : receipt_member_reg.jsp
//   모 듈 명 : 대상자 추가
//   설    명 : 대상자 추가
//   테 이 블 : exam_receipt
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean
//   작 성 일 : 2013-02-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.*, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam"); 
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	String inwons = request.getParameter("inwons");
	if (inwons == null) { inwons = ""; } else { inwons = inwons.trim(); }
	
	if (inwons.length() == 0) {
%>
	<script language="javascript">
		alert("선택한 대상자가 없습니다.");
		window.close();
	</script>
<%
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String[] arrUserid;
	arrUserid = inwons.split(",");

	for(int i=0; i<arrUserid.length; i++) {
	
		try {
			ReceiptUtil.memberReg(id_exam, arrUserid[i]);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}

	// 대상자 검색 등록 로그저장 시작
	StringBuffer bigos = new StringBuffer();

	bigos.append("등록방식 : ");
	bigos.append("대상자검색등록");
	//bigos.append(", 등록 대상자 : ");
	//bigos.append(inwons);
			
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("대상자등록");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// 대상자 검색 등록 로그저장 종료

%>

<Script language="javascript">
	alert("선택된 대상자가 추가되었습니다.");
	opener.location.reload();
	window.close();
</Script>

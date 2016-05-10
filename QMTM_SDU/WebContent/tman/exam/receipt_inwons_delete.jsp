<%
//******************************************************************************
//   프로그램 : receipt_inwons_delete.jsp
//   모 듈 명 : 대상자 삭제
//   설    명 : 응시하지 않은 접수자에 한하여 삭제 가능
//   테 이 블 : exam_receipt, exam_ans
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean
//   작 성 일 : 2013-02-14
//   작 성 자 : 
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page import="qmtm.ComLib, qmtm.common.*, qmtm.CommonUtil, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam"); 
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	String id_course = request.getParameter("id_course");	
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");	
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }
	
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
			ReceiptUtil.deleteMember(id_exam, arrUserid[i]);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}

	// 대상자 삭제 로그저장 시작
	StringBuffer bigos = new StringBuffer();

	bigos.append("대상자삭제");
	
	//bigos.append("삭제 대상자 : ");
	//bigos.append(inwons);
			
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("대상자삭제");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// 대상자 삭제 로그저장 종료

%>

<Script language="javascript">
	alert("선택된 대상자가 삭제되었습니다.");
	location.href="receipt_inwons.jsp?id_exam=<%=id_exam%>&id_course=<%=id_course%>&id_subject=<%=id_subject%>";
</Script>

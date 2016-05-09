<%
//******************************************************************************
//   프로그램 : receipt_inwons_delete.jsp
//   모 듈 명 : 대상자 삭제
//   설    명 : 응시하지 않은 접수자에 한하여 삭제 가능
//   테 이 블 : exam_receipt, exam_ans
//   자바파일 : 
//   작 성 일 : 2010-06-21
//   작 성 자 : 
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam"); 
	
	String inwons = request.getParameter("inwons");
	if (inwons == null) { inwons = ""; } else { inwons = inwons.trim(); }

	if (inwons.length() == 0) {
%>
	<script language="javascript">
		alert("선택한 대상자가 없습니다.");
		window.close();
	</script>
<%
		if(true) return;
	}

	String[] arrId_exam;
	arrId_exam = id_exam.split(",");

	String[] arrUserid;
	arrUserid = inwons.split(",");

	for(int k=0; k<arrId_exam.length; k++) {

		for(int i=0; i<arrUserid.length; i++) {
		
			try {
				ReceiptUtil.deleteMember(arrId_exam[k], arrUserid[i]);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

				if(true) return;
			}
		}

	}

%>

<Script language="javascript">
	alert("선택된 대상자가 삭제되었습니다.");
	location.href="receipt_group_inwons.jsp?id_exam=<%=id_exam%>";
</Script>

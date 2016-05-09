<%
//******************************************************************************
//   프로그램 : reexam_inwons_insert.jsp
//   모 듈 명 : 대상자 삭제
//   설    명 : 응시하지 않은 접수자에 한하여 등록 가능
//   테 이 블 : exam_receipt, exam_ans
//   자바파일 : 
//   작 성 일 : 2010-06-21
//   작 성 자 : 
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=euc-kr" %>  
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam"); 
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
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
	
	String[] arrId_exam;
	arrId_exam = id_exam.split(",");
	
	String[] arrUserid;
	arrUserid = inwons.split(",");

	for(int k=0; k<arrId_exam.length; k++) {
		
		for(int i=0; i<arrUserid.length; i++) {
		
			try {
				ReceiptUtil.getECnt(arrId_exam[k], arrUserid[i]);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

				if(true) return;
			}
		}
	
	}
%>

<Script language="javascript">
	alert("대상자 등록이 완료되었습니다.");
	opener.location.reload();
	window.close();
</Script>

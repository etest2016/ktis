<%
//******************************************************************************
//   ���α׷� : reexam_inwons_insert.jsp
//   �� �� �� : ����� ����
//   ��    �� : �������� ���� �����ڿ� ���Ͽ� ��� ����
//   �� �� �� : exam_receipt, exam_ans
//   �ڹ����� : 
//   �� �� �� : 2010-06-21
//   �� �� �� : 
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
		alert("������ ����ڰ� �����ϴ�.");
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
	alert("����� ����� �Ϸ�Ǿ����ϴ�.");
	opener.location.reload();
	window.close();
</Script>

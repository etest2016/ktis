<%
//******************************************************************************
//   ���α׷� : receipt_inwons_delete.jsp
//   �� �� �� : ����� ����
//   ��    �� : �������� ���� �����ڿ� ���Ͽ� ���� ����
//   �� �� �� : exam_receipt, exam_ans
//   �ڹ����� : 
//   �� �� �� : 2010-06-21
//   �� �� �� : 
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
		alert("������ ����ڰ� �����ϴ�.");
		window.close();
	</script>
<%
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

%>

<Script language="javascript">
	alert("���õ� ����ڰ� �����Ǿ����ϴ�.");
	location.href="receipt_inwons.jsp?id_exam=<%=id_exam%>";
</Script>

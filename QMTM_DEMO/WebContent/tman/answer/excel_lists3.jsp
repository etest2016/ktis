<%
//******************************************************************************
//   ���α׷� : excel_lists3.jsp
//   �� �� �� : �������� ����Ʈ
//   ��    �� : �������� ����Ʈ
//   �� �� �� : exam_ans, qt_userid
//   �ڹ����� : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   �� �� �� : 2008-06-19
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	response.setHeader("Content-Disposition", "attachment; filename=Inwon3.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "X";

	AnsInwonListBean[] rst = null;
	
	// �������� ���������
    try {
	    rst = AnsInwonList.getExcelBeans2(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<body>

	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="150">
		<tr height="40" bgcolor="#FFFFFF">
			<td align="center" bgcolor="#D9D9D9">���̵�</td>
			<td align="center" bgcolor="#D9D9D9">����</td>
		</tr>
<%
	if(rst == null) {
%>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
<%
	} else {
		for(int i=0; i<rst.length; i++) { 
%>
		<tr bgcolor="#FFFFFF" height="30">
			<td align="center"><%=rst[i].getUserid()%></td>
			<td align="center"><%=rst[i].getName()%></td>
		</tr>
<%
		}
	}
%>
	</table>

</body>
</html>
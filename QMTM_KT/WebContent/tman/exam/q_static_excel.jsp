<%
//******************************************************************************
//   ���α׷� : q_static_excel.jsp
//   �� �� �� : ���׺м���� ���� 
//   ��    �� : ���׺м���� ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.statics.StaticQBean, qmtm.tman.statics.StaticQ
//   �� �� �� : 2008-06-19
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.statics.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	response.setHeader("Content-Disposition", "attachment; filename=q_static.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exams");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	ExamStaticBean[] scoreQ = null;

	try {
		scoreQ = ExamStatic.getQList(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

%>

<html>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<body>

	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" width="100%">
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" bgcolor="#D9D9D9">�����</td>
			<td align="center" bgcolor="#D9D9D9">�ܿ���</td>
			<td align="center" bgcolor="#D9D9D9">�����ڵ�</td>
			<td align="center" bgcolor="#D9D9D9">��������</td>
			<td align="center" bgcolor="#D9D9D9">���̵�</td>
			<td align="center" bgcolor="#D9D9D9">�����</td>
			<td align="center" bgcolor="#D9D9D9">������</td>
			<td align="center" bgcolor="#D9D9D9">������</td>			
			<td align="center" bgcolor="#D9D9D9">��</td>
			<td align="center" bgcolor="#D9D9D9">��</td>
			<td align="center" bgcolor="#D9D9D9">��</td>
			<td align="center" bgcolor="#D9D9D9">��</td>
			<td align="center" bgcolor="#D9D9D9">��</td>
		</tr>
		<% 
			if(scoreQ != null) { 
				for(int q = 0; q < scoreQ.length; q++) {
		%>
		<tr bgcolor="#FFFFFF" height="25">
			<td align="center"><%=scoreQ[q].getSubject()%></td>
			<td align="center"><%=scoreQ[q].getChapter()%></td>
			<td align="center"><%=scoreQ[q].getId_q()%></td>
			<td align="center"><%=scoreQ[q].getQtype()%></td>
			<td align="center"><%=scoreQ[q].getDifficulty()%></td>
			<td align="center"><%=scoreQ[q].getO_rate()%></td>
			<td align="center"><%=scoreQ[q].getO_cnt()%></td>
			<td align="center"><%=scoreQ[q].getX_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx1_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx2_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx3_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx4_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx5_cnt()%></td>
		</tr>
		<%
				}
			}
		%>
	</table>

	</body>
</html>
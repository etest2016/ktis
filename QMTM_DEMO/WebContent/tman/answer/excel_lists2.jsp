<%
//******************************************************************************
//   ���α׷� : excel_lists2.jsp
//   �� �� �� : ���� �̿Ϸ��� ����Ʈ
//   ��    �� : ���� �̿Ϸ��� ����Ʈ
//   �� �� �� : exam_ans, qt_userid
//   �ڹ����� : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   �� �� �� : 2008-06-19
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	response.setHeader("Content-Disposition", "attachment; filename=Inwon2.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "N";

	AnsInwonListBean[] rst = null;

	// �Ϸ���/�̿Ϸ��� ���������
    try {
	    rst = AnsInwonList.getExcelBeans(id_exam, bigos);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<body>

	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="100%">
		<tr height="40" bgcolor="#FFFFFF">
			<td align="center" bgcolor="#D9D9D9">���̵�</td>
			<td align="center" bgcolor="#D9D9D9">����</td>
			<td align="center" bgcolor="#D9D9D9">������</td>
			<td align="center" bgcolor="#D9D9D9">������۽ð�</td>
			<td align="center" bgcolor="#D9D9D9">�������ð�</td>
			<td align="center" bgcolor="#D9D9D9">����</td>
			<td align="center" bgcolor="#D9D9D9">������</td>
			<td align="center" bgcolor="#D9D9D9">��������</td>
			<td align="center" bgcolor="#D9D9D9">������ IP</td>
		</tr>
<%
	if(rst == null) {
%>
		<tr>
			<td colspan="9">&nbsp;</td>
		</tr>
<%
	} else {
		for(int i=0; i<rst.length; i++) { 
			String score_bak = "";
			String score_log = "";
			if(rst[i].getScore_bak() > -1.0) {
				score_bak = String.valueOf(rst[i].getScore_bak());
			}

			if(!rst[i].getScore_log().equals("-1")) {
					score_log = rst[i].getScore_log();
			}
%>
		<tr bgcolor="#FFFFFF" height="30">
			<td align="center"><%=rst[i].getUserid()%></td>
			<td align="center"><%=rst[i].getName()%></td>
			<td align="center"><%=rst[i].getNr_set()%></td>
			<td align="center"><%=rst[i].getStart_time()%></td>
			<td align="center"><%=rst[i].getEnd_time()%></td>
			<td align="center"><%=rst[i].getScore()%></td>
			<td align="center"><%=score_bak%></td>
			<td align="center"><%=score_log%></td>
			<td align="center"><%=rst[i].getUser_ip()%></td>
		</tr>
<%
		}
	}
%>
	</table>

</body>
</html>
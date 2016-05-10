<
//******************************************************************************
//   ���α׷� : static_excel.jsp
//   �� �� �� : ��ü������� ��������
//   ��    �� : ��ü������� ��������
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.statics.StaticScoreBean, qmtm.tman.statics.StaticScore
//   �� �� �� : 2008-06-18
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

	response.setHeader("Content-Disposition", "attachment; filename=ExamStatic.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	StaticScoreBean scoreA = null;

	try {
		scoreA = StaticScore.getTList(id_exam);
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
			<td align="center" bgcolor="#D9D9D9">�򰡸�</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">������</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">����</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">���</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">���� 10% ���</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">�ְ�</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">����</td>
			<td align="center" width="7%" bgcolor="#D9D9D9">������ ��</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">0~9</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">10~19</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">20~29</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">30~39</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">40~49</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">50~59</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">60~69</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">70~79</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">80~89</td>
			<td align="center" width="4%" bgcolor="#D9D9D9">90~100</td>
		</tr>
		<% if(scoreA != null) { %>
		<tr bgcolor="#FFFFFF" height="30">
			<td align="center"><%=scoreA.getTitle()%></td>
			<td align="center"><%=scoreA.getQcount()%></td>
			<td align="center"><%=scoreA.getAllotting()%></td>
			<td align="center"><%=scoreA.getAvg_score()%></td>
			<td align="center"><%=scoreA.getTop_score()%></td>
			<td align="center"><%=scoreA.getMax_score()%></td>
			<td align="center"><%=scoreA.getMin_score()%></td>
			<td align="center"><%=scoreA.getAll_inwon()%></td>
			<td align="center"><%=scoreA.getInwon1()%></td>
			<td align="center"><%=scoreA.getInwon2()%></td>
			<td align="center"><%=scoreA.getInwon3()%></td>
			<td align="center"><%=scoreA.getInwon4()%></td>
			<td align="center"><%=scoreA.getInwon5()%></td>
			<td align="center"><%=scoreA.getInwon6()%></td>
			<td align="center"><%=scoreA.getInwon7()%></td>
			<td align="center"><%=scoreA.getInwon8()%></td>
			<td align="center"><%=scoreA.getInwon9()%></td>
			<td align="center"><%=scoreA.getInwon10()%></td>
		</tr>
		<% } %>
	</table>

	</body>
</html>
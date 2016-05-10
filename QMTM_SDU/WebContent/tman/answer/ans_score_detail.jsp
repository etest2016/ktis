<%
//******************************************************************************
//   ���α׷� : ans_score_detail.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ����
//   �� �� �� : qt_userid
//   �ڹ����� : qmtm.ComLib, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean
//   �� �� �� : 2013-02-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	SubjYNChkBean[] users = null;
	
	try {
		users = SubjYNChk.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));
		
		if(true) return;
	}
%>

<html>
<head>
	<title> :: ������������ Ȯ�� :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

</head>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td id="left"></td>
				<Td id="mid"><div class="title">������������ Ȯ�� <span>�������� �������� ������ Ȯ���մϴ�</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<% if(users != null) {%>
		<table border="0" cellpadding ="0" cellspacing="0" width="100%" style="margin-bottom: 0px;">
			<tr>
				<td align="right"><font color=green><B>�ʱ�������� : <%=users[0].getSuccess_score1()%>��, �Ǳ�������� : <%=users[0].getSuccess_score2()%>��</B></font></td>
			</tr>
		</table>
		<BR>
		<% } %>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="25%">���̵�</td>
				<td width="25%">����</td>
				<td width="15%">�ʱ�����</td>
				<td width="15%">�Ǳ�����</td>
				<td width="20%">��������</td>
			</tr>
<% if(users == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="5">���������� ������ �� Ȯ�����ּ���</td>
			</tr>
<% 
	} else { 
	
		for(int i=0; i<users.length; i++) {		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="center"><%=users[i].getUserid()%></td>
				<td align="center"><%=users[i].getName()%></td>
				<td align="center"><%=users[i].getScore1()%></td>
				<td align="center"><%=users[i].getScore2()%></td>
				<td align="center"><%=users[i].getSuccess_yn()%></td>				
			</tr>
<%
		}
	}
%>
		</table>

	</div>
	<div id="button">

		<img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: pointer;">
	</div>

</body>

</html>

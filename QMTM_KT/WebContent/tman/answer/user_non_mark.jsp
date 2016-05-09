<%
//******************************************************************************
//   ���α׷� : user_non_mark.jsp
//   �� �� �� : ���� ����� ���� ä��
//   ��    �� : ���� ����� ���� ä��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   �� �� �� : 2008-09-01
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	PaperNonExportBean bean = null;
	
	try {
		bean = PaperNonExport.getBeans(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
	PaperNonExportBean[] beans = null;

	try {
		beans = PaperNonExport.getUserList(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	// �ش� ������ �������� �������� �о�´�
	int qcount = 0;

	try {
		qcount = AnswerMarkNon.getQcount(id_exam);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

<html>
<head>
<title> :: ���׺� ������ ä�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<Script language="JavaScript">
	
	var allottings = <%=bean.getAllotting()%>;

	function scores(userid, i) {
		
		var u_score = eval("document.forms1.scores"+i+".value");

		if(u_score == "") {
			alert("������ �Է��ϼ���.");
			return;
		} else {				

			if(parseInt(u_score) < 0 || parseInt(u_score) > allottings) {
				alert("������ ������ " + allottings + "�� �Դϴ�\n�������� ������ ���ų� �Ǵ� ���� �Է��� �� �����ϴ�");
				return;
			}
		
			location.href = "user_non_mark_up.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+userid+"&scores="+u_score;
		}
	}
	
</Script>

</head>

<body id="popup2">
	<form name="forms1">
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="98%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���׺� ������ ä��</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
	
		<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="580">
			<tr bgcolor="#FFFFFF">
				<td height="40" valign="middle">&nbsp;<b><%=bean.getQ()%></b> <BR><b>(�����ڵ� : <%=bean.getId_q()%>, ���� : <%=bean.getAllotting()%>)</b></td>
			</tr>
		</table>

		<br>
		
		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr" align="center">
				<td width="8%"> NO </td>
				<td width="15%"> ���̵� </td>
				<td width="15%"> ���� </td>
				<td width="15%"> &nbsp;���� </td>
				<td width="47%"> ä�� </td>
			</tr>

			<% if(beans == null) { %>

			<tr>
				<td colspan="5" class="blank">ä���� �����ڰ� �����ϴ�.</td>
			</tr>
			<% 
				} else {					
			
					double ExamAllotting = 0;
					int nr_q = 0;
				    String now_point = "";

					for(int i=0; i<beans.length; i++) { 	
						
						// �ش� ����� ���׺� ����ä�� ��ȸ�Ѵ�.
						AnswerMarkNonBean rst2 = null;

						try {
							rst2 = AnswerMarkNon.getBean3(id_q, beans[i].getUserid(), id_exam);
						} catch(Exception ex) {
							response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

							if(true) return;
						}

						nr_q = rst2.getNr_q();      
						String points = rst2.getPoints();

						if(points == null || points.equals("")) {

							for (int j = 0; j < qcount; j++) {
								points = points + "{:}";
							}

							points = points.substring(0, points.length()-3);
						
						} else {
							points = rst2.getPoints();
						}		

						String[] ArrPoints = points.split(QmTm.Q_GUBUN_re, -1);
						
						if(ArrPoints[nr_q - 1] == null || ArrPoints[nr_q - 1].equals("")) {
							now_point = "";
						} else {
							now_point = ArrPoints[nr_q - 1];
						}
			%>

			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><%=beans[i].getUserid()%></td>
				<td><%=beans[i].getName()%></td>
				<td>&nbsp;<%=now_point%></td>
				<td><input type="text" name="scores<%=i%>"  size="3">��&nbsp;&nbsp;<a href="javascript:scores('<%=beans[i].getUserid()%>', <%=i%>)" ><img src="../../images/bt3_mark.gif" border="0"></a></td>
			</tr>
			<%
					}
				}
			%>
		</table>
		</form>

	</div>

	<div id="button">
		
	<img src="../../images/bt5_exit_yj1.gif" style="cursor: hand;" onclick="window.close();">
		
	</div>

</body>

</html>
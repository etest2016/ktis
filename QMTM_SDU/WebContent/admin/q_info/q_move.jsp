<%
//******************************************************************************
//   ���α׷� : q_move.jsp
//   �� �� �� : �����̵� ������
//   ��    �� : �����̵� ������
//   �� �� �� : q_subject, t_worker_subj
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String usergrade = (String)session.getAttribute("usergrade");

	
%>

<html>
<head>
	<title> :: ���� �̵� :: </title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	

</head>

<BODY id="popup2">
	
	<form name="form1" method="post" action="q_move_ok.jsp">


	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ���� <span>�ش� ���� ������ �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td id="left" width="120" align="center">�⵵/�б�&nbsp;&nbsp;</td>
				<td>
					<select name="">
						<option value="">2016��1�б�</option>
					</select>&nbsp;
				</td>
			</tr>
			
			<tr>
				<td id="left" width="120" align="center">������</td>
				<td>					
					<select name="id_subject">
						<option value="">�׽�Ʈ ����</option>
					</select>					
				</td>
			</tr>
			
		</table>


	</div>
	<div id="button">

		<input type="button" value="���������ϱ�" class="form6">&nbsp;&nbsp;<input type="button" value="����ϱ�" class="form6">

	</div>


	</form>

</body>
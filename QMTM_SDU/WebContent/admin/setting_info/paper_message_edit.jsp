<%
//******************************************************************************
//   ���α׷� : exam_write.jsp
//   �� �� �� : ������
//   ��    �� : ������ ������
//   �� �� �� : r_exlabel
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.RexlabelBean, 
//              qmtm.admin.tman.SubjectTmanUtil, qmtm.admin.tman.SubjectTmanBean, 
//              qmtm.tman.exam.ExamUtil, qmtm.tman.exam.RexlabelUtil, java.sql.Timestamp
//   �� �� �� : 2013-02-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil, java.sql.Timestamp, java.util.Calendar" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");	
%>

<html>
<head>
<title> :: �������� �޽��� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script type="text/javascript">	
	
</script>

</head>

<body id="popup2">
	
	<form name="form1" action="exam_insert.jsp" method="post">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� �޽������ <span>�������� ���� �޽����� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 500px;">		

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>��������޽���</b></td>
				<td align="right"><input type="button" value="����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>��������޽���</td>
				<td>&nbsp;<textarea name="QUIZ_START_MESSAGE" rows="5" cols="85"></textarea></td>				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>��������޽���</b></td>
				<td align="right"><input type="button" value="����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>��������޽���</td>
				<td>&nbsp;<textarea name="QUIZ_START_MESSAGE" rows="5" cols="85"></textarea></td>				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>�����������޽���</b></td>
				<td align="right"><input type="button" value="����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>�����������޽���</td>
				<td>&nbsp;<textarea name="CHEAT_ALERT_MESSAGE" rows="5" cols="85"></textarea></td>				
			</tr>
		</table><br>
		
	</div>	
	
	</form>
	
 </BODY>
</HTML>
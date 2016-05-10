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
<title> :: �űԽ��� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( ".date_picker" ).datepicker();
	});
  </script>		

<script type="text/javascript">	
	
</script>

</head>

<body id="popup2">
	
	<form name="form1" action="exam_insert.jsp" method="post">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������� ���� <span>��������� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 500px;">		

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>���������Ⱓ����</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>�����ɼ�</td>
				<td width="70%">&nbsp;<select name="SCORE_OPEN_OPTION">
				<option value="A">���� �� �ؼ� �������� ����</option>
				<option value="D">���� ��ȸ �Ⱓ�� ������ ����</option>
				<option value="E">���� ��ȸ �Ⱓ�� ���� �� �����ؼ� ����</option>					
				</select></td>
			</tr>
			<tr>
				<td id="left"><li>�������۽ð�</td>
				<td><div style="float: left;"><input type="text" class="input date_picker" name="SCORE_OPEN_SDATE1" size="12" readonly value="">
				&nbsp;<select name="SCORE_OPEN_SDATE2">
				<% 
					String jj = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj = "0"+String.valueOf(j);
						} else {
							jj = String.valueOf(j);
						}
				%>
				<option value="<%=jj%>"><%=jj%></option>
				<% } %></select>
				��&nbsp;<input type="text" class="input" name="SCORE_OPEN_SDATE3" size="3" value="00"> ��</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>��������ð�</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="SCORE_OPEN_EDATE1" size="12" readonly value="">
				&nbsp;<select name="SCORE_OPEN_EDATE2">
				<% 
					String jj2 = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj2 = "0"+String.valueOf(j);
						} else {
							jj2 = String.valueOf(j);
						}
				%>
				<option value="<%=jj2%>" ><%=jj2%></option>
				<% } %></select>
				��&nbsp;<input type="text" class="input" name="SCORE_OPEN_EDATE3" size="3" value="00"> ��</div>
				</td>
			</tr>							
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>������ȿ�Ⱓ����</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>�ٿ�ε���</td>
				<td width="70%">&nbsp;<input type="radio" value="I" name="DOWNLOAD_ABLE_METHOD" checked> ��ȿ�Ⱓ��&nbsp;&nbsp;<input type="radio" value="O" name="DOWNLOAD_ABLE_METHOD" checked> ��ȿ�Ⱓ��</td>				
			</tr>
			<tr>
				<td id="left"><li>��ȿ���۽ð�</td>
				<td><div style="float: left;"><input type="text" class="input date_picker" name="DOWNLOAD_ABLE_SDATE1" size="12" readonly value="">
				&nbsp;<select name="DOWNLOAD_ABLE_SDATE2">
				<% 
					String jj3 = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj3 = "0"+String.valueOf(j);
						} else {
							jj3 = String.valueOf(j);
						}
				%>
				<option value="<%=jj3%>"><%=jj3%></option>
				<% } %></select>
				��&nbsp;<input type="text" class="input" name="DOWNLOAD_ABLE_SDATE3" size="3" value="00"> ��</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>��ȿ����ð�</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="DOWNLOAD_ABLE_SDATE1" size="12" readonly value="">
				&nbsp;<select name="DOWNLOAD_ABLE_SDATE2">
				<% 
					String jj4 = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj4 = "0"+String.valueOf(j);
						} else {
							jj4 = String.valueOf(j);
						}
				%>
				<option value="<%=jj4%>" ><%=jj4%></option>
				<% } %></select>
				��&nbsp;<input type="text" class="input" name="DOWNLOAD_ABLE_SDATE3" size="3" value="00"> ��</div>
				</td>
			</tr>							
		</table><br>
		
		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>���ù�ļ���</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>���ù�ļ���</td>
				<td width="70%">&nbsp;<input type="radio" value="A" name="QUIZ_METHOD" checked> �񵿽��򰡹��&nbsp;&nbsp;<input type="radio" value="B" name="QUIZ_METHOD" checked> �񵿽�+�����򰡹��</td>
				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>��������Ƚ������</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>��������Ƚ��</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_RETRY_COUNT" size="3"> ȸ</td>
	
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>���������˸����Ƚ������</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>���������˸����Ƚ��</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_CHEAT_COUNT" size="3"> ȸ</td>

			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>����˸����ð�����</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>����˸����ð�</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_PRE_ETIME" size="3"> ��</td>

			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>��������������úο��ð�����</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="40%"><li>��������������úο��ð�</td>
				<td width="60%">&nbsp;<input type="text" class="input" name="QUIZ_END_RETRY_TIME" size="3"> ��</td>
				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>�������ڵ�����ð�����</b></td>
				<td align="right"><input type="button" value="�����ϱ�" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>�������ڵ�����ð�</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_AUTOSAVE_TIME" size="3"> ��</td>
				
			</tr>
		</table><br>

	</div>	
	
	</form>
	
 </BODY>
</HTML>
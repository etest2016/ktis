<%
//******************************************************************************
//   ���α׷� : std_grade_edit.jsp
//   �� �� �� : �г��ڵ����
//   ��    �� : �г��ڵ���� �˾� ������
//   �� �� �� : r_std_grade
//   �ڹ����� : qmtm.admin.etc.StdGradeBean, qmtm.admin.etc.StdGradeUtil
//   �� �� �� : 2008-04-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String std_grade = request.getParameter("std_grade");
	if (std_grade == null) { std_grade= ""; } else { std_grade = std_grade.trim(); }

	if (std_grade.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	StdGradeBean rst = null;

    try {
	    rst = StdGradeUtil.getBean(std_grade);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>
<html>
<head>
	<title>:: �г��ڵ� ���� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.grade_nm.value == "") {
				alert("�г���� �Է��ϼ���");
				frm.grade_nm.focus();
				return false;				
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="std_grade_update.jsp">
<input type="hidden" name="std_grade" value="<%=std_grade%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�г��ڵ� ���� <span> �г��ڵ� Ȯ�� �� �г�� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�г��ڵ�</td>
				<td width="200"><%=std_grade%></td>
			</tr>
			<tr>
				<td id="left">�г��</td>
				<td><input type="text" class="input" name="grade_nm" size="25" value="<%=rst.getGrade_nm()%>"></td>
			</tr>

	</table>
	</div>

<div id="button">
<a href="javascript:" onClick="send();" onfocus="this.blur();"><img src="../../../images/bt5_edit_yj1.gif" border="0"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</center>
</div>

	</form>

</BODY>
</HTML>
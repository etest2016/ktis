<%
//******************************************************************************
//   ���α׷� : std_grade_view.jsp
//   �� �� �� : �г��ڵ�Ȯ��
//   ��    �� : �г��ڵ�Ȯ�� �˾� ������
//   �� �� �� : r_std_grade
//   �ڹ����� : qmtm.admin.etc.StdGradeBean, qmtm.admin.etc.StdGradeUtil
//   �� �� �� : 2008-04-11
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

<script language="javascript">
	function edits() {
		location.href="std_grade_edit.jsp?std_grade=<%=std_grade%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* �г��ڵ带 �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "std_grade_delete.jsp?std_grade=<%=std_grade%>";
       }
    }
</script>
<html>
<head>
	<title>:: �г��ڵ� Ȯ�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�г��ڵ� Ȯ�� <span> �г��ڵ� Ȯ�� �� ����,����</span></div></td>
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
				<td><%=rst.getGrade_nm()%></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
<!--<input type="button" onClick="edits()" value="�����ϱ�">--><a href="javascript:edits();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onClick="deletes()"  value="�����ϱ�">--><a href="javascript:deletes();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="â�ݱ�">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</center>
</div>

	</form>

</BODY>
</HTML>
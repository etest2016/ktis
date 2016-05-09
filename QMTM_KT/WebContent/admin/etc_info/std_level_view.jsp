<%
//******************************************************************************
//   ���α׷� : std_level_view.jsp
//   �� �� �� : �����ڵ�Ȯ��
//   ��    �� : �����ڵ�Ȯ�� �˾� ������
//   �� �� �� : r_std_level
//   �ڹ����� : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
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

	String std_level = request.getParameter("std_level");
	if (std_level == null) { std_level= ""; } else { std_level = std_level.trim(); }

	if (std_level.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	StdLevelBean rst = null;

    try {
	    rst = StdLevelUtil.getBean(std_level);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="std_level_edit.jsp?std_level=<%=std_level%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* �����ڵ带 �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "std_level_delete.jsp?std_level=<%=std_level%>";
       }
    }
</script>
<html>
<head>
	<title>:: �����ڵ� Ȯ�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����ڵ� Ȯ�� <span> �����ڵ� Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�����ڵ�</td>
				<td width="200"><%=std_level%></td>
			</tr>
			<tr>
				<td id="left">�г��</td>
				<td><%=rst.getLevel_nm()%></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
<!--<input type="button" onClick="edits()" value="�����ϱ�">--><a href="javascript:edits();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onClick="deletes()"  value="�����ϱ�">--><a href="javascript:deletes();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="â�ݱ�">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
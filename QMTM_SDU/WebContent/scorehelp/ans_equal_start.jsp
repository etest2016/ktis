<%
//******************************************************************************
//   ���α׷� : ans_equal_start.asp
//   �� �� �� : ����� �� ��� ����
//   ��    �� : ����� �� ��� ����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 
//   �� �� �� : 
//   �� �� �� : 2009-01-21
//   �� �� �� : ���׽�Ʈ ������
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");

%>
<%
	Score_AnsEqualBean rst = null;

	try {
		rst = Score_AnsEqual.getBean(id_exam, id_q);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
	
%>

<html>
<head>
<title>��� ��� ������</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<BODY Style="margin:0px;">

	<!-- Ÿ��Ʋ ������ -->
	<div style="width: 100%; height: 70px; background-image: url(../images/bg_mark_top.gif); text-align: right;"><img src="../images/bt_re.gif" onclick="javascript:parent.window.location.reload();" style="cursor: pointer;"><img src="../images/bt_out.gif" style="cursor: pointer;" onclick="javascript:parent.window.close()"></div>

	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center" style="padding-left: 30px; padding-right: 30px;">
				<div class="title">����� ���� ����</div>
				
				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="TableD">
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>������ȣ</B></td>  
						<td bgcolor="#FFFFFF"><%=rst.getId_q()%>&nbsp;</td>
						<td width="15%" align="center" id="left"><B>����</B></td> 
						<td bgcolor="#FFFFFF"><%=rst.getAllotting()%>��</td>	
					</tr>
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>����</B></td>  
						<td height="30" bgcolor="#FFFFFF" colspan="3"><%=rst.getQ()%>&nbsp;</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>

</BODY>
</HTML>
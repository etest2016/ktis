<%
//******************************************************************************
//   ���α׷� : ans_insert.jsp
//   �� �� �� : ����� �߰� 1
//   ��    �� : ����� �߰� 1
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-05-20
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<html>
<head>
	<title>����� �߰�</title>
</head>

<BODY style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;" id="tman">
<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>
<br>
<center>
<form name="frmdata" method="post" action="ans_insert_operate.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">

<table border="0" width="350" cellpadding ="1" cellspacing="1" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<tr height="35">
		<td width="30%" align="right" style="background-color: #eefdff; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">���̵�&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;<input type="text" class="input" name="userid" size="20" readonly value="<%=userid%>"></td>
	</tr>	
	<tr height="35">
		<td align="right" style="background-color: #eefdff; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">���û���&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;<input type="radio" name="yn_end" value="Y" checked> �Ϸ�&nbsp;&nbsp;<input type="radio" name="yn_end" value="N"> �̿Ϸ�</td>
	</tr>
</table>
<p>
<input type="image" value="Ȯ���ϱ�" name="submit" src="../../images/user_static_yj1_1.gif">&nbsp;&nbsp;&nbsp;<!--input type="button" value="����ϱ�" onClick="window.close();"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif"></a>
</TD>
			<TD></TD>
		</TR>
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>
</form>
</body>
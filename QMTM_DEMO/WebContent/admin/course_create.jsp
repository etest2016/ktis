<%@ page contentType="text/html; charset=EUC-KR" %>

<%
  response.setDateHeader("Expires", 0);
  request.setCharacterEncoding("EUC-KR");
%>

<center>
<br><br>
������
<br>
<form name="frmdata" method="post" action="course_create_ok.jsp">
<table border="0" width="500" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">�����&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="course" size="20"></td>
	</tr>
	<tr height="40">
		<td width="30%" align="right">����� ���&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;����� ���</td>
	</tr>
	<tr height="40">
		<td align="right">�������&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="radio" name="yn_valid" value="Y" checked> ��밡��&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N"> ���Ҵ�</td>
	</tr>
</table>
<p>
<input type="submit" value="���������ϱ�">

</form>
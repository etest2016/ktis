<%@ page contentType="text/html; charset=EUC-KR" %>

<%
  response.setDateHeader("Expires", 0);
  request.setCharacterEncoding("EUC-KR");
%>

<center>
<br><br>
과목등록
<br>
<form name="frmdata" method="post" action="course_create_ok.jsp">
<table border="0" width="500" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">과목명&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="course" size="20"></td>
	</tr>
	<tr height="40">
		<td width="30%" align="right">담당자 등록&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;담당자 등록</td>
	</tr>
	<tr height="40">
		<td align="right">사용유무&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="radio" name="yn_valid" value="Y" checked> 사용가능&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N"> 사용불능</td>
	</tr>
</table>
<p>
<input type="submit" value="과정생성하기">

</form>
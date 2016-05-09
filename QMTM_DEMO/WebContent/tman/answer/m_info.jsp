<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*" %>

<%
response.setDateHeader("Expires", 0);
request.setCharacterEncoding("euc-kr");
%>

<html>
<head>
<title>수동채점 안내</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Pragma" content="no-cache">
<meta name="AUTHOR" content="CheongJH">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<script language="javascript">
</script>
</head>


<BODY style="margin: 0px 30px 40px 20px; ">

	<img src="../../images/sub2_webscore6.gif"><br>
	<div style="padding: 20px; font: 12px; line-height: 180%; color: #888;">
		· 좌측화면의 응시자목록은 채점 미완료자의 아이디 순으로, 그후 완료자의 아이디순으로 정열됩니다.<br>
		· 좌측화면에서 응시자 아이디를 선택하면 채점화면이 열리고, 채점을 시작합니다.<br>
		· 채점화면에서 마지막 문제를 채점 후, 하단의 채점완료를 누르면 좌측화면의 채점란이 '<font color="red">완료</font>'로 변경됩니다.<br>
		· 채점이 완료된 응시자도 다시 채점할 수 있습니다.<br>
		· 채점화면에서 우측에 있는 문제목록의 문제 번호를 클릭하여 원하는 문제로 바로 이동할 수 있습니다.<br>
		· 채점화면에서 단답형의 경우 정답란을 참조하여 채점하시면 됩니다.<br>
	</div>

</body>
</html>
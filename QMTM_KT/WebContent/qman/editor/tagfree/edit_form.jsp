<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,com.tagfree.util.*,org.w3c.tidy.*,org.w3c.dom.*" %>
<%
	// 수정할 컨텐트를 지정한다. (데이터베이스로부터 가져온 .. )
	// 여기서  " 을 특수문자로 변환한다.
	// JDK 1.4의 경우 String 클래스의 replace(RegExp, String)을 사용하고,
	// 아닐 경우 com.tagfree.util.MimeUtil의 replace 메서드를 사용한다.
	// 그리고 content를 값으로 지정하는 form의 값은 반드시 "로 감싸야 한다.
	// ex> <input type="hidden" value="<%= content % >">

	String content = "<html><body>\"test\"</body></html>";
	content = MimeUtil.replace(content, "&", "&amp;");
	content = MimeUtil.replace(content, "\"", "&#34;");
%>
<html>
<head>
<title>NKiller</title>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=euc-kr">
<META HTTP-EQUIV="Cache-Control" content="no-cache">
<META HTTP-EQUIV="Pragma" content="no-cache">
<META HTTP-EQUIV="expires" content="0">
<script>
<!--
function OnSave()
{
	var form = document.writeForm;
	var str = document.twe.MimeValue();
	form.mime_contents.value = str;
	form.submit();
}

function OnInit()
{
	var form = document.writeForm;
	form.twe.InitDocument();
}
-->
</script>
<script language="JScript" FOR="twe" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe.HtmlValue = form.contents.value;
</script>
</head>
<body topmargin="0" leftmargin="0" bgcolor="white" scroll="auto">
	<form name="writeForm" method="post" action="write.jsp">
	<input type="hidden" name="mime_contents">
	<input type="hidden" name="contents" value="<%= content %>"> <!-- 기존 컨텐트를 저장 -->
	<table>
	<tr>
	<td width="800" height="500">
		<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
		<script language="jscript" src="tweditor.js"></script>
		<!-- Active Designer 추가 끝 -->
	</td>
	</tr>
	<tr>
	<td>
	<a href="javascript:OnSave()">입력</a>
	<a href="javascript:OnInit()">초기화</a>
	</td>
	</tr>
	</table>
	</form>
</body></html>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,com.tagfree.util.*,org.w3c.tidy.*,org.w3c.dom.*" %>
<%
	// ������ ����Ʈ�� �����Ѵ�. (�����ͺ��̽��κ��� ������ .. )
	// ���⼭  " �� Ư�����ڷ� ��ȯ�Ѵ�.
	// JDK 1.4�� ��� String Ŭ������ replace(RegExp, String)�� ����ϰ�,
	// �ƴ� ��� com.tagfree.util.MimeUtil�� replace �޼��带 ����Ѵ�.
	// �׸��� content�� ������ �����ϴ� form�� ���� �ݵ�� "�� ���ξ� �Ѵ�.
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
	<input type="hidden" name="contents" value="<%= content %>"> <!-- ���� ����Ʈ�� ���� -->
	<table>
	<tr>
	<td width="800" height="500">
		<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
		<script language="jscript" src="tweditor.js"></script>
		<!-- Active Designer �߰� �� -->
	</td>
	</tr>
	<tr>
	<td>
	<a href="javascript:OnSave()">�Է�</a>
	<a href="javascript:OnInit()">�ʱ�ȭ</a>
	</td>
	</tr>
	</table>
	</form>
</body></html>

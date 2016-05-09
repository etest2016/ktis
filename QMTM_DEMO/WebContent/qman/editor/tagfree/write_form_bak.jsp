<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,com.tagfree.util.*,org.w3c.tidy.*,org.w3c.dom.*" %>
<html>
<head>
<title>NKiller</title>
<link rel="StyleSheet" href="../../../../css/style.css" type="text/css">
<script>
<!--
function OnSave()
{
	var form = document.writeForm;
	var str = document.twe.MimeValue();
	var str2 = document.twe2.MimeValue();
	var str3 = document.twe3.MimeValue();
	var str4 = document.twe4.MimeValue();
	var str5 = document.twe5.MimeValue();
	var str6 = document.twe6.MimeValue();
	var str7 = document.twe7.MimeValue();
	var str8 = document.twe8.MimeValue();
	var str9 = document.twe9.MimeValue();

	form.mime_contents.value = str;
	form.mime_contents2.value = str2;
	form.mime_contents3.value = str3;
	form.mime_contents4.value = str4;
	form.mime_contents5.value = str5;
	form.mime_contents6.value = str6;
	form.mime_contents7.value = str7;
	form.mime_contents8.value = str8;
	form.mime_contents9.value = str9;
	form.submit();
}

function OnInit()
{
	var form = document.writeForm;
	form.twe9.InitDocument();
	form.twe8.InitDocument();
	form.twe7.InitDocument();
	form.twe6.InitDocument();
	form.twe5.InitDocument();
	form.twe4.InitDocument();
	form.twe3.InitDocument();
	form.twe2.InitDocument();
	form.twe.InitDocument();
}
-->
</script>
</head>
<body topmargin="0" leftmargin="0" bgcolor="white" scroll="auto">
	<form name="writeForm" method="post" action="write.jsp">
	<input type="hidden" name="mime_contents">
	<input type="hidden" name="mime_contents2">
	<input type="hidden" name="mime_contents3">
	<input type="hidden" name="mime_contents4">
	<input type="hidden" name="mime_contents5">
	<input type="hidden" name="mime_contents6">
	<input type="hidden" name="mime_contents7">
	<input type="hidden" name="mime_contents8">
	<input type="hidden" name="mime_contents9">
	<table border="0" width="1000" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF" height="30">
			<td width="150">문제번호 : 123456</td>
			<td width="100" align="center"><a href="javascript:OnSave()">저장하기</a></td>
			<td width="100" align="center"><a href="javascript:OnInit()">초기화</a></td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<table border="0" width="1000" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF">
			<td width="600" height="640" rowspan="9">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>			
			<td width="575" colspan="2" height="35">
			<table border="0" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC">
				<tr>
					<td align="center"><input type="button" value="보기/정답" onClick=""></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="1">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor2.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="2">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor3.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="3">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor4.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="4">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor5.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="5">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor6.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="6">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor7.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="7">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor8.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="25" height="<%=600/8%>" valign="top">
				<input type="radio" name="corrects" value="8">
			</td>
			<td width="550" height="<%=600/8%>">
			<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->
			<script language="jscript" src="tweditor9.js"></script>
			<!-- Active Designer 추가 끝 -->
			</td>
		</tr>
	</table>
	
	</form>
</body></html>

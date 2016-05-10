<!--#include file="../common/ADO.asp" -->
<!--#include file="../common/function.asp" -->
<%
	Response.CacheControl = "no-cache" 
	Response.AddHeader "pragma", "no-cache" 
	Response.Expires = -1

	id_exam = Request.QueryString("id_exam")
	id_q = Request.QueryString("id_q")
%>
<html>
<head>
	<title>논술형문제 채점하기</title>
</head>
<frameset rows="140,*" cols="*" frameborder="NO" border="0" framespacing="0">
	<frame src="mark_top.asp" name="topFrame" scrolling="NO" noresize>
		<frameset rows="*" cols="300,*" framespacing="0" frameborder="no" border="0">
		    <frame name="left" src="./mark_user.asp?id_exam=<%= id_exam %>&id_q=<%= id_q %>" marginwidth="0" marginheight="0" scrolling="yes" frameborder="0" noresize>
		    <frame name="right" src="./mark_info.asp" marginwidth="0" marginheight="0" scrolling="auto" frameborder="0" noresize>
	</frameset>
</frameset>
<noframes><body oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">
</body></noframes>
<!-- #include file="../common/ADO.asp" -->
<%
	id_exam = Request("id_exam")
%>
<html>
<head>
<title>웹채점 관리 - 응시자별 채점</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<frameset rows="140,*" cols="*" frameborder="NO" border="0" framespacing="0">
	<frame src="m_top.asp" name="topFrame" scrolling="NO" noresize>
		<frameset rows="*" cols="300,*" framespacing="0" frameborder="no" border="0">
		<frame src="./m_user.asp?id_exam=<%= id_exam %>" name="leftFrame" scrolling="yes" noresize>
		<frame src="./m_mark.asp" name="mainFrame" scrolling="AUTO">
	</frameset>
</frameset>
<noframes><body oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">
</body></noframes>
                                                       
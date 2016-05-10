<!--#include file="../common/ADO.asp" -->
<!--#include file="../common/function.asp" -->

<%
	Response.CacheControl = "no-cache" 
	Response.AddHeader "pragma", "no-cache" 
	Response.Expires = -1

	G_PAGESIZE = 20
	
	id_exam = Request("id_exam")

	'페이지번호
	pg = Request.Form("pg")
	CChk = CNN_OPEN("qmtmdb")
	
	if CChk = -1 then
		Response.Write "데이터베이스에 연결하던중 오류가 발생 하였습니다<br><br>담당자에게 문의 하십시요"
		Response.End
	End if

	SQL = ""
	SQL = SQL & "Select a.userid, b.name, isnull(a.yn_mark, 'B') yn_mark "
	SQL = SQL & "From exam_ans a, qt_userid b "
	SQL = SQL & "Where a.id_exam = '" & id_exam & "' and a.userid = b.userid "
	SQL = SQL & "Order by b.name "
	
	Chk = Rst_Open(SQL, "R")

	Rst.PageSize = G_PAGESIZE
	lngTotPageSize = Rst.PageCount
	
	if pg = "" Then
		pg = 1
	End if
	
	if Rst.Eof = False Then
		Rst.AbsolutePage = pg
	End if
%>

<html>
<head>
<title>채점 대상자</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">
</head>
<script language="javascript">
	function checkCloseYn() {
		var strMsg = "";
	
		return;
	}

	function ftnFocus(pid) {
		if (document.myform.old_id.value != "") {
			eval("document.all." + document.myform.old_id.value + ".bgColor = 'FFFFFF';");
		}
		eval("document.all." + pid + ".bgColor = '#e4f5fc';");
		document.myform.old_id.value = pid;
	}

	function ftnMovePage(pg_no) {
		document.myform.pg.value = pg_no;
		document.myform.action = "./m_user.asp";
		document.myform.submit();
	}

</script>
<body onload="javascript:checkCloseYn();" style="margin: 0px 20px 30px 30px;" oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">
<form name="myform" method="post">
<input type="hidden" name="old_id">
<input type="hidden" name="id_exam" value="<%= id_exam %>">
<input type="hidden" name="pg" value="<%= pg %>">

<img src="../images/sub2_webscore5.gif">
<table class="Btype" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
	<tr class="title">
		<td>아이디</td>
		<td>이름</td>
		<td>채점</td>
		</tr>
		<%
			if Rst.Eof = False Then
				if pg = 1 Then
					i = 0
				Else
					i = pg * G_PAGESIZE - G_PAGESIZE
				End if

			For k = 1 to G_PAGESIZE
			if Rst.Eof Then
				Exit For
			End if

			i = i + 1
		%>
	<tr id="back<%= Rst("userid") %>">
		<td>
			<a href="m_mark.asp?id_exam=<%= id_exam %>&userid=<%= Rst("userid") %>" target="mainFrame" onclick="javascript:ftnFocus('back<%= Rst("userid") %>');"><u><%= Rst("userid") %></u></a>
		</td>
		<td><%= Rst("name") %></td>
		<td id="mark_<%= Rst("userid") %>">
		<%
			if Rst("yn_mark") = "Y" Then
				Response.Write "완료"
			Elseif Rst("yn_mark") = "N" Then
				Response.Write "미완료"
			Else
				Response.Write "미응시"
			End if
		%>
		</td>
	</tr>
	<% 
			Rst.MoveNext
			Next
		End if 
	%>
</table>
<br>
<table width="100%" height="30" cellpadding="0" cellspacing="0" bgcolor="f6f6f6" border="0">
	<tr>
		<td align="left" style="padding-left:10px;">Page:<%= pg %>/<%= lngTotPageSize %></td>
		<td align="right" style="padding-right:10px;">
			<%
				lngPgMok = pg \ 10
				lngPgStart = 0
				
				if lngPgMok = 0 Then
					lngPgStart = 1
					lngPgEnd = lngPgStart + 8
				Else
					lngPgStart = lngPgMok * 10
					lngPgEnd = lngPgStart + 9
					Response.Write "<a href='javascript:ftnMovePage(" & lngPgStart -1 & ")'><img src='../button/but_back.gif' align='absmiddle' border='0'></a>"
				End if
				
				For i = lngPgStart to lngPgEnd
					if i > lngTotPageSize Then
						Exit For
					End if
					
					if i = CLng(pg) Then
						Response.Write "<a href='javascript:ftnMovePage(" & i & ")'><font color=red>" & i & "</font></a>&nbsp;"
					Else
						Response.Write "<a href='javascript:ftnMovePage(" & i & ")'>" & i & "</a>&nbsp;"
					End if
				Next
				
				if lngTotPageSize > lngPgEnd Then
					Response.Write "<a href='javascript:ftnMovePage(" & lngPgEnd +1 & ")'><img src='../button/but_next.gif' align='absmiddle' border='0'></a>"
				End if
			%>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%
	Call Rst_Close
	Call Cnn_Close
%>
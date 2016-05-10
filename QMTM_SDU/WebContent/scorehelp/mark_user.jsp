<!--#include file="../common/ADO.asp" -->
<!--#include file="../paper/common.asp" -->
<!--#include file="../common/function.asp" -->
<%
	Response.CacheControl = "no-cache" 
	Response.AddHeader "pragma", "no-cache" 
	Response.Expires = -1

	Function ReplaceTag(strA) 
		ReplaceTag = Replace(Replace(strA, "<", "&lt"), ">", "&gt")
	End Function

	id_exam = Request("id_exam")
	id_q = Request("id_q")

	CChk = CNN_OPEN("qmtmdb")
	
	if Err.Number <> 0 Then
		Response.Write Err.Description
		Response.End
	End if
	
	if CChk = -1 then
		Response.Write "데이터베이스에 연결하던중 오류가 발생 하였습니다<br><br>담당자에게 문의 하십시요"
		Response.End
	End if

	'문제별 채점의 경우 Tman에서 시험지별로 문제의 배점을 다르게 할 수 있기 때문에
	'원칙적으로 문제별 채점을 하면 안되지만 같은 배점이라는 전제하에 만든다

	'해당 시험의 시험지의 문제수를 읽어온다
	SQL = ""
	SQL = SQL & "Select qcount, setcount "
	SQL = SQL & "From exam_m "
	SQL = SQL & "Where id_exam = '" & id_exam & "' "

	Chk = Rst_Open(SQL, "R")
	
	if Rst.Eof Then
		Response.Write "시험 정보가 존재 하지 않습니다. 관리자에게 문의 하십시요"
		Response.End
	End if
		
	lngQCount = Rst("qcount")
	
	Call Rst_Close
	
	'시험지별 문제코드의 위치 정보 및 배점을 읽어온다
	SQL = ""
	SQL = SQL & "Select nr_set, nr_q, allotting "
	SQL = SQL & "From exam_paper2 "
	SQL = SQL & "Where id_exam = '" & id_exam & "' and id_q = " & id_q & " "
	SQL = SQL & "Order by nr_set "
	
	Chk = Rst_Open(SQL, "R")
	
	if Rst.Eof Then
		Response.Write "시험지 정보가 존재 하지 않습니다. 관리자에게 문의 하십시요"
		Response.End
	End if
	
	lngPaperCount = Rst.RecordCount
	lngPaperCount = lngPaperCount -1

	Dim ArrNrinfo
	Dim strNrSets
	ReDim ArrNrinfo(2, lngPaperCount)
	
	strNrSets = ""
	For i = 0 to lngPaperCount
		strNrSets = strNrSets & "," & Rst("nr_set")
	
		ArrNrinfo(0, i) = Rst("nr_set")
		ArrNrinfo(1, i) = Rst("nr_q")
		ArrNrinfo(2, i) = Rst("allotting")
		Rst.MoveNext
	Next

	Call Rst_Close
	
	'해당 문제가 출제된 시험지들의 번호를 구한다
	strNrSets = Mid(strNrSets, 2)

	'첫번째 시험지의 배점을 해당 문제의 배점으로 한다
	sngAllotting = ArrNrinfo(2, 0)
	
	'해당 문제가 출제된 시험지로 시험을본 응시자들의 목록을 만든다
	SQL = ""
	SQL = SQL & "Select a.userid, b.name, a.nr_set, a.oxs, "
	SQL = SQL & "       isnull(a.points, '') points, isnull(a.answers, '') answers "
	SQL = SQL & "From exam_ans a, qt_userid b "
	SQL = SQL & "Where a.id_exam = '" & id_exam & "' and a.nr_set in (" & strNrSets & ") and "
	SQL = SQL & "      a.userid = b.userid and a.oxs is not null and a.score is not null "
	SQL = SQL & "Order by b.name "
	
	Chk = Rst_Open(SQL, "R")

	Dim mUser, mName, mPos, mPoints
	Dim ArrUserid, ArrName, ArrPos, ArrPoints
	Dim k
	
	k = -1
	mUser = ""
	mName = ""
	mPos = ""
	mPoints = ""
	While Not Rst.Eof
		tmpArr = Split(Rst("oxs"), Q_GUBUN)
		tmpPoints = ""
		
		'채점을 한번도 하지 않은 경우라면 배열을 만들어 준다
		if Rst("points") = "" Then
			ReDim tmpPoints(lngQCount -1)
			
			'배열에 들어 있는 값을 초기화 한다
			For i = 0 to lngQCount -1
				tmpPoints(i) = ""
			Next
		Else
			tmpPoints = Split(Rst("points"), Q_GUBUN)
		End if
		
		'배열의 갯수가 출제 문제 갯수와 같은지 확인한다
		if UBound(tmpArr) + 1 <> lngQCount Or UBound(tmpPoints) + 1 <> lngQCount Then
			Response.Write "채점정보의 크기가 정확하지 않습니다. 관리자에게 문의 하십시요"
			Response.End
		End if
		
		'해당 문제가 맞았는지 확인하기 위해 시험지 정보에서 문제 위치 정보를 찾는다
		lngNr = CLng(Rst("nr_set"))
		lngPos = -1
		For i = 0 to lngPaperCount
			if CLng(ArrNrinfo(0, i)) = lngNr Then
				lngPos = ArrNrinfo(1, i)
				Exit For
			End if
		Next
		
		if lngPos <= 0 Then
			Response.Write "해당 시험지 정보에서 채점 정보의 위치를 찾지 못했습니다<br>관리자에게 문의 하십시요"
			Response.End
		End if
		
		'Split 함수로 만든 배열은 인덱스의 시작이 0 이므로 -1 해준다
		lngPos = lngPos -1
		k = k + 1
		mUser = mUser & WEB_GUBUN & Rst("userid")
		mName = mName & WEB_GUBUN & Rst("name")
		mPos = mPos & WEB_GUBUN & lngPos
		mPoints = mPoints & WEB_GUBUN & tmpPoints(lngPos)
		
		Rst.MoveNext
	Wend

	Call Rst_Close

	ArrUserid = Split(Mid(mUser, Len(WEB_GUBUN) + 1), WEB_GUBUN)
	ArrName = Split(Mid(mName, Len(WEB_GUBUN) + 1), WEB_GUBUN)
	ArrPos = Split(Mid(mPos, Len(WEB_GUBUN) + 1), WEB_GUBUN)
	ArrPoints = Split(Mid(mPoints, Len(WEB_GUBUN) + 1), WEB_GUBUN)

	if UBound(ArrUserid) = 0 Then
		if mPoints = WEB_GUBUN Then
			ArrPoints = SPlit(" ", WEB_GUBUN)
		End if
	End if

	if UBound(ArrUserid) <> k Or UBound(ArrName) <> k Or UBound(ArrPos) <> k Or UBound(ArrPoints) <> k Then
		Response.Write "응시자아이디->" & UBound(ArrUserid) & "<br>"
		Response.Write "응시자이름->" & UBound(ArrName) & "<br>"
		Response.Write "문제위치->" & UBound(ArrPos) & "<br>"
		Response.Write "부분점수->" & UBound(ArrPoints) & "<br>"
		Response.Write "논술채점자 목록 배열을 만들중 오류가 발생 하였습니다. 관리자에게 문의 하십시요"
		Response.End
	End if

%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">
<style>
	body { margin: 15px; }
</style>
<Script Language="JavaScript">
	function ftnFocus(pUserid, pPos, pName, piDx) {
		var oid = document.myform.old_id.value;
	
		if (oid != "") {
			if (parseInt(oid) % 2 == 0) {
				eval("document.all.back" + oid + ".bgColor = '#F1F5FE';");
			} else {
				eval("document.all.back" + oid + ".bgColor = 'FFFFFF';");
			}
		}
		eval("document.all.back" + piDx + ".bgColor = '#e4f5fc';");
		document.myform.old_id.value = piDx;
		
		document.myform.userid.value = pUserid;
		document.myform.name.value = pName;
		document.myform.pos.value = pPos;
		document.myform.action = "./mark_m.asp";
		document.myform.target = "right";
		document.myform.submit();
	}
</Script>
</head>

<body style="margin: 0px 20px 30px 30px;" oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;"> 
<form name="myform" method="post">
<input type="hidden" name="id_exam" value="<%= id_exam %>">
<input type="hidden" name="id_q" value="<%= id_q %>">
<input type="hidden" name="allotting" value="<%= sngAllotting %>">
<input type="hidden" name="userid">
<input type="hidden" name="name">
<input type="hidden" name="pos">
<input type="hidden" name="old_id">
</form>

<img src="../images/sub2_webscore5.gif">
<table class="Btype" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
	<tr class="title"> 
		<td>번호</td>
		<td>아이디</td>
		<td>이름</td>
		<td>점수</td>
	</tr>
	<% For i = 0 to UBound(ArrUserid) %>
	<tr id="back<%= i %>" <% if i mod 2 = 0 Then %>bgcolor="#FFFFFF"<% end if %>> 
		<td><%= i + 1 %></td>
		<td><a href="javascript:ftnFocus('<%= ArrUserid(i) %>', '<%= ArrPos(i) %>', '<%= ArrName(i) %>', '<%= i %>');"><u><%= ArrUserid(i) %></u></a></td>
		<td><%= ArrName(i) %></td>
		<td id="score<%= ArrUserid(i) %>"><%= ArrPoints(i) %>&nbsp;</td>
	</tr>
	<% Next %>
</table>
<br>
<div align="right" style="padding: 3px 10px 3px 10px; background-color: #f6f6f6;">총인원: <%= UBound(ArrUserid) + 1 %>명</div>

</body>
</html>
<%
	Call Cnn_Close()
%>                                                                           
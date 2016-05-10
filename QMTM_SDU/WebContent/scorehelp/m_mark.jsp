<!--#include file="../common/ADO.asp" -->
<!--#include file="../paper/common.asp" -->
<%
	Response.CacheControl = "no-cache" 
	Response.AddHeader "pragma", "no-cache" 
	Response.Expires = -1

	id_exam = Request("id_exam")
	userid = Request("userid")
	'채점자 강평..
	comment = Request("comment")
	comment = Replace(comment, "'","''")

	'현재 문제의 배열위치
	lngPos = Request("pos")

	lngJumpPos = Request("jump_pos")
	'현재 위치, 이전문제 이동, 다음문제 이동 등의 플레그값
	aMode = Request("aMode")
	'새로운 수동채점 점수
	newPoint = Trim(Request("newPoint"))

	CChk = CNN_OPEN("qmtmdb")
	
	if CChk = -1 then
		Response.Write "데이터베이스에 연결하던중 오류가 발생 하였습니다<br><br>담당자에게 문의 하십시요"
		Response.End
	End if

	if id_exam = "" Then
		Response.Redirect "m_info.asp"
		Response.End
	End if

	'평가명, 시험지번호, 답안, 부분점수... 등을 읽어온다
	SQL = ""
	SQL = SQL & "Select a.title, a.course_year, a.course_no, a.qcount, b.nr_set, "
	SQL = SQL & "       isnull(b.answers, '') answers, isnull(b.oxs, '') oxs, isnull(b.points, '') points, b.score "
	SQL = SQL & "From exam_m a, exam_ans b "
	SQL = SQL & "Where a.id_exam = '" & id_exam & "' and a.id_exam = b.id_exam and "
	SQL = SQL & "      b.userid = '" & userid & "' and b.score is not null "

	Chk = Rst_Open(SQL, "R")

	if Rst.Eof Then
		Response.Write "자동 채점 처리가 되지 않았습니다. 수동채점은 자동채점 처리 후 가능 합니다."
		Response.End
	End if

	strTitle = Rst("title")
	strCourseYear = Rst("course_year")
	strCourseNo = Rst("course_no")
	lngTotQcnt = CLng(Rst("qcount"))
	lngNrSet = CLng(Rst("nr_set"))
	strAnswers = Rst("answers")
	strPoints = Rst("points")
	strOxs = Rst("oxs")
	sngScore = Rst("score")

	if strOxs = "" Then
		Response.Write "자동 채점 처리가 되지 않았습니다. 수동채점은 자동채점 처리 후 가능 합니다."
		Response.End
	End if

	Dim ArrAnswers, ArrPoints, ArrOxs
	ArrOxs = Split(strOxs, Q_GUBUN)
	
	'작성한 답안이 없을 경우
	if strAnswers = "" Then
		ReDim ArrAnswers(lngTotQcnt -1)

		For i = 0 to lngTotQcnt -1
			ArrAnswers(i) = ""
		Next
	Else
		ArrAnswers = Split(strAnswers, Q_GUBUN)
	End if
	
	if strPoints = "" Then
		ReDim ArrPoints(lngTotQcnt -1)
		
		For i = 0 to lngTotQcnt -1
			ArrPoints(i) = ""
		Next
	Else
		ArrPoints = Split(strPoints, Q_GUBUN)
	End if

	if UBound(ArrAnswers) + 1 <> lngTotQcnt Or UBound(ArrPoints) + 1 <> lngTotQcnt Or UBound(ArrOxs) + 1 <> lngTotQcnt Then
		Response.Write "부분점수 배열의 크기 계산중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요"
		Response.End
	End if

	Call Rst_Close

	'자동채점으로 맞은 문제는 채점할 필요가 없기 때문에 자동으로 맞은 문제를 알아 낸다
	strinCorrect = ""
	For i = 0 to lngTotQcnt -1
		if ArrOxs(i) = "O" and ArrPoints(i) = "" Then
			strinCorrect = strinCorrect & "," & (i + 1)
		End if
	Next

	if strinCorrect <> "" Then
		strinCorrect = " and a.nr_q not in (" & Mid(strinCorrect, 2) & ") "
	End if

	'단답형, 논술형 평가의 문제 및 배점정보를 읽어온다
	SQL = ""
	SQL = SQL & "Select a.nr_q, a.id_q, a.allotting, b.id_qtype, b.id_ref "
	SQL = SQL & "From exam_paper2 a, q b "
	SQL = SQL & "Where a.id_exam = '" & id_exam & "' and a.nr_set = " & lngNrSet & " and "
	SQL = SQL & "      a.id_q = b.id_q and b.id_qtype >= 4 " & strinCorrect
	SQL = SQL & "Order by a.nr_q "
	
	Chk = Rst_Open(SQL, "R")
	
	if Rst.Eof Then
		Response.Write "주관식 틀린 문제가 없습니다"
		Response.End
	End if
	
	'출제된 문제의 갯수를 알아온다
	lngQcnt = Rst.RecordCount
	
	Dim ArrNrQ, ArridQ, ArrAllotting, ArrQtype, ArridRef
	
	ReDim ArrNrQ(lngQcnt -1)
	ReDim ArridQ(lngQcnt -1)
	ReDim ArrAllotting(lngQcnt -1)
	ReDim ArrQtype(lngQcnt -1)
	ReDim ArridRef(lngQcnt -1)
	
	i = 0
	While Not Rst.Eof
		ArrNrQ(i) = Rst("nr_q")
		ArridQ(i) = Rst("id_q")
		ArrAllotting(i) = Rst("allotting")
		ArrQtype(i) = Rst("id_qtype")
		ArridRef(i) = Rst("id_ref")

		i = i + 1		
		Rst.MoveNext
	Wend
	
	Call Rst_Close
	
	'문제의 위치 정보가 없다면 채점 시작 이므로 위치값을 0으로 만들어 준다
	if lngPos = "" Then
		lngPos = 0
	Else
		lngPos = CLng(lngPos)

	'논술형 강평 작성..
	
		SQL = ""
		SQL = SQL & "Select score_comment "
		SQL = SQL & "From exam_ans_comment "
		SQL = SQL & "Where id_exam = '"& id_exam &"' and userid = '"& userid &"' and id_q = '"& ArridQ(lngPos) &"' "

		Chk = Rst_Open(SQL, "R")

		If Rst.Eof Then 
			SQL = ""
			SQL = SQL & "Insert into exam_ans_comment(id_exam, userid, id_q, score_comment, "
			SQL = SQL & "       reg_id, regdate) " 
			SQL = SQL & "Values('"& id_exam &"', '"& userid &"', '"& ArridQ(lngPos) &"', '"& comment &"', "
			SQL = SQL & "       '"& Session("userid") &"', getdate()) "
		Else
			score_comment = Rst("score_comment")
			SQL = SQL & "Update exam_ans_comment set score_comment = '"& comment &"', "
			SQL = SQL &	"       up_id = '"& Session("userid") &"', up_date = getdate() "
			SQL = SQL & "Where id_exam = '"& id_exam &"' and userid = '"& userid &"' and id_q = '"& ArridQ(lngPos) &"' "
		End If
		
		Cnn.Execute SQL
		
		if Err.Number <> 0 Then
			Response.Write "논술형 문제 강평작성 중 오류가 발생했습니다. 잠시 후 다시 시도해 주십시요<br>"
			Response.Write Err.Description
			Response.End
		End If

		Call Rst_Close
				
		'-----------------------------------------
		'부분점수 채점을 했을 경우(점수 업데이트)
		'-----------------------------------------
		if CLng(lngPos) >= 0 and newPoint <> "" Then
			lngNewPos = ArrNrQ(lngPos) -1

			oldPoint = 0
			'자동채점으로 맞은경우는 부분점수가 있다고 봐야 한다
			if ArrPoints(lngNewPos) <> "" Then
				oldPoint = CSng(ArrPoints(lngNewPos))
			Elseif ArrOxs(lngNewPos) = "O" Then
				oldPoint = CSng(ArrAllotting(lngPos))
			End if

			ArrPoints(lngNewPos) = newPoint
			newPoint = CSng(newPoint)

			if CSng(ArrAllotting(lngPos)) = CSng(newPoint) Then
				ArrOxs(lngNewPos) = "O"
			Elseif CSng(newPoint) > 0 Then
				ArrOxs(lngNewPos) = "P"
			Else
				ArrOxs(lngNewPos) = "X"
			End if

			strNewPoints = Join(ArrPoints, Q_GUBUN)
			strNewOxs = Join(ArrOxs, Q_GUBUN)

			'이전 부분점수와 비교하여 증감된 부분만큼을 총점에 더한다
			sngAddPoint = 0
			if oldPoint > newPoint Then
				'이전 점수가 현재 점수 보다 크므로 총점을 감점 시켜야 한다
				sngAddPoint = (oldPoint - newPoint) * (-1)
			Else
				sngAddPoint = newPoint - oldPoint
			End if

			sngNewScore = CSng(sngScore) + sngAddPoint

			if UBound(Split(strNewPoints, Q_GUBUN)) + 1 <> lngTotQcnt Or UBound(Split(strNewOxs, Q_GUBUN)) + 1 <> lngTotQcnt Then
				Response.Write "부분점수 결과 저장중 점수배열 크기 계산 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요"
				Response.End
			End if

			On Error Resume Next

			SQL = ""
			SQL = SQL & "Update exam_ans "
			SQL = SQL & "Set oxs = '" & strNewOxs & "', points = '" & strNewPoints & "', score = " & sngNewScore & " "
			SQL = SQL & "Where id_exam = '" & id_exam & "' and userid = '" & userid & "' "
			
			Cnn.Execute SQL

			if Err.Number <> 0 Then
				Response.Write Err.Description
				Response.End
			End if
		End if

		'새로운 위치로 이동한다
		Select Case aMode
		Case "P"
			if lngPos > 0 Then
				lngPos = lngPos -1
			End if
					Case "N"
			if lngPos < lngQcnt -1 Then
				lngPos = lngPos + 1
			End if
		Case "J"
			lngPos = CLng(lngJumpPos)
		Case "E"
			'채점 완료 처리를 한경우
			SQL = ""
			SQL = SQL & "Update exam_ans "
			SQL = SQL & "Set yn_mark = 'Y' "
			SQL = SQL & "Where id_exam = '" & id_exam & "' and userid = '" & userid & "' "
			
			Cnn.Execute SQL
			
			if Err.Number <> 0 Then
				Response.Write Err.Description
				Response.End
			End if
			
			strScript = ""
			strScript = strScript & "<script language='javascript'>"
			strScript = strScript & "parent.leftFrame.mark_" & userid & ".innerText = '완료';"
			strScript = strScript & "</script>"

			Response.Write strScript
		End Select
	End if

	lngQPos = ArrNrQ(lngPos) -1

	Dim strUserAns, strQ, strCa, strExplain, strRefTitle, strRefBody
	'문제를 읽어온다
	SQL = ""
	SQL = SQL & "Select a.q, a.ca, a.explain, b.reftitle, isnull(b.refbody1, '') refbody1, "
	SQL = SQL & "       isnull(b.refbody2, '') refbody2, isnull(b.refbody3, '') refbody3 "
	SQL = SQL & "From q a left outer join q_ref b on a.id_ref = b.id_ref "
	SQL = SQL & "Where a.id_q = " & ArridQ(lngPos) & " "

	Chk = Rst_Open(SQL, "R")
	
	strQ = Rst("q")
	strCa = Rst("ca")
	strExplain = Rst("explain")
	strRefTitle = Rst("reftitle")
	strRefBody = Rst("refbody1") & Rst("refbody2") & Rst("refbody3")

	Call Rst_Close

	strUserAns = ""
	
	'작성 답안을 읽어온다
	if CLng(ArrQtype(lngPos)) > 4 Then
		'논술형, 파일형일 경우
		SQL = ""
		SQL = SQL & "Select isnull(userans1, '') userans1, isnull(userans2, '') userans2, "
		SQL = SQL & "       isnull(userans3, '') userans3 "
		SQL = SQL & "From exam_ans_non "
		SQL = SQL & "Where id_q = " & ArridQ(lngPos) & " and userid = '" & userid & "' and "
		SQL = SQL & "      id_exam = '" & id_exam & "' "
		
		Chk = Rst_Open(SQL, "R")
		
		strUserAns = Rst("userans1") & Rst("userans2") & Rst("userans3")

		Call Rst_Close
	Else
		if Instr(ArrAnswers(lngQPos), OR_GUBUN) > 0 Then
			ArrTmp = Split(ArrAnswers(lngQPos), OR_GUBUN)

			strUserAns = ""
			For i = 0 to UBound(ArrTmp)
				strUserAns = strUserAns & "☞ " & ArrTmp(i) & vbCrlf
			Next 
		Else
			strUserAns = ArrAnswers(lngQPos)
		End if
	End If
	
	'논술형 문제 답안에 대한 강평을 가지고 온다.
	SQL = ""
	SQL = SQL & "Select score_comment "
	SQL = SQL & "From exam_ans_comment "
	SQL = SQL & "Where id_q = " & ArridQ(lngPos) & " and userid = '" & userid & "' and "
	SQL = SQL & "      id_exam = '" & id_exam & "' "
	
	Chk = Rst_Open(SQL, "R")

	If Rst.eof Then
		score_comment = ""
	else
		score_comment = Rst("score_comment")
	End if
		
	Call Rst_Close

	Call Cnn_Close	
%>
<html>
<head>
<title>응시자별 채점</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">
<script language="javascript">
	function points_save(pMode) {
		var myForm = document.frmData;
	
		if (myForm.newPoint.value != "" && myForm.newPoint.value > <%= ArrAllotting(lngPos) %>) {
			alert("배점보다 점수를 높게 입력할 수 없습니다");
			myForm.newPoint.focus();
			return;
		}
	
		myForm.aMode.value = pMode;
		myForm.action = "m_mark.asp";
		myForm.submit();
	}

	function doCorrect() {
		var myForm = document.frmData;

		myForm.aMode.value = 'C';
		myForm.newPoint.value = <%= ArrAllotting(lngPos) %>;
		myForm.action = "m_mark.asp";
		myForm.submit();
	}

	function doInCorrect() {
		var myForm = document.frmData;

		myForm.aMode.value = 'C';
		myForm.newPoint.value = 0;
		myForm.action = "m_mark.asp";
		myForm.submit();
	}
	
	function doManual() {
		var myForm = document.frmData;
	
		if (myForm.newPoint.value != "" && myForm.newPoint.value > <%= ArrAllotting(lngPos) %>) {
			alert("배점보다 점수를 높게 입력할 수 없습니다");
			myForm.newPoint.focus();
			return;
		}
	
		myForm.aMode.value = 'C';
		myForm.action = "m_mark.asp";
		myForm.submit();
	}

	function Qjump(pPos) {
		var myForm = document.frmData;

		if (myForm.newPoint.value != "" && myForm.newPoint.value > <%= ArrAllotting(lngPos) %>) {
			alert("배점보다 점수를 높게 입력할 수 없습니다");
			myForm.newPoint.focus();
			return;
		}

		myForm.aMode.value = 'J';
		myForm.jump_pos.value = pPos;
		myForm.action = "m_mark.asp";
		myForm.submit();
	}

	function markEnd() {
		var myForm = document.frmData;
	
		if (myForm.newPoint.value != "" && myForm.newPoint.value > <%= ArrAllotting(lngPos) %>) {
			alert("배점보다 점수를 높게 입력할 수 없습니다");
			myForm.newPoint.focus();
			return;
		}
	
		myForm.aMode.value = 'E';
		myForm.action = "m_mark.asp";
		myForm.submit();
	}
	
	function goHome() {
		parent.window.location.replace("examlist.asp?yearno=<%= strYear %>/<%= strNo %>&id_exam_kind=<%= id_exam_kind %>");
	}
</script>
</head>
<!--body style="margin: 0px 30px 40px 20px;" oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;"-->
<body style="margin: 0px 30px 40px 20px;">
<form name="frmData" method="post">
<input type="hidden" name="id_exam" value="<%= id_exam %>">
<input type="hidden" name="y" value="<%= strYear %>">
<input type="hidden" name="n" value="<%= strNo %>">
<input type="hidden" name="userid" value="<%= userid %>">
<input type="hidden" name="pos" value="<%= lngPos %>">
<input type="hidden" name="jump_pos">
<input type="hidden" name="aMode">


<img src="../images/sub2_webscore1.gif">
<div class="box">
	[<%= strCourseYear %> 년도 <%= strCourseNo %>회차] <font class="point"><B><%= strTitle %></B></font> 응시생 [<font class="point"><B><%= userid %></B></font>]의 답안<br>
	[문제번호 <font class="point"><B><%= ArrNrQ(lngPos) %></B></font> / 문제코드 <font class="point"><B><%= ArridQ(lngPos) %></B></font>] <%= strQ %> [배점 <%= ArrAllotting(lngPos) %> 점]
	<% if CLng(ArrQtype(lngPos)) <= 4 Then %>
	<br>[정답] 
	<%
		if CLng(ArrQtype(lngPos)) > 4 Then
			Response.Write strExplain
		Elseif strCa <> "" Then
			ArrCaTmp = Split(Replace(strCa, LIKE_GUBUN, " 또는 "), OR_GUBUN)
			if UBound(ArrCaTmp) > 0 Then
				For i = 0 to UBound(ArrCaTmp)
					Response.Write "☞&nbsp;" & ArrCaTmp(i) & "&nbsp;&nbsp;"
				Next
			Else
				Response.Write "" & ArrCaTmp(0)
			End if
		End if
	%>
	<% Else %>
	<br>[해설(채점기준)]
	<% End if %>

	<% if ArridRef(lngPos) <> "0" Then %>
	<table width="100%" align="left" border="1" cellspacing="0" cellpadding="0">
		<tr>
			<td align=center height="20">&nbsp;<font color=white>※ <%= strRefTitle %></font></td>
		</tr>
		<tr>
			<td>
				<table bgcolor="F0F0F0" width="100%" align="left" border="0" cellspacing="0" cellpadding="8">
					<tr>
						<td><%= strRefBody %></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<% End if %>
</div>

<hr>

<TABLE width="100%" cellspacing="0" cellpadding="0" border="0">
	<TR>
		<TD valign="top">
			<!-- 응시자 답안 -->
			<img src="../images/sub2_webscore8.gif"><br>
			<textarea name="textarea" cols="75" rows="8" readonly style="padding: 15px 20px 15px 20px;"><%= strUserAns %></textarea>
			<!-- 채점자 강평 -->
			<% If ArrQtype(lngPos) = 5 Then %>
			<hr><img src="../images/sub2_webscore9.gif"><br>
			<textarea cols="75" rows="8" name="comment" style="padding: 15px 20px 15px 20px;"><%= score_comment %></textarea>
			<% End If %>
			<hr><!-- 채점 -->
			<img src="../images/sub2_webscore7.gif"><br>
			<img src="../images/bt3_true.gif" onclick="javascript:doCorrect();" style="cursor: pointer;">&nbsp;<img src="../images/bt3_false.gif" onclick="javascript:doInCorrect();" style="cursor: pointer;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="newPoint" size="6" maxlength="5"> 점 &nbsp;<img src="../images/bt3_mark3.gif" onclick="javascript:doManual();" style="cursor: pointer;">
		</TD>
		<TD width="200" valign="top">
			<img src="../images/sub2_webscore10.gif">
			<table border="0" cellpadding="0" cellspacing="0" class="Btype">
				<tr class="title"> 
					<td>번호</td>
					<td>배점</td>
					<td>점수</td>
				</tr>
			<% 
				For i = 0 to lngQcnt -1
					strBg = ""
					if i = lngPos Then
						strBg = "#e4f5fc"
					Else
						strBg = "#FFFFFF"
					End if
			%>
				<tr bgcolor="<%= strBg %>"> 
					<td><a href="javascript:Qjump(<%= i %>);"><u><%= ArrNrQ(i) %></u></a></td>
					<td><%= ArrAllotting(i) %></td>
					<td>
						<%
							'해당 문제가 정답과 일치 하여 맞은 경우인지 체크 한다
							if ArrPoints(ArrNrQ(i) -1) = "" And ArrOxs(ArrNrQ(i) -1) = "O" Then
								Response.Write ArrAllotting(i)
							Else
								Response.Write ArrPoints(ArrNrQ(i) -1) 
							End If
							
							If ArrAllotting(i) = "" or ArrPoints(ArrNrQ(i) -1) = "" Then
						%>
						&nbsp;
						<% End if %>
					</td>
				</tr>
			<%
				Next
			%>
			</table>

			<div align="center" class="button">
				<% if lngPos > 0 Then %>
					<a href="javascript:points_save('P');"><< 이전</a>&nbsp;
				<% End if %>
				<% if lngPos < lngQcnt -1  Then %>
					<a href="javascript:points_save('N');">&nbsp;다음 >></a>
				<% End if %>
				<% if lngPos = lngQcnt -1  Then %>
					<a href="javascript:markEnd();">&nbsp;채점완료</a>
				<% End if %>
			</div>
		</TD>
	</TR>
</TABLE>

</form>
<p>&nbsp;</p>
</body>
</html>

<!--#include file="../common/ADO.asp" -->
<!--#include file="../paper/common.asp" -->
<%
	Response.CacheControl = "no-cache"
	Response.AddHeader "pragma", "no-cache"
	Response.Expires = -1

	id_exam = Request("id_exam")
	id_q = Request("id_q")
	answer = Request("answer")
	sngScore = Request("scores")
	
	CChk = CNN_OPEN("qmtmdb")
	
	if CChk = -1 then
		Call MsgWindow("데이타베이스 연결에 실패했습니다.")
		Response.End
	End if			
	
	'해당 시험의 시험지의 문제수를 읽어온다
	SQL = ""
	SQL = SQL & "Select qcount, setcount "
	SQL = SQL & "From exam_m "
	SQL = SQL & "Where id_exam = '" & id_exam & "' "

	Chk = Rst_Open(SQL, "R")
	
	lngQCount = Rst("qcount")
	
	Call Rst_Close

	userid = ""
	'해당 답안의 응시자를 읽어온다.
	SQL = ""
	SQL = SQL & "Select userid "
	SQL = SQL & "From imsi_exam_ans_result "
	SQL = SQL & "Where id_exam = '" & id_exam & "' and id_q = '"& id_q &"' and answer = '"& answer &"' "
	
	Chk = Rst_Open(SQL, "R")
	
	While Not Rst.eof 
	
	userid = userid & Rst("userid") &"{||}"

	Rst.movenext
	Wend
		
	Call Rst_Close
	
	userid = split(userid, "{||}")
			
	' 해당 답안의 응시자 수만큼 반복한다.
	For i = 0 To UBound(userid)
		
	On Error Resume Next
	SQL = ""
	SQL = SQL & "Select a.oxs, isnull(a.points, '') points, a.score, b.nr_q, b.allotting "
	SQL = SQL & "From exam_ans a, exam_paper2 b " 
	SQL = SQL & "Where a.id_exam='"& id_exam &"' and a.userid='"& userid(i) &"' and "
	SQL = SQL & "      b.id_q = '"& id_q &"' and a.id_exam = b.id_exam and a.nr_set = b.nr_set "

	Chk = Rst_Open(SQL, "R")

	if Err.Number <> 0 Then
		Response.Write "데이터를 읽던 중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요<br>"
		Response.Write Err.Description
		Response.End
	End if
		
	Dim tmpOxs, tmpPoints, oldPoint, sngAddPoint, sngNewScore, nr_q, allotting

	nr_q = Rst("nr_q")
	allotting = Rst("allotting")

	If CDbl(allotting) = CDbl(sngScore) Then
		strMark = "O"
	ElseIf sngScore = 0 Then
		strMark = "X"
	Else
		strMark = "P"
	End If
	
	if Rst("points") = "" Then
		ReDim tmpPoints(lngQCount -1)
	Else
		tmpPoints = Split(Rst("points"), Q_GUBUN)
	End if
		
	tmpOxs = Split(Rst("oxs"), Q_GUBUN)

	'만들어진 배열의 갯수가 정확한지 확인한다
	if UBound(tmpOxs) + 1 <> lngQCount Or UBound(tmpPoints) + 1 <> lngQCount Then
		Response.Write "부분점수 채점 정보가 잘못되었거나 자동채점 전 상태입니다.<br>우선 TMAN 에서 자동채점을 진행해주시기 바랍니다."
		Response.End
	End if

	oldPoint = CSng(tmpPoints(nr_q-1))	
		
	'채점 정보와 부분점수 정보를 배열의 위치를 찾아 넣어준다
	tmpOxs(nr_q-1) = strMark
	tmpPoints(nr_q-1) = sngScore
		
	'이전 부분점수와 비교하여 증감된 부분만큼을 총점에 더한다
	sngAddPoint = 0
	if oldPoint > sngScore Then
		'이전 점수가 현재 점수 보다 크므로 총점을 감점 시켜야 한다
		sngAddPoint = (oldPoint - sngScore) * (-1)
	Else
		sngAddPoint = sngScore - oldPoint
	End if
		
	sngNewScore = CSng(Rst("score")) + sngAddPoint
	strOx = Join(tmpOxs, Q_GUBUN)
	strPoints = Join(tmpPoints, Q_GUBUN)
		
	'점수를 업데이트 하기 전에 채점 문자열 및 부분점수 문자열이 정확한지 체크 한다
	if UBound(Split(strOx, Q_GUBUN)) <> lngQCount -1 Or UBound(Split(strPoints, Q_GUBUN)) <> lngQCount -1 Then
		Response.Write "채점 및 부분점수 생성중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요"
		Response.End
	End if
		
	Call Rst_Close

	SQL = ""
	SQL = SQL & "Update exam_ans "
	SQL = SQL & "Set oxs = '" & strOx & "', points = '" & strPoints & "', score = " & sngNewScore & " "
	SQL = SQL & "Where userid = '" & userid(i) & "' and id_exam = '" & id_exam & "' "
		
	Cnn.Execute SQL
		
	if Err.Number <> 0 Then
		Response.Write "점수를 반영하던중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요<br>"
		Response.Write Err.Description
		Response.End
	End If
	
	' 채점이 완료된 응시자는 채점 완료 페이지로 이동 시킨다.
	SQL = ""
	SQL = SQL & "Update imsi_exam_ans_result "
	SQL = SQL & "Set score = "& sngScore &", score_yn = 'Y' "
	SQL = SQL & "Where id_exam = '" & id_exam & "' and id_q = '"& id_q &"' and userid = '" & userid(i) & "' "
		
	Cnn.Execute SQL
		
	if Err.Number <> 0 Then
		Response.Write "채점 완료 모드 변경중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요<br>"
		Response.Write Err.Description
		Response.End
	End If

	Next
		
	Call Cnn_Close
%>

<script language="javascript">
	window.close();
	window.opener.location.reload();
</script>
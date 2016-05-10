<!--#include file="../common/ADO.asp" -->
<!--#include file="../paper/common.asp" -->
<%
	Response.CacheControl = "no-cache" 
	Response.AddHeader "pragma", "no-cache" 
	Response.Expires = -1
	
	strLogin = Request("id")
	id_exam = Request("id_exam")
	id_q = Request("id_q")
	userid = Request("userid")
	name = Request("name")
	sngScore = Request("score")
	lngPos = Request("pos")
	sngAllotting = Request("allotting")
	iType = Request("itype")

	comment = Request("comment")

	CChk = CNN_OPEN("qmtmdb")
	
	if CChk = -1 then
		Response.Write "데이터베이스에 연결하던중 오류가 발생 하였습니다<br><br>담당자에게 문의 하십시요"
		Response.End
	End If
	
	Dim strQ, strCa, lngQCount, strAnswer, strExplain
	
	strQ = ""
	strCa = ""
	lngQCount = 0
	strAnswer = ""
	strExplain = ""

	'논술형 문제 답안에 대한 강평을 가지고 온다.
	SQL = ""
	SQL = SQL & "Select score_comment "
	SQL = SQL & "From exam_ans_comment "
	SQL = SQL & "Where id_q = " & id_q & " and userid = '" & userid & "' and id_exam = '" & id_exam & "' "

	Chk = Rst_Open(SQL, "R")
	
	If Rst.eof Then
		score_comment = ""
	else
		score_comment = Rst("score_comment")
	End if
		
	Call Rst_Close()
	
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

	if iType = "" Then
		'해당 시험의 문제 및 정답을 읽어온다
		SQL = ""
		SQL = SQL & "Select q, ca, explain "
		SQL = SQL & "From q "
		SQL = SQL & "Where id_q = " & id_q
		
		Chk = Rst_Open(SQL, "R")
		
		strQ = Rst("q")
		strCa = Rst("ca")
		strExplain = Rst("explain")
		
		Call Rst_Close
		
		'응시자가 작성한 답안을 읽어온다
		SQL = ""
		SQL = SQL & "Select isnull(userans1, ''), isnull(userans2, ''), isnull(userans3, '') "
		SQL = SQL & "From exam_ans_non "
		SQL = SQL & "Where id_q = " & id_q & " and userid = '" & userid & "' and id_exam = '" & id_exam & "' "
				
		Chk = Rst_Open(SQL, "R")
		
		if Rst.Eof Then
			Response.Write "논술형 답안이 존재 하지 않습니다"
			Response.End
		End if
	
		strAnswer = Replace(Rst(0) & Rst(1) & Rst(2), vbCrlf, "<br>")

		Call Rst_Close()
		Call Cnn_Close()
		
		iType = "u"
	Elseif iType = "u" Then

	'=====================================================
	'논술형 문제 강평을 작성 한다
	'=====================================================
		
		SQL = ""
		SQL = SQL & "Select score_comment "
		SQL = SQL & "From exam_ans_comment "
		SQL = SQL & "Where id_exam = '"& id_exam &"' and userid = '"& userid &"' and id_q = '"& id_q &"' "

		Chk = Rst_Open(SQL, "R")

		If Rst.Eof Then 
			SQL = ""
			SQL = SQL & "Insert into exam_ans_comment(id_exam, userid, id_q, score_comment, "
			SQL = SQL & "       reg_id, regdate) " 
			SQL = SQL & "Values('"& id_exam &"', '"& userid &"', '"& id_q &"', '"& comment &"', "
			SQL = SQL & "       '"& Session("userid") &"', getdate()) "
		Else
			score_comment = Rst("score_comment")
			SQL = SQL & "Update exam_ans_comment set score_comment = '"& comment &"', "
			SQL = SQL &	"       up_id = '"& Session("userid") &"', up_date = getdate() "
			SQL = SQL & "Where id_exam = '"& id_exam &"' and userid = '"& userid &"' and id_q = '"& id_q &"' "
		End If
		
		Cnn.Execute SQL
		
		if Err.Number <> 0 Then
			Response.Write "논술형 문제 강평작성 중 오류가 발생했습니다. 잠시 후 다시 시도해 주십시요<br>"
			Response.Write Err.Description
			Response.End
		End If
		
		Call Rst_Close
	
		
		'=====================================================
		'논술형 점수를 업데이트 한다
		'=====================================================

		'형변환
		sngScore = CSng(sngScore)
		sngAllotting = CSng(sngAllotting)
		
		if sngScore < 0 Then
			Response.Write "부분점수는 0 미만으로 부여할 수 없습니다"
			Response.End
		End if
		
		strMark = ""
		if sngScore > sngAllotting Then
			Response.Write "배점보다 부분점수를 높게 입력할 수 없습니다"
			Response.End
		Elseif sngScore = sngAllotting Then
			strMark = "O"
		Elseif sngScore = 0 Then
			strMark = "X"
		Else
			strMark = "P"
		End if

		On Error Resume Next
		SQL = ""
		SQL = SQL & "Select oxs, isnull(points, '') points, score "
		SQL = SQL & "From exam_ans "
		SQL = SQL & "Where userid = '" & userid & "' and id_exam = '" & id_exam & "' "
		
		Chk = Rst_Open(SQL, "R")

		if Err.Number <> 0 Then
			Response.Write "데이터를 읽던 중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요<br>"
			Response.Write Err.Description
			Response.End
		End if
		
		Dim tmpOxs, tmpPoints, oldPoint, sngAddPoint, sngNewScore
		if Rst("points") = "" Then
			ReDim tmpPoints(lngQCount -1)
		Else
			tmpPoints = Split(Rst("points"), Q_GUBUN)
		End if

		if Err.Number <> 0 Then
			Response.Write "1. 데이터 처리 중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요<br>"
			Response.Write Err.Description
			Response.End
		End if
		
		tmpOxs = Split(Rst("oxs"), Q_GUBUN)
		
		'만들어진 배열의 갯수가 정확한지 확인한다
		if UBound(tmpOxs) + 1 <> lngQCount Or UBound(tmpPoints) + 1 <> lngQCount Then
			Response.Write "부분점수 채점 정보가 잘못되었습니다<br>관리자에게 문의 하십시요"
			Response.End
		End if
		
		if Trim(lngPos) = "" Then
			Response.Write "문제 위치정보를 찾던중 오류가 발생 하였습니다<br>잠시 후 다시 시도해 주십시요"
			Response.End
		End if
		
		if tmpPoints(lngPos) = "" Then
			oldPoint = 0
		Else
			oldPoint = CSng(tmpPoints(lngPos))
		End if
		
		'채점 정보와 부분점수 정보를 배열의 위치를 찾아 넣어준다
		tmpOxs(lngPos) = strMark
		tmpPoints(lngPos) = sngScore
		
		'이전 부분점수와 비교하여 증감된 부분만큼을 총점에 더한다
		sngAddPoint = 0
		if oldPoint > sngScore Then
			'이전 점수가 현재 점수 보다 크므로 총점을 감점 시켜야 한다
			sngAddPoint = (oldPoint - sngScore) * (-1)
		Else
			sngAddPoint = sngScore - oldPoint
		End if
		
		sngNewScore = CSng(Rst("score")) + sngAddPoint
		
		'새로운 점수가 제대로 계산되었는지 체크한다
		if sngNewScore > CSng(Rst("score")) + sngScore Or sngNewScore < CSng(Rst("score")) - oldPoint Then
			Response.Write "총점 계산중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요"
			Response.End
		End if
		
		strOx = Join(tmpOxs, Q_GUBUN)
		strPoints = Join(tmpPoints, Q_GUBUN)
		
		'점수를 업데이트 하기 전에 채점 문자열 및 부분점수 문자열이 정확한지 체크 한다
		if UBound(Split(strOx, Q_GUBUN)) <> lngQCount -1 Or UBound(Split(strPoints, Q_GUBUN)) <> lngQCount -1 Then
			Response.Write "채점 및 부분점수 생성중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요"
			Response.End
		End if

		if Err.Number <> 0 Then
			Response.Write "2. 데이터를 처리 중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요<br>"
			Response.Write Err.Description
			Response.End
		End if
		
		Call Rst_Close()

		SQL = ""
		SQL = SQL & "Update exam_ans "
		SQL = SQL & "Set oxs = '" & strOx & "', points = '" & strPoints & "', score = " & sngNewScore & " "
		SQL = SQL & "Where userid = '" & userid & "' and id_exam = '" & id_exam & "' "
		
		Cnn.Execute SQL
		
		if Err.Number <> 0 Then
			Response.Write "점수를 반영하던중 오류가 발생 하였습니다. 잠시 후 다시 시도해 주십시요<br>"
			Response.Write Err.Description
			Response.End
		End if
        
		Call Cnn_Close()

		'점수가 정상적으로 반영되었다면 좌측 화면에 반영된 점수를 표시하여 준다
		strJavaScript = ""
		strJavaScript = strJavaScript & "<script language=javascript>"
		strJavaScript = strJavaScript & "top.left.document.all.score" & userid & ".innerText = " & sngScore & ";"		
		strJavaScript = strJavaScript & "</script>"

		Response.Write "<br><br><b><font size=2 color=blue>&nbsp;&nbsp;&nbsp;&nbsp;점수가 정상적으로 반영 되었습니다</font></b>"
		Response.Write strJavaScript
		Response.End
	End If
	
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">

<Script Language="JavaScript">
	function ftnScore() {
		var score = document.frmData.txtscore.value;

		if (score == "") {
			alert("점수를 입력하지 않았습니다");
			return;
		}
		
		if (score > <%= sngAllotting %>) {
			alert("문제의 배점은 " + <%= sngAllotting %> + "점 입니다\n배점보다 점수를 높게 입력할 수 없습니다");
			return;
		}
		
		document.frmData.score.value = score;
		document.frmData.submit();
	}
</Script>
</head>

<body style="margin: 0px 30px 40px 20px;" oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">
<form name="frmData" method="post" target="_self">
<input type="hidden" name="id_exam" value="<%= id_exam %>">
<input type="hidden" name="pos" value="<%= lngPos %>">
<input type="hidden" name="userid" value="<%= userid %>">
<input type="hidden" name="allotting" value="<%= sngAllotting %>">
<input type="hidden" name="score" value="<%= sngScore %>">
<input type="hidden" name="id_q" value="<%= id_q %>">
<input type="hidden" name="itype" value="<%= iType %>">

<img src="../images/sub2_webscore1.gif">
<div class="box">
	<%= name %> [ID: <%= userid %>] 님의 답안<br>
	[문제코드 <%= id_q %>] <%= strQ %> [배점 <%= sngAllotting %> 점]<br>
	[해설(채점기준)] <%= strExplain %>
</div>
<hr>
<!-- 응시자 답안 -->
<img src="../images/sub2_webscore8.gif"><br>
<div class="box"><%= strAnswer %></div>


<!-- 채점자 강평 -->
<hr><img src="../images/sub2_webscore9.gif"><br>
<textarea cols="70" rows="5" name="comment" style="width: 450px;"><%=score_comment%></textarea>

<!-- 채점 -->
<hr><img src="../images/sub2_webscore7.gif"><br>
<input type="text" name="txtscore" size="5" maxlength="5" style="text-align:right"> 점 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img type="button" value=" 확인 " src="../images/bt3_mark2.gif" onclick="javscript:ftnScore();" style="cursor: pointer;">
</form>
</body>
</html>

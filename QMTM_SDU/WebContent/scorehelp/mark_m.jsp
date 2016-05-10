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
		Response.Write "�����ͺ��̽��� �����ϴ��� ������ �߻� �Ͽ����ϴ�<br><br>����ڿ��� ���� �Ͻʽÿ�"
		Response.End
	End If
	
	Dim strQ, strCa, lngQCount, strAnswer, strExplain
	
	strQ = ""
	strCa = ""
	lngQCount = 0
	strAnswer = ""
	strExplain = ""

	'����� ���� ��ȿ� ���� ������ ������ �´�.
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
	
	'�ش� ������ �������� �������� �о�´�
	SQL = ""
	SQL = SQL & "Select qcount, setcount "
	SQL = SQL & "From exam_m "
	SQL = SQL & "Where id_exam = '" & id_exam & "' "

	Chk = Rst_Open(SQL, "R")
	
	if Rst.Eof Then
		Response.Write "���� ������ ���� ���� �ʽ��ϴ�. �����ڿ��� ���� �Ͻʽÿ�"
		Response.End
	End if
		
	lngQCount = Rst("qcount")
	
	Call Rst_Close

	if iType = "" Then
		'�ش� ������ ���� �� ������ �о�´�
		SQL = ""
		SQL = SQL & "Select q, ca, explain "
		SQL = SQL & "From q "
		SQL = SQL & "Where id_q = " & id_q
		
		Chk = Rst_Open(SQL, "R")
		
		strQ = Rst("q")
		strCa = Rst("ca")
		strExplain = Rst("explain")
		
		Call Rst_Close
		
		'�����ڰ� �ۼ��� ����� �о�´�
		SQL = ""
		SQL = SQL & "Select isnull(userans1, ''), isnull(userans2, ''), isnull(userans3, '') "
		SQL = SQL & "From exam_ans_non "
		SQL = SQL & "Where id_q = " & id_q & " and userid = '" & userid & "' and id_exam = '" & id_exam & "' "
				
		Chk = Rst_Open(SQL, "R")
		
		if Rst.Eof Then
			Response.Write "����� ����� ���� ���� �ʽ��ϴ�"
			Response.End
		End if
	
		strAnswer = Replace(Rst(0) & Rst(1) & Rst(2), vbCrlf, "<br>")

		Call Rst_Close()
		Call Cnn_Close()
		
		iType = "u"
	Elseif iType = "u" Then

	'=====================================================
	'����� ���� ������ �ۼ� �Ѵ�
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
			Response.Write "����� ���� �����ۼ� �� ������ �߻��߽��ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
			Response.Write Err.Description
			Response.End
		End If
		
		Call Rst_Close
	
		
		'=====================================================
		'����� ������ ������Ʈ �Ѵ�
		'=====================================================

		'����ȯ
		sngScore = CSng(sngScore)
		sngAllotting = CSng(sngAllotting)
		
		if sngScore < 0 Then
			Response.Write "�κ������� 0 �̸����� �ο��� �� �����ϴ�"
			Response.End
		End if
		
		strMark = ""
		if sngScore > sngAllotting Then
			Response.Write "�������� �κ������� ���� �Է��� �� �����ϴ�"
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
			Response.Write "�����͸� �д� �� ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
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
			Response.Write "1. ������ ó�� �� ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
			Response.Write Err.Description
			Response.End
		End if
		
		tmpOxs = Split(Rst("oxs"), Q_GUBUN)
		
		'������� �迭�� ������ ��Ȯ���� Ȯ���Ѵ�
		if UBound(tmpOxs) + 1 <> lngQCount Or UBound(tmpPoints) + 1 <> lngQCount Then
			Response.Write "�κ����� ä�� ������ �߸��Ǿ����ϴ�<br>�����ڿ��� ���� �Ͻʽÿ�"
			Response.End
		End if
		
		if Trim(lngPos) = "" Then
			Response.Write "���� ��ġ������ ã���� ������ �߻� �Ͽ����ϴ�<br>��� �� �ٽ� �õ��� �ֽʽÿ�"
			Response.End
		End if
		
		if tmpPoints(lngPos) = "" Then
			oldPoint = 0
		Else
			oldPoint = CSng(tmpPoints(lngPos))
		End if
		
		'ä�� ������ �κ����� ������ �迭�� ��ġ�� ã�� �־��ش�
		tmpOxs(lngPos) = strMark
		tmpPoints(lngPos) = sngScore
		
		'���� �κ������� ���Ͽ� ������ �κи�ŭ�� ������ ���Ѵ�
		sngAddPoint = 0
		if oldPoint > sngScore Then
			'���� ������ ���� ���� ���� ũ�Ƿ� ������ ���� ���Ѿ� �Ѵ�
			sngAddPoint = (oldPoint - sngScore) * (-1)
		Else
			sngAddPoint = sngScore - oldPoint
		End if
		
		sngNewScore = CSng(Rst("score")) + sngAddPoint
		
		'���ο� ������ ����� ���Ǿ����� üũ�Ѵ�
		if sngNewScore > CSng(Rst("score")) + sngScore Or sngNewScore < CSng(Rst("score")) - oldPoint Then
			Response.Write "���� ����� ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�"
			Response.End
		End if
		
		strOx = Join(tmpOxs, Q_GUBUN)
		strPoints = Join(tmpPoints, Q_GUBUN)
		
		'������ ������Ʈ �ϱ� ���� ä�� ���ڿ� �� �κ����� ���ڿ��� ��Ȯ���� üũ �Ѵ�
		if UBound(Split(strOx, Q_GUBUN)) <> lngQCount -1 Or UBound(Split(strPoints, Q_GUBUN)) <> lngQCount -1 Then
			Response.Write "ä�� �� �κ����� ������ ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�"
			Response.End
		End if

		if Err.Number <> 0 Then
			Response.Write "2. �����͸� ó�� �� ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
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
			Response.Write "������ �ݿ��ϴ��� ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
			Response.Write Err.Description
			Response.End
		End if
        
		Call Cnn_Close()

		'������ ���������� �ݿ��Ǿ��ٸ� ���� ȭ�鿡 �ݿ��� ������ ǥ���Ͽ� �ش�
		strJavaScript = ""
		strJavaScript = strJavaScript & "<script language=javascript>"
		strJavaScript = strJavaScript & "top.left.document.all.score" & userid & ".innerText = " & sngScore & ";"		
		strJavaScript = strJavaScript & "</script>"

		Response.Write "<br><br><b><font size=2 color=blue>&nbsp;&nbsp;&nbsp;&nbsp;������ ���������� �ݿ� �Ǿ����ϴ�</font></b>"
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
			alert("������ �Է����� �ʾҽ��ϴ�");
			return;
		}
		
		if (score > <%= sngAllotting %>) {
			alert("������ ������ " + <%= sngAllotting %> + "�� �Դϴ�\n�������� ������ ���� �Է��� �� �����ϴ�");
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
	<%= name %> [ID: <%= userid %>] ���� ���<br>
	[�����ڵ� <%= id_q %>] <%= strQ %> [���� <%= sngAllotting %> ��]<br>
	[�ؼ�(ä������)] <%= strExplain %>
</div>
<hr>
<!-- ������ ��� -->
<img src="../images/sub2_webscore8.gif"><br>
<div class="box"><%= strAnswer %></div>


<!-- ä���� ���� -->
<hr><img src="../images/sub2_webscore9.gif"><br>
<textarea cols="70" rows="5" name="comment" style="width: 450px;"><%=score_comment%></textarea>

<!-- ä�� -->
<hr><img src="../images/sub2_webscore7.gif"><br>
<input type="text" name="txtscore" size="5" maxlength="5" style="text-align:right"> �� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img type="button" value=" Ȯ�� " src="../images/bt3_mark2.gif" onclick="javscript:ftnScore();" style="cursor: pointer;">
</form>
</body>
</html>

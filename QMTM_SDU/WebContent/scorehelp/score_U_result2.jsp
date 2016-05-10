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
		Call MsgWindow("����Ÿ���̽� ���ῡ �����߽��ϴ�.")
		Response.End
	End if			
	
	'�ش� ������ �������� �������� �о�´�
	SQL = ""
	SQL = SQL & "Select qcount, setcount "
	SQL = SQL & "From exam_m "
	SQL = SQL & "Where id_exam = '" & id_exam & "' "

	Chk = Rst_Open(SQL, "R")
	
	lngQCount = Rst("qcount")
	
	Call Rst_Close

	userid = ""
	'�ش� ����� �����ڸ� �о�´�.
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
			
	' �ش� ����� ������ ����ŭ �ݺ��Ѵ�.
	For i = 0 To UBound(userid)
		
	On Error Resume Next
	SQL = ""
	SQL = SQL & "Select a.oxs, isnull(a.points, '') points, a.score, b.nr_q, b.allotting "
	SQL = SQL & "From exam_ans a, exam_paper2 b " 
	SQL = SQL & "Where a.id_exam='"& id_exam &"' and a.userid='"& userid(i) &"' and "
	SQL = SQL & "      b.id_q = '"& id_q &"' and a.id_exam = b.id_exam and a.nr_set = b.nr_set "

	Chk = Rst_Open(SQL, "R")

	if Err.Number <> 0 Then
		Response.Write "�����͸� �д� �� ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
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

	'������� �迭�� ������ ��Ȯ���� Ȯ���Ѵ�
	if UBound(tmpOxs) + 1 <> lngQCount Or UBound(tmpPoints) + 1 <> lngQCount Then
		Response.Write "�κ����� ä�� ������ �߸��Ǿ��ų� �ڵ�ä�� �� �����Դϴ�.<br>�켱 TMAN ���� �ڵ�ä���� �������ֽñ� �ٶ��ϴ�."
		Response.End
	End if

	oldPoint = CSng(tmpPoints(nr_q-1))	
		
	'ä�� ������ �κ����� ������ �迭�� ��ġ�� ã�� �־��ش�
	tmpOxs(nr_q-1) = strMark
	tmpPoints(nr_q-1) = sngScore
		
	'���� �κ������� ���Ͽ� ������ �κи�ŭ�� ������ ���Ѵ�
	sngAddPoint = 0
	if oldPoint > sngScore Then
		'���� ������ ���� ���� ���� ũ�Ƿ� ������ ���� ���Ѿ� �Ѵ�
		sngAddPoint = (oldPoint - sngScore) * (-1)
	Else
		sngAddPoint = sngScore - oldPoint
	End if
		
	sngNewScore = CSng(Rst("score")) + sngAddPoint
	strOx = Join(tmpOxs, Q_GUBUN)
	strPoints = Join(tmpPoints, Q_GUBUN)
		
	'������ ������Ʈ �ϱ� ���� ä�� ���ڿ� �� �κ����� ���ڿ��� ��Ȯ���� üũ �Ѵ�
	if UBound(Split(strOx, Q_GUBUN)) <> lngQCount -1 Or UBound(Split(strPoints, Q_GUBUN)) <> lngQCount -1 Then
		Response.Write "ä�� �� �κ����� ������ ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�"
		Response.End
	End if
		
	Call Rst_Close

	SQL = ""
	SQL = SQL & "Update exam_ans "
	SQL = SQL & "Set oxs = '" & strOx & "', points = '" & strPoints & "', score = " & sngNewScore & " "
	SQL = SQL & "Where userid = '" & userid(i) & "' and id_exam = '" & id_exam & "' "
		
	Cnn.Execute SQL
		
	if Err.Number <> 0 Then
		Response.Write "������ �ݿ��ϴ��� ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
		Response.Write Err.Description
		Response.End
	End If
	
	' ä���� �Ϸ�� �����ڴ� ä�� �Ϸ� �������� �̵� ��Ų��.
	SQL = ""
	SQL = SQL & "Update imsi_exam_ans_result "
	SQL = SQL & "Set score = "& sngScore &", score_yn = 'Y' "
	SQL = SQL & "Where id_exam = '" & id_exam & "' and id_q = '"& id_q &"' and userid = '" & userid(i) & "' "
		
	Cnn.Execute SQL
		
	if Err.Number <> 0 Then
		Response.Write "ä�� �Ϸ� ��� ������ ������ �߻� �Ͽ����ϴ�. ��� �� �ٽ� �õ��� �ֽʽÿ�<br>"
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
<%
//******************************************************************************
//   ���α׷� : non_mark.jsp
//   �� �� �� : ���׺� ������ ä��
//   ��    �� : ���׺� ������ ä��
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-06-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.* " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String lngScore = request.getParameter("score");
    if (lngScore == null) { lngScore = ""; } else { lngScore = lngScore.trim(); }
    
	if (id_exam.length() == 0 || id_q.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String lngPos = request.getParameter("pos");
    double ExamAllotting = 0;
    int nr_q = 0;
    String old_score;
	Double tmpScore;
    String iType = "";   

	// �ش� ������ �������� �������� �о�´�
	int qcount = 0;

	try {
		qcount = AnswerMarkNon.getQcount(id_exam);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	// �ش� ������ ���� ����, ����, �ؼ��� ��ȸ�Ѵ�.
	AnswerMarkNonBean rst = null;

	try {
		rst = AnswerMarkNon.getBean2(id_q);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}	

	String strQ = rst.getQ();
	String strCa = rst.getCa();
	String strExplain = ComLib.nullChk(rst.getExplain());

	// �ش� ������ ���� ������ ����� �о�´�.
	AnswerMarkNonBean ans = null;

	try {
		ans = AnswerMarkNon.getAnswer(id_q, userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
	String userans1 = ComLib.nullChk(ans.getUserans1());
	String userans2 = ComLib.nullChk(ans.getUserans2());
	String userans3 = ComLib.nullChk(ans.getUserans3());

	String userans = userans1.trim() + userans2.trim() + userans3.trim();
	
	// �ش� ������ ���׺� ����ä�� ��ȸ�Ѵ�.
	AnswerMarkNonBean rst2 = null;

	try {
		rst2 = AnswerMarkNon.getBean3(id_q, userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	ExamAllotting = rst2.getAllotting();
    nr_q = rst2.getNr_q();      
    old_score = String.valueOf(rst2.getScore()); // ������ ä�� ����   

    String oxs = rst2.getOxs();
    String points = rst2.getPoints();
	
	if(points == null || points.equals("")) {
		for (int j = 0; j < qcount; j++) {
			points = points + "{:}";
		}

		points = points.substring(0, points.length()-3);
	} else {
		points = rst2.getPoints();
	}
		

    String[] ArrOxs = oxs.split(QmTm.Q_GUBUN_re, -1);
    String[] ArrPoints = points.split(QmTm.Q_GUBUN_re, -1);         

    if (ArrOxs.length != ArrPoints.length) {
%>
	<script language="JavaScript">
		alert("OXS �� POINTS �� ������ �ٸ��ϴ�");
	</script>
<%
		if(true) return;
    }
	
	// ������ ����ä�� ����
    if(lngScore.length() > 0) {     

        String ox;
        if(ExamAllotting == Double.parseDouble(lngScore)) { // lngScore �� ���� ����, Ʋ��, �κ����� ����
			ox = "O";
		} else if(Double.parseDouble(lngScore) == 0.0) {
		    ox = "X";
		} else {
		    ox = "P";
		}

        ArrOxs[nr_q - 1] = ox;          

        double tmpScore2 = ComLib.nullChkDbl(ArrPoints[nr_q - 1]);  // ������ ����� ������ ������ �´�.

        double add_point = 0; 
        if(tmpScore2 > Double.parseDouble(lngScore)) {
		   add_point = (tmpScore2 - Double.parseDouble(lngScore)) * -1;
        } else {
           add_point = Double.parseDouble(lngScore) - tmpScore2;
        }

		oxs = QmTm.join(ArrOxs, QmTm.Q_GUBUN);

        ArrPoints[nr_q - 1] = "" + lngScore;			   
        points = QmTm.join(ArrPoints, QmTm.Q_GUBUN);
        
        double score = Double.parseDouble(old_score) + add_point;

		AnswerMarkNonBean beans = new AnswerMarkNonBean();

		beans.setOxs(oxs);	
		beans.setPoints(points);	
		beans.setScore(score);	

		try {
			AnswerMarkNon.updateNon(id_exam, userid, beans);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		// ������ ���������� �ݿ��Ǿ��ٸ� ���� ȭ�鿡 �ݿ��� ������ ǥ���Ͽ� �ش�
		StringBuffer strJavaScript = new StringBuffer();
		strJavaScript.append("<script language=javascript>");
		strJavaScript.append("top.frames('fraLeft').document.all.score" + userid + ".innerText = " + lngScore + ";") ;		
		strJavaScript.append("</script>");   

        out.println(strJavaScript); 
	}
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<Script Language="JavaScript">
	function doCorrect()
	{
		document.frmData.txtscore.value = "<%= ExamAllotting %>";
		ftnScore();
	}

	function doInCorrect()
	{
	    document.frmData.txtscore.value = "0.0";
		ftnScore();
	}
	
	function ftnScore() {
		var score = document.frmData.txtscore.value;

		if (score == "") {
			alert("������ �Է����� �ʾҽ��ϴ�");
			return;
		}
		
		if (score > <%= ExamAllotting %>) {
			alert("������ ������ " + <%= ExamAllotting %> + "�� �Դϴ�\n�������� ������ ���� �Է��� �� �����ϴ�");
			return;
		}
		
		document.frmData.score.value = score;
		document.frmData.submit();
	}
</Script>
</head>

<body style="margin: 0px 30px 40px 20px;">
<form name="frmData" method="post" target="_self">
<input type="hidden" name="id_exam" value="<%= id_exam %>">
<input type="hidden" name="pos" value="<%= lngPos %>">
<input type="hidden" name="userid" value="<%= userid %>">
<input type="hidden" name="score" value="<%= lngScore %>">
<input type="hidden" name="id_q" value="<%= id_q %>">
<input type="hidden" name="iType" value="u">

<img src="../../images/sub2_webscore1.gif">
<div class="box">
	<%= userid %> ���� ���<br>
	[�����ڵ� <%= id_q %>] <%= strQ %> [���� <%= ExamAllotting %> ��]<br>
	[�ؼ�(ä������)] <%= strExplain %>
</div>
<hr>
<!-- ������ ��� -->
<img src="../../images/sub2_webscore8.gif">&nbsp;&nbsp;&nbsp;<b>[��ȱ��� : <%= userans.length() %>]</b><br>
<div class="box"><textarea cols="80" rows="15"><%= userans %></textarea></div>

<!-- ä�� -->
<hr><img src="../../images/sub2_webscore7.gif"><br>
<div style="float: left">
<img onclick="doCorrect()" src="../../images/bt3_true.gif" style="cursor: hand;">&nbsp;
<img onclick="doInCorrect()" src="../../images/bt3_false.gif" style="cursor: hand;"> &nbsp;
</div>
<div style="float: left">
<input type="text" class="input" name="txtscore" size="6" maxlength="5" onclick="this.select()" style="text-align: center;"> ��
</div>
<div style="float: left">
&nbsp;<img onclick="ftnScore()" src="../../images/bt3_mark3.gif" style="cursor: hand;">
</div>

</form>
</body>
</html>
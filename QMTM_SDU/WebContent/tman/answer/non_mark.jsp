<%
//******************************************************************************
//   프로그램 : non_mark.jsp
//   모 듈 명 : 문제별 논술형 채점
//   설    명 : 문제별 논술형 채점
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-06-02
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.* " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String lngScore = request.getParameter("score");
    if (lngScore == null) { lngScore = ""; } else { lngScore = lngScore.trim(); }
    
	if (id_exam.length() == 0 || id_q.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("fclose"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String comments = request.getParameter("score_comment");

	String lngPos = request.getParameter("pos");
    double ExamAllotting = 0;
    int nr_q = 0;
    String old_score;
	Double tmpScore;
    String iType = "";   

	int nonCnt = 0;

	try {
		nonCnt = AnswerMarkNon.userNonCnt(id_exam, id_q, userid);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "fclose"));

		if(true) return;
	}

	if(nonCnt == 0) {

		try {
			AnswerMarkNon.userNonInsert(id_exam, id_q, userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "fclose"));

			if(true) return;
		}

	}
	
	// 해당 시험의 시험지의 문제수를 읽어온다
	int qcount = 0;

	try {
		qcount = AnswerMarkNon.getQcount(id_exam);	
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "fclose"));

		if(true) return;
	}

	// 해당 논술형 문제 문제, 정답, 해설을 조회한다.
	AnswerMarkNonBean rst = null;

	try {
		rst = AnswerMarkNon.getBean2(id_q);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "fclose"));

		if(true) return;
	}	

	String strQ = rst.getQ();
	String strCa = rst.getCa();
	String strExplain = ComLib.nullChk(rst.getExplain());
	
	// 해당 논술형 문제별 수동채점 조회한다.
	AnswerMarkNonBean rst2 = null;

	try {
		rst2 = AnswerMarkNon.getBean3(id_q, userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "fclose"));

		if(true) return;
	}

	ExamAllotting = rst2.getAllotting();
    nr_q = rst2.getNr_q();      
    old_score = String.valueOf(rst2.getScore()); // 응시자 채점 점수   

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
		alert("OXS 와 POINTS 의 개수가 다릅니다");
	</script>
<%
		if(true) return;
    }
	
	// 논술형 수동채점 시작
    if(lngScore.length() > 0) {     

        String ox;
        if(ExamAllotting == Double.parseDouble(lngScore)) { // lngScore 에 따라서 맞음, 틀림, 부분점수 구분
			ox = "O";
		} else if(Double.parseDouble(lngScore) == 0.0) {
		    ox = "X";
		} else {
		    ox = "P";
		}

        ArrOxs[nr_q - 1] = ox;          

        double tmpScore2 = ComLib.nullChkDbl(ArrPoints[nr_q - 1]);  // 이전에 저장된 점수를 가지고 온다.

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
		beans.setScore_comment(comments);

		try {
			AnswerMarkNon.updateNon(id_exam, id_q, userid, beans);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "fclose"));

			if(true) return;
		}

		try {
			AnswerMarkNon.userNonUpdate(id_exam, id_q, userid, Double.parseDouble(lngScore));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "fclose"));

			if(true) return;
		}

		// 서술형 문제 로그저장 시작
		StringBuffer bigos = new StringBuffer();

		bigos.append("응시자 : ");
		bigos.append(userid);
		bigos.append("문제코드 : ");
		bigos.append(id_q);
		bigos.append(", 점수 : ");
		bigos.append(lngScore);
		bigos.append("점");
		bigos.append(", 강평 : ");
		bigos.append(comments);
		bigos.append(", 응시자총점 : ");
		bigos.append(score);
		bigos.append("점");
		
		WorkExamLogBean logbean = new WorkExamLogBean();

		logbean.setId_exam(id_exam);	
		logbean.setUserid(adm_userid);
		logbean.setGubun("서술형채점");
		logbean.setId_q("");
		logbean.setBigo(bigos.toString());

		try {
			WorkExamLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
		// 서술형 문제 로그저장 종료


		// 점수가 정상적으로 반영되었다면 좌측 화면에 반영된 점수를 표시하여 준다
		StringBuffer strJavaScript = new StringBuffer();
		strJavaScript.append("<script language=javascript>");
		strJavaScript.append("top.fraLeft.document.all.score" + userid + ".innerText = " + lngScore + ";");
		strJavaScript.append("</script>");   

        out.println(strJavaScript); 
	}

	// 해당 논술형 문제 응시자 답안을 읽어온다.
	AnswerMarkNonBean ans = null;

	try {
		ans = AnswerMarkNon.getAnswer(id_q, userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "fclose"));

		if(true) return;
	}
	
	String userans1 = ComLib.nullChk(ans.getUserans1());
	String userans2 = ComLib.nullChk(ans.getUserans2());
	String userans3 = ComLib.nullChk(ans.getUserans3());

	String userans = userans1.trim() + userans2.trim() + userans3.trim();

	String score_comment = ComLib.nullChk(ans.getScore_comment());
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
			alert("점수를 입력하지 않았습니다");
			return;
		}
		
		if (score > <%= ExamAllotting %>) {
			alert("문제의 배점은 " + <%= ExamAllotting %> + "점 입니다\n배점보다 점수를 높게 입력할 수 없습니다");
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
	<%= userid %> 님의 답안<br>
	[문제코드 <%= id_q %>] <%= strQ %> [배점 <%= ExamAllotting %> 점]<br>
	[해설(채점기준)] <%= strExplain %>
</div>
<hr>
<!-- 응시자 답안 -->
<img src="../../images/sub2_webscore8.gif">
<div class="box"><textarea cols="100" rows="15" readonly><%= userans %></textarea></div>
<BR>
<img src="../../images/sub2_webscore9.gif">
<div class="box"><textarea cols="100" rows="8" name="score_comment"><%= score_comment %></textarea></div>

<!-- 채점 -->
<hr><img src="../../images/sub2_webscore7.gif"><br>
<div style="float: left">
<img onclick="doCorrect()" src="../../images/bt3_true.gif" style="cursor: pointer;">&nbsp;
<img onclick="doInCorrect()" src="../../images/bt3_false.gif" style="cursor: pointer;"> &nbsp;
</div>
<div style="float: left">
<input type="text" class="input" name="txtscore" size="6" maxlength="5" onclick="this.select()" style="text-align: center;"> 점
</div>
<div style="float: left">
&nbsp;<img onclick="ftnScore()" src="../../images/bt3_mark3.gif" style="cursor: pointer;">
</div>

</form>
</body>
</html>
<%
//******************************************************************************
//   프로그램 : ans_mark_dan.jsp
//   모 듈 명 : 단답형 수동채점
//   설    명 : 단답형 수동채점(미채점자 리스트)
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2008-06-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

    int i_tot_cnt  = 0;

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }
	
	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String[] userid = request.getParameterValues("selectid");
	String lngScore = request.getParameter("allscore");
    double ExamAllotting = 0;
    int nr_q = 0;
    String userid2 = "";
    String old_score;
	Double tmpScore;

	AnswerMarkDanBean beans = null;

	for(int i = 0; i < userid.length; i++) {
		try {
			beans = AnswerMarkDan.getBean(id_exam, userid[i], Long.parseLong(id_q));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		if(beans == null) {
            i_tot_cnt = 0;
        } else {
            i_tot_cnt = userid.length;
        }

        ExamAllotting = beans.getAllotting();
        nr_q = beans.getNr_q();
        old_score = String.valueOf(beans.getScore()); // 응시자 채점 점수   

        String oxs = beans.getOxs();
        String points = ComLib.nullChk(beans.getPoints());

		String[] ArrOxs = oxs.split(QmTm.Q_GUBUN_re, -1);
		String[] ArrPoints;
		
		if(points.equals("")) {
			ArrPoints = new String[ArrOxs.length];
		} else {
			ArrPoints = points.split(QmTm.Q_GUBUN_re, -1);
		}

        // 수동채점 점수 업데이트
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

		try {
			AnswerMarkDan.update(id_exam, userid[i], oxs, points, score);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
%>

<html>
<head>
<title>단답형 채점</title>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">
	function ftnRefresh() {
		opener.location.reload();
		window.close();
	}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;">
<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>

<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr> 
		<td align="center">
			<font color="blue"><b>점수가 정상적으로 반영 되었습니다</b></font><br><br>
		</td>
	</tr>
	<tr> 
		<td align="center">
			<input type="image" value=" 확인 " name="button"onclick="javascript:ftnRefresh();" src="../../images/bt_get_statics1_yj1.gif" align="absmiddle"><br><br>
			확인 버튼을 눌러 주세요
		</td>
	</tr>
</table>
</TD>
			<TD></TD>
		</TR>
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>
</body>
</html>
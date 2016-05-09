<%
//******************************************************************************
//   프로그램 : user_non_mark_up.jsp
//   모 듈 명 : 시험 논술형 문항 응시자별 채점
//   설    명 : 시험 논술형 문항 응시자별 채점
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2008-09-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String lngScore = request.getParameter("scores");
	if (lngScore == null) { lngScore = ""; } else { lngScore = lngScore.trim(); }
	
	if (id_exam.length() == 0 || id_q.length() == 0 || userid.length() == 0 || lngScore.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
    double ExamAllotting = 0;
    int nr_q = 0;
    String old_score;

	// 해당 논술형 문항별 수동채점 조회한다.
	AnswerMarkNonBean rst2 = null;

	try {
		rst2 = AnswerMarkNon.getBean3(id_q, userid, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	ExamAllotting = rst2.getAllotting();
    nr_q = rst2.getNr_q();      
    old_score = String.valueOf(rst2.getScore()); // 응시자 채점 점수   

    String oxs = rst2.getOxs();
    String points = rst2.getPoints();

	if(points == null || points.equals("")) {
%>
	<script language="JavaScript">
		alert("응시자 채점이 진행되지 않았습니다.\n\n수동채점을 하시기전에 답안지관리에서\n\n일괄채점 클릭하신후 선택한 응시자만 채점\n\n또는 모든 응시자 채점을 진행하셔야만\n\n수동채점을 진행하실 수 있습니다.");
	</script>
<%
		if(true) return;
	
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
		
		try {
			AnswerMarkNon.updateNon(id_exam, userid, beans);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}
%>

<Script language="JavaScript">
	location.href="user_non_mark.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
</Script>
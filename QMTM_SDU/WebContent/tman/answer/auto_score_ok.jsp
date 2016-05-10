<%
//******************************************************************************
//   프로그램 : auto_score_ok.jsp
//   모 듈 명 : 과락여부 설정
//   설    명 : 과락여부 설정
//   테 이 블 : 
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.answer.UserQScore, 
//              qmtm.tman.answer.UserQScoreBean, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean
//   작 성 일 : 2013-04-25
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.QmTm, qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.answer.UserQScore, qmtm.tman.answer.UserQScoreBean, qmtm.tman.answer.SubjYNChk, qmtm.tman.answer.SubjYNChkBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String success_score1 = request.getParameter("success_score1");
	if (success_score1 == null) { success_score1 = ""; } else { success_score1 = success_score1.trim(); }

	String success_score2 = request.getParameter("success_score2");
	if (success_score2 == null) { success_score2 = ""; } else { success_score2 = success_score2.trim(); }

	if (id_exam.length() == 0 || success_score1.length() == 0 || success_score2.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

	// 시험 Title 및 문제수 정보 가져오기	
	UserQScoreBean info = null;

	try {
	    info = UserQScore.getExamInfo(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	String title = info.getTitle();
	int qcount = info.getQcount();
	
	// 응시자별 답안 정보 가져오기
	UserQScoreBean[] rst = null;

	try {
	    rst = UserQScore.getOxs(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	if(rst == null) {
%>
<script language="javascript">
	alert("채점이 진행되지 않았습니다.\n채점을 완료한 후 다시 진행하시기 바랍니다.");
	window.close();
</script>				
<%		
		if(true) return;

	} else {

		// 과락정보 삭제
		try {
			SubjYNChk.delete(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		String[] arrAnswers;
		String[] arrOxs;
		String[] arrPoints;
		String[] arrUserid;
		String[] arrName;

		UserQScoreBean[] rst2 = null;

		for(int ans=0; ans<rst.length; ans++) {
			int nr_set = rst[ans].getNr_set();
			arrAnswers = rst[ans].getAnswers().split(QmTm.Q_GUBUN_re, -1);
			arrOxs = rst[ans].getOxs().split(QmTm.Q_GUBUN_re, -1);

			// 응시자별 시험지 정보를 가지고 온다.
			try {
				rst2 = UserQScore.getQinfo(id_exam, nr_set);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}

			String[] arrUserQ = new String[qcount];

			for(int qinfo=0; qinfo<qcount; qinfo++) {
				arrUserQ[qinfo] = String.valueOf(rst2[qinfo].getId_q());
			}
			
			String imsi_points = rst[ans].getPoints();
			
			if(imsi_points == null || imsi_points.equals("")) {
				for (int i = 0; i < qcount; i++) {
					imsi_points = imsi_points + "{:}";
				}

				imsi_points = imsi_points.substring(0, imsi_points.length()-3);
			} 

			arrPoints = imsi_points.split(QmTm.Q_GUBUN_re, -1);	

			double score1 = 0; // 필기형 점수
			double score2 = 0; // 실기형 점수

			String success_yn = "N";

			// 문제별 채점 결과를 만든다.
			for(int qinfo=0; qinfo<rst2.length; qinfo++) {				
				String result_ox = "";
				double result_score = 0;				
				
				if(arrOxs[rst2[qinfo].getNr_q()-1].equals("O")) {
					result_ox = "O";
					result_score = rst2[qinfo].getAllotting();

					if(rst2[qinfo].getYn_practice().equals("Y")) {
						score2 = score2 + rst2[qinfo].getAllotting();
					} else {
						score1 = score1 + rst2[qinfo].getAllotting(); 
					}

				} else if(arrOxs[rst2[qinfo].getNr_q()-1].equals("P")) {
					result_ox = "P";
					result_score = Double.parseDouble(arrPoints[rst2[qinfo].getNr_q()-1]);

					if(rst2[qinfo].getYn_practice().equals("Y")) {
						score2 = score2 + Double.parseDouble(arrPoints[rst2[qinfo].getNr_q()-1]);
					} else {
						score1 = score1 + Double.parseDouble(arrPoints[rst2[qinfo].getNr_q()-1]);
					}

				} else {
					result_ox = "X";
					result_score = 0;
				}
				
			} // 문제별 채점 for 문 종료
			
			if((score1 >= Double.parseDouble(success_score1)) && (score2 >= Double.parseDouble(success_score2))) {
				success_yn = "Y";
			} else {
				success_yn = "N";
			}

			try {
				SubjYNChk.insert(id_exam, rst[ans].getUserid(), rst[ans].getName(), String.valueOf(score1), String.valueOf(score2), String.valueOf(success_score1), String.valueOf(success_score2), success_yn);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}

		} // 응시자별 시험지 for 문 종료

	}
%>

<script language="javascript">
	alert("과락설정이 완료되었습니다.");
	location.href="auto_score.jsp?id_exam=<%=id_exam%>";
</script>

<%
//******************************************************************************
//   프로그램 : ans_insert_operate_ok.jsp
//   모 듈 명 : 답안지 DB 저장
//   설    명 : 답안지 DB 저장
//   테 이 블 : exam_paper2, q, q_ref
//   자바파일 : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon, qmtm.ExamPaper
//   작 성 일 : 2008-05-21
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

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String yn_end = request.getParameter("yn_end");
	if (yn_end == null) { yn_end = ""; } else { yn_end = yn_end.trim(); }
	
	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set = ""; } else { nr_set = nr_set.trim(); }
	
	String qcounts = request.getParameter("qcount");
	
	if (id_exam.length() == 0 || userid.length() == 0 || yn_end.length() == 0 || nr_set.length() == 0 || qcounts.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int qcount = Integer.parseInt(qcounts);
	
	// 시험정보를 읽어온다.
	ExamPaperBean[] qs = null;

	try {
		qs = ExamPaper.getBeans(id_exam, Integer.parseInt(nr_set));
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if (qs == null) {
%>
	<script language="JavaScript">
		alert("해당하는 문제정보가 없습니다");
	</script>
<%
		if(true) return;
	}
	if (qs.length != qcount) {
%>
	<script language="JavaScript">
		alert("시험정보의 문제수와 문제지의 문제수가 다릅니다");
	</script>
<%
		if(true) return;
	}

	// 문제별 표시를 위한 데이터

	int[] arrId_qtype = new int[qcount];
	String[] ex_order = new String[qcount];
	int[] arrCacount = new int[qcount]; // 정답 갯수

	String answer_ans = "";

	// looping

	for (int i = 0; i < qcount; i++)
	{
		ex_order[i] = qs[i].getEx_order();
		String[] arrEx_order = ex_order[i].split(",",-1);

		if(qs[i].getId_qtype() <= 3) {
			if(qs[i].getCacount() > 1) {
				
				String[] answers = request.getParameterValues("ans"+i);
				String arrAns = "";

				if(answers == null) {
					arrAns = "";
				} else {
					for(int j = 0; j < answers.length; j++) {
						arrAns = arrAns + arrEx_order[Integer.parseInt(answers[j])-1] + QmTm.OR_GUBUN;
					}
					arrAns = arrAns.substring(0,(arrAns.length()-3));
				}

				answer_ans = answer_ans + arrAns + QmTm.Q_GUBUN;
			} else {
				String answer = request.getParameter("ans"+i);
				answer_ans = answer_ans + arrEx_order[Integer.parseInt(answer)-1] + QmTm.Q_GUBUN;
			}
		} else if(qs[i].getId_qtype() == 4) { // 단답형

			if(qs[i].getCacount() > 1) {
				
				String[] answers = request.getParameterValues("ans"+i);
				String arrAns = "";

				for(int j = 0; j < qs[i].getCacount(); j++) {
					if(j+1 == qs[i].getCacount()) {
						arrAns = arrAns + answers[j];
					} else {
						arrAns = arrAns + answers[j] + QmTm.OR_GUBUN;
					}
				}

				answer_ans = answer_ans + arrAns + QmTm.Q_GUBUN;
			} else {
				String answer = request.getParameter("ans"+i);
				answer_ans = answer_ans + answer + QmTm.Q_GUBUN;
			}

		} else if(qs[i].getId_qtype() == 5) { // 논술형

			  String answer = request.getParameter("ans"+i);

			  ExamAnswerNonBean non = new ExamAnswerNonBean();

			  StringBuffer buf = new StringBuffer(answer);
			  String anstmp1,anstmp2, anstmp3;

			  if (buf.length() <= 2000) {
			    anstmp1 = buf.substring(0); anstmp2 = ""; anstmp3 = "";
			  } else if (buf.length() <= 4000) {
			    anstmp1 = buf.substring(0, 2000);
			    anstmp2 = buf.substring(2000);
			    anstmp3 = "";
			  } else {
			    anstmp1 = buf.substring(0, 2000);
			    anstmp2 = buf.substring(2000, 4000);
			    anstmp3 = buf.substring(4000); // 최대 6000 자 저장
			  }
			  if (anstmp1.length() > 0) {
			    non.setUserans1(anstmp1);
			    non.setUserans2(anstmp2);
			    non.setUserans3(anstmp3);
			  }

			  non.setId_exam(id_exam);
			  non.setUserid(userid);
			  non.setId_q(qs[i].getId_q());
			  non.setNr_set(Integer.parseInt(nr_set));
			
			try {
				ExamAnswerNon.insert(non);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

				if(true) return;
			}

			answer_ans = answer_ans + QmTm.Q_GUBUN;
		}
	}

	ExamAnswerBean ans = new ExamAnswerBean();

	ans.setId_exam(id_exam);
	ans.setUserid(userid);
	ans.setNr_set(Integer.parseInt(nr_set));
	ans.setYn_end(yn_end);
	ans.setAnswers(answer_ans.substring(0,(answer_ans.length()-3)));

	// 답안지 등록
    try {
	    ExamAnswer.insert(ans);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<script language="javascript">
	alert("답안지가 정상적으로 등록되었습니다.");
	window.opener.get_answer_add();
	window.close();
</script>


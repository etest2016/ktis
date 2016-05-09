<%
//******************************************************************************
//   ���α׷� : ans_edit_ok.jsp
//   �� �� �� : ����� DB ����
//   ��    �� : ����� DB ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAns
//   �� �� �� : 2008-05-21
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String yn_end = request.getParameter("yn_end");

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set = ""; } else { nr_set = nr_set.trim(); }

	String str_qcount = request.getParameter("qcount");
	if (str_qcount == null) { str_qcount = ""; } else { str_qcount = str_qcount.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0 || nr_set.length() == 0 || str_qcount.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int qcount = Integer.parseInt(str_qcount);
	
	// ���������� �о�´�.
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
		alert("�ش��ϴ� ���������� �����ϴ�");
	</script>
<%
		if(true) return;
	}
	if (qs.length != qcount) {
%>
	<script language="JavaScript">
		alert("���������� �������� �������� �������� �ٸ��ϴ�");
	</script>
<%
		if(true) return;
	}

	// ������ ǥ�ø� ���� ������

	int[] arrId_qtype = new int[qcount];
	String[] ex_order = new String[qcount];
	int[] arrCacount = new int[qcount]; // ���� ����

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
				
				if(answer == null) {
					answer_ans = answer_ans + "" + QmTm.Q_GUBUN;
				} else {
					answer_ans = answer_ans + arrEx_order[Integer.parseInt(answer)-1] + QmTm.Q_GUBUN;
				}

			}
		} else if(qs[i].getId_qtype() == 4) { // �ܴ���

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

		} else if(qs[i].getId_qtype() == 5) { // �����

			  String answer = request.getParameter("ans"+i);

			  ExamAnswerNonBean non = new ExamAnswerNonBean();

			  StringBuffer buf = new StringBuffer(answer);
			  String anstmp1,anstmp2, anstmp3, anstmp4, anstmp5;

			  if (buf.length() <= 1200) {
			    anstmp1 = buf.substring(0); anstmp2 = ""; anstmp3 = ""; anstmp4 = ""; anstmp5 = "";
			  } else if (buf.length() <= 2400) {
			    anstmp1 = buf.substring(0, 1200);
			    anstmp2 = buf.substring(1200);
			    anstmp3 = "";
				anstmp4 = "";
				anstmp5 = "";
			  } else if (buf.length() <= 3600) {
			    anstmp1 = buf.substring(0, 1200);
			    anstmp2 = buf.substring(1200, 2400);
			    anstmp3 = buf.substring(2400);
				anstmp4 = "";
				anstmp5 = "";
			  } else if (buf.length() <= 4800) {
			    anstmp1 = buf.substring(0, 1200);
			    anstmp2 = buf.substring(1200, 2400);
				anstmp3 = buf.substring(2400, 3600);
				anstmp4 = buf.substring(3600);
				anstmp5 = "";
			  } else {
			    anstmp1 = buf.substring(0, 1200);
			    anstmp2 = buf.substring(1200, 2400);
				anstmp3 = buf.substring(2400, 3600);
				anstmp4 = buf.substring(3600, 4800);
				anstmp5 = buf.substring(4800);
			  }
			  if (anstmp1.length() > 0) {
			    non.setUserans1(anstmp1);
			    non.setUserans2(anstmp2);
			    non.setUserans3(anstmp3);
				non.setUserans4(anstmp4);
				non.setUserans5(anstmp5);
			  }

			try {
				ExamAnswerNon.update(id_exam, userid, qs[i].getId_q(), non);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

				if(true) return;
			}

			answer_ans = answer_ans + QmTm.Q_GUBUN;
		}
	}

	ExamAnswerBean ans = new ExamAnswerBean();

	ans.setAnswers(answer_ans.substring(0,(answer_ans.length()-3)));

	// ����� ����
    try {
	    ExamAnswer.update(id_exam, userid, ans);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<script language="javascript">
	alert("������� ���������� �����Ǿ����ϴ�.");
	window.close();
</script>

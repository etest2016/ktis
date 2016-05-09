<%
//******************************************************************************
//   프로그램 : user_ans_view.jsp
//   모 듈 명 : 답안지 조회
//   설    명 : 답안지 조회
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamUtil
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
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	ExamAnswerAddBean ans = null;

	try {
		ans = ExamAnswerAdd.getBean(userid, id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if(ans == null) {
%>
	<script language="javascript">
		alert("시험에 미응시하셨습니다.\n\n시험에 응시하신 후 답안지를 확인하실 수 있습니다.");
		window.close();
	</script>
<%
		if(true) return;
	}
	
	int nr_set = ans.getNr_set();

	ExamInfoBean info = null;
	
	try {
		info = ExamInfo.getBean(id_exam);
	}
    catch (Exception ex) {
        out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	String title = info.getTitle();
	double totalAllot = info.getAllotting();
	int qcount = info.getQcount();

	// 시험정보를 읽어온다.
	ExamPaperBean[] qs = null;

	try {
		qs = ExamPaper.getBeans45(id_exam, nr_set, userid);
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

	String[] arrExlabel = info.getExlabel().split(",");

	String[] arrAnswer;
	String[] arrOX;
	String[] arrPoint;

	if (ans.getAnswers().length() >= qcount) {
	  arrAnswer = ans.getAnswers().split(QmTm.Q_GUBUN_re, -1);
	} else {
	  arrAnswer = new String[qcount];
	}

	if (ans.getOxs().length() >= qcount) {
	  arrOX = ans.getOxs().split(QmTm.Q_GUBUN_re, -1);
	} else {
	  arrOX = new String[qcount];
	}

	if (ans.getPoints().length() >= qcount) {
	  arrPoint = ans.getPoints().split(QmTm.Q_GUBUN_re, -1);
	} else {
	  arrPoint = new String[qcount];
	}

	if (arrAnswer.length != qs.length) {
%>
	<script language="JavaScript">
		alert("답안지의 문제수와 실제 문제수가 틀립니다.);
	</script>
<%
		if(true) return;
	}

	// 문제별 표시를 위한 데이터

	int[] arrId_qtype = new int[qcount];
	long[] arrId_q = new long[qcount];
	String[] arrDifficulty1 = new String[qcount];

	int[] arrQuestionNo = new int[qcount];     // 문제번호
	String[] arrQuestion = new String[qcount]; // 문제내용
	String[] arrOPX_img = new String[qcount];  // 문제번호의 배경이미지 (OX 관련)

	boolean[] arrHasEx = new boolean[qcount];  // 보기유무
	int[] arrExcount = new int[qcount];        // 보기 개수
	String[][] arrEx = new String[qcount][5];  // 보기라벨 + 보기내용

	double[] arrAllot = new double[qcount];    // 배점
	String[] arrCA = new String[qcount];       // 정답표시

	String[] arrUserCA = new String[qcount];       // 본인 답안

	String[] arrUA = new String[qcount];       // 제출답안표시

	String[] arrOXP = new String[qcount];       // OXP 표시
	
	String[] arrExplain = new String[qcount];      // 해설

	String[] arrQtype = new String[qcount]; // 문제유형

	String[] ex_order = new String[qcount];

	int[] arrCacount = new int[qcount]; // 정답 갯수

	String[] arrYn_caorder = new String[qcount];
	String[] arrYn_case = new String[qcount];
	String[] arrYn_blank = new String[qcount];

	int[] arrId_valid_type = new int[qcount];

	// 초기화
	String strChk = "";

	// looping

	for (int i = 0; i < qcount; i++)
	{
		if (arrAnswer[i] == null) { arrAnswer[i] = ""; }
		if (arrOX[i] == null) { arrOX[i] = ""; }
		if (arrPoint[i] == null) { arrPoint[i] = ""; }

		arrId_qtype[i] = qs[i].getId_qtype();
	    arrId_valid_type[i] = qs[i].getId_valid_type();
	    arrCacount[i] = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		String correctAnswer = qs[i].getCa();

		arrYn_caorder[i] = qs[i].getYn_caorder();
		arrYn_case[i] = qs[i].getYn_case();
		arrYn_blank[i] = qs[i].getYn_blank();

		arrId_q[i] = qs[i].getId_q();
		ex_order[i] = qs[i].getEx_order();

		if(arrId_qtype[i] == 1) {
			arrQtype[i] = "OX형";
		} else if(arrId_qtype[i] == 2) {
			arrQtype[i] = "선다형";
		} else if(arrId_qtype[i] == 3) {
			arrQtype[i] = "복수 답안형";
		} else if(arrId_qtype[i] == 4) {
			arrQtype[i] = "단답형";
		} else if(arrId_qtype[i] == 5) {
			arrQtype[i] = "논술형";
		}
		
		if (qs[i].getId_difficulty1() == 0) {
			arrDifficulty1[i] = "없음";
		} else if (qs[i].getId_difficulty1() == 1) {
			arrDifficulty1[i] = "최상";
		} else if (qs[i].getId_difficulty1() == 2) {
			arrDifficulty1[i] = "상";
		} else if (qs[i].getId_difficulty1() == 3) {
			arrDifficulty1[i] = "중";
		} else if (qs[i].getId_difficulty1() == 4) {
			arrDifficulty1[i] = "하";
		} else if (qs[i].getId_difficulty1() == 5) {
			arrDifficulty1[i] = "최하";
		} 

		arrCA[i] = ExamPaper.getAnswerDisplay(arrId_valid_type[i], arrId_qtype[i], arrCacount[i], arrEx_order, correctAnswer, arrExlabel);

		//arrUserCA[i] = ExamPaper.getAnswerDisplay(id_valid_type, arrId_qtype[i], arrCacount[i], arrEx_order, arrAnswer[i], arrExlabel);

		if (arrId_qtype[i] == 5) {
			arrCA[i] = "";
		}

		if (arrId_qtype[i] == 5) { arrAnswer[i] = qs[i].getUserans(); }
		    arrUA[i] = QA.getAnswerDisplay(9, arrId_qtype[i], arrCacount[i], arrEx_order, arrAnswer[i], arrExlabel);
		
		// 문제표시
	    arrQuestionNo[i] = qs[i].getNr_q();
	    arrQuestion[i] = qs[i].getQ();

	    // 보기표시
	    if (arrId_qtype[i] <= 3) {
		  arrHasEx[i] = true;
	    } else {
		  arrHasEx[i] = false;
	    }
	    
		arrExcount[i] = qs[i].getExcount();
	    
		for (int j = 0; j < arrExcount[i]; j++) {
		  arrEx[i][j] = arrExlabel[j] + " " + QmTm.delTag(qs[i].getArrEx()[j]);
	    }

	    // 배점
	    arrAllot[i] = qs[i].getAllotting();

	    // 해설관련
	    if (qs[i].getExplain().length() > 0) {
		  arrExplain[i] = qs[i].getExplain();
	    } else {
		  arrExplain[i] = "";
	    }

	    // 채점표시 관련
	    if (arrOX[i].equalsIgnoreCase("O")) { // 정답
		  arrOXP[i] = arrOX[i].toUpperCase();
		  arrPoint[i] = String.valueOf(arrAllot[i]);
	    } else if (arrOX[i].equalsIgnoreCase("X")) { // 오답
		  arrOXP[i] = arrOX[i].toUpperCase();
		  arrPoint[i] = "0";	
	    } else if (arrOX[i].equalsIgnoreCase("P")) { // 부분점수
		  arrOXP[i] = "△";
		  arrPoint[i] = arrPoint[i];
	    } else {
		  arrOXP[i] = "";
		  arrPoint[i] = "";
	    }

	    if (arrPoint[i].length() == 0) arrPoint[i] = "";
 }
%>

<title>답안지 보기</title>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<body>

	<table width="90%" cellpadding="0" cellspacing="0" border="0" align="center">
	
		<tr>
			<td>
				<br>
				<table border="0" cellpadding="0" cellspacing="0" id="tableD" WIDTH="100%">
					<tr>
						<td id="left" width="50%" colspan="2"><li>시험명 : </li><font color=green><b><%=title%></b></font></td>
						<td id="left" width="50%" colspan="2"><li>답안제출여부 : </li><font color=green><b><%if(ans.getYn_end().equals("Y")) { %>답안제출 완료<% } else { %>답안제출 미완료<% } %></b></font></td>
					</tr>
					<tr>
						<td width="25%" id="left"><li>시험지 번호 : </li><font color=green><b><%=nr_set%></b></font></td>
						<td width="25%" id="left" ><li>문제수 : </li><font color=green><b><%=qcount%></b></font> 문항</td>
						<td width="25%" id="left"><li>배점 : </li><font color=green><b><%=totalAllot%></b></font> 점</td>
						<td width="25%" id="left"><li>응시자 : </li><font color=green><b><%=userid%></b></font></td>
					</tr>					
				</table>
				<table border="0" cellpadding="0" cellspacing="0" id="tableD" WIDTH="100%">					
					<tr>
						<td width="35%" id="left"><li>시험시작시간 : </li><font color=green><b><%=ans.getStart_time().toString()%></b></font></td>
						<td width="35%" id="left" ><li>답안제출시간 : </li><font color=green><b><%=ans.getEnd_time().toString()%></b></font></td>
						<td width="30%" id="left"><li>접속IP : </li><font color=green><b><%=ans.getUser_ip()%></b></font></td>
					</tr>					
				</table>
				<BR>
			</td>
		</tr>
		<tr>
			<td>
								
				<table border="0" width='100%'>
					<tr>
						<td>

							<% for(int i = 0; i < qcount; i++) { %>
							<table border="0" width="100%" >
								<tr>
									<td colspan="2" align="left" valign="top"><font color="#ooo"><b>&nbsp;<%=arrQuestionNo[i]%>.</b></font></td>
								</tr>								
								
								<tr>
									<td width="7%" valign="top">&nbsp;&nbsp;(배점)</td>
									<td><font color="#B70000"><%= arrAllot[i] %></font></td>
								</tr>
								<tr>
									<td width="7%" valign="top">&nbsp;&nbsp;(답안)</td>
									<td><font color="#B70000">
									<% 
										if(arrId_qtype[i] == 5) { 
											if(arrUA[i].trim().length() > 0) {
									%>
									답 있음
									<%
											} else {
									%>	
									답 없음
									<%
											}
										} else {
									%>										
										<%= arrUA[i] %>
									<% 
										} 
									%>
									</font></td>
								</tr>	
								
								<tr>
									<td colspan="2" height="5">&nbsp;</td>
								</tr>							
							</table>

							<% } %>

						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
			</td>
		</tr>
	</table>
	
</body>
</html>
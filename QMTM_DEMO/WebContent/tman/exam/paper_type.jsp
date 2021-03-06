<%
//******************************************************************************
//   프로그램 : paper_type.jsp
//   모 듈 명 : 시험지 미리보기
//   설    명 : 시험지 미리보기
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-05-16
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }


	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		window.close();
	</script>
<%	
	}

	ExamInfoBean info = null;
	
	try {
		info = ExamInfo.getBean(id_exam);
	}
    catch (Exception ex) {
        out.println(ex.getMessage());
	}

	String title = info.getTitle();
	double totalAllot = info.getAllotting();
	int qcount = info.getQcount();

	ExamPaperBean[] qs = null;

	try {
		qs = ExamPaper.getBeans(id_exam, Integer.parseInt(nr_set));
	} catch (Exception ex) {
		out.println(ex.getMessage());
	}

	if (qs == null) {
%>
	<script language="JavaScript">
		alert("해당하는 문제정보가 없습니다");
	</script>
<%
	}
	if (qs.length != qcount) {
%>
	<script language="JavaScript">
		alert("시험정보의 문제수와 문제지의 문제수가 다릅니다");
	</script>
<%
	}

	String[] arrExlabel = info.getExlabel().split(",");
%>

<%
	// 문제별 표시를 위한 데이터

	long[] arrId_q = new long[qcount];
	String[] arrDifficulty1 = new String[qcount];
	
	boolean[] arrHasRef = new boolean[qcount]; // 지문여부
	String[] arrRefTitle = new String[qcount]; // 지문제목 및 해당문제번호
	String[] arrRefBody = new String[qcount];  // 지문내용

	int[] arrQuestionNo = new int[qcount];     // 문제번호
	String[] arrQuestion = new String[qcount]; // 문제내용
	String[] arrOPX_img = new String[qcount];  // 문제번호의 배경이미지 (OX 관련)

	boolean[] arrHasEx = new boolean[qcount];  // 보기유무
	int[] arrExcount = new int[qcount];        // 보기 개수
	String[][] arrEx = new String[qcount][5];  // 보기라벨 + 보기내용

	double[] arrAllot = new double[qcount];    // 배점
	String[] arrCA = new String[qcount];       // 정답표시
	
	boolean[] arrHasExplain = new boolean[qcount]; // 해설유무
	String[] arrExplain = new String[qcount];      // 해설

	String[] arrHint = new String[qcount];      // 힌트

	String[] arrQtype = new String[qcount]; // 문제유형

	// 초기화
	String id_ref = "";     // 지문ID

	// looping

	for (int i = 0; i < qcount; i++)
	{
		int id_qtype = qs[i].getId_qtype();
	    int id_valid_type = qs[i].getId_valid_type();
	    int cacount = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		String correctAnswer = qs[i].getCa().trim();

		arrId_q[i] = qs[i].getId_q();
		arrHint[i] = qs[i].getHint();

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

		// 지문표시
		if (id_ref.equalsIgnoreCase(qs[i].getId_ref())) {     // id_ref 전과동
		    arrHasRef[i] = false;
		} else if (qs[i].getId_ref().equalsIgnoreCase("0")) { // id_ref = 0 : 지문무
		    arrHasRef[i] = false;
		} else {                                              // id_ref 가 변경 되었고 지문유
		    arrHasRef[i] = true;

			id_ref = qs[i].getId_ref();
		    arrRefTitle[i] = "※ " + qs[i].getReftitle() + "[" + qs[i].getQ_no1() + "]" ;

			if (qs[i].getQ_no1() != qs[i].getQ_no2()) { // 여러문제에 적용
		      arrRefTitle[i] += " ~ [" + qs[i].getQ_no2() + "]";
		    }

			arrRefBody[i] = qs[i].getRefbody();
		}

		arrCA[i] = ExamPaper.getAnswerDisplay(id_valid_type, id_qtype, cacount, arrEx_order, correctAnswer, arrExlabel);

		if (id_qtype == 5) {
			arrCA[i] = "N/A";
		}

	  // 문제표시
	  arrQuestionNo[i] = qs[i].getNr_q();
	  arrQuestion[i] = qs[i].getQ();

	  // 보기표시
	  if (id_qtype <= 3) {
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
		arrHasExplain[i] = true; arrExplain[i] = qs[i].getExplain();
	  } else {
		arrHasExplain[i] = false;
	  }
	}
%>

<HTML>
<HEAD>
	<TITLE> :: 시험지 미리보기 :: </TITLE>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<style>
		
		Body { margin: 0px 20px 100px 20px; font: normal 12px gulim; line-height: 140%; }
		table, tr, td, div { font: normal 12px gulim; line-height: 140%; }
		img { border: 0px; }
		
		#exam_info { line-height: 150%; border: 0px solid #CCC; padding: 0px 0px 20px 0px; margin-top: 5px; font: normal 13px gulim; 
			border-bottom: 1px dotted #999;
		}
		#ref { margin-top: 25px; }
		#q { margin-top: 25px; line-height: 120%; }
		#ex { margin-top: 15px; padding-left: 8px; }
		#ans { margin-top: 10px; color: red; }


	</style>
	<script language="JavaScript">

		function paper_html() {
			location.href="paper_type_html.jsp?id_exam=<%=id_exam%>&nr_set=<%=nr_set%>";
		}

	</script>
</HEAD>

<BODY id="tman">
	
	<Div align="right">
		<img src="../../images/bt2_html.gif" onclick="javascript:paper_html();" style="cursor: hand;" onfocus="this.blur();">
	</Div>
	
	<Div id="exam_info">
		<li>시험명 : <%=title%></li>
		<li>시험지 번호 : <%=nr_set%></li>
		<li>문제수 : <%=qcount%></li>
	</Div>

	<% for(int i = 0; i < qcount; i++) { %>


	<!--------------------------------------- 문제 --------------------------------------->
	<Div id="q">
		<font color="#0000CC"><%=arrQuestionNo[i]%>.&nbsp;<%=arrQuestion[i]%></font>
	</Div>


	<!--------------------------------------- 보기 --------------------------------------->
	<Div id="ex">
		<% if (arrHasEx[i]) { %>
			<% for (int j = 0; j < arrExcount[i]; j++) { %>
				<%= arrEx[i][j] %><br>
			<% } %>
		<% } %>
	</Div>

	<!--------------------------------------- 정답 --------------------------------------->
	<Div id="ans">
		(정답) <%= arrCA[i] %><Br>
		(배점) <%=arrAllot[i]%><br>
		(난이도) <%= arrDifficulty1[i] %> <br>
	</Div>

	<% } %>

</BODY>
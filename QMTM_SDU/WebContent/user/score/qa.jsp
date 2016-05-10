<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, etest.*, etest.score.*, etest.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<%
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// from exam_m and related tables

	User_ExamInfoBean info = null;

	try {
	  info = User_ExamInfo.getBean(id_exam);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	if (info == null) {
%>
	<script type="text/javascript">
		alert("평가정보가 없습니다.");
		window.close();
	</script>
<%
		if(true) return ;
	}

	String title = info.getTitle();
	double totalAllot = info.getAllotting();
	int qcount = info.getQcount();

	// from exam_ans
	User_ExamAnsBean ans = null;

	try {
	  ans = User_ExamAns.getBean(userid, id_exam);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	if (ans == null) {
%>
	<script type="text/javascript">
		alert("평가에 응시하지 않았습니다.");
		window.close();
	</script>
<%
		if(true) return ;
	} 

	// exam_paper2, q, ref, exam_ans_non
	User_ExamPaper2Bean[] qs = null;

	try {
	  qs = User_ExamPaper2.getBeans(ans.getId_exam(), ans.getNr_set(), ans.getUserid());
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	if (qs == null) {
%>
	<script type="text/javascript">
		alert("해당하는 평가에 문제정보가 없습니다.\n\n관리자에게 문의하시기 바랍니다.");
		window.close();
	</script>
<%
		if(true) return ;
	}
	if (qs.length != qcount) {
%>
	<script type="text/javascript">
		alert("평가정보의 문제수와 문제지의 문제수가 다릅니다\n\n관리자에게 문의하시기 바랍니다.");
		window.close();
	</script>
<%
		if(true) return ;
	}

	String[] arrExlabel = info.getExlabel().split(",");

	String[] arrAnswer;
	String[] arrOX;
	String[] arrPoint;

	if (ans.getAnswers().length() >= qcount) {
	  arrAnswer = ans.getAnswers().split(User_QmTm.Q_GUBUN_re, -1);
	} else {
	  arrAnswer = new String[qcount];
	}

	if (ans.getOxs().length() >= qcount) {
	  arrOX = ans.getOxs().split(User_QmTm.Q_GUBUN_re, -1);
	} else {
	  arrOX = new String[qcount];
	}

	if (ans.getPoints().length() >= qcount) {
	  arrPoint = ans.getPoints().split(User_QmTm.Q_GUBUN_re, -1);
	} else {
	  arrPoint = new String[qcount];
	}

	if (arrAnswer.length != qs.length) {
%>
	<script type="text/javascript">
		alert("답안지의 문제수와 문제지의 문제수가 다릅니다\n\n관리자에게 문의하시기 바랍니다.");
		window.close();
	</script>
<%
		if(true) return ;
	}

	String scoreDisplay = ""; // 본인점수계표시

	if (ans.getYn_end().equalsIgnoreCase("N")) { // 답안 미제출
	  scoreDisplay = "<font color='red'>답안 미제출</font>";
	} else if (ans.getOxs().length() == 0) { // 답안 채점전
	  scoreDisplay = "<font color='red'>답안 채점전</font>";
	} else { // 답안제출 and 채점후
	  if (ans.getScore_log().equals("-1")) { // 득점가감 무
		scoreDisplay = ans.getScore() + "";
	  } else { // 득점가감 유
		scoreDisplay = "" + ans.getScore();
		scoreDisplay += "(원점수:" + ans.getScore_bak() + ", 득점 가감 내용:";
		char c = ans.getScore_log().charAt(0);
		scoreDisplay += ans.getScore_log().substring(1);
		if (c == '+') { scoreDisplay += " 가점)"; }
		else { scoreDisplay += " 감점)"; }
	  }
	}

	// 문제별 표시를 위한 데이터

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

	String[] arrUA_align = new String[qcount]; // 제출답안의 td align
	String[] arrUA_width = new String[qcount]; // 제출답안의 td width
	String[] arrUA = new String[qcount];       // 제출답안표시

	String[] arrOXP_color = new String[qcount]; // 채점표시색갈
	String[] arrOXP = new String[qcount];       // OXP 표시

	boolean[] arrHasExplain = new boolean[qcount]; // 해설유무
	String[] arrExplain = new String[qcount];      // 해설

	String[] arrQtype = new String[qcount]; // 문제유형
	String[] arrCAx = new String[qcount];   // 종합채점표에서 정답 표시
	String[] arrUAx = new String[qcount];   // 종합채점표에서 제출답 표시

	String[] arrTableID = new String[qcount];      // 보이기 제어를 위한 table id

	// 초기화
	String id_ref = "";     // 지문ID

	// looping

	for (int i = 0; i < qcount; i++)
	{
	  if (arrAnswer[i] == null) { arrAnswer[i] = ""; }
	  if (arrOX[i] == null) { arrOX[i] = ""; }
	  if (arrPoint[i] == null) { arrPoint[i] = ""; }

	  int id_qtype = qs[i].getId_qtype();
	  int id_valid_type = qs[i].getId_valid_type();
	  int cacount = qs[i].getCacount();
	  int[] arrEx_order = qs[i].getArrEx_order();
	  String correctAnswer = qs[i].getCa();

	  // 보이기/감추기
	  if(arrOX[i].equalsIgnoreCase("O")) { arrTableID[i] = "YesTab"; }
	  else { arrTableID[i] = "NoTab"; }

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

	  // 문제표시
	  arrQuestionNo[i] = qs[i].getNr_q();
	  arrQuestion[i] = qs[i].getQ();
	  arrOPX_img[i] = "../images/" + arrOX[i] + "04.gif";

	  // 보기표시
	  if (id_qtype <= 3) {
		arrHasEx[i] = true;
	  } else {
		arrHasEx[i] = false;
	  }
	  arrExcount[i] = qs[i].getExcount();
	  for (int j = 0; j < arrExcount[i]; j++) {
		arrEx[i][j] = arrExlabel[j] + " " + User_QmTm.delTag(qs[i].getArrEx()[j]);
	  }

	  // 배점
	  arrAllot[i] = qs[i].getAllotting();

	  // 정답표시
	  arrCA[i] = User_QA.getAnswerDisplay(id_valid_type, id_qtype, cacount, arrEx_order, correctAnswer, arrExlabel);

	  if (id_qtype == 5) {
		arrCA[i] = "";
	  }

	  // 제출답안관련
	  if (id_qtype == 5) { // 논술형
		arrUA_align[i] = "left"; arrUA_width[i] = "60%";
	  } else {
		arrUA_align[i] = "center"; arrUA_width[i] = "";
	  }
	  if (id_qtype == 5) { arrAnswer[i] = qs[i].getUserans(); }
	  arrUA[i] = User_QA.getAnswerDisplay(9, id_qtype, cacount, arrEx_order, arrAnswer[i], arrExlabel);

	  // 채점표시 관련
	  if (arrOX[i].equalsIgnoreCase("O")) { // 정답
		arrOXP_color[i] = "blue"; arrOXP[i] = arrOX[i].toUpperCase();
		arrPoint[i] = String.valueOf(arrAllot[i]);
	  } else if (arrOX[i].equalsIgnoreCase("X")) { // 오답
		arrOXP_color[i] = "red"; arrOXP[i] = arrOX[i].toUpperCase();
		arrPoint[i] = "0";
	  } else if (arrOX[i].equalsIgnoreCase("P")) { // 부분점수
		arrOXP_color[i] = "#33CCCC"; arrOXP[i] = "△";
	  } else {
		arrOXP_color[i] = "gray"; arrOXP[i] = "";
		arrPoint[i] = "";
	  }

	  // 해설관련
	  if (qs[i].getExplain().length() > 0) {
		arrHasExplain[i] = true; arrExplain[i] = qs[i].getExplain();
	  } else {
		arrHasExplain[i] = false;
	  }

	  // 채점표종합관련
	  if      (id_qtype == 1) arrQtype[i] = "OX형";
	  else if (id_qtype == 2) arrQtype[i] = "선다형";
	  else if (id_qtype == 3) arrQtype[i] = "복수답안형";
	  else if (id_qtype == 4) arrQtype[i] = "단답형";
	  else if (id_qtype == 5) arrQtype[i] = "논술형";

	  if (id_qtype == 5) { // 논술형
		arrCAx[i] = "";
		if (arrUA[i].length() == 0) { arrUAx[i] = "논술답안 없슴"; }
		else { arrUAx[i] = "논술답안 제출"; }
	  } else {
		arrCAx[i] = arrCA[i]; arrUAx[i] = arrUA[i];
	  }

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>응시자ID : [<%= userid %>] --- 정답 해설 및 채점</title>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/indie_style.css" type="text/css">
<style type="text/css">
  body      { font-size: 12 }
  table     { font-size: 12 }
</style>
<script type="text/javascript" src="../js/MM_script.js"></script>

<script type="text/javascript">
function init()
{
  self.moveTo(0,0) ;
  self.resizeTo(screen.availWidth,screen.availHeight) ;
}
</script>

</head>

<body bgcolor="#FFFFFF" onload="init()" oncontextmenu="return false;" ondragstart="return false;" onselectstart="return false;">

<form name="thisfrm">
  <input type='hidden' name='chkflag' value='all'>
  <input type='hidden' name='chkflag2' value='all'>
</form>

<!-- buttons -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="60">
  <tr>
    <td width="82%" valign="middle" class="form-h">
      <table width="228" border="0" cellspacing="1">
        <tr>
          <td width="45"><a href="javascript:viewCrtTab();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../images/bt1_1.gif',1)"><img src="../images/bt1_2.gif" width="45" height="22" border="0" name="Image6"></a></td><br>
          <td width="85"><a href="javascript:viewYes();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../images/bt1_3.gif',1)"><img src="../images/bt1_4.gif" width="85" height="22" border="0" name="Image1"></a></td>
          <td width="98"><a href="javascript:viewNo();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../images/bt1_5.gif',1)"><img src="../images/bt1_6.gif" width="98" height="22" border="0" name="Image2"></a></td>
        </tr>
      </table>
    </td>
    <td align="right" valign="bottom" width="26%">
      <!--<input type="image" name="cmdPrint" onclick="window.print();" src="../images/b-print.gif" width="42" height="51">-->
      <input type="image" name="cmdClose" onclick="window.close();" src="../images/b-exit.gif" width="42" height="51">
    </td>
  </tr>
</table>

<!-- spacer -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="14">
  <tr><td width="80%" align="center" background="../images/gab_dot.gif"></td></tr>
</table>

<!-- title, userID-->
<table align="center" width="80%" border="0" cellspacing="0" cellpadding="0" class="copy">
  <tr>
    <td width="60%">
      - <b><font color="#6666CC">평가명</font></b> : <%= title %><br>
    </td>
    <td width="40%" valign="top" align="right">
      <b>- <font color="#6666CC">응시자 ID</font></b> : <%= userid %><br>
    </td>
  </tr>
</table><br>

<!-- 배점, 문제수, 득점 -->
<table align="center" width="80%" border="0" cellspacing="1" cellpadding="2" class="copy" bgcolor="#666666">
  <tr align="center">
    <td width="16%" bgcolor="#F7F7E8">배점</td>
    <td width="16%" bgcolor="#FFFFFF"><%= totalAllot %></td>
    <td width="16%" bgcolor="#F7F7E8">문제수</td>
    <td width="16%" bgcolor="#FFFFFF"><%= qcount %></td>
    <td width="16%" bgcolor="#F7F7E8">본인점수</td>
    <td width="16%" bgcolor="#FFFFFF"><%= scoreDisplay %></td>
  </tr>
</table>

<!-- spacer -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="14">
  <tr><td width="80%" align="center" background="../images/gab_dot.gif"></td></tr>
</table>

<% for (int i = 0; i < qcount; i++) { /* 문제별로 loop 를 돌리면서 */ %>

<!-- 지문 -->
<% if (arrHasRef[i]) { %>
<table border="0" width="80%" align="center" cellpadding="0" cellspacing="0" id="<%= arrTableID[i] %>" style="display:none">
  <tr><td colspan=2 height="15">&nbsp;</td></tr>
  <tr height="25">
    <td colspan="2" bgcolor="#6666CC">
      <font color='#FFFFFF'><%= arrRefTitle[i] %></font>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="right">
      <table bgcolor="#F0F0F0" width="100%" align="center" border="0" cellspacing="0" cellpadding="8" class="copy">
        <tr><td><%= arrRefBody[i] %></td></tr>
      </table>
    </td>
  </tr>
</table>
<% } %>
<!-- end of 지문 -->

<!-- 문제 및 보기 -->
<table border="0" width="80%" align="center" cellpadding="2" cellspacing="0" id="<%= arrTableID[i] %>" style="display:none">
  <tr><td colspan=2 height="15">&nbsp;</td></tr>
  <!-- 문제 -->
  <tr>
    <td valign=top width="28" height="28" align="center">
      <table border="0" width="27" height="22" background="<%= arrOPX_img[i] %>">
        <tr>
          <td align="center" width="27" height="22">
            <font face=Arial color="#000000" size=3><b><%= arrQuestionNo[i] %></b></font>
          </td>
        </tr>
      </table>
    </td>
    <td bgcolor="#F5F5F5" valign="middle" align="left"><%= arrQuestion[i] %></td>
  </tr>
  <!-- 보기 -->
  <% if (arrHasEx[i]) { %>
    <% for (int j = 0; j < arrExcount[i]; j++) { %>
      <tr>
        <td align="center" width="30" valign="top">&nbsp;</td>
        <td valign="top"><%= arrEx[i][j] %></td>
      </tr>
   <% } %>
 <% } %>
</table>
<!-- end of 문제 및 보기 -->

<!-- 채점결과 -->
<table align="center" width="80%" class="copy" id="<%= arrTableID[i] %>" style="display:none">
  <tr>
    <td bgcolor="#FFFFFF" align="left" valign="top" width="18">
      <img src="../images/i-hint.gif" width="18" height="18">
    </td>
    <td bgcolor="#FFFFFF" align="left" valign="top">
      <b><font color="#6666CC">&nbsp;채점</font></b>
    </td>
  </tr>
</table>
<table align="center" cellspacing=1 cellpadding=2 width=80% border=0 bgcolor="#CCCCCC" class="copy" id="<%= arrTableID[i] %>" style="display:none">
  <tr align=center bgcolor=#F7F7E8>
    <td><font color="#000000">&nbsp;&nbsp;배점&nbsp;&nbsp;</font></td>
    <td><font color="#000000">&nbsp;&nbsp;득점&nbsp;&nbsp;</font></td>
    <td><font color="#000000">&nbsp;&nbsp;정답&nbsp;&nbsp;</font></td>
    <td width="<%= arrUA_width[i] %>"><font color="#000000">제출답안</font></td>
    <td><font color="#000000">&nbsp;&nbsp;채점&nbsp;&nbsp;</font></td>
  </tr>
  <tr align="center" bgcolor="#FFFFFF">
    <td><%= arrAllot[i] %></td>
    <td><%= arrPoint[i] %></td>
    <td><%= arrCA[i] %></td>
    <td align="<%= arrUA_align[i] %>"><%= arrUA[i] %></td>
    <td><font color="<%= arrOXP_color[i] %>"><b><%= arrOXP[i] %></b></font></td>
  </tr>
</table>

<!-- end of 채점결과 -->

<!-- 해설 -->
<% if (arrHasExplain[i]) { %>
<table border="0" width="80%" align="center" cellpadding="0" cellspacing="0" id="<%= arrTableID[i] %>" style="display:none">
  <tr><td height="15">&nbsp;</td></tr>
  <tr>
    <td bgcolor="#FFFFFF" align="left" valign="top">
      <img src="../images/i-answer.gif" width="17" height="18" border="0" align="middle">
      <font color="#6666CC"><b>&nbsp;해설</b></font>
    </td>
  </tr>
  <tr>
    <td align="right">
      <table bgcolor="#F0F0F0" width="100%" align="center" border="0" cellspacing="0" cellpadding="8" class="copy">
        <tr><td><%= arrExplain[i] %></td></tr>
      </table>
    </td>
  </tr>
</table>
<% } %>
<!-- 해설 -->

<% } /* end of for loop (문제별로) */ %>

<!-- 채점표 -->
<table align="center" width="80%" border="0" cellspacing="1" cellpadding="2" class="copy" bgcolor="#666666" id="crtTab" STYLE="display:">
  <tr>
    <td bgcolor="#F7F7E8" align="center">문항번호</td>
    <td bgcolor="#F7F7E8" align="center">문제유형</td>
    <td bgcolor="#F7F7E8" align="center">본인답안</td>
    <td bgcolor="#F7F7E8" align="center">&nbsp;&nbsp;정답&nbsp;&nbsp;</td>
    <td bgcolor="#F7F7E8" align="center">&nbsp;&nbsp;채점&nbsp;&nbsp;</td>
    <td bgcolor="#F7F7E8" align="center">&nbsp;&nbsp;배점&nbsp;&nbsp;</td>
    <td bgcolor="#F7F7E8" align="center">본인득점</td>
  </tr>

  <% for (int i = 0; i < qcount; i++) { /* 문제별로 loop 를 돌리면서 */ %>
  <tr align="center" bgcolor="#FFFFFF">
    <td><%= arrQuestionNo[i] %></td>
    <td><%= arrQtype[i] %></td>
    <td><%= arrUAx[i] %></td>
    <td><%= arrCAx[i] %></td>
    <td><%= arrOXP[i] %></td>
    <td><%= arrAllot[i] %></td>
    <td><%= arrPoint[i] %></td>
  </tr>
  <% } %>

</table>
<!-- end of 채점표 -->

<!-- spaccer line -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="14">
  <tr><td width="80%" align="center" background="../images/gab_dot.gif"></td></tr>
</table>

<!-- 제어버튼 -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="60">
  <tr>
    <td width="82%" valign="middle" class="form-h">
      <table width="228" border="0" cellspacing="1">
        <tr>
          <td width="45"><a href="javascript:viewCrtTab();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../images/bt1_1.gif',1)"><img src="../images/bt1_2.gif" width="45" height="22" border="0" name="Image6"></a></td><br>
          <td width="85"><a href="javascript:viewYes();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../images/bt1_3.gif',1)"><img src="../images/bt1_4.gif" width="85" height="22" border="0" name="Image1"></a></td>
          <td width="98"><a href="javascript:viewNo();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../images/bt1_5.gif',1)"><img src="../images/bt1_6.gif" width="98" height="22" border="0" name="Image2"></a></td>
        </tr>
      </table>
    </td>
    <td align="right" valign="bottom" width="26%">
      <!--<input type="image" name="cmdPrint" onclick="window.print();" src="../images/b-print.gif" width="42" height="51">-->
      <input type="image" name="cmdClose" onclick="window.close();" src="../images/b-exit.gif" width="42" height="51">
    </td>
  </tr>
</table>
<!-- end of 제어버튼 -->

</body>
</html>

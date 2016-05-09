<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, etest.*, etest.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
%>
<%
	//String userid =	get_cookie(request, "userid");
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (userid == "" || id_exam == "") {
		throw new QmTmException("[로긴이 필요합니다.]@close@notice");
	}

	String gindex = request.getParameter("gindex");
	String refresh_YN = "Y";
	if (gindex == null) {
		gindex = "0";
		refresh_YN = "N";
	}

	String timeLeft = request.getParameter("timeLeft"); // 시험도중 refresh 의 경우
	if (timeLeft == null || timeLeft.equals("")) { timeLeft = "999999999"; }
	long refresh_remain_time = Long.parseLong(timeLeft);
%>
<%
	/* WindowsXP SP2 인지... */
	String browser = request.getHeader("User-Agent");
	boolean isSP2 = (browser.indexOf("SV1") >= 0) ? true : false;

	String user_ip = request.getRemoteAddr();
%>
<%
  // Step 1 : 시험의 기본 설정 값을 읽어온다

	User_ExamInfoBean ei;

	try {
		ei = User_ExamInfo.getBean(id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	if (ei == null) {
%>
   <Script language="JavaScript">
	   alert("개설되어진 시험이 없습니다.");
       top.window.close();
   </Script>
<% 	  
	  if(true) return;
  }

	int id_auth_type = ei.getId_auth_type(); // 0=로긴only, 1=과정대상자, 2=접수자
	int id_exam_type = ei.getId_exam_type(); // 0 : 평가형, 1 : 자유모의고사형(반복시험가능)
	long limittime = ei.getLimittime(); // [sec]
	int qcount = ei.getQcount(); // 문제수
	int setcount = ei.getSetcount(); // 시험지수
	long to_login_start = ei.getTo_login_start(); // [sec]
	long to_login_end = ei.getTo_login_end(); // [sec]
	long to_exam_start1 = ei.getTo_exam_start1(); // [sec]
	long to_exam_end1 = ei.getTo_exam_end1(); // [sec]
	long to_end1_from_start1 = ei.getTo_end1_from_start1(); // [sec]
	double allotting = ei.getAllotting();
	Timestamp system_now = ei.getSystem_now();	
	String now_time = system_now.toString().substring(0,16);
	Timestamp login_start = ei.getLogin_start();
	String exlabel = ei.getExlabel();
	String[] arrExlabel = exlabel.split(",");
	String paper_type = String.valueOf(ei.getPaper_type()); // 11,12,13 ~ 51,52,53
	String title = ei.getTitle();
	String yn_sametime = "";
	if(userid.equals("tman@@2008")) {
		yn_sametime = "N";
	} else {
		yn_sametime = ei.getYn_sametime();
	}	
	String id_ltimetype = ei.getId_ltimetype();
	String yn_viewas = ei.getYn_viewas();
	String yn_open_score_direct = ei.getYn_open_score_direct();
	String retry_exam = ei.getRetry_exam();	

	String id_movepage = ei.getId_movepage();

	if(userid.equals("tman@@2008")) {
		id_movepage = "F";
	} 
%>

<%
  // Step 1-1 : 이미지 경로를 설정한다.

  //접속 서버 정보 및 공통 이미지 폴더 경로 읽어오기
	//String sv_root = "../../CommonFiles";
	String sv_root = "../";
	String imagesDir = "";

	if(paper_type.equals("11")){
		imagesDir = sv_root + "/images/TypeA/02";
	} else if (paper_type.equals("12")){
		imagesDir = sv_root + "/images/TypeA/03";
	} else if (paper_type.equals("13")){
		imagesDir = sv_root + "/images/TypeA/01";
	} else if (paper_type.equals("21")){
		imagesDir = sv_root + "/images/TypeB/02";
	} else if (paper_type.equals("22")){
		imagesDir = sv_root + "/images/TypeB/03";
	} else if (paper_type.equals("23")){
		imagesDir = sv_root + "/images/TypeB/01";
	} else if (paper_type.equals("31")){
		imagesDir = sv_root + "/images/TypeC/01";
	} else if (paper_type.equals("32")){
		imagesDir = sv_root + "/images/TypeC/02";
	} else if (paper_type.equals("33")){
		imagesDir = sv_root + "/images/TypeC/03";
	}
%>
<%
  // Step 1-2 : 기본값을 채운다

%>
<%
  // Step2 :  응시자정보

  boolean hasAnswer;
  boolean hasSubmit;
  boolean isAuthTester;
  Timestamp end_time;

  try {
    hasAnswer = User_QmTm.hasAnswer(userid, id_exam);
    hasSubmit = User_QmTm.hasSubmit(userid, id_exam);
    isAuthTester = User_QmTm.isAuthTester(id_auth_type, userid, id_exam);
    end_time = User_QmTm.getEnd_time(userid, id_exam); // 답안이 없으면 null
  }
  catch (Exception ex) {
    out.println(ComLib.getExceptionMsg(ex, "back"));

    if(true) return;
  }
%>
<%
  // Step 3 : 입실제외

  if (!userid.equals("tman@@2008")) { //교수자 일경우에는 체크를 안한다.
	
  // 3-1 : 평가형으로 답안을 제출한 경우
  if (hasSubmit && id_exam_type == 0) {
    String str = end_time.toString().substring(0, 19);	
   %>
   <Script language="JavaScript">
	   alert("[답안을 이미 제출 하였습니다]");
	   top.window.close();	
   </Script>
   <%
	   if(true) return;
  }

  // 3-2 : 입실허용시간이 지난경우
  if (yn_sametime.equalsIgnoreCase("Y")) { // 동시평가
    if (to_login_end <= 0 || to_exam_end1 <= 0) {
    %>
   <Script language="JavaScript">
	   alert("[입실 가능 시간이 지났습니다]");
	   top.window.close();
   </Script>
   <%
	   if(true) return;
    } else if(to_login_start > 0) {
   %>
   
   <Script language="JavaScript">
	   alert("시험 입장시간 이전입니다. 시험입장시간을 확인하시기 바랍니다.");
	   top.window.close();
   </Script>	
   <%
	   if(true) return;
	}
  }
  else { // 동시평가가 아닌 경우
    //   sec = to 종료시간   + 제한시간   + 여유시간
    long sec = to_exam_end1 + limittime + DBPool.SAFE_TIME * 60;
    if (sec < 0) {
   %>
   <Script language="JavaScript">
	   alert("[시험시간이 종료 되었습니다]");
       top.window.close();
   </Script>
   <%	  
	   if(true) return;
    } else if(to_exam_start1 > 0) {	
   %>
   <Script language="JavaScript">
	   alert("시험 시작시간 이전입니다. 시험시작시간을 확인하시기 바랍니다.");
	   
       top.window.close();
   </Script>
   <%
	   if(true) return;
	}
  }
%>

<%
  // Step 4 : 응시 대상자인지 체크한다
  
  if (id_auth_type != 0) {
    if (isAuthTester == false) {
    %>
   <Script language="JavaScript">
	   alert("[이 시험의 응시대상자가 아닙니다]");
	   top.window.close();
   </Script>
   <%  
	   if(true) return;
    }
  }

  } // 교수자 테스트 아이디 종료

%>

<%
  // Step 5 : 답안지

  // 5-1 :  답안지제출 and 자유모의고사 --> 답안지 삭제

  if (hasSubmit && id_auth_type != 0)
  {
    try {
		User_ExamAns.delete(userid, id_exam);
    }
    catch (Exception ex) {
       out.println(ComLib.getExceptionMsg(ex, "back"));

	   if(true) return;
    }
    hasAnswer = false;
    hasSubmit = false;
  } 
  
  // 5-2 : 답안지 무 --> 빈답안지 추가
  if (hasAnswer == false)
  {
    try {
        User_ExamAns.insertBlank(userid, id_exam, setcount, system_now, limittime, user_ip, retry_exam);
        User_Log.saveLogText("1", id_exam, userid, "0", user_ip, browser, "", "", "", "");
    }
    catch (Exception ex) {
        out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
  }

  // 5-3 : 답안지를 읽어온다
  User_ExamAnsBean ans;

  try {
      ans = User_ExamAns.getBean(userid, id_exam);
  }
  catch (Exception ex) {
      out.println(ComLib.getExceptionMsg(ex, "back"));

      if(true) return;
  }

  String answers = ans.getAnswers();
  String yn_end = ans.getYn_end();
  int nr_set = ans.getNr_set();
  long remain_time = ans.getRemain_time();
  String[] arrAnswers = answers.split(User_QmTm.Q_GUBUN_re, -1);

%> 

<%
  // Step 6 : 시험 문제를 읽어온다.

  User_ExamPaper2Bean[] qs;
  
  try {
      qs = User_ExamPaper2.getBeans(id_exam, nr_set, userid);
  } catch(Exception ex) {
	  out.println(ComLib.getExceptionMsg(ex, "back"));

	  if(true) return;
  }
  
  if (qs == null) {
%>
   <Script language="JavaScript">
	   alert("등록되어진 시험지가 없습니다.");
       top.window.close();
   </Script>
<% 	  
	  if(true) return;
  }

  if (qcount != qs.length) {
  %>
   <Script language="JavaScript">
	   alert("문제수가 맞지 않습니다.");
       top.window.close();
   </Script>
  <% 	  
	  if(true) return;
  }
%>

<%
	// 단답형 처리 관련
	User_PaperListBean[] jls;
	int lngMsg = 0;

	try {
		jls = User_PaperList.getBeans(id_exam, nr_set);
	} catch (Exception ex) {
%>
		<Script language="JavaScript">
			alert("인터넷 연결상태가 좋지 않습니다.");
			top.window.close();
		</Script>
<%
			if(true) return ;
	}
	if (jls == null) {
%>
		<Script language="JavaScript">
			alert("문항정보가 등록되지 않았습니다.");
			top.window.close();
		</Script>
<%
		if(true) return ;
	} else {
		lngMsg = jls.length;
	}
%>

<%
	// 문항별 영역 처리 관련

	User_PaperList2Bean[] jls2;

	boolean Guide_area = true;
	int lngArea = 0;

	try {
		jls2 = User_PaperList2.getBeans(id_exam);
	} catch (Exception ex) {
%>
		<Script language="JavaScript">
			alert("인터넷 연결상태가 좋지 않습니다.");
			top.window.close();
		</Script>
<%
		if(true) return ;
	}

	if (jls2 == null) {
		Guide_area = false;
	} else {
		Guide_area = true;
		lngArea = jls2.length;
	} 
%>

<%
  // Step 7

  // 7-1 : 시험지 페이지별 정보

  User_ExamPaper2.setPageInfo(qs);
  String pageList = User_ExamPaper2.getPageList();
  String startList = User_ExamPaper2.getStartList();
  String endList = User_ExamPaper2.getEndList();
  int nonCount = User_ExamPaper2.getNonCount();    // 논술형 문제수
  double nonAllot = User_ExamPaper2.getNonAllot(); // 논술형 배점계

  // 7-2 : 시험지 형식

  char[] arr = paper_type.toCharArray();
  char paperType = arr[0];  // 1~5
  char paperImage = arr[1]; // 1~3

  String paperDir = "../images/type_" + paperType + "/image_" + paperImage;
  String bgColor = "#BEDC56";

  if (paperType == '5' && paperImage == '2') {
    bgColor = "#78ADFF";
  }
  else if (paperType == '5' && paperImage == '1') {
    bgColor = "#FFE0B3";
  }

  // 7-3 : 잔여시간

  if (yn_sametime.equalsIgnoreCase("Y")) // 동시시험
  {
    if (to_exam_end1 > limittime) {
      remain_time = limittime;
    }
    else {
      remain_time = to_exam_end1;
    }
  }
  else // not 동시시험
  {
    if (remain_time > limittime) {
      remain_time = limittime;
    }
    if (remain_time > refresh_remain_time) { // 시험도중 refresh 시 ...
      remain_time = refresh_remain_time;
    }
  }
%>

<html>

<head>

<title>시험지</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=utf-8">
<link rel="stylesheet" href="../css/indie_style.css" type="text/css">
<% 
	if(paper_type.equals("11")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeA2.css' type='text/css'>");
	} else if(paper_type.equals("12")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeA3.css' type='text/css'>");
	} else if(paper_type.equals("13")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeA1.css' type='text/css'>");
	} else if(paper_type.equals("21")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeB2.css' type='text/css'>");
	} else if(paper_type.equals("22")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeB3.css' type='text/css'>");
	} else if(paper_type.equals("23")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeB1.css' type='text/css'>");
	} else if(paper_type.equals("31")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeC1.css' type='text/css'>");
	} else if(paper_type.equals("32")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeC2.css' type='text/css'>");
	} else if(paper_type.equals("33")) { 
		out.println("<link rel='stylesheet' href='"+sv_root+"/css/TypeC3.css' type='text/css'>");
	}
%>

<style type="text/css">
	body      { font-size: <%= ei.getFontsize() %>pt; font-family: <%= ei.getFontname() %>, 돋움체, 굴림체; }
	table     { font-size: <%= ei.getFontsize() %>pt; font-family: <%= ei.getFontname() %>, 돋움체, 굴림체; line-height: 150%; }
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--
	function MM_swapImgRestore() { //v3.0
	  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
	}

	function MM_findObj(n, d) { //v4.01
	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && d.getElementById) x=d.getElementById(n); return x;
	}

	function MM_swapImage() { //v3.0
	  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
	}
//-->
</SCRIPT>

<script language="javascript">

// Global variables from server variables

var userid, id_exam;
var gindex, refresh_YN, isSTOP;

var bgColor, endList, exlabel, id_ltimetype, id_movepage;
var isSP2, limittime, log_option, pageList, paper_type, paperType;
var paperImage, qcount, qcntperpage, remain_time, startList;
var title, to_exam_start1, web_window_mode, yn_open_score_direct;
var yn_viewas, yn_sametime;

// Array for 문제별정보
var ArridQ = new Array();
var ArrQ = new Array();
var ArrEx = new Array (new Array(), new Array(), new Array(), new Array(), new Array());
var ArrExOrder = new Array();
var ArrRef = new Array();
var ArrRefTitle = new Array();
var ArridRef = new Array();
var ArrQno1 = new Array();
var ArrQno2 = new Array();
var ArrQPage = new Array();
var ArrExCount = new Array();
var ArrCa = new Array();
var ArrCaCount = new Array();
var ArrQType = new Array();
var ArrExlabel = new Array();
var ArrLtimes = new Array();
var ArrAnswers = new Array();
var ArrAllotting = new Array();
var ArrNonChk = new Array();     // Array for 논술형답안 작성여부

var ArrSingle = new Array();     // 단답형 한줄에 표시여부
var ArrExRow = new Array();      // 보기 한줄당 표시될 보기 갯수 (추가)
var ArrFront = new Array();      // 단답형 앞 메시지
var ArrBack = new Array();       // 단답형 뒷 메시지
var ArrMsgQid = new Array();     
var ArrBox = new Array();        // 단답형 입력 박스 크기

<% for (int i = 0; i < qcount; i++) { %>

   ArridQ[<%= i %>] = <%= qs[i].getId_q() %>;
   ArrQPage[<%= i %>] = <%= qs[i].getPage() %>;
   ArrQno1[<%= i %>] = <%= qs[i].getQ_no1() %>;
   ArrQno2[<%= i %>] = <%= qs[i].getQ_no2() %>;
   ArrExOrder[<%= i %>] = "<%= qs[i].getEx_order() %>";
   ArrExCount[<%= i %>] = <%= qs[i].getExcount() %>;
   ArrCaCount[<%= i %>] = <%= qs[i].getCacount() %>;
   ArrQType[<%= i %>] = <%= qs[i].getId_qtype() %>;
   ArrAllotting[<%= i %>] = <%= qs[i].getAllotting() %>;
   ArridRef[<%= i %>] = "<%= qs[i].getId_ref() %>";
   ArrRef[<%= i %>] = "<%= User_QmTm.changeChar(qs[i].getRefbody()) %>";
   ArrRefTitle[<%= i %>] = "<%= User_QmTm.changeChar(qs[i].getReftitle()) %>";
   ArrNonChk[<%= i %>] = "<%= qs[i].getNonCheck() %>"; // 논술형답안 작성여부

   ArrQ[<%= i %>] = "<%= User_QmTm.changeChar(qs[i].getQ()) %>";
   <% for (int j = 0; j < qs[i].getExcount(); j++) { %>
   ArrEx[<%= j %>][<%= i %>] = "<%= User_QmTm.changeChar(qs[i].getArrEx()[j]) %>";
   <% } %>

   ArrAnswers[<%= i %>] = "";

   // 단답형 문항 커스트 마이징..
	ArrSingle[<%= i %>] = "<%= qs[i].getYn_single_line() %>";
	ArrExRow[<%= i %>] = <%= qs[i].getEx_rowcnt() %>; 
 	
<% } %>

// 단답형 문항 커스트 마이징..
<% for (int j = 0; j < lngMsg; j++) { %>
	ArrFront[<%= j %>] = "<%= QmTm.changeChar(jls[j].getFront_msg()) %>";
	ArrBack[<%= j %>] = "<%= QmTm.changeChar(jls[j].getBack_msg()) %>";
	ArrMsgQid[<%= j %>] = <%= jls[j].getId_q() %>;
	ArrBox[<%= j %>] = "<%= jls[j].getBox_size() %>";
<% } %> 

var ArrExTmp, ArrPage, ArrStart, ArrEnd;

// 구분자
var JOIN_GUBUN, LIKE_GUBUN, OR_GUBUN, Q_GUNUN;
var KEYWORD_A, KEYWORD_B, KEYWORD_C;
var RKEYWORD_A, RKEYWORD_B, RKEYWORD_C;

// regexp
var gLIKE_GUBUN, gOR_GUBUN, gQ_GUNUN;
var gRKEYWORD_A, gRKEYWORD_B, gRKEYWORD_C;
var giCHAR_PATTERN1, giCHAR_PATTERN2, giCHAR_PATTERN3, giCHAR_PATTERN4;

// from SET
var ANS_MAX_LEN;

// for control
var ExamEndYN = "N";
var gMove_YN = "Y";
var keyCodeTabEsc = 0;
var ignoreLostFocus = false;
var isWindowMoved = false;
var isWindowResized = false;

// for 타이머
var timeLeftStart = 0;
var timeLeft = 0;
var timerID = null;
var isTimer = false;
var started = 0;
var LastTime = 0;

var orgTop;
var orgLeft;

function init()
{
  window.scrollTo(0, 0);
  
  userid = "<%= userid %>";
  id_exam = "<%= id_exam %>";
  gindex = <%= gindex %>;
  refresh_YN = "<%= refresh_YN %>";
  if (refresh_YN == "Y") {
    ignoreLostFocus = true;
  }
  <% if (DBPool.STOP) { %> isSTOP = true; <% } else { %> isSTOP = false; <% } %>
  bgColor = "<%= bgColor %>";
  endList = "<%= endList %>";
  exlabel = "<%= exlabel %>";
  id_ltimetype = "<%= id_ltimetype %>";
  id_movepage = "<%= id_movepage %>";
  <% if (isSP2) { %> isSP2 = true; <% } else { %> isSP2 = false; <% } %>
  limittime = <%= ei.getLimittime() %>;       // [sec]
  log_option = "<%= ei.getLog_option() %>";   // A:간이로그, B:풀로그
  pageList = "<%= pageList %>";
  paper_type = "<%= ei.getPaper_type() %>";   // 11 ~ 53
  paperType = "<%= paperType %>";             // 1 ~ 5
  paperImage = "<%= paperImage %>";           // 1 ~ 3
  qcount = <%= qcount %>;
  qcntperpage = <%= ei.getQcntperpage() %>;
  remain_time = <%= remain_time %>;           // [sec]
  startList = "<%= startList %>";
  title = "<%= title %>";
  to_exam_start1 = <%= ei.getTo_exam_start1() %>;   // [sec]
  web_window_mode = <%= ei.getWeb_window_mode() %>; // 0:FullScreen, 1:NoFull
  yn_open_score_direct = "<%= yn_open_score_direct %>";
  yn_viewas = "<%= yn_viewas %>";
  yn_sametime = "<%= ei.getYn_sametime() %>";

  // 구분자

  JOIN_GUBUN = "<%= User_QmTm.JOIN_GUBUN %>";
  LIKE_GUBUN = "<%= User_QmTm.LIKE_GUBUN %>";
  OR_GUBUN = "<%= User_QmTm.OR_GUBUN %>";
  Q_GUBUN = "<%= User_QmTm.Q_GUBUN %>";

  KEYWORD_A = "<%= User_QmTm.KEYWORD_A %>";  // {:}
  KEYWORD_B = "<%= User_QmTm.KEYWORD_B %>";  // {|}
  KEYWORD_C = "<%= User_QmTm.KEYWORD_C %>";  // {^}

  RKEYWORD_A = "<%= User_QmTm.RKEYWORD_A %>";
  RKEYWORD_B = "<%= User_QmTm.RKEYWORD_B %>";
  RKEYWORD_C = "<%= User_QmTm.RKEYWORD_C %>";

  // regexp

  gLIKE_GUBUN = /<%= User_QmTm.LIKE_GUBUN_re %>/g;
  gOR_GUBUN = /<%= User_QmTm.OR_GUBUN_re %>/g;
  gQ_GUNUN = /<%= User_QmTm.Q_GUBUN_re %>/;

  gRKEYWORD_A = /<%= User_QmTm.RKEYWORD_A %>/g;
  gRKEYWORD_B = /<%= User_QmTm.RKEYWORD_B %>/g;
  gRKEYWORD_C = /<%= User_QmTm.RKEYWORD_C %>/g;

  giCHAR_PATTERN1 = /<%= User_QmTm.CHAR_PATTERN1 %>/gi;
  giCHAR_PATTERN2 = /<%= User_QmTm.CHAR_PATTERN2 %>/gi;
  giCHAR_PATTERN3 = /<%= User_QmTm.CHAR_PATTERN3 %>/gi;
  giCHAR_PATTERN4 = /<%= User_QmTm.CHAR_PATTERN4 %>/gi;

  // 답안처리 : 다국어 및 특수문자
  <% if (arrAnswers.length == qcount) { %>
  ArrAnswers = Cnv("<%= User_QmTm.changeChar(User_QmTm.join(arrAnswers, User_QmTm.JOIN_GUBUN)) %>").split("<%= User_QmTm.JOIN_GUBUN %>", -1);
  <% } %>

  // from SET
  ANS_MAX_LEN = <%= DBPool.ANS_MAX_LEN %>;

  // value of hidden variables
  var frm = document.frmData;  
  frm.userid.value = userid;
  frm.id_exam.value = id_exam;
  frm.title.value = title;
  frm.id_ltimetype.value = id_ltimetype;
  frm.paper_type.value = paper_type;
  frm.yn_open_score_direct.value = yn_open_score_direct;

  // for Checking move
  orgTop = parent.screenTop;
  orgLeft = parent.screenLeft;

  var height_avail = 0;

//alert("document.body.clientHeight=" + document.body.clientHeight);
//alert("document.body.scrollHeight=" + document.body.scrollHeight);
//alert("window.screen.height=" + window.screen.height);
//alert("window.screen.availHeight=" + window.screen.avaiHeight);

  if (web_window_mode == 0) { height_avail = document.body.clientHeight; }
  else { height_avail = 600; }

  /* 2008-07-09 주석처리
  if (paperType == "3") {
    document.all.middlediv.style.height = height_avail - 135;
    document.all.centerdiv.style.height = height_avail - 135;
    if (yn_viewas == "Y") { document.all.ansdiv.style.height = height_avail - 150; }
  }
  else  if (paperType == "4") {
    document.all.middlediv.style.height = height_avail - 151;
    document.all.centerdiv.style.height = height_avail - 151;
    if (yn_viewas == "Y") { document.all.ansdiv.style.height = height_avail - 166; }
  }
  else {
    document.all.middlediv.style.height = height_avail - 114;
    document.all.centerdiv.style.height = height_avail - 114;
    if (yn_viewas == "Y") { document.all.ansdiv.style.height = height_avail - 129; }
  }
  */

  // 페이지 정보를 담는다
  ArrPage = pageList.split(":");
  ArrStart = startList.split(":");
  ArrEnd = endList.split(":");

  for (var i = 0; i < ArrPage.length; i++) { // string --> integer
    ArrPage[i] = parseInt(ArrPage[i], 10);
    ArrStart[i] = parseInt(ArrStart[i], 10);
    ArrEnd[i] = parseInt(ArrEnd[i], 10);
  }

  // 보기 label
  ArrExlabel = exlabel.split(",");

  if (gindex != 0 && id_movepage == "F") {
    // gindex 유지
  }
  else
  {
    // gindex 계산
    gindex = 0;

    // 답안을 입력하지 않은 문제로 이동
    for (var i = 0; i <= (ArrAnswers.length - 1); i++)
    {
      if (ArrAnswers[i] == "" && ArrNonChk[i] == "") {
        gindex = ArrPage[ArrQPage[i] - 1];
        break;
      } else if (ArrNonChk[i] == "N") {
        gindex = ArrPage[ArrQPage[i] - 1];
        break;
      }
    }

    // 모든 답안이 체크 되어 있다면 마지막 문제로 이동
    if (gindex == 0) {
      gindex = ArrPage[ArrQPage[qcount - 1] - 1]
    }
  }

  var tmpindex = gindex;
  if (tmpindex < 0) { tmpindex = 0; }
  if (id_movepage != "F") {
    document.all.prevbtn.style.display = "none";
  }

  if (refresh_YN == "N") {
    document.all.guide.style.display = "";
    document.all.contents.style.display = "none";
    if (yn_sametime == "Y") {
      document.all.outImg.style.display = "none";
    }
  }
  else // refresh_YN == "Y"
  {
    GetQ();
    document.all.guide.style.display = "none";
    document.all.contents.style.display = "";
    document.all.Re_No.style.display = "";
    if (id_ltimetype == "N") {  // 제한시간 없슴
      document.all.outImg.style.display = "";
    } else {
      document.all.outImg.style.display = "none";
    }
    if (yn_viewas == "Y") {
      document.all.reply.style.display = "";
    }
    if (id_ltimetype != "N") {
      Timerinit();
    }
  }

  if (to_exam_start1 > 0 && yn_sametime == "Y") {
    Timerinit2();
  } else if (to_exam_start1 < 0 && yn_sametime == "Y") {
    examStart();
  }
}

function refresh_onclick()
{
  ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함

  EvtLog("2"); // 새로고침
  var timeLeft = document.frmData.timeLeft.value;
  top.frames("fraTest").location.replace("etest.jsp?id_exam=" + id_exam + "&userid=" + userid + "&gindex=" + gindex + "&timeLeft=" + timeLeft);
}

function CloseUsingX()
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // 강제종료(X) Event Log 저장 : 20
    EvtLog("20");
    myalert("시험중 X 버튼을 이용하여 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
  }
}

function Resize()
{
  if (log_option == "Y")
  {
    if (isWindowResized) { return; }
    isWindowResized = true;

    // 창크기변경 Event Log 저장 : 11
    Hide();
    EvtLog("11");
    myalert("시험중 창크기를 변경하는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
    ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함임
    parent.close();
  }
}

function WindowMoved()
{
  // 창의 위치 변경여부

  var top = parent.screenTop;
  var left = parent.screenLeft;

  if (orgTop != top || orgLeft != left) {
    isWindowMoved = true;
  } else {
    isWindowMoved = false;
  }
}

function CheckMove()
{
  if (log_option == "Y")
  {
    if (isWindowMoved) { return; }
    WindowMoved();

    if (isWindowMoved) {
      // 창위치변경 Event Log 저장 : 12
      Hide();
      EvtLog("12");
      myalert("시험중 창위치를 변경하는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
      ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함임
      parent.close();
    }
  }
}

function LostFocus()
{
  if (ignoreLostFocus) {     // Refresh, Key-Event, alert 등등
    ignoreLostFocus = false;
    return;
  }

  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // LostFocus 의 원인
    if (keyCodeTabEsc == 9) { // Alt+Tab
      EvtLog("22");
      myalert("시험중 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
      keyCodeTabEsc = 0;
    } else if (keyCodeTabEsc == 27) { // Alt+Esc
      EvtLog("23");
      myalert("시험중 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
      keyCodeTabEsc = 0;
    }

    // 포커스이동 Event Log 저장 : 13
    EvtLog("13");
    //myalert("시험중 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
  }
}

function chkkeyup(e)
{
    var kc = event.keyCode;
    if (kc == 9 || kc == 27) { keyCodeTabEsc = kc; } // LostFocus() 에서 이용
}

function chkkeydown(e)
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    ignoreLostFocus = false;
    var kc = event.keyCode;

    if (kc == 93 || kc == 113 || kc >= 116 && kc <= 123) {
      // myalert("시험중 누르신 키는 사용하실 수 없습니다 ...");
      event.keyCode = 0;
      event.cancelBubble = true;
      event.returnValue = false;
      return false;
    }

    // 경고항목
    if (event.altKey && kc == 115) {
      // Alt + F4 (강제종료)
      ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함
      Hide();
      AnsSave("F"); // remain-time 저장을 위하여
      EvtLog("21");
      myalert("시험중 Alt + F4 를 이용하여 강제종료 하였습니다\n\n운영자의 허락없이 종료하는 경우, 부정행위로 오해 받을 수 있습니다\n\n운영자에게 강제종료한 사실을 통보하였습니다");
    }
    else if (event.altKey && kc == 9) {
      // Alt + Tab (화면전환) : 제어불가 --> LostFocus 에서 처리
      // EvtLog("22");
      // myalert("시험중 Alt + Tab 를 이용하여 화면전환을 하였습니다\n\n부정행위로 오해 받을 수 있습니다\n\n운영자에게 통보하였습니다");
    }
    else if (event.altKey && kc == 27) {
      // Alt + Esc (화면전환) : 제어불가 --> LostFocus 에서 처리
      // EvtLog("23");
      // myalert("시험중 Alt + Esc 를 이용하여 화면전환을 하였습니다\n\n부정행위로 오해 받을 수 있습니다\n\n운영자에게 통보하였습니다");
    }
    // 주의항목
    else if (kc == 91 || kc == 92) {
      // Windows
      Hide();
      EvtLog("51");
      myalert("시험중 Windows키를 사용하실 수 없습니다\n\n문제가 보이지 않으면 상단 우측에 있는 새로고침을 누르세요.");
    }
    else if (kc == 93) {
      // Context menu
      myalert("시험중 컨텍스트 메뉴키를 사용하실 수 없습니다\n\n문제가 보이지 않으면 상단 우측에 있는 새로고침을 누르세요.");
      event.keyCode = 0;
      return false;
      //EvtLog("52"); // event.keyCode = 0 가 가능하므로 로그저장 불필요
    }
    else if (kc == 112) {
      // F1 (IE 도움말)
      EvtLog("53");
      Hide();
      myalert("시험중 F1키를 사용하실 수 없습니다\n\n도움말창을 닫으세요\n\n문제가 보이지 않으면 상단 우측에 있는 새로고침을 누르세요.");
    }
    else if (kc == 114) {
      // F3 (IE 검색창)
      myalert("시험중 F3키를 사용하실 수 없습니다");
      event.keyCode = 0;
      return false;
      // EvtLog("54"); // event.keyCode = 0 가 가능하므로 로그저장 불필요
    }
    else if (kc == 116) {
      // F5 Key (새로고침:강제)
      ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함
      EvtLog("55");
      Hide();
      myalert("문제가 보이지 않을 경우 F5 를 누르지 말고\n\n상단우측에 있는 [새로고침] 버튼을 누르세요\n\nF5 키를 이용할 경우 기존 답안이 없어질 수도 있습니다\n\n확인후 다시 시험을 시작하세요");
    }
    // Ctrl(17) or Alt(18) + 기타키 사용제한
    else if ((event.ctrlKey || event.altKey)) {
      if (kc != 17 && kc != 18) {
        myalert("Ctrl 또는 Alt 키와의 복합적인 키기능은 사용할 수 없습니다.");
        event.keyCode = 0;
        event.cancelBubble = true;
        event.returnValue = false;
        return false;
      }
    }
  } // end of log_option == "Y"
}

document.onkeyup = chkkeyup;
document.onkeydown = chkkeydown;

function myalert(msg) // alert 시 blur 를 허용하기 위함...
{
  if (timeLeft > 0)
  {
    msg += "\n\n시험시간은 계속 진행되고 있습니다.\n\n메세지 확인 즉시 본 창을 닫으시고";
    if (timeLeft <= 180) {
      msg += "\n\n시험을 마무리하시기 바랍니다.";
    } else {
      msg += "\n\n시험을 진행하시기 바랍니다.";
    }
  }

  alert(msg);
  ignoreLostFocus = true;
}

</script>

<script language="javascript">

// functions

function examStart()
{
  document.all.startbutton.disabled = true;
  document.all.guide.style.display = "none";
  document.all.contents.style.display = "";
  document.all.Re_No.style.display = "";

  if (id_ltimetype == "N") {  // 제한시간 없슴
    document.all.outImg.style.display = "";
  } else {
    document.all.outImg.style.display = "none";
  }

  if (yn_viewas == "Y") { document.all.reply.style.display = ""; }
  <% if (hasAnswer) { %>
    EvtLog("3"); // 이어풀기
  <% } else { %>
    EvtLog("1"); // 시험시작
  <% } %>
  GetQ();
  if (id_ltimetype != "N") { Timerinit(); }
}

function goout_onclick()
{
  // 퇴실 Event Log : 9
  EvtLog("9")

  top.window.opener.location.reload();  // 동일 웹프로젝트시
  top.window.close();  // 별도 웹프로젝트시
}

function GetQ()
{
  var qNumber;
  var idx;
  var i, j, k, z, lngExCnt, isub;
  var tmp, tmp2, ArrTmp;
  var old_ref = "";
  var ref_start, ref_end;
  var multi_tmp;

  mExamArea();
  k = 0;

  // 일반형 (화면당 N개의 문제)

  if (ArrQType[ArrStart[gindex - 1] - 1] < 5) // 1:OX형, 2:선다형, 3:복수답안형, 4:단답형
  {
    document.frmData.nr_q.value = "";
    document.frmData.id_q.value = "";

    for (idx = ArrStart[gindex - 1] - 1; idx <= ArrEnd[gindex - 1] - 1; idx++)
    {
      k = k + 1;
      lngExCnt = ArrExCount[idx] - 1;
      qNumber = idx + 1;

      if (ArrQType[idx] < 4) {
        ArrExTmp = ArrExOrder[idx].split(",");
        for (i = 0; i < ArrExTmp.length; i++) {
          ArrExTmp[i] = parseInt(ArrExTmp[i], 10);
        }
      }

      if (ArridRef[idx] != "0")
      {
        //이전 지문이 현재 지문과 다르다면 이전 지문을 현재 지문으로 변경한다
        //이전 지문과 현재 지문이 같을 경우는 지문을 표시할 필요가 없다
        if (old_ref != ArridRef[idx]) {
          old_ref = ArridRef[idx];
          RefDisp(idx, k);
        }
      }

      eval("document.all.quizno" + k + ".innerHTML = \"<b><big>" + qNumber + ". </big></b>\";");
      eval("document.all.quiz" + k + ".innerHTML = RestoreChar(ArrQ[" + idx + "]) + \"<br><font color=blue>[배점 " + ArrAllotting[idx] + "]</font>\";");

      if (ArrQType[idx] <= 3) // 1:OX형, 2:선다형, 3:복수답안형
      {
        for (i = 0; i <= lngExCnt; i++)
        {
          eval("document.all.lb" + k + (i + 1) + ".innerHTML = InputHtml(" + i + "," + idx + ");");
          eval("document.all.ln" + k + (i + 1) + ".innerHTML = '" + ArrExlabel[i] + "&nbsp;';");
          eval("document.all.ex" + k + (i + 1) + ".innerHTML = RestoreChar(ArrEx[" + i + "][" + idx + "]);");
          // eval("document.all.ex" + k + (i + 1) + ".innerHTML = RestoreChar(ArrEx[" + (ArrExTmp[i] - 1) + "][" + idx + "]);");

          if (ArrQType[idx] == 3) // 3:복수답안형
          {
            multi_tmp = ArrAnswers[idx].split(OR_GUBUN);
            for(isub=0; isub<= multi_tmp.length -1; isub++)
            {
              if (multi_tmp[isub] == ArrExTmp[i])
              {
                eval("document.all.ln" + k + (i + 1) + ".style.color = 'red';");
                eval("document.all.ex" + k + (i + 1) + ".style.color = 'red';");
                break;
              }
            }
          } // end of 3:복수답안형

          else // 1:OX형, 2:선다형
          {
            if (ArrAnswers[idx] == ArrExTmp[i])
            {
              eval("document.all.ln" + k + (i + 1) + ".style.color = 'red';");
              eval("document.all.ex" + k + (i + 1) + ".style.color = 'red';");
            }
          } // end of 1:OX형, 2:선다형

	} // end of for loop i <= lngExCnt

      } // end of 1:OX형, 2:선다형, 3:복수답안형

      else if (ArrQType[idx] == 4) // 4:단답형
      {
        
		for (i=0; i<= <%= lngMsg -1 %>; i++) {
			if (ArridQ[idx] == ArrMsgQid[i]) {
				lngMpos = i;
				break;
			 }
		}
		
		tmp = KeyWord_bak(RestoreChar2(ArrAnswers[idx]));
        tmp2 = "";

        if (ArrCaCount[idx] > 1) // 복수답
        {
          if (tmp == "") {
            for (i = 1; i <= ArrCaCount[idx] - 1; i++) { tmp = tmp + OR_GUBUN; }
          }

          ArrTmp = tmp.split(OR_GUBUN);

          if (ArrSingle[idx] == "N") {
		 for (j=1; j<= ArrCaCount[idx]; j++) {
		   tmp2 = tmp2 + (String.fromCharCode(9311 + j)) + RestoreChar(ArrFront[lngMpos]) + " <input type=\"text\" size=\"" + ArrBox[lngMpos] + "\" name=\"ans" + idx + "\" value=\"" + ArrTmp[j-1] + "\" onchange=\"javascript:AnsCheck(" + idx + ", this.value);\" onKeyPress=\"CheckKeys(" + k + ")\">" + RestoreChar(ArrBack[lngMpos]) + "<br>";
		   lngMpos = lngMpos + 1;
		 }
	  } else {
		for (j=1; j<= ArrCaCount[idx]; j++) {
		   tmp2 = tmp2 + RestoreChar(ArrFront[lngMpos]) + "<input type=\"text\" size=\"" + ArrBox[lngMpos] + "\" name=\"ans" + idx + "\" value=\"" + ArrTmp[j-1] + "\" onchange=\"javascript:AnsCheck(" + idx + ", this.value);\" onKeyPress=\"CheckKeys(" + k + ")\">" + RestoreChar(ArrBack[lngMpos]);
		   lngMpos = lngMpos + 1;
		}
	  }
	} else {
		tmp2 = tmp2 + RestoreChar(ArrFront[lngMpos]) + "<input type=\"text\" size=\"" + ArrBox[lngMpos] + "\" name=\"ans" + idx + "\" value=\"" + tmp + "\" onchange=\"javascript:AnsCheck(" + idx + ", this.value);\" onKeyPress=\"CheckKeys(" + k + ")\">" + RestoreChar(ArrBack[lngMpos]);
	}

	eval("document.all.ex" + k + "1.innerHTML = tmp2;");

    } // end of 4:단답형

 }   // end of for loop idx <= ArrEnd[gindex - 1] - 1

    ButtonVisible(); // 다음, 이전.. 버튼들에 대한 표시

  }  // end of 일반형 (1:OX형, 2:선다형, 3:복수답안형, 4:단답형)

  else // 5: 논술형 (화면당 1문제)
  {
    k = k + 1;
    idx = ArrStart[gindex-1]-1;
    qNumber = idx + 1;
    document.frmData.nr_q.value = qNumber;
    document.frmData.id_q.value = ArridQ[idx];

    eval("document.all.quizno1.innerHTML = \"<b><big>" + qNumber + ". </big></b>\";");
    eval("document.all.quiz1.innerHTML = RestoreChar(ArrQ[" + idx + "]) + \"<br>[배점 " + ArrAllotting[idx] + "]\";");

    if (ArridRef[idx] != "0") { RefDisp(idx, k); } // 지문표시
    ignoreLostFocus = true;
    window.open("nonpage.jsp?id_q=" + ArridQ[idx] + "&userid=" + userid + "&id_exam=" + id_exam + "&index=" + (idx + 1), "fraAction");
  } // end of 5: 논술형
}

function ButtonVisible()
{
  // 다음, 이전 버튼 제어

  if (ArrStart[gindex - 1] - 1 == 0 && ArrEnd[gindex - 1] - 1 == qcount - 1)
  {
    if (id_movepage == "F") { document.all.prevbtn.style.display = "none"; }
    document.all.nextbtn.style.display = "none";
  }
  else if (ArrStart[gindex - 1] - 1 <= 0 && ArrEnd[gindex - 1] - 1 < qcount - 1) {
    if (id_movepage == "F") { document.all.prevbtn.style.display = "none"; }
    document.all.nextbtn.style.display = "";
  }
  else if (ArrEnd[gindex - 1] - 1 >= qcount - 1) {
    if (id_movepage == "F") {
      document.all.prevbtn.style.display = "";
    }
    document.all.nextbtn.style.display = "none";
  }
  else {
    if (id_movepage == "F") {
      document.all.prevbtn.style.display = "";
    }
    document.all.nextbtn.style.display = "";
  }

  // 답안제출 버튼
  if (ArrEnd[gindex -1 ] - 1 >= qcount - 1) {
    document.all.examsubmit.style.display = "";
  }
  else {
    document.all.examsubmit.style.display = "none";
  }

  if (yn_viewas == "Y") { replyCheckAll(); }
  gMove_YN = "Y";

  if (document.all.contents.style.display == "")
  {
    document.all.contents2.focus();

    if (yn_viewas == "Y")
    {
      if (gindex > 0) {
        eval("document.all.reply" + ArrStart[gindex-1] + ".focus();");
      } else {
        document.all.reply1.focus();
      }
    }
  }
}

function RefDisp(rindex, rnum)
{
  var ref_msg = "";
  ref_msg += "<table width='80%' align='left' border='0' cellspacing='0' cellpadding='0'>";
  ref_msg += "<tr><td>"

  if (ArrQno1[rindex] == ArrQno2[rindex])
  {
    ref_msg += "<table bgcolor='#6666CC' width='100%' align='left' border='0' cellspacing='0' cellpadding='0' class='copy'>";
    ref_msg += "<tr>";
    ref_msg += "<td align=center>&nbsp;<font color=white>※ " + RestoreChar(ArrRefTitle[rindex]) + "[" + (ArrQno1[rindex]) + "]</font>&nbsp;</td>";
    ref_msg += "</tr></table>";
  } else {
    ref_msg += "<table bgcolor='#6666CC' width='100%' align='left' border='0' cellspacing='0' cellpadding='0' class='copy'>";
    ref_msg += "<tr>";
    ref_msg += "<td align=center>&nbsp;<font color=white>※ " + RestoreChar(ArrRefTitle[rindex]) + "[" + (ArrQno1[rindex]) + "] ~ [" + (ArrQno2[rindex]) + "]</font>&nbsp;</td>";
    ref_msg += "</tr></table>";
  }

  ref_msg += "</td></tr><tr><td>"
  ref_msg += "<table bgcolor='F0F0F0' width='100%' align='left' border='0' cellspacing='0' cellpadding='8' class='copy'>";
  ref_msg += "<tr>";
  ref_msg += "<td width=15>&nbsp;</td>";
  ref_msg += "<td class='exam'>";
  ref_msg += RestoreChar(ArrRef[rindex]);
  ref_msg += "</td></tr></table></td></tr></table>";

  eval("document.all.ref" + rnum + ".innerHTML = ref_msg;");
}

function InputHtml(idx, pindex)
{
  var strCheck = "";
  var ArrTmp;
  var ansType = "";

  var valTmp = ArrExTmp[idx];
  var lngTmp = ArrQType[pindex];

  if (ArrAnswers[pindex] != "")
  {
    if(lngTmp != 3) {
      if (parseInt(ArrAnswers[pindex]) == valTmp) { strCheck = " checked"; }
    }
    else {
      ArrTmp = ArrAnswers[pindex].split(OR_GUBUN);
      for (var k = 0; k < ArrTmp.length; k++) {
        if (ArrTmp[k] == valTmp) {
          strCheck = " checked";
          break;
        }
      }
    }
  }

  if (lngTmp == 1 || lngTmp == 2) {
    ansType = "<input type='radio' name='ans" + pindex + "' value='" + valTmp + "'" + strCheck + " onclick=\"javascript:AnsCheck(" + pindex + ", this.value);\">";
  } else if (lngTmp == 3) {
    ansType = "<input type='checkbox' name='ans" + pindex + "' value='" + valTmp + "'" + strCheck + " onclick=\"javascript:AnsCheck(" + pindex + ", this.value);\">";
  }

  return(ansType);
}

function ClearQ()
{
  for (var x = 1; x <= qcntperpage; x++)
  {
    eval("document.all.ref" + x + ".innerHTML = '';");
    eval("document.all.quiz" + x + ".innerHTML = '';");

    for (var y = 1; y <= 6; y++)
    {
      eval("document.all.ln" + x + y + ".innerHTML = '';");
      eval("document.all.ln" + x + y + ".style.color = 'black';");
      eval("document.all.ex" + x + y + ".innerHTML = '';");
      eval("document.all.ex" + x + y + ".style.color = 'black';");
    }
  }
}

function NextQ()
{
  if (gMove_YN == "N")
  {
    myalert("답안을 저장 중입니다. 10초이상 다음문제가 표시되지 않을경우 새로고침 버튼을 눌러 주세요");
    return;
  }

  if (gindex > qcount - 1 || ExamEndYN == "Y") { return; }

  if (id_movepage != "F")
  {
    for(var i = ArrStart[gindex - 1] - 1; i < ArrEnd[gindex - 1]; i++)
    {
      if ((ArrQType[i] <= 4 && ArrAnswers[i] == "") || (ArrQType[i] == 5 &&  ArrNonChk[i] == "N")) {
        // 자유 이동이 아니면 문제를 풀어야 다음페이지로 이동 가능
        myalert((i + 1) + " 번 문제의 답안을 입력하지 않으셨습니다 !!!");
        return;
      }
    }
  }

  if (isSTOP) { gMove_YN = "N"; }

  AnsSave("N");
}

function GetNext()
{
  gindex++;
  if (gindex >= ArrQPage[qcount -1]) { gindex = ArrQPage[qcount - 1]; }
  GetQ();
}

function PreviousQ()
{
  if (gMove_YN == "N") {
    myalert("답안을 저장 중입니다. 10초이상 다음문제가 표시되지 않을경우 새로고침 버튼을 눌러 주세요");
    return;
  }

  if (gindex <= 0 || ExamEndYN == "Y") { return; }

  if (isSTOP) { gMove_YN = "N"; }
  AnsSave("P");
}

function GetPrevious()
{
  gindex--;
  if (gindex <= 0) { gindex = 0; }
  GetQ();
}

function disable_btn()
{
  if (isSTOP) { gMove_YN = "N"; }
  document.all.prevbtn.style.display = "none";
  document.all.nextbtn.style.display = "none";
}

function Save_Err()
{
  myalert("답안 저장중 오류가 발생 하였습니다\n확인을 누르시면 답안이 저장된 위치부터 이어서 진행 됩니다");
  top.frames("fraTest").location.replace("etest.jsp?id_exam=" + id_exam + "&userid=" + userid + "&gindex=&timeLeft=" + timeLeft);
}

function QResume()
{
  document.all.message.style.display = "none";
  document.all.contents.style.display = "";
}

function GotoQ(pindex)
{
  var tmp;

  if (gMove_YN == "Y") {
    if (isSTOP) { gMove_YN = "N"; }
    gindex = ArrQPage[pindex];
    AnsSave("C");
  } else {
    myalert("답안을 저장 중입니다. 10초이상 다음문제가 표시되지 않을경우 새로고침 버튼을 눌러 주세요");
    return;
  }
}

function Calindex(pindex)
{
  var tmpidx;

  var mok = Math.floor(pindex / qcntperpage);
  var na = pindex % qcntperpage;

  if (mok <= 0) {
    tmpidx = 0;
  } else {
    tmpidx = mok * qcntperpage;
  }

  return(tmpidx);
}

function AnsCheck(pindex, ansTmp)
{
  var tmp, checked;
  var pos = 0;
  var cindex = "", aTmp, lbltmp = "";
  var arrTmp;
  var tmpCa, tmpCa2;

  // 보기표시 색깔변경

  for (var i = ArrStart[gindex - 1]; i <= ArrEnd[gindex - 1]; i++) {
    pos++;
    if (pindex + 1 == i) { break; }
  }

  if (ArrQType[pindex] != 5) {
    document.frmData.oldnon.value = ""; // 비교를 위해 논술형 답안을 초기화
  }

  if (ArrQType[pindex] == 3) // 3:복수답안형
  {
    tmp = "";
    for (var i = 0; i < ArrExCount[pindex]; i++)
    {
      eval("checked = document.frmData.ans" + pindex + "[" + i + "].checked;");
      if (checked == true)
      {
        eval("tmp += document.frmData.ans" + pindex + "[" + i + "].value;");
        tmp += OR_GUBUN;
        eval("document.all.ln" + pos + (i + 1) + ".style.color = 'red';");
        eval("document.all.ex" + pos + (i + 1) + ".style.color = 'red';");
        cindex += i + OR_GUBUN;
      }
      else
      {
        eval("document.all.ln" + pos + (i + 1) + ".style.color = 'black';");
        eval("document.all.ex" + pos + (i + 1) + ".style.color = 'black';");
      }
    } // end of for loop

    if (tmp != "") { tmp = tmp.substr(0, tmp.length - OR_GUBUN.length); }
    ArrAnswers[pindex] = tmp;

    if (yn_viewas == "Y")
    {
      if (cindex == "") { lbltmp = " "; }
      else
      {
        cindex = cindex.substr(0, cindex.length - OR_GUBUN.length);
        aTmp = cindex.split(OR_GUBUN);
        for(var i = 0; i < aTmp.length; i++) { lbltmp += ArrExlabel[aTmp[i]] + "," }
        lbltmp = lbltmp.substr(0, lbltmp.length-1);
      }
      eval("document.all.replya" + (pindex + 1) + ".innerText = '" + lbltmp + "';");
    }

  } // end of 3:복수답안형

  else if (parseInt(ArrQType[pindex]) == 4 && ArrCaCount[pindex] > 1) // 4:단답형 and 복수답
  {
    tmp = ""; tmpCa2 = "";

    for (var i = 0; i < ArrCaCount[pindex]; i++)
    {
      eval("tmp += KeyWord_Chk(document.frmData.ans" + pindex + "[" + i + "].value);");
      tmp += OR_GUBUN;

      if (yn_viewas == "Y")
      {
        //답안지창에 표시해 주기 위하여
        eval("tmpCa = document.frmData.ans" + pindex + "[" + i + "].value;");
        tmpCa = "☞ " + tmpCa;
        if (tmpCa.length > ANS_MAX_LEN + 1) { tmpCa = tmpCa.substr(0, ANS_MAX_LEN + 1) + ".."; }
        //화면표시를 위해 문자변경
        tmpCa = ansDis(tmpCa);
        tmpCa2 += tmpCa + "<br>"
      }
    }

    tmp = tmp.substr(0, tmp.length - OR_GUBUN.length);
    tmpCa2 = tmpCa2.substr(0, tmpCa2.length - 4);
    ArrAnswers[pindex] = tmp;

    if (yn_viewas == "Y") {
      eval("document.all.replya" + (pindex + 1) + ".innerHTML = '" + tmpCa2 + "';");
    }

  } // end of 4:단답형 and 복수답

  else if (ArrQType[pindex] == 5) // 5:논술형
  {
    if (document.frmData.nonans.value != "") { ArrNonChk[pindex] = "Y"; }
    else { ArrNonChk[pindex] = "N"; }

    // 답안지에 표시하기 위해서 엔터값을 날린다
    ansTmp = ansTmp.replace(/\r/g, " ");
    ansTmp = ansTmp.replace(/\n/g, "");

    if (yn_viewas == "Y")
    {
      if (ansTmp == "") {
        ansTmp = "(논술)미작성";
      } else if (ansTmp.length > ANS_MAX_LEN) {
        ansTmp = ansTmp.substr(0, ANS_MAX_LEN) + "..";
      }

      //화면표시를 위해 문자변경
      ansTmp = ansDis(ansTmp);
      eval("document.all.replya" + (pindex + 1) + ".innerHTML = '" + ansTmp + "';");
    }

  } // end of 5:논술형

  else // 1:OX, 2:선다형, 4:단답형 and 단수답
  {
    ArrAnswers[pindex] = KeyWord_Chk(ansTmp);

    // 선택한 보기의 색변경
    if (ArrQType[pindex] <= 2) // 1:OX, 2:선다형
    {
      for (var i = 0; i < ArrExCount[pindex]; i++)
      {
        if (eval("document.frmData.ans" + pindex + "[" + i + "].value == ansTmp"))
        {
          eval("document.all.ln" + pos + (i + 1) + ".style.color = 'red';");
          eval("document.all.ex" + pos + (i + 1) + ".style.color = 'red';");
          if (yn_viewas == "Y") {
            eval("document.all.replya" + (pindex + 1) + ".innerText = '" + ArrExlabel[i] + "';");
          }
        }
        else {
          eval("document.all.ln" + pos + (i + 1) + ".style.color = 'black';");
          eval("document.all.ex" + pos + (i + 1) + ".style.color = 'black';");
        }
      }
    } // end of 1:OX, 2:선다형 (선택한 보기의 색변경)

    if (yn_viewas == "Y")
    {
      if (ArrQType[pindex] == 4) // 4:단답형 and 단수답
      {
        if (ansTmp.length > ANS_MAX_LEN) { ansTmp = ansTmp.substr(0, ANS_MAX_LEN) + ".."; }
        ansTmp = ansDis(ansTmp); // 화면표시를 위해 문자변경
        eval("document.all.replya" + (pindex + 1) + ".innerHTML = '" + ansTmp + "';");
      }
    }

  } // end of 1:OX, 2:선다형, 4:단답형 and 단수답

  if (yn_viewas == "Y") { replyCheck(pindex); }
}

function AnsSave(pType)
{
  // pType : N=Next, P=Previous, C=GetQ?, F=무조건DB저장

  var form = document.frmData;
  var strAns = ArrAnswers.join(Q_GUBUN);
  var id_q = form.id_q.value;
  form.movetype.value = pType;

  if (id_q == "") // 논술형이 아님
  {
    if ((form.answers.value == strAns || strAns == "") && pType != "F") // 답안변경무 or 답안무
    {
      // 로그남기기
      form.answers.value = KeyWord_log(strAns);
      form.log_type.value = "2";
      form.method = "post";
      form.target = "fraAction";
      form.action = "savelog.jsp";
      form.submit();

      if (pType == "N")    { GetNext(); }
      else if(pType == "P"){ GetPrevious(); }
      else if(pType == "C"){ GetQ(); }
    }

    else // 답안변경유 or pTYpe = "F"
    {
      // DB 에저장 (DB 저장시 로그남기기 병행)
      strAns = ansChange(strAns);
      form.answers.value = strAns;
      form.method = "post";
      form.target = "fraAction";
      form.action = "saveans.jsp";
      form.submit();
    }

  } // end of id_q == "" : 논술형이 아님

  else // id_q != "" : 논술형
  {
    if (form.nonans.value == form.oldnon.value && pType != "F") // 논술형 답안 변경무
    {
      // 로그남기기
      form.log_type.value = "2";
      form.newnon.value = "";
      strAns = ansChange(form.nonans.value);
      form.newnon.value = strAns;
      form.method = "post";
      form.target = "fraAction";
      form.action = "savelog.jsp";
      form.submit();

      if (pType == "N")    { GetNext(); }
      else if(pType == "P"){ GetPrevious(); }
      else if(pType == "C"){ GetQ(); }
    }

    else // 논술형 답안 변경유 or pType = "F"
    {
      if (pType != "F") {
        if (NonLength() == false) {
          return;
        }
      }

      // DB 에저장 (DB 저장시 로그남기기 병행)
      form.oldnon.value = form.nonans.value;
      form.newnon.value = "";
      strAns = ansChange(form.nonans.value);
      form.newnon.value = strAns;
      form.method = "post";
      form.target = "fraAction";
      form.action = "saveans.jsp";
      form.submit();
    }
  } // end of id_q != "" : 논술형
}

function NonLength()
{
  // 논술형의 입력한 글자수 표시
  var non_length = document.frmData.nonans.value.length
  myalert(non_length + "자를 입력하였습니다.");
  if (non_length > 5000) {
    myalert("논술형 답안은 5000자 이내에서 작성하셔야 합니다.");
    return false;
  }
  return true;
}

function EvtLog(pType)
{	
  ignoreLostFocus = true;
  
  var form = document.frmData;
  form.answers.value = ArrAnswers.join(Q_GUBUN);
  form.log_type.value = "1";
  form.id_activity_type.value = pType;

  form.method = "post";
  form.target = "fraActionEvt";
  form.action = "savelog.jsp";
  form.submit();
}

function SubmitPage()
{
  var form = document.frmData;
  var strMsg;

  ignoreLostFocus = true;
  ExamEndYN = "Y";

  if (id_ltimetype == "Y" && form.timeLeft.value == "-1") {}
  else {
    for(var i = ArrStart[0] - 1; i < ArrEnd[gindex - 1]; i++)
    {
      if (ArrQType[i] <= 4) // 논술형이 아니면
      {
        if (ArrAnswers[i] == "") {
          ExamEndYN = "N";
          myalert((i + 1) + " 번 문제의 답안을 입력하지 않으셨습니다 !!!");
          //return;
        }
      }
      else // 논술형
      {
        if (ArrNonChk[i] == "N") {
          ExamEndYN = "N";
          myalert((i + 1) + " 번 문제의 답안을 입력하지 않으셨습니다 !!!!!!");
          //return;
        }
      }

	  break;

    } // end of for loop (모든 문제에 대하여)

    if (ExamEndYN == "N")
    {
      if (confirm("정말로 답안을 제출 하시겠습니까 ????") == false) {
        ignoreLostFocus = true;
        return;
      }
      ExamEndYN = "Y";
    }
    else
    {
      if (confirm("답안을 제출 하시겠습니까?") == false) {
        ignoreLostFocus = true;
        return;
      }
      ExamEndYN = "Y";
    }
  }

  timerStop();

  document.all.timeLimitHMS.style.display = "none";
  document.all.Re_No.style.display = "none";
  if (yn_viewas == "Y") { document.all.reply.style.display = "none"; }
  document.all.contents.style.display = "none";
  document.all.resubmit.style.display = "";

  form.answers.value = ansChange(ArrAnswers.join(Q_GUBUN));  // 현재 답안의 테그변경
  form.newnon.value = "";  // 답안전송을 위해 클리어

  if (ArrQType[ArrStart[gindex - 1] - 1] == 5) // 현재 페이지가 논술형
  {
    form.oldnon.value = form.nonans.value;
    form.newnon.value = "";
    strAns = ansChange(form.nonans.value);
    form.newnon.value = strAns;
  }

  // 답안제출 Event Log : 5
  EvtLog("5");

  // 답안지 저장
  form.yn_submit.value = "Y";
  form.method = "post";
  form.target = "fraAction";
  form.action = "saveans.jsp";
  form.submit();
}

function End_Msg()
{
  document.all.outImg.style.display = "";
  document.all.test_end.style.display = "";

  document.all.resubmit.style.display = "none";
  document.all.nonImg.style.display = "none";
  document.all.test_end.style.display = "";
}

function AlertDisplay(strTmp)
{
  var strMsg = "";

  strMsg += "<table align='center' border='0' width='80%' height='80%'>";
  strMsg += "<tr><td align='center'>";
  strMsg += "<big><font color='blue'><b>" + strTmp + "</b></font></big>";
  strMsg += "<br><br><a href='javascript:QResume();'><b>문제화면으로..</b></a>";
  strMsg += "</td></tr>";
  strMsg += "</table>";
  document.all.contents.style.display = "none";
  document.all.msg.innerHTML = strMsg;
  document.all.message.style.display = "";
}

function RestoreChar(strTmp)
{
  var tmpStr;
  tmpStr = strTmp.replace(giCHAR_PATTERN1, "\"");

  return(tmpStr);
}

function RestoreChar2(strTmp)
{
  var tmpStr = ansChange(strTmp);

  tmpStr = tmpStr.replace(giCHAR_PATTERN1, "&#34;"); // double-qoute
  tmpStr = tmpStr.replace(giCHAR_PATTERN2, "\r");    // carage return
  tmpStr = tmpStr.replace(giCHAR_PATTERN3, "\\");    // back-slash
  tmpStr = tmpStr.replace(giCHAR_PATTERN4, "&#34;"); // double-qoute

  return(tmpStr);
}

function CheckKeys(pindex)
{
  if(event.keyCode == 13) { event.keyCode = 0; }
}

function Hide()
{
  document.all.examsubmit.style.display = "none";
  document.all.contents.style.display = "none";
  document.all.msg.style.display = "none";
}

function replyCheckAll()
{
  for (var i = 0; i < ArrAnswers.length; i++)
  {
    if (ArrAnswers[i] != "") {
      eval("document.all.reply" + (i + 1) + ".style.backgroundColor = '#F1EBAD';");
    } else {
      if (ArrNonChk[i] == "Y") {
        eval("document.all.reply" + (i + 1) + ".style.backgroundColor = '#F1EBAD';");
      }
    }
  }
}

function replyCheck(pindex)
{
  if (ArrQType[pindex] <= 4) // 논술형이 아니면
  {
    eval("document.all.reply" + (pindex + 1) + ".style.backgroundColor = '#F1EBAD';");
  }
  else // 논술형
  {
    if (document.frmData.nonans.value != "") {
      ArrNonChk[pindex] = "Y";
      eval("document.all.reply" + (pindex + 1) + ".style.backgroundColor = '#F1EBAD';");
    } else {
      ArrNonChk[pindex] = "N";
      eval("document.all.reply" + (pindex + 1) + ".style.backgroundColor = '#FFFFFF';");
    }
  }
}

function retrySubmit()
{
  // 답안재제출 Event Log
  EvtLog("6");

  var form = document.frmData;
  /*
  var win;
  win = window.open("", "submitPage", "width=300, height=200, scrollbars=no,resizable=yes");
  win.focus();
  form.target = "submitPage";
  form.yn_submit.value = "Y";
  form.method = "post";
  form.action = "saveans.jsp";
  form.submit();
  */
  form.target = "fraAction";
  form.yn_submit.value = "Y";
  form.method = "post";
  form.action = "saveans.jsp";
  form.submit();
}

function ansChange(pval)
{
  var chgAns;

  chgAns = pval.replace(/\&/g, "&amp;");
  chgAns = chgAns.replace(/</g, "&lt;");
  chgAns = chgAns.replace(/>/g, "&gt;");
  chgAns = chgAns.replace(gRKEYWORD_A, KEYWORD_A);
  chgAns = chgAns.replace(gRKEYWORD_B, KEYWORD_B);
  chgAns = chgAns.replace(gRKEYWORD_C, KEYWORD_C);

  return(chgAns);
}

function ansDis(pval)
{
  var tmpCa;

  tmpCa = pval.replace(/\&/g, "&amp;");
  tmpCa = tmpCa.replace(/\\/g, "&#92;");
  tmpCa = tmpCa.replace(/</g, "&lt;");
  tmpCa = tmpCa.replace(/>/g, "&gt;");
  tmpCa = tmpCa.replace(/'/g, "&#39;");
  tmpCa = tmpCa.replace(giCHAR_PATTERN3, "&#92;");

  return(tmpCa);
}

function KeyWord_Chk(rtmp)
{
  rtmp = rtmp.replace(/{:}/g, RKEYWORD_A);
  rtmp = rtmp.replace(/{\|}/g, RKEYWORD_B);
  rtmp = rtmp.replace(/{\^}/g, RKEYWORD_C);
  return(rtmp);
}

function KeyWord_bak(rtmp)
{
  rtmp = rtmp.replace(gRKEYWORD_A, "{:}");
  rtmp = rtmp.replace(gRKEYWORD_B, "{|}");
  rtmp = rtmp.replace(gRKEYWORD_C, "{^}");
  return(rtmp);
}

function KeyWord_log(rtmp)
{
  rtmp = rtmp.replace(gRKEYWORD_A, KEYWORD_A);
  rtmp = rtmp.replace(gRKEYWORD_B, KEYWORD_B);
  rtmp = rtmp.replace(gRKEYWORD_C, KEYWORD_C);
  return(rtmp);
}

function Cnv(str)
{
  // 다국어 처리 함수
  var ver = parseFloat(ScriptEngineMajorVersion() + "." + ScriptEngineMinorVersion());
  var re = /(&#)(\d+)(;)/g;
  var re2 = /\&amp;/g;
  var re3 = /\&lt;/g;
  var re4 = /\&gt;/g;
  var tmpStr = "";

  if (ver >= 5.5)
  {
    tmpStr = str.replace
    (re, function($0,$1,$2) {
      return (String.fromCharCode($2));
    }
    );
  }
  else
  {
    if (str != "")
    {
      var arr, i, repStr;
      arr = str.match(re);

      if (arr != null)
      {
        for (i=0;i<arr.length;i++) {
          repStr = arr[i].substr(2, arr[i].length - 3);
          str = str.replace(arr[i], String.fromCharCode(repStr));
        };
        tmpStr = str;
      }
      else
      {
        tmpStr = str;
      }
    }
  }

  tmpStr = tmpStr.replace(re3, "<");
  tmpStr = tmpStr.replace(re4, ">");
  tmpStr = tmpStr.replace(re2, "&");

  return(tmpStr);
}

function mExamArea()
{
  // 시험지 표시 영역을 그리는 부분

  var strArea = "";
  var i = 0;
  var exRowidx = 0;
  var Guide_msg = "";  

  strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top' width='100%' id='contents2'>";

  // 모든문제에 대해서 Loop 를 돌려가며

  for(var k = ArrStart[gindex - 1] - 1; k < ArrEnd[gindex - 1]; k++)
  {
    i++;
    strArea += "<tr><td>";
    strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top' width='100%'>";
    strArea += "<tr><td height='20'></td></tr><tr><td>"; // 빈줄

    <% if(Guide_area) { %>
	<% for(int kk = 0; kk < jls2.length; kk++) { %> 
			if(<%=jls2[kk].getNr_q()-1%> == k) {
				Guide_msg = "<%=jls2[kk].getGuide_msg()%>";
				strArea += "</td></tr>";
				strArea += "<tr><td height='20' class='q'><font color=blue><b>* " + Guide_msg + "</b></font></td></tr><tr><td>";
				strArea += "<tr><td height='10'></td></tr><tr><td>"; // 빈줄  
			}
	<%
		}
	} else {		
	%>
		strArea += "</td></tr>";
			strArea += "<tr><td height='10'></td></tr><tr><td>"; // 빈줄  
	<%
	}
	%>	
	
	// 지문영역
    if (ArridRef[k] != "0")
    {
      strArea += "<div id='ref" + i + "'></div>";
      strArea += "</td></tr>";
      strArea += "<tr><td height='12'></td></tr><tr><td>"; // 빈줄
    }

    // 문제영역
    strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top'>";
    strArea += "<tr>";
    strArea += "<td valign='top'><div id='quizno" + i + "'></td>";
    strArea += "<td width='5'></td>";
    strArea += "<td><div id='quiz" + i + "'></div></td>";
    strArea += "</tr>";
    strArea += "</table></td></tr>";
    strArea += "<tr><td height='7'></td></tr><tr><td>"; // 빈줄

    strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top'>";

    // 보기영역

    if (ArrQType[k] <= 3) // 1:OX, 2:선다, 3:복수답안
    {

	  exRowidx = 0;
	  
	  for (var m = 0; m <= ArrExCount[k]; m++)
      {
           if (exRowidx == 0) {
			   strArea = strArea + "<tr>";
			   strArea = strArea + "<td valign='top' width=30></td>";
	       }
		
		   strArea = strArea + "<td valign='top' heigth='20'><div id='lb" + i + m + "'></td>";
		   strArea = strArea + "<td valign='top' heigth='20'><div id='ln" + i + m + "'></td>";
		   strArea = strArea + "<td heigth='20'><div id='ex" + i + m + "'></div></td>";
		   strArea = strArea + "<td width='50'></td>";

    	   exRowidx++;

		   if (ArrExRow[k] == exRowidx) {
			   strArea = strArea + "</tr>";
			   exRowidx = 0;
		   }
	  }
				
	  //보기의 갯수로 인하여 tr이 닫히는 않을경우 처리
	  if (exRowidx != 0) {
		  strArea = strArea + "</tr>";
		  exRowidx = 0;
	  }

   } else // 4:단답형, 5:논술형
     {
      strArea += "<tr>";
      strArea += "<td valign='top' colspan='2'><div id='lb" + i + "1'></td>";
      strArea += "<td><div id='ex" + i + "1'></div></td>";
      strArea += "</tr>";
    }

    strArea += "</table></td></tr></table></td></tr>";
  }

  strArea += "</table></td></tr></table>";

  document.all.quizdiv.innerHTML = strArea;
}
</script>

<script language="javascript">

// for timer

function timerStop()
{
  if (isTimer) { window.clearTimeout(timerID); }
  isTimer = false;
}

// 시험 종료용 타이머

function Timerinit()
{
  var timeLimit = limittime;  // [sec]
  var timeLeft = remain_time; // [sec]

  document.all("timeLimitHMS").innerText = "제한시간 : " + displayHMS(timeLimit);
  timerStart(timeLeft);
}

function timerStart(intSeconds)
{
  timerStop();

  var sDate = new Date();
  started = sDate.getTime();

  timeLeftStart = intSeconds;
  timeLeft = timeLeftStart;
  isTimer = true;
  timer();
}

function timer()
{
  var form = document.frmData;
  var interval = 1;
  var nDate = new Date();
  var now = nDate.getTime();
  var elapsed = 0;
  var i, tmp = "";

  if (LastTime == 0 || LastTime < now) {
    LastTime = now;
  } else if (LastTime > now) {
    form.etc.value = "타이머 조작 - 사용자가 PC의 타이머를 조작 하였습니다";
    EvtLog("41");
    myalert("사용자 PC의 타이머를 조작 하였습니다\n타이머 조작은 부정행위 입니다\n\n시험을 중단 합니다");
    top.window.close();
    return;
  }

  if (isTimer && timeLeft > 0)
  {
    elapsed = Math.ceil((now - started) / 1000 + 0.5);
    timeLeft = timeLeftStart - elapsed;
    form.timeLeft.value = timeLeft;
    document.all.timeLimitHMS.innerText = displayHMS(timeLeft) + " " ;
    timerID = window.setTimeout("timer()", interval * 1000);

    if (timeLeft == 180)
    {
      // 종료시간 3분전에 안내 메시지 표시
      myalert("시험 종료시간 까지 3분이 남았습니다.\n\n답안작성을 서두르시기 바랍니다");
    }
  }
  else // 제한시간 종료시
  {
    if (id_ltimetype == "Y") {
      form.timeLeft.value = "-1";
      ExamEndYN = "Y";
      myalert("제한시간이 경과되어 답안을 자동으로 제출합니다");
      SubmitPage();
    }
    else if(id_ltimetype == "N") { }
  }
}

// 입실 대기용 타이머

function Timerinit2()
{
  var timeLimit = to_exam_start1;
  var timeLeft = to_exam_start1;

  document.all("timeWait").innerText = displayHMS(timeLimit);
  timerStart2(timeLeft);
}

function timerStart2(intSeconds)
{
  timerStop();

  var sDate = new Date();
  started = sDate.getTime();

  timeLeftStart = intSeconds;
  timeLeft = timeLeftStart;
  isTimer = true;
  timer2();
}

function timer2()
{
  var form = document.frmData;
  var interval = 1;
  var nDate = new Date();
  var now = nDate.getTime();
  var elapsed = 0;

  if (LastTime == 0 || LastTime < now)
  {
    LastTime = now;
  }
  else if (LastTime > now)
  {
    form.etc.value = "타이머 조작 - 사용자가 PC의 타이머를 조작 하였습니다";
    EvtLog("41");
    myalert("사용자 PC의 타이머가 오동작 하였습니다\n\n타이머가 오동작 하여 시험을 중단 합니다");
    top.window.close();
    return;
  }

  if (isTimer && timeLeft >= 0)
  {
    elapsed = Math.ceil((now - started) / 1000 + 0.5);
    document.all.timeWait.innerText = displayHMS(timeLeft) + " " ;
    timeLeft = timeLeftStart - elapsed;
    timerID = window.setTimeout("timer2()", interval * 1000);
  }
  else // 제한시간 종료시
  {
    // 시험시작 시간이 되었으므로 시험의 타이머를 진행 시킨다.
    document.all.timeWait.style.display = "none";
    examStart();
  }
}

// 시간 디스플레이

function displayHMS(intSeconds)
{
  var intTmp, hh, mm, ss, strHMS;

  intTmp = Math.floor(intSeconds / 3600);
  hh = (intTmp <= 0) ? "" : (intTmp + "시간 ");

  intTmp = Math.floor((intSeconds % 3600) / 60);
  if (intTmp <= 0) { mm = "" }
  else if (intTmp < 10) { mm = intTmp + "분 " }
  else { mm = intTmp + "분 " }

  intTmp = Math.floor(intSeconds % 60);
  if (intTmp <= 0) { ss = "0초" }
  else if (intTmp < 10) { ss = intTmp + "초 " }
  else { ss = intTmp + "초 " }

  strHMS = hh + mm + ss;

  return(strHMS);
}

</script>

</head>

<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" onload="init();" onmouseout="CheckMove();" onblur="LostFocus();" onunload="CloseUsingX();" onresize="Resize();">

<% /* divAll */ %>
<div id="divAll">

<form name="frmData">

<input type="hidden" name="userid">
<input type="hidden" name="id_exam">
<input type="hidden" name="title">
<input type="hidden" name="id_ltimetype">
<input type="hidden" name="paper_type">
<input type="hidden" name="yn_open_score_direct">
<input type="hidden" name="answers">
<input type="hidden" name="timeLeft">
<input type="hidden" name="id_activity_type">
<input type="hidden" name="oxs">
<input type="hidden" name="etc">
<input type="hidden" name="nr_q">
<input type="hidden" name="id_q">
<input type="hidden" name="yn_submit" value="N">
<input type="hidden" name="log_type" value="1">
<input type="hidden" name="movetype" value="C">
<textarea name="oldnon" style="display:none"></textarea>
<textarea name="newnon" style="display:none"></textarea>

<!--// 2008-07-09 추가//-->
<input type="hidden" name="limittime" value="<%= limittime %>">
<input type="hidden" name="logtype" value="">
<input type="hidden" name="nr_set">
<input type="hidden" name="logstyle" value="1">
<!------------------------>

<TABLE cellpadding="0" cellspacing="0" border="0" class="Layout">
	<!-- 상단 -->
	<TR id="Top">
		<TD id="A">&nbsp;</TD>
		<TD id="B">
			<!-- 시험명 및 제한시간 -->
			<Div id="L">
				<TABLE cellpadding="0" cellspacing="0" BORDER="0">
					<TR>
						<!-- 로고 표시 -->
						<TD id="Logo"><img src="../logo/logo.gif"></TD>
						<!-- 시험명 및 제한시간 표시 -->
						<TD id="Title"><%=title%><div id="time" style="display:;"><div id="timeLimitHMS"></div></div></TD>
						<TD id="Bg">&nbsp;</TD>
					</TR>
				</TABLE>
			</Div>
			<!-- 버튼 삽입 -->
			<Div id="R">
			<img src="<%= imagesDir%>/bt_refresh.gif" id="Re_No" name="Re_No" style="display:none; cursor: hand;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Re_No','','<%= imagesDir%>/bt_refresh_up.gif',1)" onclick="JavaScript:refresh_onclick();"><img id="outImg" style="cursor: hand; display:" src="<%= imagesDir%>/bt_out.gif" name="outImg" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('outImg','','<%= imagesDir%>/bt_out_up.gif',1)" onclick="JavaScript:goout_onclick();"><img id="nonImg" style="cursor: hand; display: none;" src="<%= imagesDir%>/bt_non.gif" name="nonImg"></Div>
		</TD>
		<TD id="C">&nbsp;</TD>
	</TR>
	
	<!-- 본문 -->
	<TR id="main">	
		<TD id="A">&nbsp;</TD>
		<!-- 내용 -->
		<TD id="B">
			<div id="centerdiv" style="overflow: no; width: 100%; height: 100%;">
				<!-- 시험 시작 전 단계: No1 -->
				<div id="guide" style="display: ">
					<TABLE border="0" cellpadding="0" cellspacing="0">
						<TR>
							<TD id="img"><img src="<%=sv_root%>/images/img_guide.gif"></TD>
							<TD align="center">
								<TABLE id="table" cellpadding="0" cellspacing="0" border="0">
									<TR>
										<TD id="A">&nbsp;</TD>
									</TR>
									<TR>
										<TD id="B">
											<% if(remain_time != 0) { %>
											<% if(yn_sametime.equalsIgnoreCase("N")) { %><li>제한 시간은 <font color="red"><b><%= limittime / 60 %></b>분</font> 입니다.</li><% } %>
											<% } %>
											<li>다음 이동 버튼이 10초이상 표시되지 않을 경우 새로고침 버튼을 누르시기 바랍니다.</li>
											<li>새로고침 버튼을 눌러도 해결이 안될 경우 인터넷 연결을 확인하시기 바랍니다.</li>
								<% if( ! yn_sametime.equalsIgnoreCase("Y")) { %>
											<li>시험에 응시할 준비가 되셨으면 시험시작 버튼을 클릭하여 시험에 응시하십시요.</li>
											<li>아직 준비가 되지 않으셨다면 오른쪽 상단의 나가기 버튼을 클릭하여 나가실 수 있습니다. </li>								
										</TD>
									</TR>
									<TR>
										<TD id="C">&nbsp;</TD>
									</TR>
								</TABLE>
								<p>
								<input type="image" src="<%= imagesDir%>/bt_start.gif" <% if(yn_sametime.equalsIgnoreCase("N")) { %> onClick="JavaScript:examStart();" <% } else { %> onclick="JavaScript:examStart();" <% } %> id="startbutton" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('startbutton','','<%= imagesDir%>/bt_start_up.gif',1)" name="startbutton">
								</p>
								<% } else { %>
											<li>대기시간이 끝나면 자동으로 시험이 시작 됩니다.</li> 
											<hr>
											<li>시험시작 대기시간</li>
											<div style="padding: 10px 0px 0px 15px;"><span id="timeWait" style="display: margin-top: 50px;"></span></div>
											<input type="image" src="<%= imagesDir%>/bt_start.gif" id="startbutton" style="display:none;">
										</TD>
									</TR>
									<TR>
										<TD id="C">&nbsp;</TD>
									</TR>
								</TABLE>
								<% } %>
							</TD>
						</TR>
					</TABLE>	
				</div>

				<!-- 시험 진행 중: No2 -->
				<div id="contents" style="display: none;">	
					<TABLE cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
						<% if(paper_type.equals("12") || paper_type.equals("11") || paper_type.equals("13")) { %>
						<TR>
							<!-- 문제 및 보기 타이틀-->
							<TD id="Ltitle"><div style="float: left;"><img src="<%= imagesDir%>/question.gif"></div><div style="float: right;"><img src="<%= imagesDir%>/question_.gif"></div></TD>
							<!-- 나의 답안 확인 타이틀 -->
							<TD id="Rtitle"><img src="<%= imagesDir%>/answer.gif"></TD>
						</TR>
						<% } %>
						<TR>						
							<TD id="L">
							<!-- 문제 및 보기 화면 -->
							<div style="overflow: auto; height: 100%; width: 100%;">
								<div id="quizdiv" style="width: 100%;"></div>
								<div id="msg" style="width: 100%;"></div>		
								<!-- 버튼 삽입 -->
								<div id="button" style="width: 100%;">
									<img src="<%= imagesDir%>/bt_pre.gif" onclick="javascript:PreviousQ();" id="prevbtn" style="cursor: hand;">
									<img src="<%= imagesDir%>/bt_next.gif" onclick="javascript:NextQ();" id="nextbtn" style="cursor: hand;">
									<!--img src="<%= imagesDir%>/bt_pre_subject.gif">
									<img src="<%= imagesDir%>/bt_next_subject.gif"-->
									<img src="<%= imagesDir%>/bt_end.gif" style="cursor: hand;" onclick="javascript:SubmitPage();" id="examsubmit">
								</div>
							</div>
							</TD>
							<!-- 나의 답안 확인 창 -->
							<TD id="reply">
								<% if(yn_viewas.equalsIgnoreCase("Y")) { %>
								<div id="ansdiv" style="overflow: auto; width: 100%; height: 100%;">
								<TABLE cellpadding="0" cellspacing="0" border="0">
									<TR id="title">
										<TD>문제</TD>
										<TD>답안</TD>
									</TR>
									<%
										for (int i = 0; i < qcount ; i++) // 문제별로 답안 표시
										{
										  String ansDisp = User_QmTm.getAnsDisplay(i, qs, arrAnswers, arrExlabel);
										  String trColor;
										  if ((i % 2) == 0) { trColor = "#F7F7E8"; }
										  else { trColor = "#FFFFFF"; }
										%>
										<tr bgcolor="<%= trColor %>">
										  <% if (id_movepage.equalsIgnoreCase("F")) { %>
										  <td align="center" id="reply<%= i + 1 %>" width="50"><a href="javascript:GotoQ(<%= i %>)"><font color="blue"><u><%= i + 1 %></u></font></a></td>
										  <td align="center" id="replya<%= i + 1 %>" width="120"><%= ansDisp %></td>
										  <% } else { %>
										  <td align="center" id="reply<%= i + 1 %>" width="50"><font color="blue"><%= i + 1 %></font></td>
										  <td align="center" id="replya<%= i + 1 %>" width="120"><%= ansDisp %></td>
										  <% } %>
										</tr>
										<%
										} // end of for loop : 문제별로 답안표시
										%>
								</TABLE>
								</div>
								<% } %>
							</TD>
						</TR>
					</TABLE>						
				</div>
				<!-- 시험 종료 단계: No3 -->
				<div id="test_end" style="display:none;">	
					<TABLE border="0" cellpadding="0" cellspacing="0">
						<TR>
							<TD id="img"><img src="<%=sv_root%>/images/img_test_end.gif"></TD>
							<TD align="center">
								
								<TABLE id="table" cellpadding="0" cellspacing="0" border="0">
									<TR>
										<TD id="A">&nbsp;</TD>
									</TR>					
									<TR>
										<TD id="B">	
											<% if(yn_open_score_direct.equalsIgnoreCase("Y")) { %>
											<li>점수: <span id="end_score"></span></li>
											<li>총점: <%= allotting %></li>
											<li>문제수: <%= qcount %></li>		
											<hr>
											<li>위 점수는 가채점 결과로 단답형 채점 및 채점보정에 의해 변동이 있을 수 있습니다.</li>
											<% } %>	
											<li>작성하신 답안이 정상적으로 제출되었습니다.</li>
											<li>시험에 응시하시느라 수고 많으셨습니다.</li>	
										</TD>
									</TR>	
									<TR>
										<TD id="C">&nbsp;</TD>
									</TR>
								</TABLE>
								<p><img src="<%= imagesDir%>/bt_out2.gif" name="bt_out2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt_out2','','<%= imagesDir%>/bt_out2_up.gif',1)" style="cursor: hand;" onclick="JavaScript:goout_onclick();"></p>
							</TD>
						</TR>
					</TABLE>
					
				</div>
				<!-- 수동 답안 제출 화면 -->
				<div id="resubmit" style="display:none;">
					<TABLE id="table" cellpadding="0" cellspacing="0" border="0">					
						<TR>
							<TD id="A"><img src="<%= imagesDir%>/resubmit.gif"></TD>
						</TR>
						<TR>
							<TD id="B">
								네트워크 부하로 인하여 답안 저장에 약간의 시간이 소요될 수 있습니다.<br>
								20초 이상 현재 화면이 그대로일 경우 아래 재전송 버튼을 클릭하여 답안을 재전송 하십시오.	
								<div class="button" align="left"><img type="button" value="답안 재전송" onclick="javascript:retrySubmit();" src="<%=imagesDir%>/bt_retry.gif" style="cursor: hand;"></div>
							</TD>						
					</TABLE>					
				</div>
			</div>
		</TD>
		<TD id="C">&nbsp;</TD>
	</TR>
	<!-- 하단 -->
	<TR id="Bottom">
		<TD id="A">&nbsp;</TD>
		<TD id="B"><img src="<%= imagesDir%>/copyright.gif"></TD>
		<TD id="C">&nbsp;</TD>
	</TR>
</TABLE>

</form>
</div>
</body>
</html>

<%
//******************************************************************************
//   ����  �׷� : etest.jsp
//   ��  ��  �� : ������ ������������
//   ��      �� : �Ϲ��� ������ ������������
//   �� ��   �� : 
//   �ڹ�  ���� : 
//   ��  ��  �� : 
//   ��  ��  �� : 
//   ��  ��  �� : 
//   ��  ��  �� : 
//	 ����  ���� : 
//******************************************************************************
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.*, etest.*, etest.paper.*, java.sql.*, java.sql.Timestamp, qmtm.tman.answer.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<%	
	//String userid = request.getParameter("userid");
	String userid = (String)session.getAttribute("current_userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (userid == "" || id_exam == "") {
		throw new QmTmException("[�α��� �ʿ��մϴ�.]@close@notice");
	}

	String gindex = request.getParameter("gindex");
	String refresh_YN = "Y";
	if (gindex == null) {
		gindex = "0";
		refresh_YN = "N";
	}

	String timeLeft = request.getParameter("timeLeft"); // ���赵�� refresh �� ���
	if (timeLeft == null || timeLeft.equals("")) { timeLeft = "999999999"; }
	long refresh_remain_time = Long.parseLong(timeLeft);
%>
<%
	/* WindowsXP SP2 ����... */
	String browser = request.getHeader("User-Agent");
	boolean isSP2 = (browser.indexOf("SV1") >= 0) ? true : false;

	String user_ip = request.getHeader("iv-remote-address");

	if(user_ip == null || user_ip.equals("")) {
		user_ip = request.getRemoteAddr();
	}
%>

<%
  // *************�����ð� �������� �о���� ���� (by sjh - 2013.10.10)*************
  String PersonalTimeYN = "N";
  String yn_sametimes = "";
  Timestamp login_starts = null;
  Timestamp login_ends = null;
  Timestamp exam_starts1 = null;
  Timestamp exam_ends1 = null;

  PersonalTime2Bean ptb = null;

  if (!userid.equals("tman@@2008")) { //������ �ϰ�쿡�� üũ�� ���Ѵ�.
	  
	  try {
		  ptb = PersonalTime2.getTime(id_exam, userid);
	  } catch(Exception ex) {
		  out.println(ComLib.getExceptionMsg(ex, "fclose"));

	      if(true) return;
	  }

	  if(ptb == null) {
		  PersonalTimeYN = "N";
	  } else {
          PersonalTimeYN = "Y";
		  yn_sametimes = ptb.getYn_sametime();
		  login_starts = ptb.getLogin_start();
		  login_ends = ptb.getLogin_end();
		  exam_starts1 = ptb.getExam_start1();
		  exam_ends1 = ptb.getExam_end1();
	  }
  }
  // *************�����ð� �������� �о���� ���� (by sjh - 2013.10.10)*************

%>

<%
  // Step 1 : ������ �⺻ ���� ���� �о�´�
	User_ExamInfoBean ei;

	if (PersonalTimeYN.equals("Y")) { 
	// *************�����ð� �����ϰ�� ���������ð� ���� �о���� ���� (by sjh - 2013.10.10)*************
		try {
			ei = User_ExamInfo.getBean(id_exam, yn_sametimes, login_starts, login_ends, exam_starts1, exam_ends1);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "fclose"));

			if(true) return;
		}
	// *************�����ð� �����ϰ�� ���������ð� ���� �о���� ����*************
	} else {
	try {
		ei = User_ExamInfo.getBean(id_exam);
	} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "fclose"));

	    if(true) return;
	}
	}

	if (ei == null) {
%>
   <Script type="text/javascript">
	   alert("�����Ǿ��� �򰡰� �����ϴ�.");
       top.window.close();
   </Script>
<% 	  
	  if(true) return;
  }

	int id_auth_type = ei.getId_auth_type(); // 0=�α�only, 1=���������, 2=������
	int id_exam_type = ei.getId_exam_type(); // 0 : ����, 1 : �������ǰ����(�ݺ����谡��)
	int qcount = ei.getQcount(); // ������
	int setcount = ei.getSetcount(); // ��������
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
	String yn_activex = ei.getYn_activex();
	String yn_sametime = "";
	if(userid.equals("tman@@2008")) {
		yn_sametime = "N";
	} else {
		yn_sametime = ei.getYn_sametime();
	}	

	long limittime = 4800;

	if(yn_sametime.equals("N")) {
		limittime = ei.getLimittime(); // [sec]
	} else {
		limittime = to_end1_from_start1;
	}

	String id_ltimetype = ei.getId_ltimetype();
	String yn_viewas = ei.getYn_viewas();
	String yn_open_score_direct = ei.getYn_open_score_direct();

	String id_movepage = ei.getId_movepage();

	if(userid.equals("tman@@2008")) {
		id_movepage = "F";
	} 
%>

<%
    // *************�����ں��� ���ѽð� ���� ��� �߰� ���� (���迬�� �ð��� ���� ��� �ݿ��Ѵ�) (by sjh - 2013.10.10)*************
	ExtendTimeBean etb = null;

	try {
		etb = ExtendTime.getExtendTime(id_exam, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "fclose"));

		if(true) return;
	}
	
	int lngExtTime = 0;
	String ExtYN = "N";

	if(etb == null) {
		lngExtTime = 0;
		ExtYN = "N";
	} else {
		ExtYN = etb.getYn_start();
		lngExtTime = etb.getExt_min() * 60;
	}

	if(ExtYN.equals("N") && lngExtTime > 0) {
		limittime = limittime + lngExtTime;
	}
	// *************�����ں��� ���ѽð� ���� ��� �߰� ����*************
%>

<%
  // Step 1-1 : �̹��� ��θ� �����Ѵ�.

  //���� ���� ���� �� ���� �̹��� ���� ��� �о����
	//String sv_root = "../../CommonFiles";
	String sv_root = "..";
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
  // Step 1-2 : �⺻���� ä���

%>
<%
  // Step2 :  ����������

  boolean hasAnswer;
  boolean hasSubmit;
  boolean isAuthTester;
  Timestamp end_time;
  boolean hasReqForRetryExamBySuccessScore;

  try {
    hasAnswer = User_QmTm.hasAnswer(userid, id_exam);
    hasSubmit = User_QmTm.hasSubmit(userid, id_exam);
    isAuthTester = User_QmTm.isAuthTester(id_auth_type, userid, id_exam);
    end_time = User_QmTm.getEnd_time(userid, id_exam); // ����� ������ null
    hasReqForRetryExamBySuccessScore = User_QmTm.hasReqForRetryExamBySuccessScore(userid, id_exam);
  }
  catch (Exception ex) {
    out.println(ComLib.getExceptionMsg(ex, "back"));

    if(true) return;
  }
%>
<%
  // Step 3 : �Խ�����

  if (!userid.equals("tman@@2008")) { //������ �ϰ�쿡�� üũ�� ���Ѵ�.
	
  // 3-1 : �������� ����� ������ ���
  if ((hasSubmit && id_exam_type == 0) && hasReqForRetryExamBySuccessScore == false ) {
    String str = end_time.toString().substring(0, 19);	
   %>
   <Script type="text/javascript">
	   alert("[����� �̹� ���� �Ͽ����ϴ�]");
	   top.window.close();	
   </Script>
   <%
	   if(true) return;
  }

  // 3-2 : �Խ����ð��� �������
  if (yn_sametime.equalsIgnoreCase("Y")) { // ������
	  if (hasAnswer) {
	    if (to_exam_end1 <= 0) {
	%>
	       <Script type="text/javascript">
	    	   alert("[�Խ� ���� �ð��� �������ϴ�]");
	    	   top.window.close();
	       </Script>
	<%
	    	   if(true) return;
	  	}  		  
	  } else {
	    if (to_login_end <= 0 || to_exam_end1 <= 0) {
   	%>
   	       <Script type="text/javascript">
   	    	   alert("[�Խ� ���� �ð��� �������ϴ�]");
   	    	   top.window.close();
   	       </Script>
   	<%
   	    	   if(true) return;
   	  	}  			  
	  }

  
  	if(to_login_start > 0) {
   %>   
   <Script type="text/javascript">
	   alert("�� ����ð� �����Դϴ�. ������ð��� Ȯ���Ͻñ� �ٶ��ϴ�.");
	   top.window.close();
   </Script>	
   <%
	   if(true) return;
	}
  }
  else { // �����򰡰� �ƴ� ���
    //   sec = to ����ð�   + ���ѽð�   + �����ð�
    long sec = to_exam_end1 + limittime + DBPool.SAFE_TIME * 60;
    if (sec < 0) {
   %>
   <Script type="text/javascript">
	   alert("[�򰡽ð��� ���� �Ǿ����ϴ�]");
       top.window.close();
   </Script>
   <%	  
	   if(true) return;
    } else if(to_exam_start1 > 0) {	
   %>
   <Script type="text/javascript">
	   alert("�� ���۽ð� �����Դϴ�. �򰡽��۽ð��� Ȯ���Ͻñ� �ٶ��ϴ�.");
	   
       top.window.close();
   </Script>
   <%
	   if(true) return;
	}
  }

  // 3-3 : �������� �������� �ʾ��� ���
	if (!(setcount > 0)) {
   %>
   <script type="text/javascript">
	   alert("�������� �������� �ʾҽ��ϴ�.");
	   top.window.close();	
   </script>
   <%
	   if(true) return;
	}
%>

<%
  // Step 4 : ���� ��������� üũ�Ѵ�
  
  if (id_auth_type != 0) {
    if (isAuthTester == false) {
    %>
   <Script type="text/javascript">
	   alert("[�� �򰡿� ���ô���ڰ� �ƴմϴ�]");
	   top.window.close();
   </Script>
   <%  
	   if(true) return;
    }
  }

  } // ������ �׽�Ʈ ���̵� ����

%>

<%
  // Step 5 : �����

  // 5-1 :  ��������� and �������ǰ�� --> ����� ����

  if ((hasSubmit && id_exam_type != 0) || hasReqForRetryExamBySuccessScore)
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
  
  String answers = "";
  int nr_set;
  String yn_end = "N";
  long remain_time = limittime;
  String[] arrAnswers = answers.split(User_QmTm.Q_GUBUN_re, -1);
  
  // 5-2 : ����� �� --> ������ �߰�
  if (hasAnswer == false)
  {
    try {
        User_ExamAns.insertBlank(userid, id_exam, setcount, system_now, limittime, user_ip);
    }
    catch (Exception ex) {
        out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	try {
        User_Log.saveLogText("1", id_exam, userid, "0", user_ip, browser, "", "", "", "");
    }
    catch (Exception ex) {        
		out.println(ex.getMessage());
    }

	// *************������� �߰� �Ǿ����Ƿ� ���� ó���� �Ϸ� �Ǿ����� �����ϴ� �κ� ���� (by sjh - 2013.10.10)*************
	if(lngExtTime > 0) {
		  
	   try {
		   ExtendTime.extendTimeUpdate(id_exam, userid);
	   } catch(Exception ex) {
		   out.println(ComLib.getExceptionMsg(ex, "fclose"));

		   if(true) return;
	   }

	}
	// *************������� �߰� �Ǿ����Ƿ� ���� ó���� �Ϸ� �Ǿ����� �����ϴ� �κ� ����*************


  } else { // ���� ����������� ó��
   
	  // *************���������� �ð� ���� ó���� �Ǿ����Ƿ� �ð��� �����۾� ���� (by sjh - 2013.10.10)*************
	  if(ExtYN.equals("N") && lngExtTime > 0) {
				
		 try {
			 ExtendTime.remainTimeUpdate(id_exam, userid, lngExtTime);
		 } catch(Exception ex) {
			 out.println(ComLib.getExceptionMsg(ex, "fclose"));

			 if(true) return;
    	}

		 try {
			 ExtendTime.extendTimeUpdate(id_exam, userid);
		 } catch(Exception ex) {
			 out.println(ComLib.getExceptionMsg(ex, "fclose"));

			 if(true) return;
		 }
	  }

  }
	  // *************���������� �ð� ���� ó���� �Ǿ����Ƿ� �ð��� �����۾� ����*************

  // 5-3 : ������� �о�´�
  User_ExamAnsBean ans;

  try {
      ans = User_ExamAns.getBean(userid, id_exam);
  }
  catch (Exception ex) {
      out.println(ComLib.getExceptionMsg(ex, "back"));

      if(true) return;
  }

  answers = ans.getAnswers();
  yn_end = ans.getYn_end();
  nr_set = ans.getNr_set();
  remain_time = ans.getRemain_time();
  arrAnswers = answers.split(User_QmTm.Q_GUBUN_re, -1);

%> 

<%
  // Step 6 : ���� ������ �о�´�.

  User_ExamPaper2Bean[] qs;
  
  try {
      qs = User_ExamPaper2.getBeans(id_exam, nr_set, userid);
  } catch(Exception ex) {
	  out.println(ComLib.getExceptionMsg(ex, "back"));

	  if(true) return;
  }
  
  if (qs == null) {
%>
   <Script type="text/javascript">
	   alert("��ϵǾ��� �������� �����ϴ�.");
       top.window.close();
   </Script>
<% 	  
	  if(true) return;
  }

  if (qcount != qs.length) {
  %>
   <Script type="text/javascript">
	   alert("�������� ���� �ʽ��ϴ�.");
       top.window.close();
   </Script>
  <% 	  
	  if(true) return;
  }
%>

<%
  // Step 7

  // 7-1 : ������ �������� ����

  User_ExamPaper2.setPageInfo(qs);
  String pageList = User_ExamPaper2.getPageList();
  String startList = User_ExamPaper2.getStartList();
  String endList = User_ExamPaper2.getEndList();
  int nonCount = User_ExamPaper2.getNonCount();    // ����� ������
  double nonAllot = User_ExamPaper2.getNonAllot(); // ����� ������

  // 7-2 : ������ ����

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

  // 7-3 : �ܿ��ð�

  if (yn_sametime.equalsIgnoreCase("Y")) // ���ý���
  {
    if (to_exam_end1 > limittime) {
      remain_time = limittime;
	} else {
      remain_time = to_exam_end1 + lngExtTime;
    }
    
	if (remain_time > refresh_remain_time) { // ���赵�� refresh �� ...
	  remain_time = refresh_remain_time;
    }
  }
  else // not ���ý���
  {
    //if (remain_time > limittime) {
	//  remain_time = limittime;
	//}		
			
    if (remain_time > refresh_remain_time) { // ���赵�� refresh �� ...
      remain_time = refresh_remain_time;
    }
  }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<title>eTest</title>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
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
	html, body{ width:100%; height:100%; }
	body      { font-size: <%= ei.getFontsize() %>pt; font-family: <%= ei.getFontname() %>, ����ü, ����ü; }
	table     { font-size: <%= ei.getFontsize() %>pt; font-family: <%= ei.getFontname() %>, ����ü, ����ü; line-height: 150%; }
</style>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		init();
		if((yn_activex === "Y") && (userid !== "tman@@2008")) {
			top.window.opener.document.AntiCheatX.StartAntiCheatApp();
		}
	});
</script>
<SCRIPT type="text/javascript">
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

<script type="text/javascript">

// Global variables from server variables

var userid, id_exam;
var gindex, refresh_YN, isSTOP;

var bgColor, endList, exlabel, id_ltimetype, id_movepage;
var isSP2, limittime, log_option, pageList, paper_type, paperType;
var paperImage, qcount, qcntperpage, remain_time, startList;
var title, to_exam_start1, web_window_mode, yn_open_score_direct;
var yn_viewas, yn_sametime, yn_activex;

// Array for ����������
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
var ArrNonChk = new Array();     // Array for �������� �ۼ�����

var ArrSingle = new Array();     // �ܴ��� ���ٿ� ǥ�ÿ���
var ArrExRow = new Array();      // ���� ���ٴ� ǥ�õ� ���� ���� (�߰�)

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
   ArrNonChk[<%= i %>] = "<%= qs[i].getNonCheck() %>"; // �������� �ۼ�����

   ArrQ[<%= i %>] = "<%= User_QmTm.changeChar(qs[i].getQ()) %>";
   <% for (int j = 0; j < qs[i].getExcount(); j++) { %>
   ArrEx[<%= j %>][<%= i %>] = "<%= User_QmTm.changeChar(qs[i].getArrEx()[j]) %>";
   <% } %>

   ArrAnswers[<%= i %>] = "";

   // �ܴ��� ���� Ŀ��Ʈ ����¡..
	ArrSingle[<%= i %>] = "<%= qs[i].getYn_single_line() %>";
	ArrExRow[<%= i %>] = <%= qs[i].getEx_rowcnt() %>; 
 	
<% } %>

var ArrExTmp, ArrPage, ArrStart, ArrEnd;

// ������
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

// for Ÿ�̸�
var timeLeftStart = 0;
var timeLeft = 0;
var timerID = null;
var isTimer = false;
var started = 0;
var LastTime = 0;

var orgTop;
var orgLeft;

var height_avail, height_top, height_bottom ,height_centerdiv = 0;

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
  log_option = "<%= ei.getLog_option() %>";   // A:���̷α�, B:Ǯ�α�
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
  yn_activex = "<%= ei.getYn_activex() %>";

  // ������
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

  // ���ó�� : �ٱ��� �� Ư������
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

  setContentsSize();

  // ������ ������ ��´�
  ArrPage = pageList.split(":");
  ArrStart = startList.split(":");
  ArrEnd = endList.split(":");

  for (var i = 0; i < ArrPage.length; i++) { // string --> integer
    ArrPage[i] = parseInt(ArrPage[i], 10);
    ArrStart[i] = parseInt(ArrStart[i], 10);
    ArrEnd[i] = parseInt(ArrEnd[i], 10);
  }

  // ���� label
  ArrExlabel = exlabel.split(",");

  if (gindex != 0 && id_movepage == "F") {
    // gindex ����
  }
  else
  {
    // gindex ���
    gindex = 0;

    // ����� �Է����� ���� ������ �̵�
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

    // ��� ����� üũ �Ǿ� �ִٸ� ������ ������ �̵�
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
    if (id_ltimetype == "N") {  // ���ѽð� ����
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
  ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ����

  EvtLog("2"); // ���ΰ�ħ
  var timeLeft = document.frmData.timeLeft.value;
  top.fraTest.location.replace("etest.jsp?id_exam=" + id_exam + "&gindex=" + gindex + "&timeLeft=" + timeLeft);
}

function CloseUsingX()
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // ��������(X) Event Log ���� : 20
    if((yn_activex === "Y") && (userid !== "tman@@2008")) {
	  top.window.opener.document.AntiCheatX.StopAntiCheatApp();
    }
    EvtLog("20");
    myalert("���� X ��ư�� �̿��Ͽ� ��ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
  }
}

function Resize()
{
  if (log_option == "Y")
  {
    if (isWindowResized) { return; }
    isWindowResized = true;

    // âũ�⺯�� Event Log ���� : 11
    Hide();
    EvtLog("11");
    myalert("���� âũ�⸦ �����ϴ� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
    ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ������
    parent.close();
  }
}

function WindowMoved()
{
  // â�� ��ġ ���濩��

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
      // â��ġ���� Event Log ���� : 12
      Hide();
      EvtLog("12");
      myalert("���� â��ġ�� �����ϴ� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
      ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ������
      parent.close();
    }
  }
}

function LostFocus()
{
  if (ignoreLostFocus) {     // Refresh, Key-Event, alert ���
    ignoreLostFocus = false;
    return;
  }

  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // LostFocus �� ����
    if (keyCodeTabEsc == 9) { // Alt+Tab
      EvtLog("22");
      myalert("���� ��ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
      keyCodeTabEsc = 0;
    } else if (keyCodeTabEsc == 27) { // Alt+Esc
      EvtLog("23");
      myalert("���� ��ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
      keyCodeTabEsc = 0;
    }

    // ��Ŀ���̵� Event Log ���� : 13
    EvtLog("13");
    //myalert("���� ��ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
  }
}

function chkkeyup(e)
{
    var kc = event.keyCode;
    if (kc == 9 || kc == 27) { keyCodeTabEsc = kc; } // LostFocus() ���� �̿�
}

function chkkeydown(e)
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    ignoreLostFocus = false;
    var kc = event.keyCode;

    if (kc == 93 || kc == 113 || kc >= 116 && kc <= 123) {
      // myalert("���� ������ Ű�� ����Ͻ� �� �����ϴ� ...");
      event.keyCode = 0;
      event.cancelBubble = true;
      event.returnValue = false;
      return false;
    }

    // ����׸�
    if (event.altKey && kc == 115) {
      // Alt + F4 (��������)
      ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ����
      Hide();
      AnsSave("F"); // remain-time ������ ���Ͽ�
      EvtLog("21");
      myalert("���� Alt + F4 �� �̿��Ͽ� �������� �Ͽ����ϴ�\n\n����� ������� �����ϴ� ���, ���������� ���� ���� �� �ֽ��ϴ�\n\n��ڿ��� ���������� ����� �뺸�Ͽ����ϴ�");
    }
    else if (event.altKey && kc == 9) {
      // Alt + Tab (ȭ����ȯ) : ����Ұ� --> LostFocus ���� ó��
      // EvtLog("22");
      // myalert("���� Alt + Tab �� �̿��Ͽ� ȭ����ȯ�� �Ͽ����ϴ�\n\n���������� ���� ���� �� �ֽ��ϴ�\n\n��ڿ��� �뺸�Ͽ����ϴ�");
    }
    else if (event.altKey && kc == 27) {
      // Alt + Esc (ȭ����ȯ) : ����Ұ� --> LostFocus ���� ó��
      // EvtLog("23");
      // myalert("���� Alt + Esc �� �̿��Ͽ� ȭ����ȯ�� �Ͽ����ϴ�\n\n���������� ���� ���� �� �ֽ��ϴ�\n\n��ڿ��� �뺸�Ͽ����ϴ�");
    }
    // �����׸�
    else if (kc == 91 || kc == 92) {
      // Windows
      Hide();
      EvtLog("51");
      myalert("���� WindowsŰ�� ����Ͻ� �� �����ϴ�\n\n������ ������ ������ ��� ������ �ִ� ���ΰ�ħ�� ��������.");
    }
    else if (kc == 93) {
      // Context menu
      myalert("���� ���ؽ�Ʈ �޴�Ű�� ����Ͻ� �� �����ϴ�\n\n������ ������ ������ ��� ������ �ִ� ���ΰ�ħ�� ��������.");
      event.keyCode = 0;
      return false;
      //EvtLog("52"); // event.keyCode = 0 �� �����ϹǷ� �α����� ���ʿ�
    }
    else if (kc == 112) {
      // F1 (IE ����)
      EvtLog("53");
      Hide();
      myalert("���� F1Ű�� ����Ͻ� �� �����ϴ�\n\n����â�� ��������\n\n������ ������ ������ ��� ������ �ִ� ���ΰ�ħ�� ��������.");
    }
    else if (kc == 114) {
      // F3 (IE �˻�â)
      myalert("���� F3Ű�� ����Ͻ� �� �����ϴ�");
      event.keyCode = 0;
      return false;
      // EvtLog("54"); // event.keyCode = 0 �� �����ϹǷ� �α����� ���ʿ�
    }
    else if (kc == 116) {
      // F5 Key (���ΰ�ħ:����)
      ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ����
      EvtLog("55");
      Hide();
      myalert("������ ������ ���� ��� F5 �� ������ ����\n\n��ܿ����� �ִ� [���ΰ�ħ] ��ư�� ��������\n\nF5 Ű�� �̿��� ��� ���� ����� ������ ���� �ֽ��ϴ�\n\nȮ���� �ٽ� �򰡸� �����ϼ���");
    }
    // Ctrl(17) or Alt(18) + ��ŸŰ �������
    else if ((event.ctrlKey || event.altKey)) {
      if (kc != 17 && kc != 18) {
        myalert("Ctrl �Ǵ� Alt Ű���� �������� Ű����� ����� �� �����ϴ�.");
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

function myalert(msg) // alert �� blur �� ����ϱ� ����...
{
  if (timeLeft > 0)
  {
    msg += "\n\n�򰡽ð��� ��� ����ǰ� �ֽ��ϴ�.\n\n�޼��� Ȯ�� ��� �� â�� �����ð�";
    if (timeLeft <= 180) {
      msg += "\n\n�򰡸� �������Ͻñ� �ٶ��ϴ�.";
    } else {
      msg += "\n\n�򰡸� �����Ͻñ� �ٶ��ϴ�.";
    }
  }

  alert(msg);
  ignoreLostFocus = true;
}

</script>

<script type="text/javascript">

// functions

function examStart()
{
  document.all.startbutton.disabled = true;
  document.all.guide.style.display = "none";
  document.all.contents.style.display = "";
  document.all.Re_No.style.display = "";

  if (id_ltimetype == "N") {  // ���ѽð� ����
    document.all.outImg.style.display = "";
  } else {
    document.all.outImg.style.display = "none";
  }

  if (yn_viewas == "Y") { document.all.reply.style.display = ""; }
  <% if (hasAnswer) { %>
    EvtLog("3"); // �̾�Ǯ��
  <% } else { %>
    EvtLog("1"); // �������
  <% } %>
  GetQ();
  if (id_ltimetype != "N") { Timerinit(); }
}

function goout_onclick()
{
  // ��� Event Log : 9
  EvtLog("9")
  if((yn_activex === "Y") && (userid !== "tman@@2008")) {
	  top.window.opener.document.AntiCheatX.StopAntiCheatApp();
  }
  top.window.opener.location.reload();  // ���� ��������Ʈ��
  top.window.close();  // ���� ��������Ʈ��
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

  // �Ϲ��� (ȭ��� N���� ����)

  if (ArrQType[ArrStart[gindex - 1] - 1] < 5) // 1:OX��, 2:������, 3:���������, 4:�ܴ���
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
        //���� ������ ���� ������ �ٸ��ٸ� ���� ������ ���� �������� �����Ѵ�
        //���� ������ ���� ������ ���� ���� ������ ǥ���� �ʿ䰡 ����
        if (old_ref != ArridRef[idx]) {
          old_ref = ArridRef[idx];
          RefDisp(idx, k);
        }
      }

      eval("document.all.quizno" + k + ".innerHTML = \"<b><big>" + qNumber + ". </big></b>\";");
      eval("document.all.quiz" + k + ".innerHTML = RestoreChar(ArrQ[" + idx + "]) + \"<br><font color=blue>[���� " + ArrAllotting[idx] + "]</font>\";");

      if (ArrQType[idx] <= 3) // 1:OX��, 2:������, 3:���������
      {
        for (i = 0; i <= lngExCnt; i++)
        {
          eval("document.all.lb" + k + (i + 1) + ".innerHTML = InputHtml(" + i + "," + idx + ");");
          eval("document.all.ln" + k + (i + 1) + ".innerHTML = '" + ArrExlabel[i] + "&nbsp;';");
          eval("document.all.ex" + k + (i + 1) + ".innerHTML = RestoreChar(ArrEx[" + i + "][" + idx + "]);");
          // eval("document.all.ex" + k + (i + 1) + ".innerHTML = RestoreChar(ArrEx[" + (ArrExTmp[i] - 1) + "][" + idx + "]);");

          if (ArrQType[idx] == 3) // 3:���������
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
          } // end of 3:���������

          else // 1:OX��, 2:������
          {
            if (ArrAnswers[idx] == ArrExTmp[i])
            {
              eval("document.all.ln" + k + (i + 1) + ".style.color = 'red';");
              eval("document.all.ex" + k + (i + 1) + ".style.color = 'red';");
            }
          } // end of 1:OX��, 2:������

	} // end of for loop i <= lngExCnt

      } // end of 1:OX��, 2:������, 3:���������

      else if (ArrQType[idx] == 4) // 4:�ܴ���
      {
		tmp = KeyWord_bak(RestoreChar2(ArrAnswers[idx]));
        tmp2 = "";

        if (ArrCaCount[idx] > 1) // ������
        {
          if (tmp == "") {
            for (i = 1; i <= ArrCaCount[idx] - 1; i++) { tmp = tmp + OR_GUBUN; }
          }
          ArrTmp = tmp.split(OR_GUBUN);
		 for (j=1; j<= ArrCaCount[idx]; j++) {
            tmp2 = tmp2 + j + ") <input type=\"text\" size=\"20\" maxlength=\"50\" name=\"ans" + idx + "\" value=\"" + ArrTmp[j - 1] + "\" onchange=\"javascript:AnsCheck(" + idx + ", this.value);\" onKeyPress=\"CheckKeys(" + k + ")\">" + "<br>";
		 }
        } // end of ������

        else { // �ܼ���
          tmp2 = tmp2 + "<input type=\"text\" size=\"20\" maxlength=\"50\" name=\"ans" + idx + "\" value=\"" + tmp + "\" onchange=\"javascript:AnsCheck(" + idx + ", this.value);\" onKeyPress=\"CheckKeys(" + k + ")\">";
	}

	eval("document.all.ex" + k + "1.innerHTML = tmp2;");

    } // end of 4:�ܴ���

 }   // end of for loop idx <= ArrEnd[gindex - 1] - 1

    ButtonVisible(); // ����, ����.. ��ư�鿡 ���� ǥ��

  }  // end of �Ϲ��� (1:OX��, 2:������, 3:���������, 4:�ܴ���)

  else // 5: ����� (ȭ��� 1����)
  {
    k = k + 1;
    idx = ArrStart[gindex-1]-1;
    qNumber = idx + 1;
    document.frmData.nr_q.value = qNumber;
    document.frmData.id_q.value = ArridQ[idx];

    eval("document.all.quizno1.innerHTML = \"<b><big>" + qNumber + ". </big></b>\";");
    eval("document.all.quiz1.innerHTML = RestoreChar(ArrQ[" + idx + "]) + \"<br>[���� " + ArrAllotting[idx] + "]\";");

    if (ArridRef[idx] != "0") { RefDisp(idx, k); } // ����ǥ��
    ignoreLostFocus = true;
    window.open("nonpage.jsp?id_q=" + ArridQ[idx] + "&userid=" + userid + "&id_exam=" + id_exam + "&index=" + (idx + 1), "fraAction");
  } // end of 5: �����
}

function ButtonVisible()
{
  // ����, ���� ��ư ����

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
    ref_msg += "<td align=center>&nbsp;<font color=white>�� " + RestoreChar(ArrRefTitle[rindex]) + "[" + (ArrQno1[rindex]) + "]</font>&nbsp;</td>";
    ref_msg += "</tr></table>";
  } else {
    ref_msg += "<table bgcolor='#6666CC' width='100%' align='left' border='0' cellspacing='0' cellpadding='0' class='copy'>";
    ref_msg += "<tr>";
    ref_msg += "<td align=center>&nbsp;<font color=white>�� " + RestoreChar(ArrRefTitle[rindex]) + "[" + (ArrQno1[rindex]) + "] ~ [" + (ArrQno2[rindex]) + "]</font>&nbsp;</td>";
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
    myalert("����� ���� ���Դϴ�. 10���̻� ���������� ǥ�õ��� ������� ���ΰ�ħ ��ư�� ���� �ּ���");
    return;
  }

  if (gindex > qcount - 1 || ExamEndYN == "Y") { return; }

  if (id_movepage != "F")
  {
    for(var i = ArrStart[gindex - 1] - 1; i < ArrEnd[gindex - 1]; i++)
    {
      if ((ArrQType[i] <= 4 && ArrAnswers[i] == "") || (ArrQType[i] == 5 &&  ArrNonChk[i] == "N")) {
        // ���� �̵��� �ƴϸ� ������ Ǯ��� ������������ �̵� ����
        myalert((i + 1) + " �� ������ ����� �Է����� �����̽��ϴ� !!!");
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
    myalert("����� ���� ���Դϴ�. 10���̻� ���������� ǥ�õ��� ������� ���ΰ�ħ ��ư�� ���� �ּ���");
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
  myalert("��� ������ ������ �߻� �Ͽ����ϴ�\nȮ���� �����ø� ����� ����� ��ġ���� �̾ ���� �˴ϴ�");
  top.fraTest.location.replace("etest.jsp?id_exam=" + id_exam + "&gindex=&timeLeft=" + timeLeft);
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
    myalert("����� ���� ���Դϴ�. 10���̻� ���������� ǥ�õ��� ������� ���ΰ�ħ ��ư�� ���� �ּ���");
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

  // ����ǥ�� ���򺯰�

  for (var i = ArrStart[gindex - 1]; i <= ArrEnd[gindex - 1]; i++) {
    pos++;
    if (pindex + 1 == i) { break; }
  }

  if (ArrQType[pindex] != 5) {
    document.frmData.oldnon.value = ""; // �񱳸� ���� ����� ����� �ʱ�ȭ
  }

  if (ArrQType[pindex] == 3) // 3:���������
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

  } // end of 3:���������

  else if (parseInt(ArrQType[pindex]) == 4 && ArrCaCount[pindex] > 1) // 4:�ܴ��� and ������
  {
    tmp = ""; tmpCa2 = "";

    for (var i = 0; i < ArrCaCount[pindex]; i++)
    {
      eval("tmp += KeyWord_Chk(document.frmData.ans" + pindex + "[" + i + "].value);");
      tmp += OR_GUBUN;

      if (yn_viewas == "Y")
      {
        //�����â�� ǥ���� �ֱ� ���Ͽ�
        eval("tmpCa = document.frmData.ans" + pindex + "[" + i + "].value;");
        tmpCa = "�� " + tmpCa;
        if (tmpCa.length > ANS_MAX_LEN + 1) { tmpCa = tmpCa.substr(0, ANS_MAX_LEN + 1) + ".."; }
        //ȭ��ǥ�ø� ���� ���ں���
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

  } // end of 4:�ܴ��� and ������

  else if (ArrQType[pindex] == 5) // 5:�����
  {
    if (document.frmData.nonans.value != "") { ArrNonChk[pindex] = "Y"; }
    else { ArrNonChk[pindex] = "N"; }

    // ������� ǥ���ϱ� ���ؼ� ���Ͱ��� ������
    ansTmp = ansTmp.replace(/\r/g, " ");
    ansTmp = ansTmp.replace(/\n/g, "");

    if (yn_viewas == "Y")
    {
      if (ansTmp == "") {
        ansTmp = "(���)���ۼ�";
      } else if (ansTmp.length > ANS_MAX_LEN) {
        ansTmp = ansTmp.substr(0, ANS_MAX_LEN) + "..";
      }

      //ȭ��ǥ�ø� ���� ���ں���
      ansTmp = ansDis(ansTmp);
      eval("document.all.replya" + (pindex + 1) + ".innerHTML = '" + ansTmp + "';");
    }

  } // end of 5:�����

  else // 1:OX, 2:������, 4:�ܴ��� and �ܼ���
  {
    ArrAnswers[pindex] = KeyWord_Chk(ansTmp);

    // ������ ������ ������
    if (ArrQType[pindex] <= 2) // 1:OX, 2:������
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
    } // end of 1:OX, 2:������ (������ ������ ������)

    if (yn_viewas == "Y")
    {
      if (ArrQType[pindex] == 4) // 4:�ܴ��� and �ܼ���
      {
        if (ansTmp.length > ANS_MAX_LEN) { ansTmp = ansTmp.substr(0, ANS_MAX_LEN) + ".."; }
        ansTmp = ansDis(ansTmp); // ȭ��ǥ�ø� ���� ���ں���
        eval("document.all.replya" + (pindex + 1) + ".innerHTML = '" + ansTmp + "';");
      }
    }

  } // end of 1:OX, 2:������, 4:�ܴ��� and �ܼ���

  if (yn_viewas == "Y") { replyCheck(pindex); }
}

function AnsSave(pType)
{
  // pType : N=Next, P=Previous, C=GetQ?, F=������DB����

  var form = document.frmData;
  var strAns = ArrAnswers.join(Q_GUBUN);
  var id_q = form.id_q.value;
  form.movetype.value = pType;

  if (id_q == "") // ������� �ƴ�
  {
    if ((form.answers.value == strAns || strAns == "") && pType != "F") // ��Ⱥ��湫 or ��ȹ�
    {
      // �α׳����
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

    else // ��Ⱥ����� or pTYpe = "F"
    {
      // DB ������ (DB ����� �α׳���� ����)
      strAns = ansChange(strAns);
      form.answers.value = strAns;
      form.method = "post";
      form.target = "fraAction";
      form.action = "saveans.jsp";
      form.submit();
    }

  } // end of id_q == "" : ������� �ƴ�

  else // id_q != "" : �����
  {
    if (form.nonans.value == form.oldnon.value && pType != "F") // ����� ��� ���湫
    {
      // �α׳����
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

    else // ����� ��� ������ or pType = "F"
    {
      if (pType != "F") {
        if (NonLength() == false) {
          return;
        }
      }

      // DB ������ (DB ����� �α׳���� ����)
      form.oldnon.value = form.nonans.value;
      form.newnon.value = "";
      strAns = ansChange(form.nonans.value);
      form.newnon.value = strAns;
      form.method = "post";
      form.target = "fraAction";
      form.action = "saveans.jsp";
      form.submit();
    }
  } // end of id_q != "" : �����
}

function NonLength()
{
  // ������� �Է��� ���ڼ� ǥ��
  var non_length = document.frmData.nonans.value.length
  myalert(non_length + "�ڸ� �Է��Ͽ����ϴ�.");
  if (non_length > 5000) {
    myalert("����� ����� 5000�� �̳����� �ۼ��ϼž� �մϴ�.");
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

  if (id_ltimetype == "T" && form.timeLeft.value == "-1") {}
  else {
    for(var i = ArrStart[0] - 1; i < ArrEnd[gindex - 1]; i++)
    {
      if (ArrQType[i] <= 4) // ������� �ƴϸ�
      {
        if (ArrAnswers[i] == "") {
          ExamEndYN = "N";
          myalert((i + 1) + " �� ������ ����� �Է����� �����̽��ϴ� !!!");
          myalert("����� ��� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
          break;
        }
      }
      else // �����
      {
        if (ArrNonChk[i] == "N") {
          ExamEndYN = "N";
          myalert((i + 1) + " �� ������ ����� �Է����� �����̽��ϴ� !!!!!!");
          myalert("����� ��� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.");
          break;
        }
      }
    } // end of for loop (��� ������ ���Ͽ�)
	
    if (ExamEndYN == "N")
    {
    	ExamEndYN = "N";
        ignoreLostFocus = true;
        return;  
    } else
    {
      if (confirm("����� ���� �Ͻðڽ��ϱ� ?") == false) {
    	  ExamEndYN = "N";
          ignoreLostFocus = true;
          return;
      } else {
          ExamEndYN = "Y";     	  
      }     
    }
  }

  timerStop();

  document.all.timeLimitHMS.style.display = "none";
  document.all.Re_No.style.display = "none";
  if (yn_viewas == "Y") { document.all.reply.style.display = "none"; }
  document.all.contents.style.display = "none";
  document.all.resubmit.style.display = "";

  form.answers.value = ansChange(ArrAnswers.join(Q_GUBUN));  // ���� ����� �ױ׺���
  form.newnon.value = "";  // ��������� ���� Ŭ����

  if (ArrQType[ArrStart[gindex - 1] - 1] == 5) // ���� �������� �����
  {
    form.oldnon.value = form.nonans.value;
    form.newnon.value = "";
    strAns = ansChange(form.nonans.value);
    form.newnon.value = strAns;
  }

  // ������� Event Log : 5
  EvtLog("5");

  // ����� ����
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
  strMsg += "<br><br><a href='javascript:QResume();'><b>����ȭ������..</b></a>";
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
  if (ArrQType[pindex] <= 4) // ������� �ƴϸ�
  {
    eval("document.all.reply" + (pindex + 1) + ".style.backgroundColor = '#F1EBAD';");
  }
  else // �����
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
  // ��������� Event Log
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
  // �ٱ��� ó�� �Լ�
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
  // ������ ǥ�� ������ �׸��� �κ�

  var strArea = "";
  var i = 0;
  var exRowidx = 0;
  var Guide_msg = "";  

  strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top' width='100%' id='contents2'>";

  // ��繮���� ���ؼ� Loop �� ��������

  for(var k = ArrStart[gindex - 1] - 1; k < ArrEnd[gindex - 1]; k++)
  {
    i++;
    strArea += "<tr><td>";
    strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top' width='100%'>";
    strArea += "<tr><td height='20'></td></tr><tr><td>"; // ����

	// ��������
    if (ArridRef[k] != "0")
    {
      strArea += "<div id='ref" + i + "'></div>";
      strArea += "</td></tr>";
      strArea += "<tr><td height='12'></td></tr><tr><td>"; // ����
    }

    // ��������
    strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top'>";
    strArea += "<tr>";
    strArea += "<td valign='top'><div id='quizno" + i + "'></td>";
    strArea += "<td width='5'></td>";
    strArea += "<td><div id='quiz" + i + "'></div></td>";
    strArea += "</tr>";
    strArea += "</table></td></tr>";
    strArea += "<tr><td height='7'></td></tr><tr><td>"; // ����

    strArea += "<table border='0' cellpadding='0' cellspacing='0' align='left' valign='top'>";

    // ���⿵��

    if (ArrQType[k] <= 3) // 1:OX, 2:����, 3:�������
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
				
	  //������ ������ ���Ͽ� tr�� ������ ������� ó��
	  if (exRowidx != 0) {
		  strArea = strArea + "</tr>";
		  exRowidx = 0;
	  }

   } else // 4:�ܴ���, 5:�����
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

<script type="text/javascript">

// for timer

function timerStop()
{
  if (isTimer) { window.clearTimeout(timerID); }
  isTimer = false;
}

// ���� ����� Ÿ�̸�

function Timerinit()
{
  var timeLimit = limittime;  // [sec]
  var timeLeft = remain_time; // [sec]

  document.all("timeLimitHMS").innerText = "���ѽð� : " + displayHMS(timeLimit);
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

  checkWindowSizeAndUpdateContentSize();

  if (LastTime == 0 || LastTime < now) {
    LastTime = now;
  } else if (LastTime > now) {
    form.etc.value = "Ÿ�̸� ���� - ����ڰ� PC�� Ÿ�̸Ӹ� ���� �Ͽ����ϴ�";
    EvtLog("41");
    myalert("����� PC�� Ÿ�̸Ӹ� ���� �Ͽ����ϴ�\nŸ�̸� ������ �������� �Դϴ�\n\n�򰡸� �ߴ� �մϴ�");
    if((yn_activex === "Y") && (userid !== "tman@@2008")) {
    	top.window.opener.document.AntiCheatX.StopAntiCheatApp();
    }
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
      // ����ð� 3������ �ȳ� �޽��� ǥ��
      myalert("�� ����ð� ���� 3���� ���ҽ��ϴ�.\n\n����ۼ��� ���θ��ñ� �ٶ��ϴ�");
    }
  }
  else // ���ѽð� �����
  {
    if (id_ltimetype == "T") {
      form.timeLeft.value = "-1";
      ExamEndYN = "Y";
      myalert("���ѽð��� ����Ǿ� ����� �ڵ����� �����մϴ�");
      SubmitPage();
    }
    else if(id_ltimetype == "N") { }
  }
}

// �Խ� ���� Ÿ�̸�

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
    form.etc.value = "Ÿ�̸� ���� - ����ڰ� PC�� Ÿ�̸Ӹ� ���� �Ͽ����ϴ�";
    EvtLog("41");
    myalert("����� PC�� Ÿ�̸Ӱ� ������ �Ͽ����ϴ�\n\nŸ�̸Ӱ� ������ �Ͽ� �򰡸� �ߴ� �մϴ�");
    if((yn_activex === "Y") && (userid !== "tman@@2008")) {
    	top.window.opener.document.AntiCheatX.StopAntiCheatApp();
    }
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
  else // ���ѽð� �����
  {
    // ������� �ð��� �Ǿ����Ƿ� ������ Ÿ�̸Ӹ� ���� ��Ų��.
    document.all.timeWait.style.display = "none";
    examStart();
  }
}

// �ð� ���÷���

function displayHMS(intSeconds)
{
  var intTmp, hh, mm, ss, strHMS;

  intTmp = Math.floor(intSeconds / 3600);
  hh = (intTmp <= 0) ? "" : (intTmp + "�ð� ");

  intTmp = Math.floor((intSeconds % 3600) / 60);
  if (intTmp <= 0) { mm = "" }
  else if (intTmp < 10) { mm = intTmp + "�� " }
  else { mm = intTmp + "�� " }

  intTmp = Math.floor(intSeconds % 60);
  if (intTmp <= 0) { ss = "0��" }
  else if (intTmp < 10) { ss = intTmp + "�� " }
  else { ss = intTmp + "�� " }

  strHMS = hh + mm + ss;

  return(strHMS);
}

function checkWindowSizeAndUpdateContentSize() {
	if(height_avail !== $(window).height()) {
		setContentsSize();
	}
}

function setContentsSize() {
  height_avail = $(window).height();
  height_top = $('#Top').height();
  height_bottom = $('#Bottom').height();
  height_centerdiv = height_avail - ( height_top + height_bottom );
  $('#centerdiv').height(height_centerdiv);
  var contents_div_height = $('#centerdiv').height() - $('.Layout #Main #B #contents #Ltitle').height();
  $('.contents-height').height(contents_div_height);
  $("#ansdiv").height(contents_div_height - 45);
}

</script>

</head>

<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" 
onmouseout="CheckMove();" onblur="LostFocus();" onunload="CloseUsingX();" onresize="Resize();" 
oncontextmenu="return false" ondragstart="return false;" onselectstart="return false;">

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

<!--// 2008-07-09 �߰�//-->
<input type="hidden" name="limittime" value="<%= limittime %>">
<input type="hidden" name="logtype" value="">
<input type="hidden" name="nr_set">
<input type="hidden" name="logstyle" value="1">
<!------------------------>

<TABLE cellpadding="0" cellspacing="0" border="0" class="Layout">
	<!-- ��� -->
	<TR id="Top">
		<TD id="A">&nbsp;</TD>
		<TD id="B">
			<!-- ����� �� ���ѽð� -->
			<Div id="L">
				<TABLE cellpadding="0" cellspacing="0" BORDER="0">
					<TR>
						<!-- �ΰ� ǥ�� -->
						<TD id="Logo"><img src="../logo/logo.png"></TD>
						<!-- ����� �� ���ѽð� ǥ�� -->
						<TD id="Title"><%=title%><div id="time" style="display:;"><div id="timeLimitHMS"></div></div></TD>
						<TD id="Bg">&nbsp;</TD>
					</TR>
				</TABLE>
			</Div>
			<!-- ��ư ���� -->
			<Div id="R">
			<img src="<%= imagesDir%>/bt_refresh.gif" id="Re_No" name="Re_No" style="display:none; cursor: pointer;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Re_No','','<%= imagesDir%>/bt_refresh_up.gif',1)" onclick="JavaScript:refresh_onclick();"><img id="outImg" style="cursor: pointer; display:" src="<%= imagesDir%>/bt_out.gif" name="outImg" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('outImg','','<%= imagesDir%>/bt_out_up.gif',1)" onclick="JavaScript:goout_onclick();"><img id="nonImg" style="cursor: pointer; display: none;" src="<%= imagesDir%>/bt_non.gif" name="nonImg"></Div>
		</TD>
		<TD id="C">&nbsp;</TD>
	</TR>
	
	<!-- ���� -->
	<TR id="Main">	
		<TD id="A">&nbsp;</TD>
		<!-- ���� -->
		<TD id="B">
			<div id="centerdiv" style="overflow: no; width: 100%;">
				<!-- ���� ���� �� �ܰ�: No1 -->
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
												<% if(yn_sametime.equalsIgnoreCase("N")) { %><li>���� �ð��� <font color="red"><b><%= limittime / 60 %></b>��</font> �Դϴ�.</li><% } %>
												<% } %>
												<li>���� �̵� ��ư�� 10���̻� ǥ�õ��� ���� ��� ���ΰ�ħ ��ư�� �����ñ� �ٶ��ϴ�.</li>
												<li>���ΰ�ħ ��ư�� ������ �ذ��� �ȵ� ��� ���ͳ� ������ Ȯ���Ͻñ� �ٶ��ϴ�.</li>
									<% if( ! yn_sametime.equalsIgnoreCase("Y")) { %>
												<li>�򰡿� ������ �غ� �Ǽ����� �򰡽��� ��ư�� Ŭ���Ͽ� �򰡿� �����Ͻʽÿ�.</li>
												<li>���� �غ� ���� �����̴ٸ� ������ ����� ������ ��ư�� Ŭ���Ͽ� ������ �� �ֽ��ϴ�. </li>								
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
												<li>���ð��� ������ �ڵ����� �򰡰� ���� �˴ϴ�.</li> 
												<hr>
												<li>�򰡽��� ���ð�</li>
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

				<!-- ���� ���� ��: No2 -->
				<div id="contents" style="display: none;">	
					<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
						<% if(paper_type.equals("12") || paper_type.equals("11") || paper_type.equals("13")) { %>
						<TR>
							<!-- ���� �� ���� Ÿ��Ʋ-->
							<TD id="Ltitle"><div style="float: left;"><img src="<%= imagesDir%>/question.gif"></div><div style="float: right;"><img src="<%= imagesDir%>/question_.gif"></div></TD>
							<!-- ���� ��� Ȯ�� Ÿ��Ʋ -->
							<TD id="Rtitle"><img src="<%= imagesDir%>/answer.gif"></TD>
						</TR>
						<% } %>
						<TR>						
							<TD id="L">
							<!-- ���� �� ���� ȭ�� -->
							<div class="contents-height" style="overflow: auto; width: 100%;">
								<div id="quizdiv" style="width: 100%;"></div>
								<div id="msg" style="width: 100%;"></div>		
								<!-- ��ư ���� -->
								<div id="button" style="width: 100%;">
									<img src="<%= imagesDir%>/bt_pre.gif" onclick="javascript:PreviousQ();" id="prevbtn" style="cursor: pointer;">
									<img src="<%= imagesDir%>/bt_next.gif" onclick="javascript:NextQ();" id="nextbtn" style="cursor: pointer;">
									<!--img src="<%= imagesDir%>/bt_pre_subject.gif">
									<img src="<%= imagesDir%>/bt_next_subject.gif"-->
									
								</div>
							</div>
							</TD>
							<!-- ���� ��� Ȯ�� â -->
							<TD id="reply" class="height_100">
								<img src="<%= imagesDir%>/bt_end_large.gif" style="cursor: pointer;" onclick="javascript:SubmitPage();" id="examsubmit">
								<% if(yn_viewas.equalsIgnoreCase("Y")) { %>
								<div id="ansdiv" style="overflow: auto; width: 100%;">
								<TABLE cellpadding="0" cellspacing="0" border="0">
									<TR id="title">
										<TD>����</TD>
										<TD>���</TD>
									</TR>
									<%
										for (int i = 0; i < qcount ; i++) // �������� ��� ǥ��
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
										} // end of for loop : �������� ���ǥ��
										%>
								</TABLE>
								</div>
								<% } %>
							</TD>
						</TR>
					</TABLE>						
				</div>
				<!-- ���� ���� �ܰ�: No3 -->
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
											<li>����: <span id="end_score"></span></li>
											<li>����: <%= allotting %></li>
											<li>������: <%= qcount %></li>		
											<hr>
											<li>�� ������ ��ä�� ����� �ܴ��� ä�� �� ä�������� ���� ������ ���� �� �ֽ��ϴ�.</li>
											<% } %>	
											<li>�ۼ��Ͻ� ����� ���������� ����Ǿ����ϴ�.</li>
											<li>�򰡿� �����Ͻô��� ���� �����̽��ϴ�.</li>	
										</TD>
									</TR>	
									<TR>
										<TD id="C">&nbsp;</TD>
									</TR>
								</TABLE>
								<p><img src="<%= imagesDir%>/bt_out2.gif" name="bt_out2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('bt_out2','','<%= imagesDir%>/bt_out2_up.gif',1)" style="cursor: pointer;" onclick="JavaScript:goout_onclick();"></p>
							</TD>
						</TR>
					</TABLE>
					
				</div>
				<!-- ���� ��� ���� ȭ�� -->
				<div id="resubmit" style="display:none;">
					<TABLE id="table" cellpadding="0" cellspacing="0" border="0">					
						<TR>
							<TD id="A"><img src="<%= imagesDir%>/resubmit.gif"></TD>
						</TR>
						<TR>
							<TD id="B">
								��Ʈ��ũ ���Ϸ� ���Ͽ� ��� ���忡 �ణ�� �ð��� �ҿ�� �� �ֽ��ϴ�.<br>
								20�� �̻� ���� ȭ���� �״���� ��� �Ʒ� ������ ��ư�� Ŭ���Ͽ� ����� ������ �Ͻʽÿ�.	
								<div class="button" align="left"><img alt="��� ������" onclick="javascript:retrySubmit();" src="<%=imagesDir%>/bt_retry.gif" style="cursor: pointer;"></div>
							</TD>		
						</TR>				
					</TABLE>					
				</div>
			</div>
		</TD>
		<TD id="C">&nbsp;</TD>
	</TR>
	<!-- �ϴ� -->
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

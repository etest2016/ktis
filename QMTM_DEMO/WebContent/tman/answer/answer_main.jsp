<%
//******************************************************************************
//   프로그램 : answer_main.jsp
//   모 듈 명 : 답안지 관리 
//   설    명 : 답안지 관리
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-05-19
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, java.sql.*, qmtm.tman.exam.ExamList" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0 || id_course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	String randomtype = "";

	try {
		randomtype = ExamList.getRandomType(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
	String pt_exam_edit = "";
	String pt_exam_delete = "";
	String pt_answer_edit = "";
	String pt_score_edit = "";
	String pt_static_edit = "";
	
	LoginProcBean bean = null;

	try {
		bean = LoginProc.getExam_work(id_course, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	pt_exam_edit = bean.getPt_exam_edit();
	pt_exam_delete = bean.getPt_exam_delete();
	pt_answer_edit = bean.getPt_answer_edit();
	pt_score_edit = bean.getPt_score_edit();
	pt_static_edit = bean.getPt_static_edit();

%>

<HTML>
 <HEAD>
 <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
  <TITLE> :: 답안지 관리 :: </TITLE>  

  <link rel="stylesheet" href="../../dhtmlxGrid/common/css/style.css" type="text/css" media="screen" />
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <link rel="stylesheet" type="text/css" href="../../dhtmlxGrid/codebase/dhtmlxgrid.css">
  <link rel="stylesheet" type="text/css" href="../../dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_web.css">
  <script  src="../../dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
  <script  src="../../dhtmlxGrid/codebase/dhtmlxgrid.js"></script>		
  <script  src="../../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
  <script  src="../../dhtmlxGrid/codebase/excells/dhtmlxgrid_excell_link.js"></script>

 <style>

	BODY { background-image: url(../../images/bg_mpaper_r.gif); background-repeat: repeat-x; margin: 0px; }

	body, table, tr, td, div, textarea, input, select, opion { font-size: 12px; line-height: 140%; }
	img { border: 0px; }

	a:link { text-decoration: none; font-weight: normal; }
	a:visited { text-decoration: none; font-weight: normal; }
	a:active { text-decoration: none; }
	a:hover { text-decoration: underline; font-weight: normal; }
	
	/*
	#top a:link { text-decoration: none; color: #FFFFFF; font-weight: normal; font-size: 12px; }
	#top a:visited { text-decoration: none; color: #FFFFFF; font-weight: normal; font-size: 12px; }
	#top a:active { text-decoration: none; font-size: 12px; }
	#top a:hover { color: #FFFFFF; text-decoration: none; font-weight: bold; font-size: 12px;  }
	*/

	.submenu { position:absolute; background-color: #ffffff; padding: 14px 15px 12px 15px; border: 1px solid #000; top: 35px; }

	#tabletop {}
	#tabletop td { font: normal 11px dotum; color: #000; text-align: center; }
	#tabletop td span{ color: blue; }	

 </style>

 </HEAD>

 <BODY onLoad="get_inwons('btn1');">

	<form name="form1">
	<input type="hidden" name="id_exam">
	<input type="hidden" name="sel_userids">

	<TABLE width="80%" height="100%" cellpadding="0" cellspacing="0" border="0" align="Center">
		<TR id="top">
			<TD valign="top" height="55">
				
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td style="padding-top: 10px; padding-left: 10px; color: #FFF;" width="*" valign="top">
							<span id='menu0' onClick="get_inwon_list();" onfocus="this.blur();" style="cursor: hand;">새로고침</span>&nbsp;&nbsp;&nbsp;
							<span id='menu1' onClick='subManuView(1)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)'>답안지</span>&nbsp;&nbsp;&nbsp;
							<span id='menu2' onClick='subManuView(2)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)'>응시상태변경</span>&nbsp;&nbsp;&nbsp;
							<% if(pt_score_edit.equals("Y")) { %><span id='menu3' onClick='subManuView(3)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(3)' onMouseOut='menuColorBack(3)'>일괄채점</span><% } else { %>일괄채점<% } %>&nbsp;&nbsp;&nbsp;
							<% if(pt_score_edit.equals("Y")) { %><span id='menu4' onClick='m4_4_pop()' onfocus="this.blur();" style="cursor: hand;">수동채점</span><% } else { %>수동채점<% } %>&nbsp;&nbsp;&nbsp;
							<% if(pt_score_edit.equals("Y")) { %><span id='menu5' onclick="m5_2_pop();" onfocus="this.blur();" style="cursor: hand;">득점가감처리</span><% } else { %>득점가감처리<% } %>&nbsp;&nbsp;&nbsp;
							<!--<span id='menu6' onClick='subManuView(6)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(6)' onMouseOut='menuColorBack(6)' >이벤트로그조회</span>&nbsp;&nbsp;&nbsp;
							<span onClick='subManuView(7)' onfocus="this.blur();" style="cursor: hand;" id='menu7' onMouseOver='menuColorChange(7)' onMouseOut='menuColorBack(7)'>답안로그조회</span>&nbsp;&nbsp;&nbsp;-->
							<span id='menu8' onclick="javascript:m8_2_pop()" onfocus="this.blur();" style="cursor: hand;">응시자정보조회</span>&nbsp;&nbsp;&nbsp;
							<!--<span id='menu9' onclick="javascript:m10_2_pop()" onfocus="this.blur();" style="cursor: hand;">부정행위의심자조회</span>&nbsp;&nbsp;&nbsp;-->
							<!--<span id='menu9' onclick="javascript:m11_2_pop()" onfocus="this.blur();" style="cursor: hand;">개인별시간연장</span>&nbsp;&nbsp;&nbsp;
							<!--<%if(randomtype.equals("NN")) { %><span id='menu11' onclick="javascript:m12_1_pop()" onfocus="this.blur();" style="cursor: hand;">답변내역엑셀다운</span>&nbsp;&nbsp;&nbsp;<% } %>-->
							<!--<span id='menu10' onClick='subManuView(10)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(10)' onMouseOut='menuColorBack(10)'>채점관리</span>&nbsp;&nbsp;&nbsp;-->
						</td>
						<td width="45" align="right" valign="top"><img src="../../images/bt_mpaper_out.gif" onclick="window.close();" onfocus="this.blur();" style="cursor: hand;"></td>
					</tr>
				</table>

				<!--------------------------------------------------------------------->
				<!--                         서브메뉴 시작                           -->
				<!--------------------------------------------------------------------->

				<div id='subMenu1' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m1_1" style="display: none;">
							<td align="center" >답안지조회</td>
						</tr>
						<tr id="m1_2">
							<td align="center" ><a href="javascript:m1_2_pop();">답안지조회</a></td>
						</tr>
						<tr id="m1_3" style="display: none;">
							<td align="center">답안지편집</td>
						</tr>
						<tr id="m1_4">
							<td align="center"><a href="javascript:m1_4_pop();">답안지편집</a></td>
						</tr>
						<tr id="m1_5" style="display: none;">
							<td align="center">답안지추가</td>
						</tr>
						<tr id="m1_6">
							<td align="center"><a href="javascript:m1_6_pop();">답안지추가</a></td>
						</tr>
						<tr id="m1_7" style="display: none;">
							<td align="center">답안지삭제</td>
						</tr>
						<tr id="m1_8">
							<td align="center"><a href="javascript:m1_8_pop();">답안지삭제</a></td>
						</tr>
						<tr id="m1_9" style="display: none;">
							<td align="center">답안지복구</td>
						</tr>
						<tr id="m1_10">
							<td align="center"><a href="javascript:m1_10_pop();">답안지복구</a></td>
						</tr>
						<tr id="m1_11" style="display: none;">
							<td align="center">DB에서 답안지삭제</td>
						</tr>
						<tr id="m1_12">
							<td align="center"><a href="javascript:m1_12_pop();">DB에서 답안지삭제</a></td>
						</tr>
					</table>
				</div>
				
				<div id='subMenu2' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m2_1" style="display: none;">
							<td>선택한 응시자의 응시상태를 [미완료] -> [완료] 변경</td>
						</tr>
						<tr id="m2_2">
							<td><a href="javascript:m2_2_pop();">선택한 응시자의 응시상태를 [미완료] -> [완료] 변경</a></td>
						</tr>
						<tr id="m2_3" style="display: none;">
							<td>선택한 응시자의 응시상태를 [완료] -> [미완료] 변경</td>
						</tr>
						<tr id="m2_4">
							<td><a href="javascript:m2_4_pop();">선택한 응시자의 응시상태를 [완료] -> [미완료] 변경</a></td>
						</tr>
						<!--<tr id="m2_5" style="display: none;">
							<td>선택한 응시자를 재응시 가능하도록 변경</td>
						</tr>
						<tr id="m2_6">
							<td><a href="javascript:m2_6_pop();">선택한 응시자를 재응시 가능하도록 변경</a></td>
						</tr>-->
					</table>
				</div>
				
				<div id='subMenu3' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m3_1" style="display: none;">
							<td>선택한 응시자만 채점</td>
						</tr>
						<tr id="m3_2">
							<td><a href="javascript:m3_2_pop()">선택한 응시자만 채점</a></td>
						</tr>
						<tr id="m3_3" style="display: none;">
							<td>모든 응시자 채점</td>
						</tr>
						<tr id="m3_4">
							<td><a href="javascript:m3_4_pop()">모든 응시자 채점</a></td>
						</tr>
					</table>
				</div>
				
				<div id='subMenu4' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<!--<tr id="m4_1" style="display: none;">
							<td>문항별 수동채점</td>
						</tr>
						<tr id="m4_2">
							<td><a href="javascript:m4_2_pop()">문항별 수동채점</a></td>
						</tr>
						<tr id="m4_1" style="display: none;">
							<td>응시자별 수동채점</td>
						</tr>
						<tr id="m4_2">
							<td><a href="javascript:m4_4_pop()">응시자별 수동채점</a></td>
						</tr>
						<tr id="m4_5" style="display: none;">
							<td>논술형 문항 다운로드 및 채점</td>
						</tr>
						<tr id="m4_6">
							<td><a href="javascript:m4_6_pop()">논술형 문항 다운로드 및 채점</a></td>
						</tr>-->
					</table>
					</div>

				<div id='subMenu5' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m5_1" style="display: none;">
							<td></td>
						</tr>
						<tr id="m5_2">
							<td></td>
						</tr>
					</table>
				</div>

				<div id='subMenu6' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m6_1" style="display: none;">
							<td>선택한 응시자 이벤트 로그 조회</td>
						</tr>
						<tr id="m6_2">
							<td><a href="javascript:m6_2_pop()">선택한 응시자 이벤트 로그 조회</a></td>
						</tr>
						<!--<tr id="m6_3" style="display: none;">
							<td>시험 이벤트 로그 Import</td>
						</tr>
						<tr id="m6_4">
							<td><a href="javascript:m6_4_pop()">시험 이벤트 로그 Import</a></td>
						</tr>-->
					</table>
				</div>
				
				<div id='subMenu7' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m7_1" style="display: none;">
							<td>선택한 응시자 답안 로그 조회</td>
						</tr>
						<tr id="m7_2">
							<td><a href="javascript:m7_2_pop()">선택한 응시자 답안 로그 조회</a></td>
						</tr>
						<!--<tr id="m7_3" style="display: none;">
							<td>시험 답안 유실자 검색</td>
						</tr>
						<tr id="m7_4">
							<td><a href="javascript:m7_4_pop()">시험 답안 유실자 검색</a></td>
						</tr>-->
					</table>
				</div>
				
				<div id='subMenu8' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m8_1" style="display: none;">
							<td></td>
						</tr>
						<tr id="m8_2">
							<td></a></td>
						</tr>
					</table>
				</div>

				<div id='subMenu9' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m9_1" style="display: none;">
							<td></td>
						</tr>
						<tr id="m9_2">
							<td></a></td>
						</tr>
					</table>
				</div>				

				<div id='subMenu10' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m10_1" style="display: none;">
							<td>과정채점자 등록관리</td>
						</tr>
						<tr id="m10_2">
							<td><a href="javascript:m15_1_pop()">과정채점자 등록관리</a></td>
						</tr>
						<tr id="m10_3" style="display: none;">
							<td>평가채점자 관리</td>
						</tr>
						<tr id="m10_4">
							<td><a href="javascript:m15_2_pop()">평가채점자 관리</a></td>
						</tr>
					</table>
				</div>
				
			</TD>
		</TR>
		<TR id="main">
			<td valign="top" height="*">
				<div id="delUsers"></div>
				<div id="restoreUsers"></div>

				<!--------------------------------------------------------------------->
				<!--                          검색 시작                              -->
				<!--------------------------------------------------------------------->

				<table width="100%" border="0" cellspacing="0" cellpadding="0" onClick='subManuClear()' style="border-bottom: 1px solid #dbddd2;">
					<tr>
						<td colspan="4" height="35" style="border-top: 1px solid #eef0e5; border-bottom: 1px solid #e6e8db; background-color: #fafaf8; vertical-align: middle; padding-left: 15px;"><img src="../../images/userpp_search1.gif"></td>
					</tr>
					<tr style="background-color: #f0f1e9; padding: 12px 16px 12px 16px; ">
						<td style="border-right: 1px solid #fff; padding-left: 23px;" width="20%">
							<img src="../../images/userpp_search2.gif"><br>
							
							<div style="float: left;"><input type="text" class="input" name="userid" size="12" tabindex="1"></div>
							<div style="float: left; padding-left: 10px; padding-top: 1px;"><a href="javascript:get_user_search();"><img src="../../images/userpp_search.gif" tabindex="2" onfocus="this.blur();"></a></div>
						</td>
						<td style="border-right: 1px solid #fff;" width="20%">
							<img src="../../images/userpp_search3.gif"><br>

							<div style="float: left;"><input type="text" class="input" name="name" size="12" tabindex="3"></div>
							<div style="float: left; padding-left: 10px; padding-top: 1px;"><a href="javascript:get_user_search();"><img src="../../images/userpp_search.gif" tabindex="4" onfocus="this.blur();"></a></div>

						</td>
						<td style="border-right: 1px solid #fff;" width="34%">
							<img src="../../images/userpp_search4.gif"><br>
							<div id="statics1" style="float: left;"><input type="text" class="input" size="6" >&nbsp;&nbsp;<input type="text" class="input" size="6" >&nbsp;&nbsp;<input type="text" class="input" size="6" ></div>
							<div style="float: left; padding-left: 10px; padding-top: 1px;">
							<!--<input type="button" value="확인" onClick="get_statics1();">--><a href="javascript:get_statics1();"><img src="../../images/userpp_search.gif" tabindex="5" onfocus="this.blur();"></a></div>
						</td>
						<td>
							<img src="../../images/userpp_search5.gif"><br>
							<div id="statics2" style="float: left;"><input type="text" class="input" size="6">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="input"size="6"></div>
							<div style="float: left; padding-left: 10px; padding-top: 1px;"><a href="javascript:get_statics2();"><img src="../../images/userpp_search.gif" tabindex="6" onfocus="this.blur();"></a></div>
						</td>
					</tr>
				</table>

				<!--------------------------------------------------------------------->
				<!--                           TAB메뉴                               -->
				<!--------------------------------------------------------------------->

				<div class="tab" style="margin-top: 8px; background-image: url(../../images/a0a0a0.gif); repeat: repeat-x; width: 100%;">
					<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
						<TR>
							<TD width="82"><a href="javascript:get_inwons('btn1');" onfocus="this.blur();"><img src="../../images/tabB01.gif" id="btn1"><img src="../../images/tabB01_.gif" id="btn1_"></a></TD>
							<TD width="84"><a href="javascript:get_inwons('btn2');" onfocus="this.blur();"><img src="../../images/tabB02.gif" id="btn2"><img src="../../images/tabB02_.gif" id="btn2_"></a></TD>
							<TD width="84"><a href="javascript:get_inwons('btn3');" onfocus="this.blur();"><img src="../../images/tabB03.gif" id="btn3"><img src="../../images/tabB03_.gif" id="btn3_"></a></TD>
							<TD width="137"><a href="javascript:get_inwons('btn4');" onfocus="this.blur();"><img src="../../images/tabB04.gif" id="btn4"><img src="../../images/tabB04_.gif" id="btn4_"></a></TD>							
							<TD width="*" align="right"><!--<a href="javascript:score_100();">[ 100점 만점 환산점수로 변경 ]</a>&nbsp;<a href="javascript:rate_100();">[ 100점 만점 비율점수로 변경 ]</a>&nbsp;<a href="javascript:score_export();">[ LMS로 성적내보내기 ]</a>&nbsp;&nbsp;&nbsp;&nbsp;--><img src="../../images/bt_answer_yj7.gif" onClick='excel_save();'  onfocus="this.blur();" style="cursor: hand;"></TD>
						</TR>
					</TABLE>
					
				</div>

				<!--------------------------------------------------------------------->
				<!--                          메인 박스                              -->
				<!--------------------------------------------------------------------->				

				<table cellpadding="0" cellspacing="0" border="0" height="72%" width="100%" style="margin-bottom: 5px;"><tr><td valign="top">

					<table width="1120" border="0" onClick='subManuClear()' height="97%">
						<tr>
							<td valign="top" style="font-size: 11px;">
								<table cellspacing="0" cellpadding="0" border="0" id="tabletop" width="1120">
									<tr align="center">
										<td>
					
					<DIV id="ProgressBar" style="display:none;" class="progress_img_all_cover">
					<img src="../../images/loading.gif" style="position:absolute; top:25%; left:40%;"/> 
                    </DIV>
					
					<!-- 응시자 리스트 시작-->
					<div id="gridbox" style="width:1120;height:450px;background-color:white;"></div>

									</td>
								</tr>
								</table>
							</td>
						</tr>
					</table>
				
				</td></tr></table>

	<script language="JavaScript">
	
	var now_btn;

	var strs = "";

	function menuColorChange(changeNum)
	{
		changeMenu = eval("document.all.menu"+changeNum);
		changeMenu.style.backgroundColor = '';
	}

	function menuColorBack(backNum)
	{
		backMenu = eval("document.all.menu"+backNum);
		backMenu.style.backgroundColor = '';
	}

	function getPosX(o) 
	{
		var x = 0;
		while (o != null) 
		{
			x += o.offsetLeft;
			o = o.offsetParent;
		}
		return x;
		}

	function getPosY(o) 
	{
		var x = 0;
		while (o != null) 
		{
			x += o.offsetTop;
			o = o.offsetParent;
		}
		return x;
	}

	function subManuView(viewNum)
	{
	  if(now_btn == "btn1") { // 완료자 선택
		  document.getElementById("m1_1").disabled = true;
		  document.getElementById("m1_2").style.display = "block"; 
		  document.getElementById("m1_1").style.display = "none";

		  document.getElementById("m1_3").disabled = true;
		  document.getElementById("m1_4").style.display = "block"; 
		  document.getElementById("m1_3").style.display = "none";

		  document.getElementById("m1_5").disabled = true;
		  document.getElementById("m1_5").style.display = "block"; 
		  document.getElementById("m1_6").style.display = "none";

		  document.getElementById("m1_7").disabled = true;
		  document.getElementById("m1_8").style.display = "block"; 
		  document.getElementById("m1_7").style.display = "none";

		  document.getElementById("m1_9").disabled = true;
		  document.getElementById("m1_9").style.display = "block"; 
		  document.getElementById("m1_10").style.display = "none";

		  document.getElementById("m1_11").disabled = true;
		  document.getElementById("m1_11").style.display = "block"; 
		  document.getElementById("m1_12").style.display = "none";

		  document.getElementById("m2_1").disabled = true;
		  document.getElementById("m2_1").style.display = "block"; 
		  document.getElementById("m2_2").style.display = "none";

		  document.getElementById("m2_3").disabled = true;
		  document.getElementById("m2_4").style.display = "block"; 
		  document.getElementById("m2_3").style.display = "none";

		  document.getElementById("m3_1").disabled = true;
		  document.getElementById("m3_2").style.display = "block"; 
		  document.getElementById("m3_1").style.display = "none";

		  document.getElementById("m3_3").disabled = true;
		  document.getElementById("m3_4").style.display = "block"; 
		  document.getElementById("m3_3").style.display = "none";

		  //document.getElementById("m4_1").disabled = true;
		  //document.getElementById("m4_2").style.display = "block"; 
		  //document.getElementById("m4_1").style.display = "none";

		  //document.getElementById("m4_3").disabled = true;
		  //document.getElementById("m4_4").style.display = "block"; 
		  //document.getElementById("m4_3").style.display = "none";

		  //document.getElementById("m4_5").disabled = true;
		  //document.getElementById("m4_6").style.display = "block"; 
		  //document.getElementById("m4_5").style.display = "none";

		  document.getElementById("m5_1").disabled = true;
		  document.getElementById("m5_2").style.display = "block"; 
		  document.getElementById("m5_1").style.display = "none";

		  document.getElementById("m6_1").disabled = true;
		  document.getElementById("m6_2").style.display = "block"; 
		  document.getElementById("m6_1").style.display = "none";

		  //document.getElementById("m6_3").disabled = true;
		  //document.getElementById("m6_4").style.display = "block"; 
		  //document.getElementById("m6_3").style.display = "none";

		  document.getElementById("m7_1").disabled = true;
		  document.getElementById("m7_2").style.display = "block"; 
		  document.getElementById("m7_1").style.display = "none";

		  //document.getElementById("m7_3").disabled = true;
		  //document.getElementById("m7_4").style.display = "block"; 
		  //document.getElementById("m7_3").style.display = "none";
			
		  document.getElementById("m8_1").disabled = true;
		  document.getElementById("m8_2").style.display = "block"; 
		  document.getElementById("m8_1").style.display = "none";

		  document.getElementById("m9_1").disabled = true;
		  document.getElementById("m9_2").style.display = "block"; 
		  document.getElementById("m9_1").style.display = "none";

	  } else if(now_btn == "btn2") { // 미완료자 선택
		  document.getElementById("m1_1").disabled = true;
		  document.getElementById("m1_2").style.display = "block"; 
		  document.getElementById("m1_1").style.display = "none";

		  document.getElementById("m1_3").disabled = true;
		  document.getElementById("m1_4").style.display = "block"; 
		  document.getElementById("m1_3").style.display = "none";

		  document.getElementById("m1_5").disabled = true;
		  document.getElementById("m1_5").style.display = "block"; 
		  document.getElementById("m1_6").style.display = "none";

		  document.getElementById("m1_7").disabled = true;
		  document.getElementById("m1_8").style.display = "block"; 
		  document.getElementById("m1_7").style.display = "none";

		  document.getElementById("m1_9").disabled = true;
		  document.getElementById("m1_9").style.display = "block"; 
		  document.getElementById("m1_10").style.display = "none";

		  document.getElementById("m1_11").disabled = true;
		  document.getElementById("m1_11").style.display = "block"; 
		  document.getElementById("m1_12").style.display = "none";

		  document.getElementById("m2_1").disabled = true;
		  document.getElementById("m2_2").style.display = "block"; 
		  document.getElementById("m2_1").style.display = "none";

		  document.getElementById("m2_3").disabled = true;
		  document.getElementById("m2_3").style.display = "block"; 
		  document.getElementById("m2_4").style.display = "none";

		  document.getElementById("m3_1").disabled = true;
		  document.getElementById("m3_2").style.display = "block"; 
		  document.getElementById("m3_1").style.display = "none";

		  document.getElementById("m3_3").disabled = true;
		  document.getElementById("m3_4").style.display = "block"; 
		  document.getElementById("m3_3").style.display = "none";

		  //document.getElementById("m4_1").disabled = true;
		  //document.getElementById("m4_2").style.display = "block"; 
		  //document.getElementById("m4_1").style.display = "none";

		  //document.getElementById("m4_3").disabled = true;
		  //document.getElementById("m4_4").style.display = "block"; 
		  //document.getElementById("m4_3").style.display = "none";

		  //document.getElementById("m4_5").disabled = true;
		  //document.getElementById("m4_6").style.display = "block"; 
		  //document.getElementById("m4_5").style.display = "none";

		  document.getElementById("m5_1").disabled = true;
		  document.getElementById("m5_1").style.display = "block"; 
		  document.getElementById("m5_2").style.display = "none";

		  document.getElementById("m6_1").disabled = true;
		  document.getElementById("m6_2").style.display = "block"; 
		  document.getElementById("m6_1").style.display = "none";

		  //document.getElementById("m6_3").disabled = true;
		  //document.getElementById("m6_4").style.display = "block"; 
		  //document.getElementById("m6_3").style.display = "none";

		  document.getElementById("m7_1").disabled = true;
		  document.getElementById("m7_2").style.display = "block"; 
		  document.getElementById("m7_1").style.display = "none";

		  //document.getElementById("m7_3").disabled = true;
		  //document.getElementById("m7_4").style.display = "block"; 
		  //document.getElementById("m7_3").style.display = "none";
			
		  document.getElementById("m8_1").disabled = true;
		  document.getElementById("m8_2").style.display = "block"; 
		  document.getElementById("m8_1").style.display = "none";

		  document.getElementById("m9_1").disabled = true;
		  document.getElementById("m9_2").style.display = "block"; 
		  document.getElementById("m9_1").style.display = "none";

	  } else if(now_btn == "btn3") { // 미응시 선택

		  document.getElementById("m1_1").disabled = true;
		  document.getElementById("m1_1").style.display = "block"; 
		  document.getElementById("m1_2").style.display = "none";

		  document.getElementById("m1_3").disabled = true;
		  document.getElementById("m1_3").style.display = "block"; 
		  document.getElementById("m1_4").style.display = "none";

		  document.getElementById("m1_5").disabled = true;
		  document.getElementById("m1_6").style.display = "block"; 
		  document.getElementById("m1_5").style.display = "none";
		  
		  document.getElementById("m1_7").disabled = true;
		  document.getElementById("m1_7").style.display = "block"; 
		  document.getElementById("m1_8").style.display = "none";

		  document.getElementById("m1_9").disabled = true;
		  document.getElementById("m1_9").style.display = "block"; 
		  document.getElementById("m1_10").style.display = "none";

		  document.getElementById("m1_11").disabled = true;
		  document.getElementById("m1_11").style.display = "block"; 
		  document.getElementById("m1_12").style.display = "none";

		  document.getElementById("m2_1").disabled = true;
		  document.getElementById("m2_1").style.display = "block"; 
		  document.getElementById("m2_2").style.display = "none";

		  document.getElementById("m2_3").disabled = true;
		  document.getElementById("m2_3").style.display = "block"; 
		  document.getElementById("m2_4").style.display = "none";

		  //document.getElementById("m2_5").disabled = true;
		  //document.getElementById("m2_5").style.display = "block"; 
		  //document.getElementById("m2_6").style.display = "none";

		  document.getElementById("m3_1").disabled = true;
		  document.getElementById("m3_1").style.display = "block"; 
		  document.getElementById("m3_2").style.display = "none";

		  document.getElementById("m3_3").disabled = true;
		  document.getElementById("m3_3").style.display = "block"; 
		  document.getElementById("m3_4").style.display = "none";

		  //document.getElementById("m4_1").disabled = true;
		  //document.getElementById("m4_1").style.display = "block"; 
		  //document.getElementById("m4_2").style.display = "none";

		  //document.getElementById("m4_3").disabled = true;
		  //document.getElementById("m4_3").style.display = "block"; 
		  //document.getElementById("m4_4").style.display = "none";

		  //document.getElementById("m4_5").disabled = true;
		  //document.getElementById("m4_5").style.display = "block"; 
		  //document.getElementById("m4_6").style.display = "none";

		  document.getElementById("m5_1").disabled = true;
		  document.getElementById("m5_1").style.display = "block"; 
		  document.getElementById("m5_2").style.display = "none";

		  document.getElementById("m6_1").disabled = true;
		  document.getElementById("m6_1").style.display = "block"; 
		  document.getElementById("m6_2").style.display = "none";

		  //document.getElementById("m6_3").disabled = true;
		  //document.getElementById("m6_3").style.display = "block"; 
		  //document.getElementById("m6_4").style.display = "none";

		  document.getElementById("m7_1").disabled = true;
		  document.getElementById("m7_1").style.display = "block"; 
		  document.getElementById("m7_2").style.display = "none";

		  //document.getElementById("m7_3").disabled = true;
		  //document.getElementById("m7_3").style.display = "block"; 
		  //document.getElementById("m7_4").style.display = "none";

		  document.getElementById("m8_1").disabled = true;
		  document.getElementById("m8_2").style.display = "block"; 
		  document.getElementById("m8_1").style.display = "none";

		  document.getElementById("m9_1").disabled = true;
		  document.getElementById("m9_2").style.display = "block"; 
		  document.getElementById("m9_1").style.display = "none";

	  } else if(now_btn == "btn4") { // 답안 삭제자 선택

		  document.getElementById("m1_1").disabled = true;
		  document.getElementById("m1_1").style.display = "block"; 
		  document.getElementById("m1_2").style.display = "none";

		  document.getElementById("m1_3").disabled = true;
		  document.getElementById("m1_3").style.display = "block"; 
		  document.getElementById("m1_4").style.display = "none";

		  document.getElementById("m1_5").disabled = true;
		  document.getElementById("m1_5").style.display = "block"; 
		  document.getElementById("m1_6").style.display = "none";

		  document.getElementById("m1_7").disabled = true;
		  document.getElementById("m1_7").style.display = "block"; 
		  document.getElementById("m1_8").style.display = "none";

		  document.getElementById("m1_9").disabled = true;
		  document.getElementById("m1_10").style.display = "block"; 
		  document.getElementById("m1_9").style.display = "none";

		  document.getElementById("m1_11").disabled = true;
		  document.getElementById("m1_12").style.display = "block"; 
		  document.getElementById("m1_11").style.display = "none";

		  document.getElementById("m2_1").disabled = true;
		  document.getElementById("m2_1").style.display = "block"; 
		  document.getElementById("m2_2").style.display = "none";

		  document.getElementById("m2_3").disabled = true;
		  document.getElementById("m2_3").style.display = "block"; 
		  document.getElementById("m2_4").style.display = "none";

		  //document.getElementById("m2_5").disabled = true;
		  //document.getElementById("m2_5").style.display = "block"; 
		  //document.getElementById("m2_6").style.display = "none";

		  document.getElementById("m3_1").disabled = true;
		  document.getElementById("m3_1").style.display = "block"; 
		  document.getElementById("m3_2").style.display = "none";

		  document.getElementById("m3_3").disabled = true;
		  document.getElementById("m3_3").style.display = "block"; 
		  document.getElementById("m3_4").style.display = "none";

		  //document.getElementById("m4_1").disabled = true;
		  //document.getElementById("m4_1").style.display = "block"; 
		  //document.getElementById("m4_2").style.display = "none";

		  //document.getElementById("m4_3").disabled = true;
		  //document.getElementById("m4_3").style.display = "block"; 
		  //document.getElementById("m4_4").style.display = "none";

		  //document.getElementById("m4_5").disabled = true;
		  //document.getElementById("m4_5").style.display = "block"; 
		  //document.getElementById("m4_6").style.display = "none";

		  document.getElementById("m5_1").disabled = true;
		  document.getElementById("m5_1").style.display = "block"; 
		  document.getElementById("m5_2").style.display = "none";

		  document.getElementById("m6_1").disabled = true;
		  document.getElementById("m6_1").style.display = "block"; 
		  document.getElementById("m6_2").style.display = "none";

		  //document.getElementById("m6_3").disabled = true;
		  //document.getElementById("m6_3").style.display = "block"; 
		  //document.getElementById("m6_4").style.display = "none";

		  document.getElementById("m7_1").disabled = true;
		  document.getElementById("m7_1").style.display = "block"; 
		  document.getElementById("m7_2").style.display = "none";

		  //document.getElementById("m7_3").disabled = true;
		  //document.getElementById("m7_3").style.display = "block"; 
		  //document.getElementById("m7_4").style.display = "none";
			
		  document.getElementById("m8_1").disabled = true;
		  document.getElementById("m8_2").style.display = "block"; 
		  document.getElementById("m8_1").style.display = "none";

		  document.getElementById("m9_1").disabled = true;
		  document.getElementById("m9_2").style.display = "block"; 
		  document.getElementById("m9_1").style.display = "none";

	  } else {

		  document.getElementById("m1_1").disabled = true;
		  document.getElementById("m1_1").style.display = "block"; 
		  document.getElementById("m1_2").style.display = "none";

		  document.getElementById("m1_3").disabled = true;
		  document.getElementById("m1_3").style.display = "block"; 
		  document.getElementById("m1_4").style.display = "none";

		  document.getElementById("m1_5").disabled = true;
		  document.getElementById("m1_5").style.display = "block"; 
		  document.getElementById("m1_6").style.display = "none";
		  
		  document.getElementById("m1_7").disabled = true;
		  document.getElementById("m1_7").style.display = "block"; 
		  document.getElementById("m1_8").style.display = "none";

		  document.getElementById("m1_9").disabled = true;
		  document.getElementById("m1_9").style.display = "block"; 
		  document.getElementById("m1_10").style.display = "none";

		  document.getElementById("m1_11").disabled = true;
		  document.getElementById("m1_11").style.display = "block"; 
		  document.getElementById("m1_12").style.display = "none";

		  document.getElementById("m2_1").disabled = true;
		  document.getElementById("m2_1").style.display = "block"; 
		  document.getElementById("m2_2").style.display = "none";

		  document.getElementById("m2_3").disabled = true;
		  document.getElementById("m2_3").style.display = "block"; 
		  document.getElementById("m2_4").style.display = "none";

		  document.getElementById("m3_1").disabled = true;
		  document.getElementById("m3_1").style.display = "block"; 
		  document.getElementById("m3_2").style.display = "none";

		  document.getElementById("m3_3").disabled = true;
		  document.getElementById("m3_3").style.display = "block"; 
		  document.getElementById("m3_4").style.display = "none";

		  //document.getElementById("m4_1").disabled = true;
		  //document.getElementById("m4_1").style.display = "block"; 
		  //document.getElementById("m4_2").style.display = "none";

		  //document.getElementById("m4_3").disabled = true;
		  //document.getElementById("m4_3").style.display = "block"; 
		  //document.getElementById("m4_4").style.display = "none";

		  //document.getElementById("m4_5").disabled = true;
		  //document.getElementById("m4_5").style.display = "block"; 
		  //document.getElementById("m4_6").style.display = "none";

		  document.getElementById("m5_1").disabled = true;
		  document.getElementById("m5_1").style.display = "block"; 
		  document.getElementById("m5_2").style.display = "none";

		  document.getElementById("m6_1").disabled = true;
		  document.getElementById("m6_1").style.display = "block"; 
		  document.getElementById("m6_2").style.display = "none";

		  document.getElementById("m7_1").disabled = true;
		  document.getElementById("m7_1").style.display = "block"; 
		  document.getElementById("m7_2").style.display = "none";

		  document.getElementById("m8_1").disabled = true;
		  document.getElementById("m8_1").style.display = "block"; 
		  document.getElementById("m8_2").style.display = "none";

		  document.getElementById("m9_1").disabled = true;
		  document.getElementById("m9_2").style.display = "block"; 
		  document.getElementById("m9_1").style.display = "none";
	  }
	
		menuNo = eval("menu"+viewNum);
		subMenu = eval("document.all.subMenu"+viewNum);
	
		for (i=1; i<=10;i++)  // 9를 서브메뉴 개수만큼 넣어야함
		{
			if (i!=viewNum){
				if (eval("document.all.subMenu"+i).style.display =='')
				{
					eval("document.all.subMenu"+i).style.display = 'none';
				}
			}
		}
		
		// 서브메뉴 위치 지정

		if (subMenu.style.display =='none')
		{	
			subMenu.style.left = getPosX(menuNo);
			subMenu.style.top = getPosY(menuNo)+20;
			subMenu.style.display = '';

		}
		else if (subMenu.style.display =='')
		{
			subMenu.style.left = getPosX(menuNo);
			subMenu.style.top = getPosY(menuNo)+20;
			subMenu.style.display = 'none';
		}
	}


	function subManuClear()
	{
	for (i=1; i<=10;i++)  //
	{
		eval("document.all.subMenu"+i).style.display = 'none';
	}
	}

	function excel_save() {
		if(now_btn == "btn1") {
			location.href = "excel_lists.jsp?id_exam=<%=id_exam%>";
		} else if(now_btn == "btn2") {
			location.href = "excel_lists2.jsp?id_exam=<%=id_exam%>";
		} else if(now_btn == "btn3") {
			location.href = "excel_lists3.jsp?id_exam=<%=id_exam%>";
		} else if(now_btn == "btn4") {
			location.href = "excel_lists4.jsp?id_exam=<%=id_exam%>";
		}
	}

	function get_inwons(btns) {	
		subManuClear();
		
		if (btns == "btn1"){
			document.getElementById("btn1").style.display = "none"; 
			document.getElementById("btn1_").style.display = "block";
			document.getElementById("btn2").style.display = "block"; 
			document.getElementById("btn2_").style.display = "none";
			document.getElementById("btn3").style.display = "block"; 
			document.getElementById("btn3_").style.display = "none";
			document.getElementById("btn4").style.display = "block"; 
			document.getElementById("btn4_").style.display = "none";
		} else if (btns == "btn2") {
			document.getElementById("btn1").style.display = "block"; 
			document.getElementById("btn1_").style.display = "none";
			document.getElementById("btn2").style.display = "none"; 
			document.getElementById("btn2_").style.display = "block";
			document.getElementById("btn3").style.display = "block"; 
			document.getElementById("btn3_").style.display = "none";
			document.getElementById("btn4").style.display = "block"; 
			document.getElementById("btn4_").style.display = "none";
		} else if (btns == "btn3") {
			document.getElementById("btn1").style.display = "block"; 
			document.getElementById("btn1_").style.display = "none";
			document.getElementById("btn2").style.display = "block"; 
			document.getElementById("btn2_").style.display = "none";
			document.getElementById("btn3").style.display = "none"; 
			document.getElementById("btn3_").style.display = "block";
			document.getElementById("btn4").style.display = "block"; 
			document.getElementById("btn4_").style.display = "none";
		} else if (btns == "btn4") {
			document.getElementById("btn1").style.display = "block"; 
			document.getElementById("btn1_").style.display = "none";
			document.getElementById("btn2").style.display = "block"; 
			document.getElementById("btn2_").style.display = "none";
			document.getElementById("btn3").style.display = "block"; 
			document.getElementById("btn3_").style.display = "none";
			document.getElementById("btn4").style.display = "none"; 
			document.getElementById("btn4_").style.display = "block";
		}

		now_btn = btns;

		var strs = "";
		
		//document.all.inwon_lists2.innerHTML = strs;

		document.form1.total_inwon.value = "";

		Show_LayerProgressBar(true);
		
		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_inwon_list_callback;

		if(btns == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(btns == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		} else if(btns == "btn3") {
			inwon1.open("GET", "inwon_lists3.jsp?id_exam=<%=id_exam%>", true);
		} else if(btns == "btn4") {
			inwon1.open("GET", "inwon_lists4.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function get_inwon_list() {		
		
		Show_LayerProgressBar(true);

		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_inwon_list_callback;

		if(now_btn == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn3") {
			inwon1.open("GET", "inwon_lists3.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn4") {
			inwon1.open("GET", "inwon_lists4.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function get_inwon_list_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				//if(typeof(document.all.inwon_lists) == "object") {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				} else if(now_btn == "btn3") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,");
					mygrid.setInitWidths("150,120,*")
					mygrid.setColAlign("left,left,left")
					mygrid.setColTypes("ro,ro,ro");
					mygrid.setColSorting("str,str,")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists3.xml",function(){	
					});
				} else if(now_btn == "btn4") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists4.xml",function(){								
					});
				} 
				
				setTimeout("Show_LayerProgressBar(false)",1000);
				document.form1.total_inwon.value = inwon1.responseText;
				
				subManuClear();				
			}
		}
	}

	function get_inwons_order(field, order) {

		subManuClear();

		var fields = field;
		var orders = order;

		order1 = new ActiveXObject("Microsoft.XMLHTTP");
		order1.onreadystatechange = get_inwons_order_callback;

		if(now_btn == "btn1") {
			order1.open("GET", "inwon_order_lists.jsp?id_exam=<%=id_exam%>&fields="+fields+"&orders="+orders, true);
		} else if(now_btn == "btn2") {
			order1.open("GET", "inwon_order_lists2.jsp?id_exam=<%=id_exam%>&fields="+fields+"&orders="+orders, true);
		} else if(now_btn == "btn3") {
			if(fields == "userid" || fields == "name") {
				order1.open("GET", "inwon_order_lists3.jsp?id_exam=<%=id_exam%>&fields="+fields+"&orders="+orders, true);
			} else {
				return;
			}
		} else if(now_btn == "btn4") {
			order1.open("GET", "inwon_order_lists4.jsp?id_exam=<%=id_exam%>&fields="+fields+"&orders="+orders, true);
		}

		order1.send();
	}

	function get_inwons_order_callback() { 
		if(order1.readyState == 4) {
			if(order1.status == 200) {
				if(typeof(document.all.inwon_lists) == "object") {
					document.all.inwon_lists2.innerHTML = order1.responseText;
					document.form1.total_inwon.value = document.form1.inwon_lists.length;
				}
			}
		}
	}

	function m1_6_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("답안지 추가할 대상자를 선택해주세요.");
			return;
		} else {
			subManuClear();
			window.open("ans_insert.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_ins","width=400, height=200, scrollbars=yes");
		}
	}

	function get_answer_add() {
		
		Show_LayerProgressBar(true);
		
		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_answer_add_callback;

		inwon1.open("GET", "inwon_lists3.jsp?id_exam=<%=id_exam%>", true);

		inwon1.send();
	}

	function get_answer_add_callback() {

		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				//if(typeof(document.all.inwon_lists) == "object") {
				mygrid = new dhtmlXGridObject('gridbox');	
				mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
				mygrid.setHeader("아이디,성명,");
				mygrid.setInitWidths("150,120,*")
				mygrid.setColAlign("left,left,left")
				mygrid.setColTypes("ro,ro,ro");
				mygrid.setColSorting("str,str,")
				mygrid.setMultiselect(!mygrid.selMultiRows);
				mygrid.setEditable(!mygrid.isEditable);
				mygrid.init();
				mygrid.setSkin("dhx_web");
				mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists3.xml",function(){	
				});

				setTimeout("Show_LayerProgressBar(false)",1000);
				document.form1.total_inwon.value = inwon1.responseText;
				alert("답안지가 정상적으로 등록되었습니다.");

				subManuClear();
				//}
			}
		}
	}

	function get_answer_score() {
		subManuClear();

		Show_LayerProgressBar(true);

		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_answer_score_callback;

		if(now_btn == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function get_answer_score_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}

				setTimeout("Show_LayerProgressBar(false)",1000);

				document.form1.total_inwon.value = inwon1.responseText;
				alert("정답 채점이 끝났습니다. 새 점수가 반영되려면 [성적 통계] 처리를 다시 실행해야 됩니다.");				
			}
		}
	}

	function get_answer_score_proc() {
		subManuClear();
		Show_LayerProgressBar(true);

		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_answer_score_proc_callback;

		if(now_btn == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function get_answer_score_proc_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}
				
				setTimeout("Show_LayerProgressBar(false)",1000);

				document.form1.total_inwon.value = inwon1.responseText;
				alert("득점가감처리작업이 완료되었습니다. 새 점수가 반영되려면 [성적 통계] 처리를 다시 실행해야 됩니다.");				
			}
		}
	}

	function get_100_score_proc() {
		subManuClear();

		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_100_score_proc_callback;

		if(now_btn == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function get_100_score_proc_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}
				document.form1.total_inwon.value = inwon1.responseText;
				alert("100점 만점으로 환산처리작업이 완료되었습니다.");
				
			}
		}
	}

	function get_100_score_reset() {
		subManuClear();

		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_100_score_reset_callback;

		if(now_btn == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function get_100_score_reset_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}
				document.form1.total_inwon.value = inwon1.responseText;
				alert("100점 만점으로 환산처리한 점수가 원점수로 복원되었습니다.");
			}
		}
	}

	function rate_100_score_proc() {
		subManuClear();

		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = rate_100_score_proc_callback;

		if(now_btn == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function rate_100_score_proc_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}
				document.form1.total_inwon.value = inwon1.responseText;
				alert("100점 비율 점수로 환산처리작업이 완료되었습니다.");
			}
		}
	}

	function rate_100_score_reset() {
		subManuClear();

		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = rate_100_score_reset_callback;

		if(now_btn == "btn1") {
			inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>", true);
		} else if(now_btn == "btn2") {
			inwon1.open("GET", "inwon_lists2.jsp?id_exam=<%=id_exam%>", true);
		}

		inwon1.send();
	}

	function rate_100_score_reset_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}
				document.form1.total_inwon.value = inwon1.responseText;
				alert("100점 비율 점수로 환산처리한 점수가 원점수로 복원되었습니다.");				
			}
		}
	}

	function selects(vals) {
		subManuClear();
		window.open("ans_view.jsp?id_exam=<%=id_exam%>&userid="+vals,"ans_view","width=1100, height=700, scrollbars=yes");
	}

	function m1_2_pop() {
		
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}
				
		if(strs == "" || strs == null) {
			alert("답안지를 조회할 대상자를 선택해주세요.");
		} else {
			subManuClear();
			window.open("ans_view.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_view","width=1100, height=700, scrollbars=yes");	  
		}
	}

	function m1_4_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("답안지를 수정할 대상자를 선택해주세요.");
		} else {
			subManuClear();
			window.open("ans_edit.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_edit","width=1100, height=700, scrollbars=yes");	  
		}
	}

	function m1_8_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}			
		}

		if(strs == "" || strs == null) {
			alert("답안지를 삭제할 대상자를 선택해주세요.");
		} else {
			var st = confirm("선택한 응시자의 답안지를 삭제하시겠습니까? \n\n답안지를 삭제하면 나중에 복구 목록에서 복구할 수 있습니다. \n\n재 시험을 치르게 할 때만 삭제하시기 바랍니다.\n\n답안지를 삭제하고 재 시험을 치르게 되면 성적 통계 처리를 다시 하셔야 합니다." );

			if (st == true) {
				subManuClear();
				del_list(selectId.substring(0,selectId.length-1));
			}
		}
	}

	function del_list(userids) {
		
		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = del_list_callback;
		qs2.open("POST", "ans_delete.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs2.send("id_exam=<%=id_exam%>&btn="+now_btn+"&userids="+userids);
	}

	function del_list_callback() {
		//var val = document.form1.inwon_lists.length;

		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}	
				
				setTimeout("Show_LayerProgressBar(false)",1000);

				document.form1.total_inwon.value = qs2.responseText;
				get_inwon_list();
				alert("답안지가 삭제되었습니다.\n\n삭제된 답안지를 복구하시려면 삭제된 답안지 목록에서 답안지 복구를 사용하세요.\n\n답안지가 삭제된 응시자는 시험 기간중이라면 다시 로그인하여 재 시험을 볼 수 있습니다.");				
			}
		}
	}
	
	function m1_10_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("답안지를 복구할 대상자를 선택해주세요.");
		} else {
			var st = confirm("선택한 응시자의 답안지를 복구하시겠습니까?");

			if (st == true) {
				//window.open("ans_restore.jsp?id_exam=<%=id_exam%>&userid="+selectId,"ans_restore","width=300, height=100");
				subManuClear();
				restore_list(selectId.substring(0,selectId.length-1));
			}
		}
	}

	function restore_list(userids) {

		Show_LayerProgressBar(true);

		qs3 = new ActiveXObject("Microsoft.XMLHTTP");
		qs3.onreadystatechange = restore_list_callback;
		qs3.open("POST", "ans_restore.jsp", true);
		qs3.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs3.send("id_exam=<%=id_exam%>&btn="+now_btn+"&userids="+userids);
	}

	function restore_list_callback() {		

		if(qs3.readyState == 4) {
			if(qs3.status == 200) {
				if(typeof(document.all.restoreUsers) == "object") {
		
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists4.xml",function(){	
					});

					setTimeout("Show_LayerProgressBar(false)",1000);
					
					document.form1.total_inwon.value = qs3.responseText;
					get_inwon_list();
					alert("답안지가 정상적으로 복구되었습니다.");
				}
			}
		}
	}

	function m1_12_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("답안지를 DB에서 삭제할 대상자를 선택해주세요.");
		} else {
			var st = confirm("**************** 주의 ****************\n\n선택한 응시자의 답안지를 DB에서 삭제하시겠습니까? \n\n답안지를 DB에서 삭제하면 복구하실 수 없습니다. \n\n신중하게 진행하시기 바랍니다." );

			if (st == true) {
				subManuClear();
				del_list_db(selectId.substring(0,selectId.length-1));
			}
		}
	}

	function del_list_db(userids) {

		Show_LayerProgressBar(true);

		del2 = new ActiveXObject("Microsoft.XMLHTTP");
		del2.onreadystatechange = del_list_db_callback;
		del2.open("POST", "ans_db_delete.jsp", true);
		del2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		del2.send("id_exam=<%=id_exam%>&userids="+userids);
	}

	function del_list_db_callback() {
		
		if(del2.readyState == 4) {
			if(del2.status == 200) {
				if(typeof(document.all.delUsers) == "object") {
		
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists4.xml",function(){	
					});

					setTimeout("Show_LayerProgressBar(false)",1000);
					
					document.form1.total_inwon.value = del2.responseText;
					get_inwon_list();
					alert("선택한 응시자 답안지가 DB에서 삭제되었습니다.");
				}
			}
		}
	}

	function m2_2_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}			
		}

		if(strs == "" || strs == null) {
			alert("대상자를 선택해주세요.");
		} else {
			var st = confirm("선택한 응시자의 응시상태를 [미완료]에서 [완료]로 변경합니다.\n\n[완료]로 변경하면 성적 통계에 해당 응시자의 성적이 반영됩니다.\n\n그러나 [완료]로 변경하면 해당 응시자는 시험을 다시 응시할 수 없습니다.\n\n계속하시겠습니까?");

			if(st == true) {
				answer_Y(selectId.substring(0,selectId.length-1));
			}
		}
	}

	function answer_Y(userids) {

		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = answer_Y_callback;
		qs2.open("POST", "ans_Y.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs2.send("id_exam=<%=id_exam%>&userids="+userids);
	}

	function answer_Y_callback() {			

		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				if(typeof(document.all.delUsers) == "object") {
			
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
                    
					setTimeout("Show_LayerProgressBar(false)",1000);
					document.form1.total_inwon.value = qs2.responseText;
					get_inwon_list();
					alert("응시상태 변경처리가 완료되었습니다.");
					subManuClear();
				}
			}
		}
	}

	function m2_6_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}			
		}

		if(strs == "" || strs == null) {
			alert("대상자를 선택해주세요.");
		} else {
			var st = confirm("선택한 응시자를 재응시 가능하도록 변경합니다.\n\n계속하시겠습니까?");

			if(st == true) {
				restart_Y(selectId.substring(0,selectId.length-1));
			}
		}
	}
	
	function m2_4_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}			
		}

		if(strs == "" || strs == null) {
			alert("대상자를 선택해주세요.");
		} else {
			var st = confirm("선택한 응시자의 응시상태를 [완료]에서 [미완료]로 변경합니다.\n\n[미완료]로 변경하면 성적 통계에 해당 응시자의 성적이 반영되지 않습니다.\n\n그리고 [미완료]로 변경하면 해당 응시자는 해당 시험을 푼 문제 이후부터 다시 응시할 수 있습니다.\n\n계속하시겠습니까?");

			if(st == true) {
				answer_N(selectId.substring(0,selectId.length-1));
			}
		}
	}

	function m3_2_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("채점진행 할 대상자를 선택해주세요.");
		} else {
			var st = confirm("현재 선택한 응시자 답안지를 일괄 정답 채점을 합니다.\n\n수동 채점을 한 결과는 정답 채점에 그대로 반영이 됩니다.\n\n실행하시겠습니까?");

			if(st == true) {
				subManuClear();
				window.open("ans_score.jsp?id_exam=<%=id_exam%>&userids="+selectId.substring(0,selectId.length-1),"ans_score","width=500, height=120");
			}
		}
	}

	function m3_4_pop() {

		var st = confirm("전체 응시자 답안지를 일괄 정답 채점을 합니다.\n\n수동 채점을 한 결과는 정답 채점에 그대로 반영이 됩니다.\n\n실행하시겠습니까?");

		if(st == true) {
			window.open("ans_all_score.jsp?id_exam=<%=id_exam%>&btns="+now_btn,"ans_all_score","width=500, height=120");
		}
	}

	function m4_2_pop() {
		subManuClear();
		window.open("ans_mark.jsp?id_exam=<%=id_exam%>","ans_mark","width=1100, height=640, scrollbars=yes");
	}

	function m4_4_pop() {
		subManuClear();
		window.open("m_frame.jsp?id_exam=<%=id_exam%>","ans_mark2","width=900, height=650, scrollbars=yes");
		//window.open("ans_mark.jsp?id_exam=<%=id_exam%>","ans_mark","width=1100, height=640, scrollbars=yes");		
	}

	function m4_6_pop() {
		subManuClear();
		window.open("exam_non_answer.jsp?id_exam=<%=id_exam%>","ans_mark3","width=900, height=680, scrollbars=yes");
	}

	function m5_2_pop() {
		
		var frmx = document.form1;
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("득점가감처리 할 대상자를 선택해주세요.");
		} else {
			var st = confirm("득점가감처리는 채점이 완료된 응시자만 가능합니다.\n\n채점이 되지 않았으면 채점후 진행하시기 바랍니다.\n\n실행하시겠습니까?");

			if(st == true) {
				window.open("","new_win2","width=500, height=300");
				frmx.id_exam.value = "<%=id_exam%>";
				frmx.sel_userids.value = selectId;
				frmx.method="post";
				frmx.action = "ans_score_process.jsp";
				frmx.target = "new_win2";
				frmx.submit();
			}
		}
	}

	function score_100() {
		
		var st = confirm("해당 시험에 배점이 100점이 아닐경우에\n\n응시자들 점수를 100점 만점 점수로\n\n환산처리하실 수 있습니다.\n\n응시자 채점을 하지 않았을 경우에는\n\n채점 진행 후 이용하시기 바랍니다.\n\n실행하시겠습니까?");

		if(st == true) {
			window.open("100_score.jsp?id_exam=<%=id_exam%>","100_win","width=500, height=300");		
		}
	}

	function rate_100() {
		
		var st = confirm("해당 시험에 배점이 100점이 아닐경우에\n\n응시자들 점수를 100점 만점 비율점수로\n\n환산처리하실 수 있습니다.\n\n응시자 채점을 하지 않았을 경우에는\n\n채점 진행 후 이용하시기 바랍니다.\n\n실행하시겠습니까?");

		if(st == true) {
			window.open("100_rate.jsp?id_exam=<%=id_exam%>","100_win","width=500, height=300");		
		}
	}
	
	function answer_N(userids) {

		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = answer_N_callback;
		qs2.open("POST", "ans_N.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs2.send("id_exam=<%=id_exam%>&userids="+userids);
	}

	function answer_N_callback() {
		
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				if(typeof(document.all.delUsers) == "object") {
			
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});					
				}

				setTimeout("Show_LayerProgressBar(false)",1000);
				document.form1.total_inwon.value = qs2.responseText;
				get_inwon_list();
				alert("응시상태 변경처리가 완료되었습니다.");
				subManuClear();
			}
		}
	}

	function restart_Y(userids) {

		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = restart_Y_callback;
		qs2.open("POST", "restart_Y.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs2.send("id_exam=<%=id_exam%>&userids="+userids);
	}

	function restart_Y_callback() {
		
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_lists2.xml",function(){	
					});
				}

				setTimeout("Show_LayerProgressBar(false)",1000);
				get_inwon_list();
				alert("재응시 가능상태로 변경처리가 완료되었습니다.");
				subManuClear();

			}
		}
	}

	function get_user_search() {
		subManuClear();

		var frm = document.form1;

		if(frm.userid.value == "" && frm.name.value == "") {
			alert("검색할 아이디 또는 성명을 입력하세요");
			return;
		}

		var userid = frm.userid.value;
		var name = frm.name.value; 

		Show_LayerProgressBar(true);
		
		inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
		inwon1.onreadystatechange = get_user_search_callback;
		
		if(now_btn == "btn3") {
			inwon1.open("GET", "inwon_search2.jsp?id_exam=<%=id_exam%>&btn="+now_btn+"&userid="+userid+"&name="+name, true);
		} else {
			inwon1.open("GET", "inwon_search.jsp?id_exam=<%=id_exam%>&btn="+now_btn+"&userid="+userid+"&name="+name, true);
		}
	
		inwon1.send();	
	}

	function get_user_search_callback() {
		if(inwon1.readyState == 4) {
			if(inwon1.status == 200) {
				if(now_btn == "btn1") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_search.xml",function(){	
					});
				} else if(now_btn == "btn2") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_search.xml",function(){	
					});
				} else if(now_btn == "btn3") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,");
					mygrid.setInitWidths("150,120,*")
					mygrid.setColAlign("left,left,left")
					mygrid.setColTypes("ro,ro,ro");
					mygrid.setColSorting("str,str,")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_search2.xml",function(){	
					});
				} else if(now_btn == "btn4") {
					mygrid = new dhtmlXGridObject('gridbox');	
					mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
					mygrid.setHeader("아이디,성명,시험지,시험시작시간,답안제출시간,응시자IP,득점,원득점,가감내용");
					mygrid.setInitWidths("150,90,80,150,150,120,80,80,*")
					mygrid.setColAlign("left,left,center,center,center,left,left,left,left")
					mygrid.setColTypes("ro,link,ro,ro,ro,ro,ro,ro,ro");
					mygrid.setColSorting("str,str,int,str,str,str,int,int,str")
					mygrid.setMultiselect(!mygrid.selMultiRows);
					mygrid.setEditable(!mygrid.isEditable);
					mygrid.init();
					mygrid.setSkin("dhx_web");
					mygrid.loadXML("../../dhtmlxGrid/xml/inwon_search.xml",function(){								
					});
				} 
				setTimeout("Show_LayerProgressBar(false)",1000);
			}
		}
	}

	function get_statics1() {
		subManuClear();

		static1 = new ActiveXObject("Microsoft.XMLHTTP");
		static1.onreadystatechange = get_statics1_callback;

		static1.open("GET", "statics1.jsp?id_exam=<%=id_exam%>", true);

		static1.send();
	}

	function get_statics1_callback() {
		if(static1.readyState == 4) {
			if(static1.status == 200) {
				if(typeof(document.all.statics1) == "object") {
					document.all.statics1.innerHTML = static1.responseText;
				}
			}
		}
	}

	function get_statics2() {
		subManuClear();

		static2 = new ActiveXObject("Microsoft.XMLHTTP");
		static2.onreadystatechange = get_statics2_callback;

		static2.open("GET", "statics2.jsp?id_exam=<%=id_exam%>", true);

		static2.send();
	}

	function get_statics2_callback() {
		if(static2.readyState == 4) {
			if(static2.status == 200) {
				if(typeof(document.all.statics2) == "object") {
					document.all.statics2.innerHTML = static2.responseText;
				}
			}
		}
	}

	function go(ing,end){
		document.all.div1.style.display = "block";
		document.all.div1.style.width = (ing+1)/end*100+"%";
		//ing+1 하는이유는 (ing+1)/end*100  =0 이되면 에러가 나기 때문
	}

	function m6_2_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("이벤트로그를 확인할 대상자를 선택해주세요.");
		} else {
			subManuClear();
			window.open("ans_event.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_event","width=1020, height=650, scrollbars=yes");
		}
	}

	function m6_4_pop() {
		var str = confirm("시험 이벤트 로그를 DB에 저장하시겠습니까?\n\n이벤트 로그 Import 작업은 서버에 많은 부하를 주게 되므로\n반드시 시험이 없는 서버가 한가한 시간에 작업을 진행하시기 바랍니다.\n\n계속하시겠습니까?");

		if(str == true) {
			subManuClear();
			window.open("http://localhost/qmtmweb/paper/log_evt_import.asp?id_exam=<%=id_exam%>","ans_event","width=1020, height=650, scrollbars=no");
		}
	}

	function m7_2_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("답안로그를 확인할 대상자를 선택해주세요.");
		} else {
			subManuClear();
			window.open("ans_log.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_log","width=1020, height=650, scrollbars=yes");
		}
	}

	function m7_4_pop() {
		var str = confirm("답안 유실 의심자 검색을 실행하시겠습니까?\n\n답안 유실 의심자 검색작업은 서버에 많은 부하를 주게 되므로\n반드시 시험이 없는 서버가 한가한 시간에 작업을 진행하시기 바랍니다.\n\n계속하시겠습니까?");

		if(str == true) {
			subManuClear();
			window.open("http://localhost/qmtmweb/paper/log_ans_find.asp?id_exam=<%=id_exam%>","ans_lost_find","width=800, height=650, scrollbars=yes");
		}
	}

	function m15_1_pop() {
		subManuClear();
		window.open("http://localhost/qmtmweb/admin/mk_list2.asp?id_course=<%=id_course%>&userid=<%=userid%>&id_exam=<%=id_exam%>","ans_manager","width=900, height=650, scrollbars=yes");
	}

	function m15_2_pop() {
		subManuClear();
		window.open("http://localhost/qmtmweb/admin/mn_insert.asp?id_exam=<%=id_exam%>","exam_manager","width=700, height=450, scrollbars=yes");
	}

	function m8_2_pop() {
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}
			
		}

		if(strs == "" || strs == null) {
			alert("응시자 정보를 확인할 대상자를 선택해주세요.");
		} else {
			subManuClear();
			window.open("user_info.jsp?userid="+selectId.substring(0,selectId.length-1),"user_info","width=580, height=450, scrollbars=no");
		}
	}
	
	function m9_2_pop() {
		window.open("../../scorehelp/exam_list.jsp?id_exam=<%=id_exam%>","score_help","fullscreen, scrollbars=yes");
	}

	function m10_2_pop() {
		subManuClear();
		window.open("cheat_exam.jsp?id_exam=<%=id_exam%>","ans_mark2","width=1050, height=650, scrollbars=yes");
	}

	function m11_2_pop() {
		
		if(now_btn == "btn1" || now_btn == "btn3" || now_btn == "btn4") {
			alert("미완료자에 대해서만 개인시간을 연장할 수 있습니다.");
			return;
		}
		
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			for(var i=0; i<ArrIds.length; i++) {
				selectId += mygrid.cells(ArrIds[i],0).getValue() + ",";
			}			
		}
				
		if(strs == "" || strs == null) {
			alert("개인별 시간연장 할 대상자를 선택해주세요.");
		} else {
			subManuClear();
			window.open("user_time_change.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_view","width=600, height=550, scrollbars=no");	
		}
	}

	function m12_1_pop() {
		subManuClear();
		location.href="http://localhost/qmtmweb/admin_util/exam_ans_list_excel.asp?id_exam=<%=id_exam%>";
	}

	function score_export() {

		var str = confirm("LMS로 성적내보내기를 실행합니다.\n\nLMS 로 성적내보내기 전 채점을 진행하셔야 하며,\n\n단답형이나 논술형 문항이 포함되었을경우에는\n\n응시자들에 대해서 수동채점을 진행하셔야 성적내보내기가 가능합니다.\n\n\nLMS로 성적내보내기를 실행하시겠습니까?");

		if(str) {
			window.open("lms_score_export.jsp?id_exam=<%=id_exam%>","lms_export","width=350, height=250");
		}
	}
		  
	function Show_LayerProgressBar(isView) { 
		if (isView) { 
			document.all.ProgressBar.style.display = "block";
		}else{ 
			document.all.ProgressBar.style.display = "none";
		} 
	} 

	</script>

		<div align="right"><!--<font color="red"><b>* 재응시자는 리스트상에 붉은색으로 표시됩니다.</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->합계&nbsp;&nbsp;<input type="text" class="input" name="total_inwon" size="6" readonly> 명&nbsp;</div>
		<!--/div-->

		</TD>
	</TR>		
	</TABLE>

	</form>

</BODY>
</HTML>



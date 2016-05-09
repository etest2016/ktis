<%
//******************************************************************************
//   ���α׷� : answer_main.jsp
//   �� �� �� : ����� ���� 
//   ��    �� : ����� ����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-05-19
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	�������� : 
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
  <TITLE> :: ����� ���� :: </TITLE>  

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
							<span id='menu0' onClick="get_inwon_list();" onfocus="this.blur();" style="cursor: hand;">���ΰ�ħ</span>&nbsp;&nbsp;&nbsp;
							<span id='menu1' onClick='subManuView(1)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)'>�����</span>&nbsp;&nbsp;&nbsp;
							<span id='menu2' onClick='subManuView(2)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)'>���û��º���</span>&nbsp;&nbsp;&nbsp;
							<% if(pt_score_edit.equals("Y")) { %><span id='menu3' onClick='subManuView(3)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(3)' onMouseOut='menuColorBack(3)'>�ϰ�ä��</span><% } else { %>�ϰ�ä��<% } %>&nbsp;&nbsp;&nbsp;
							<% if(pt_score_edit.equals("Y")) { %><span id='menu4' onClick='m4_4_pop()' onfocus="this.blur();" style="cursor: hand;">����ä��</span><% } else { %>����ä��<% } %>&nbsp;&nbsp;&nbsp;
							<% if(pt_score_edit.equals("Y")) { %><span id='menu5' onclick="m5_2_pop();" onfocus="this.blur();" style="cursor: hand;">��������ó��</span><% } else { %>��������ó��<% } %>&nbsp;&nbsp;&nbsp;
							<!--<span id='menu6' onClick='subManuView(6)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(6)' onMouseOut='menuColorBack(6)' >�̺�Ʈ�α���ȸ</span>&nbsp;&nbsp;&nbsp;
							<span onClick='subManuView(7)' onfocus="this.blur();" style="cursor: hand;" id='menu7' onMouseOver='menuColorChange(7)' onMouseOut='menuColorBack(7)'>��ȷα���ȸ</span>&nbsp;&nbsp;&nbsp;-->
							<span id='menu8' onclick="javascript:m8_2_pop()" onfocus="this.blur();" style="cursor: hand;">������������ȸ</span>&nbsp;&nbsp;&nbsp;
							<!--<span id='menu9' onclick="javascript:m10_2_pop()" onfocus="this.blur();" style="cursor: hand;">���������ǽ�����ȸ</span>&nbsp;&nbsp;&nbsp;-->
							<!--<span id='menu9' onclick="javascript:m11_2_pop()" onfocus="this.blur();" style="cursor: hand;">���κ��ð�����</span>&nbsp;&nbsp;&nbsp;
							<!--<%if(randomtype.equals("NN")) { %><span id='menu11' onclick="javascript:m12_1_pop()" onfocus="this.blur();" style="cursor: hand;">�亯���������ٿ�</span>&nbsp;&nbsp;&nbsp;<% } %>-->
							<!--<span id='menu10' onClick='subManuView(10)' onfocus="this.blur();" style="cursor: hand;" onMouseOver='menuColorChange(10)' onMouseOut='menuColorBack(10)'>ä������</span>&nbsp;&nbsp;&nbsp;-->
						</td>
						<td width="45" align="right" valign="top"><img src="../../images/bt_mpaper_out.gif" onclick="window.close();" onfocus="this.blur();" style="cursor: hand;"></td>
					</tr>
				</table>

				<!--------------------------------------------------------------------->
				<!--                         ����޴� ����                           -->
				<!--------------------------------------------------------------------->

				<div id='subMenu1' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m1_1" style="display: none;">
							<td align="center" >�������ȸ</td>
						</tr>
						<tr id="m1_2">
							<td align="center" ><a href="javascript:m1_2_pop();">�������ȸ</a></td>
						</tr>
						<tr id="m1_3" style="display: none;">
							<td align="center">���������</td>
						</tr>
						<tr id="m1_4">
							<td align="center"><a href="javascript:m1_4_pop();">���������</a></td>
						</tr>
						<tr id="m1_5" style="display: none;">
							<td align="center">������߰�</td>
						</tr>
						<tr id="m1_6">
							<td align="center"><a href="javascript:m1_6_pop();">������߰�</a></td>
						</tr>
						<tr id="m1_7" style="display: none;">
							<td align="center">���������</td>
						</tr>
						<tr id="m1_8">
							<td align="center"><a href="javascript:m1_8_pop();">���������</a></td>
						</tr>
						<tr id="m1_9" style="display: none;">
							<td align="center">���������</td>
						</tr>
						<tr id="m1_10">
							<td align="center"><a href="javascript:m1_10_pop();">���������</a></td>
						</tr>
						<tr id="m1_11" style="display: none;">
							<td align="center">DB���� ���������</td>
						</tr>
						<tr id="m1_12">
							<td align="center"><a href="javascript:m1_12_pop();">DB���� ���������</a></td>
						</tr>
					</table>
				</div>
				
				<div id='subMenu2' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m2_1" style="display: none;">
							<td>������ �������� ���û��¸� [�̿Ϸ�] -> [�Ϸ�] ����</td>
						</tr>
						<tr id="m2_2">
							<td><a href="javascript:m2_2_pop();">������ �������� ���û��¸� [�̿Ϸ�] -> [�Ϸ�] ����</a></td>
						</tr>
						<tr id="m2_3" style="display: none;">
							<td>������ �������� ���û��¸� [�Ϸ�] -> [�̿Ϸ�] ����</td>
						</tr>
						<tr id="m2_4">
							<td><a href="javascript:m2_4_pop();">������ �������� ���û��¸� [�Ϸ�] -> [�̿Ϸ�] ����</a></td>
						</tr>
						<!--<tr id="m2_5" style="display: none;">
							<td>������ �����ڸ� ������ �����ϵ��� ����</td>
						</tr>
						<tr id="m2_6">
							<td><a href="javascript:m2_6_pop();">������ �����ڸ� ������ �����ϵ��� ����</a></td>
						</tr>-->
					</table>
				</div>
				
				<div id='subMenu3' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m3_1" style="display: none;">
							<td>������ �����ڸ� ä��</td>
						</tr>
						<tr id="m3_2">
							<td><a href="javascript:m3_2_pop()">������ �����ڸ� ä��</a></td>
						</tr>
						<tr id="m3_3" style="display: none;">
							<td>��� ������ ä��</td>
						</tr>
						<tr id="m3_4">
							<td><a href="javascript:m3_4_pop()">��� ������ ä��</a></td>
						</tr>
					</table>
				</div>
				
				<div id='subMenu4' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<!--<tr id="m4_1" style="display: none;">
							<td>���׺� ����ä��</td>
						</tr>
						<tr id="m4_2">
							<td><a href="javascript:m4_2_pop()">���׺� ����ä��</a></td>
						</tr>
						<tr id="m4_1" style="display: none;">
							<td>�����ں� ����ä��</td>
						</tr>
						<tr id="m4_2">
							<td><a href="javascript:m4_4_pop()">�����ں� ����ä��</a></td>
						</tr>
						<tr id="m4_5" style="display: none;">
							<td>����� ���� �ٿ�ε� �� ä��</td>
						</tr>
						<tr id="m4_6">
							<td><a href="javascript:m4_6_pop()">����� ���� �ٿ�ε� �� ä��</a></td>
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
							<td>������ ������ �̺�Ʈ �α� ��ȸ</td>
						</tr>
						<tr id="m6_2">
							<td><a href="javascript:m6_2_pop()">������ ������ �̺�Ʈ �α� ��ȸ</a></td>
						</tr>
						<!--<tr id="m6_3" style="display: none;">
							<td>���� �̺�Ʈ �α� Import</td>
						</tr>
						<tr id="m6_4">
							<td><a href="javascript:m6_4_pop()">���� �̺�Ʈ �α� Import</a></td>
						</tr>-->
					</table>
				</div>
				
				<div id='subMenu7' style="z-index:1; display: none;" class="submenu">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr id="m7_1" style="display: none;">
							<td>������ ������ ��� �α� ��ȸ</td>
						</tr>
						<tr id="m7_2">
							<td><a href="javascript:m7_2_pop()">������ ������ ��� �α� ��ȸ</a></td>
						</tr>
						<!--<tr id="m7_3" style="display: none;">
							<td>���� ��� ������ �˻�</td>
						</tr>
						<tr id="m7_4">
							<td><a href="javascript:m7_4_pop()">���� ��� ������ �˻�</a></td>
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
							<td>����ä���� ��ϰ���</td>
						</tr>
						<tr id="m10_2">
							<td><a href="javascript:m15_1_pop()">����ä���� ��ϰ���</a></td>
						</tr>
						<tr id="m10_3" style="display: none;">
							<td>��ä���� ����</td>
						</tr>
						<tr id="m10_4">
							<td><a href="javascript:m15_2_pop()">��ä���� ����</a></td>
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
				<!--                          �˻� ����                              -->
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
							<!--<input type="button" value="Ȯ��" onClick="get_statics1();">--><a href="javascript:get_statics1();"><img src="../../images/userpp_search.gif" tabindex="5" onfocus="this.blur();"></a></div>
						</td>
						<td>
							<img src="../../images/userpp_search5.gif"><br>
							<div id="statics2" style="float: left;"><input type="text" class="input" size="6">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="input"size="6"></div>
							<div style="float: left; padding-left: 10px; padding-top: 1px;"><a href="javascript:get_statics2();"><img src="../../images/userpp_search.gif" tabindex="6" onfocus="this.blur();"></a></div>
						</td>
					</tr>
				</table>

				<!--------------------------------------------------------------------->
				<!--                           TAB�޴�                               -->
				<!--------------------------------------------------------------------->

				<div class="tab" style="margin-top: 8px; background-image: url(../../images/a0a0a0.gif); repeat: repeat-x; width: 100%;">
					<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
						<TR>
							<TD width="82"><a href="javascript:get_inwons('btn1');" onfocus="this.blur();"><img src="../../images/tabB01.gif" id="btn1"><img src="../../images/tabB01_.gif" id="btn1_"></a></TD>
							<TD width="84"><a href="javascript:get_inwons('btn2');" onfocus="this.blur();"><img src="../../images/tabB02.gif" id="btn2"><img src="../../images/tabB02_.gif" id="btn2_"></a></TD>
							<TD width="84"><a href="javascript:get_inwons('btn3');" onfocus="this.blur();"><img src="../../images/tabB03.gif" id="btn3"><img src="../../images/tabB03_.gif" id="btn3_"></a></TD>
							<TD width="137"><a href="javascript:get_inwons('btn4');" onfocus="this.blur();"><img src="../../images/tabB04.gif" id="btn4"><img src="../../images/tabB04_.gif" id="btn4_"></a></TD>							
							<TD width="*" align="right"><!--<a href="javascript:score_100();">[ 100�� ���� ȯ�������� ���� ]</a>&nbsp;<a href="javascript:rate_100();">[ 100�� ���� ���������� ���� ]</a>&nbsp;<a href="javascript:score_export();">[ LMS�� ������������ ]</a>&nbsp;&nbsp;&nbsp;&nbsp;--><img src="../../images/bt_answer_yj7.gif" onClick='excel_save();'  onfocus="this.blur();" style="cursor: hand;"></TD>
						</TR>
					</TABLE>
					
				</div>

				<!--------------------------------------------------------------------->
				<!--                          ���� �ڽ�                              -->
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
					
					<!-- ������ ����Ʈ ����-->
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
	  if(now_btn == "btn1") { // �Ϸ��� ����
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

	  } else if(now_btn == "btn2") { // �̿Ϸ��� ����
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

	  } else if(now_btn == "btn3") { // ������ ����

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

	  } else if(now_btn == "btn4") { // ��� ������ ����

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
	
		for (i=1; i<=10;i++)  // 9�� ����޴� ������ŭ �־����
		{
			if (i!=viewNum){
				if (eval("document.all.subMenu"+i).style.display =='')
				{
					eval("document.all.subMenu"+i).style.display = 'none';
				}
			}
		}
		
		// ����޴� ��ġ ����

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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
			alert("����� �߰��� ����ڸ� �������ּ���.");
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
				mygrid.setHeader("���̵�,����,");
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
				alert("������� ���������� ��ϵǾ����ϴ�.");

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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("���� ä���� �������ϴ�. �� ������ �ݿ��Ƿ��� [���� ���] ó���� �ٽ� �����ؾ� �˴ϴ�.");				
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("��������ó���۾��� �Ϸ�Ǿ����ϴ�. �� ������ �ݿ��Ƿ��� [���� ���] ó���� �ٽ� �����ؾ� �˴ϴ�.");				
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("100�� �������� ȯ��ó���۾��� �Ϸ�Ǿ����ϴ�.");
				
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("100�� �������� ȯ��ó���� ������ �������� �����Ǿ����ϴ�.");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("100�� ���� ������ ȯ��ó���۾��� �Ϸ�Ǿ����ϴ�.");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("100�� ���� ������ ȯ��ó���� ������ �������� �����Ǿ����ϴ�.");				
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
			alert("������� ��ȸ�� ����ڸ� �������ּ���.");
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
			alert("������� ������ ����ڸ� �������ּ���.");
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
			alert("������� ������ ����ڸ� �������ּ���.");
		} else {
			var st = confirm("������ �������� ������� �����Ͻðڽ��ϱ�? \n\n������� �����ϸ� ���߿� ���� ��Ͽ��� ������ �� �ֽ��ϴ�. \n\n�� ������ ġ���� �� ���� �����Ͻñ� �ٶ��ϴ�.\n\n������� �����ϰ� �� ������ ġ���� �Ǹ� ���� ��� ó���� �ٽ� �ϼž� �մϴ�." );

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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("������� �����Ǿ����ϴ�.\n\n������ ������� �����Ͻ÷��� ������ ����� ��Ͽ��� ����� ������ ����ϼ���.\n\n������� ������ �����ڴ� ���� �Ⱓ���̶�� �ٽ� �α����Ͽ� �� ������ �� �� �ֽ��ϴ�.");				
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
			alert("������� ������ ����ڸ� �������ּ���.");
		} else {
			var st = confirm("������ �������� ������� �����Ͻðڽ��ϱ�?");

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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					alert("������� ���������� �����Ǿ����ϴ�.");
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
			alert("������� DB���� ������ ����ڸ� �������ּ���.");
		} else {
			var st = confirm("**************** ���� ****************\n\n������ �������� ������� DB���� �����Ͻðڽ��ϱ�? \n\n������� DB���� �����ϸ� �����Ͻ� �� �����ϴ�. \n\n�����ϰ� �����Ͻñ� �ٶ��ϴ�." );

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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					alert("������ ������ ������� DB���� �����Ǿ����ϴ�.");
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
			alert("����ڸ� �������ּ���.");
		} else {
			var st = confirm("������ �������� ���û��¸� [�̿Ϸ�]���� [�Ϸ�]�� �����մϴ�.\n\n[�Ϸ�]�� �����ϸ� ���� ��迡 �ش� �������� ������ �ݿ��˴ϴ�.\n\n�׷��� [�Ϸ�]�� �����ϸ� �ش� �����ڴ� ������ �ٽ� ������ �� �����ϴ�.\n\n����Ͻðڽ��ϱ�?");

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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					alert("���û��� ����ó���� �Ϸ�Ǿ����ϴ�.");
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
			alert("����ڸ� �������ּ���.");
		} else {
			var st = confirm("������ �����ڸ� ������ �����ϵ��� �����մϴ�.\n\n����Ͻðڽ��ϱ�?");

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
			alert("����ڸ� �������ּ���.");
		} else {
			var st = confirm("������ �������� ���û��¸� [�Ϸ�]���� [�̿Ϸ�]�� �����մϴ�.\n\n[�̿Ϸ�]�� �����ϸ� ���� ��迡 �ش� �������� ������ �ݿ����� �ʽ��ϴ�.\n\n�׸��� [�̿Ϸ�]�� �����ϸ� �ش� �����ڴ� �ش� ������ Ǭ ���� ���ĺ��� �ٽ� ������ �� �ֽ��ϴ�.\n\n����Ͻðڽ��ϱ�?");

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
			alert("ä������ �� ����ڸ� �������ּ���.");
		} else {
			var st = confirm("���� ������ ������ ������� �ϰ� ���� ä���� �մϴ�.\n\n���� ä���� �� ����� ���� ä���� �״�� �ݿ��� �˴ϴ�.\n\n�����Ͻðڽ��ϱ�?");

			if(st == true) {
				subManuClear();
				window.open("ans_score.jsp?id_exam=<%=id_exam%>&userids="+selectId.substring(0,selectId.length-1),"ans_score","width=500, height=120");
			}
		}
	}

	function m3_4_pop() {

		var st = confirm("��ü ������ ������� �ϰ� ���� ä���� �մϴ�.\n\n���� ä���� �� ����� ���� ä���� �״�� �ݿ��� �˴ϴ�.\n\n�����Ͻðڽ��ϱ�?");

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
			alert("��������ó�� �� ����ڸ� �������ּ���.");
		} else {
			var st = confirm("��������ó���� ä���� �Ϸ�� �����ڸ� �����մϴ�.\n\nä���� ���� �ʾ����� ä���� �����Ͻñ� �ٶ��ϴ�.\n\n�����Ͻðڽ��ϱ�?");

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
		
		var st = confirm("�ش� ���迡 ������ 100���� �ƴҰ�쿡\n\n�����ڵ� ������ 100�� ���� ������\n\nȯ��ó���Ͻ� �� �ֽ��ϴ�.\n\n������ ä���� ���� �ʾ��� ��쿡��\n\nä�� ���� �� �̿��Ͻñ� �ٶ��ϴ�.\n\n�����Ͻðڽ��ϱ�?");

		if(st == true) {
			window.open("100_score.jsp?id_exam=<%=id_exam%>","100_win","width=500, height=300");		
		}
	}

	function rate_100() {
		
		var st = confirm("�ش� ���迡 ������ 100���� �ƴҰ�쿡\n\n�����ڵ� ������ 100�� ���� ����������\n\nȯ��ó���Ͻ� �� �ֽ��ϴ�.\n\n������ ä���� ���� �ʾ��� ��쿡��\n\nä�� ���� �� �̿��Ͻñ� �ٶ��ϴ�.\n\n�����Ͻðڽ��ϱ�?");

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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("���û��� ����ó���� �Ϸ�Ǿ����ϴ�.");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
				alert("������ ���ɻ��·� ����ó���� �Ϸ�Ǿ����ϴ�.");
				subManuClear();

			}
		}
	}

	function get_user_search() {
		subManuClear();

		var frm = document.form1;

		if(frm.userid.value == "" && frm.name.value == "") {
			alert("�˻��� ���̵� �Ǵ� ������ �Է��ϼ���");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
					mygrid.setHeader("���̵�,����,");
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
					mygrid.setHeader("���̵�,����,������,������۽ð�,�������ð�,������IP,����,������,��������");
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
		//ing+1 �ϴ������� (ing+1)/end*100  =0 �̵Ǹ� ������ ���� ����
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
			alert("�̺�Ʈ�α׸� Ȯ���� ����ڸ� �������ּ���.");
		} else {
			subManuClear();
			window.open("ans_event.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_event","width=1020, height=650, scrollbars=yes");
		}
	}

	function m6_4_pop() {
		var str = confirm("���� �̺�Ʈ �α׸� DB�� �����Ͻðڽ��ϱ�?\n\n�̺�Ʈ �α� Import �۾��� ������ ���� ���ϸ� �ְ� �ǹǷ�\n�ݵ�� ������ ���� ������ �Ѱ��� �ð��� �۾��� �����Ͻñ� �ٶ��ϴ�.\n\n����Ͻðڽ��ϱ�?");

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
			alert("��ȷα׸� Ȯ���� ����ڸ� �������ּ���.");
		} else {
			subManuClear();
			window.open("ans_log.jsp?id_exam=<%=id_exam%>&userid="+selectId.substring(0,selectId.length-1),"ans_log","width=1020, height=650, scrollbars=yes");
		}
	}

	function m7_4_pop() {
		var str = confirm("��� ���� �ǽ��� �˻��� �����Ͻðڽ��ϱ�?\n\n��� ���� �ǽ��� �˻��۾��� ������ ���� ���ϸ� �ְ� �ǹǷ�\n�ݵ�� ������ ���� ������ �Ѱ��� �ð��� �۾��� �����Ͻñ� �ٶ��ϴ�.\n\n����Ͻðڽ��ϱ�?");

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
			alert("������ ������ Ȯ���� ����ڸ� �������ּ���.");
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
			alert("�̿Ϸ��ڿ� ���ؼ��� ���νð��� ������ �� �ֽ��ϴ�.");
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
			alert("���κ� �ð����� �� ����ڸ� �������ּ���.");
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

		var str = confirm("LMS�� �����������⸦ �����մϴ�.\n\nLMS �� ������������ �� ä���� �����ϼž� �ϸ�,\n\n�ܴ����̳� ����� ������ ���ԵǾ�����쿡��\n\n�����ڵ鿡 ���ؼ� ����ä���� �����ϼž� �����������Ⱑ �����մϴ�.\n\n\nLMS�� �����������⸦ �����Ͻðڽ��ϱ�?");

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

		<div align="right"><!--<font color="red"><b>* �������ڴ� ����Ʈ�� ���������� ǥ�õ˴ϴ�.</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->�հ�&nbsp;&nbsp;<input type="text" class="input" name="total_inwon" size="6" readonly> ��&nbsp;</div>
		<!--/div-->

		</TD>
	</TR>		
	</TABLE>

	</form>

</BODY>
</HTML>



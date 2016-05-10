<%
//******************************************************************************
//   프로그램 : q_s_lits.jsp
//   모 듈 명 : 문제 관리
//   설    명 : 문제 목록 및 추가,수정,삭제
//   테 이 블 : q, 
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, qmtm.common.NameBean, 
//             qmtm.common.NameUtil, qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, qmtm.common.NameBean, qmtm.common.NameUtil, qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }	
	
	if (userid.length() == 0 || id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// 화면 Depth
	NameBean names = null;

	try {
		names = NameUtil.getSubject(id_q_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	
	// 담당자 권한 체크	
	String pt_q_edit = "";
	String pt_q_delete = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getQ_work(id_q_subject, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	pt_q_edit = bean.getPt_q_edit();
	pt_q_delete = bean.getPt_q_delete();

    // 과목에 해당하는 문제 가져오기	
	QListBean[] rst = null;

    try {
	    rst = QListUtil.getSBeans(userid, id_q_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<HTML>
 <HEAD>
  <TITLE> QMAN 과목 문제 관리 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>
  <SCRIPT LANGUAGE="JavaScript">
  <!--

   var pt_q_edit = "<%=pt_q_edit%>";
   var pt_q_delete = "<%=pt_q_delete%>";

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
		if(pt_q_edit == "Y") {
		    document.getElementById("m1_1").style.display = "block"; 
			document.getElementById("m1_2").style.display = "block";

			document.getElementById("m2_1").style.display = "block"; 
			document.getElementById("m2_2").style.display = "block";
			document.getElementById("m2_3").style.display = "block"; 
			
		} else {
			document.getElementById("m1_1").style.display = "none"; 
			document.getElementById("m1_2").style.display = "none";

			document.getElementById("m2_1").style.display = "none"; 
			document.getElementById("m2_2").style.display = "none";
			document.getElementById("m2_3").style.display = "none"; 
		}

		if(pt_q_delete == "Y") {
			document.getElementById("m2_3").style.display = "block";
		} else {
			document.getElementById("m2_3").style.display = "none";
		}
		
		menuNo = eval("menu"+viewNum);
		subMenu = eval("document.all.subMenu"+viewNum);
	  
	    for (i=1; i<=2;i++)  // 2를 서브메뉴 개수만큼 넣어야함
	    {
		   if (i!=viewNum)
		   {
		      if (eval("document.all.subMenu"+i).style.display =='')
		      {
			     eval("document.all.subMenu"+i).style.display = 'none';
		      }
		   }
	   }

	  if (subMenu.style.display =='none')
	  {
		  subMenu.style.left = getPosX(menuNo);
		  subMenu.style.top = getPosY(menuNo)+35;
		  subMenu.style.display = '';
	  }
	  else if (subMenu.style.display =='')
	  {
		  subMenu.style.left = getPosX(menuNo);
		  subMenu.style.top = getPosY(menuNo)+35;
		  subMenu.style.display = 'none';
	   }
	}

	function menuColorChange(changeNum)
	{
		changeMenu = eval("document.all.menu"+changeNum);
		changeMenu.style.backgroundColor = '#DFDFDF';
	}

	function menuColorBack(backNum)
	{
		backMenu = eval("document.all.menu"+backNum);
		backMenu.style.backgroundColor = '#FFFFFF';
	}
	
	function subManuClear()
	{
	  for (i=1; i<=2;i++)
	  {
		  eval("document.all.subMenu"+i).style.display = 'none';
	  }
	}
			
	function m1_1_pop(){
		$.posterPopup("q_qtype.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","QInsert","width=500,height=500,scrollbars=yes");
	}

	function m1_2_pop(){
		$.posterPopup("../editor/batchFile.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","BatchInsert","width=700,height=730,scrollbars=yes");
	}

	function QEdit(){
		$.posterPopup("q_edit.jsp?id_q_subject=<%=id_q_subject%>","QEdit","width=740,height=500");
	}

	function q_delete() {
		 subManuClear();
		 
		 var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists.length == undefined) {
			 if(frmx.inwon_lists.checked == true) {
				 selectId = selectId + frmx.inwon_lists.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 if (frmx.inwon_lists[i].checked == true) {
					selectId = selectId + frmx.inwon_lists[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("삭제할 문제를 선택해주세요.");
		 } else {
			 var st = confirm("선택한 문제를 삭제하시겠습니까?\n\n이미 시험으로 출제된 문제은 삭제되지 않습니다." );

			 if (st == true) {
				$.posterPopup("q_delete.jsp?qs="+selectId.substring(0,selectId.length-1),"qs_del","width=600, height=250");
				//del_list(selectId.substring(0,selectId.length-1));
			 }
		 }
	 }

	 function del_list(qs) {
		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = del_list_callback;
		qs2.open("POST", "q_delete.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=EUC-KR");
		qs2.send("qs="+qs);
	 }

	 function del_list_callback() {
		var val = document.form1.inwon_lists.length;

		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				if(typeof(document.all.delUsers) == "object") {

					for (var i=0; i<val; i++)
					{
						for (var j=0; j<document.form1.inwon_lists.options.length; j++)
						{
							if (document.form1.inwon_lists.options[j].selected == true)
							{
								document.form1.inwon_lists.remove(j);
								break;
					        }
						 }
					 }
					document.form1.total_inwon.value = document.form1.inwon_lists.length;
					alert("문제가 삭제되었습니다.\n\n삭제된 답안지를 복구하시려면 삭제된 답안지 목록에서 답안지 복구를 사용하세요.\n\n답안지가 삭제된 응시자는 시험 기간중이라면 다시 로그인하여 재 시험을 볼 수 있습니다.");
				}
			}
		}
	}

	function q_move() {
		 subManuClear();

		 var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists.length == undefined) {
			 if(frmx.inwon_lists.checked == true) {
				 selectId = selectId + frmx.inwon_lists.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 if (frmx.inwon_lists[i].checked == true) {
					selectId = selectId + frmx.inwon_lists[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("이동할 문제를 선택해주세요.");
		 } else {
			 $.posterPopup("q_move.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=600, height=300");
		 }
	}

	function q_copy() {
		 subManuClear();

		 var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists.length == undefined) {
			 if(frmx.inwon_lists.checked == true) {
				 selectId = selectId + frmx.inwon_lists.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 if (frmx.inwon_lists[i].checked == true) {
					selectId = selectId + frmx.inwon_lists[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("복사할 문제를 선택해주세요.");
		 } else {
			 $.posterPopup("q_copy.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=600, height=300");
		 }
	}

	function cpt_insert() {
		subManuClear();

		$.posterPopup("../../admin/q_tree/chapter/chapter_insert.jsp?id_q_subject=<%=id_q_subject%>","insert","width=400, height=250, scrollbars=no");
    }

	function q_static() {
		subManuClear();

		var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists.length == undefined) {
			 if(frmx.inwon_lists.checked == true) {
				 selectId = selectId + frmx.inwon_lists.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 if (frmx.inwon_lists[i].checked == true) {
					selectId = selectId + frmx.inwon_lists[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("문제분석 확인할 문제를 선택해주세요.");
			 return;
		 } else if(k > 1) {
			 alert("문제분석은 여러개의 문제를 확인할 수 없습니다.\n\n문제분석 확인할 문제만 선택해주세요.");
			 return;
		 } else { 	
			 $.posterPopup("q_static_view.jsp?id_q="+selectId.substring(0,selectId.length-1),"q_static","width=850, height=600 scrollbars=yes");
		 }
	}
	
	function q_info() {
		subManuClear();

		var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists.length == undefined) {
			 if(frmx.inwon_lists.checked == true) {
				 selectId = selectId + frmx.inwon_lists.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 if (frmx.inwon_lists[i].checked == true) {
					selectId = selectId + frmx.inwon_lists[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("문제정보 변경할 문제를 선택해주세요.");
		 } else {
			 $.posterPopup("q_info_edit.jsp?id_qs="+selectId.substring(0,selectId.length-1),"info_q","top=0, left=0, width=540, height=560");
		 }
	}
	
	function q_preview() {
		 subManuClear();

		 var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists.length == undefined) {
			 if(frmx.inwon_lists.checked == true) {
				 selectId = selectId + frmx.inwon_lists.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 if (frmx.inwon_lists[i].checked == true) {
					selectId = selectId + frmx.inwon_lists[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("미리보기 할 문제를 선택해주세요.");
		 } else {
			 $.posterPopup("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","width=850, height=600, scrollbars=yes");
		 }
	 }

	 function html_saves() {
		 subManuClear();

		 var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists.length == undefined) {
			 if(frmx.inwon_lists.checked == true) {
				 selectId = selectId + frmx.inwon_lists.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 if (frmx.inwon_lists[i].checked == true) {
					selectId = selectId + frmx.inwon_lists[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("HTML 저장 할 문제를 선택해주세요.");
		 } else {
			 location.href = "q_html_save.jsp?id_qs="+selectId.substring(0,selectId.length-1);
		 }
	 }

	 function selects() {
		 subManuClear();

		 var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.inwon_lists == undefined) {
			 k = 0;
		 } else if(frmx.inwon_lists != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 k = k + 1;
			 }
		 }

		 frmx.search_cnt.value = k;
	 }

	 function dbl_selects(vals) {
		 $.posterPopup("../editor/edit_form.jsp?id_q="+vals+"&id_subject=<%=names.getId_subject()%>","q_edit","width=1020, height=740, scrollbars=yes");
	 }

	 function dbl_selects_text(vals) {
		 $.posterPopup("../editor/edit_form_text.jsp?id_q="+vals+"&id_subject=<%=names.getId_subject()%>","q_edit","width=1020, height=740, scrollbars=yes");
	 }

	 function check_enable() {
		var frmx = document.form1;
		
		if(frmx.inwon_lists.length == undefined) {
			 frmx.inwon_lists.checked = true;
		} else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 frmx.inwon_lists[i].checked = true;
			 }
		 }
	 }

	 function check_disable() {
		var frmx = document.form1;
		
		if(frmx.inwon_lists.length == undefined) {
			 frmx.inwon_lists.checked = false;
		} else if(frmx.inwon_lists.length != undefined) {
			 for (i=0; i<=frmx.inwon_lists.length -1; i++) {
				 frmx.inwon_lists[i].checked = false;
			 }
		}
	 }

	 function q_search() {
		$.posterPopup("q_search.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>","q_search","width=1000, height=600, scrollbars=yes");
	 }

	 function q_excel() {
		 location.href="<%=ComLib.getConfig("weburl")%>/admin_util/q_subject_excel.asp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>";
	 }

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onLoad = "selects();" id="qman">
	<div id="main">
		<FORM NAME="form1">
		<div id="mainTop">
			<div class="title">문제관리 <span>선택 카테고리의 하위 단원 생성 및 신규문제 등록,수정,삭제,분석등의 작업을 진행합니다. </span></div>			
		</div>

		<table border="0" cellpadding ="0" cellspacing="0">
			<tr>
				<td name='menu1' id='menu1' onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)' onClick='subManuView(1)'><img src="../../images/bt6_qman_1.gif" style="cursor: pointer;"></td>
				<td name='menu2' id='menu2' onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)' onClick='subManuView(2)'><img src="../../images/bt6_qman_2.gif" style="cursor: pointer;"></td>
				<td <% if(pt_q_edit.equals("Y")) { %> onClick='cpt_insert();' <% } %>><img src="../../images/bt6_qman_3.gif" style="cursor: pointer;"></td>
				<td onClick='q_static();'><img src="../../images/bt6_qman_4.gif" style="cursor: pointer;"></td>
				<td <% if(pt_q_edit.equals("Y")) { %> onClick='q_info();' <% } %>><img src="../../images/bt6_qman_5.gif" style="cursor: pointer;"></td>
				<td onClick='q_preview();'><img src="../../images/bt6_qman_6.gif" style="cursor: pointer;"></td>
				<td onClick='html_saves();'><img src="../../images/bt6_qman_7.gif" style="cursor: pointer;"></td>
				<td onClick='q_search();'><img src="../../images/bt6_qman_8.gif" style="cursor: pointer;"></td>
			</tr>
	 	</table>

		<div id='subMenu1' style="position:absolute; z-index:1; display: none; margin-top: 27px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<img src="../../images/bt7_q_sub1.gif" id="m1_1" onclick="javascript:m1_1_pop();" style="cursor: pointer;">
					</td>
					<td>
						<img src="../../images/bt7_q_sub2.gif" id="m1_2" onclick="javascript:m1_2_pop();" style="cursor: pointer;">
					</td>
				</tr>
			</table>
		</div>

		<div id='subMenu2' style="position:absolute; z-index:1; background-color: #FFFFFF; display: none; margin-top: 27px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<img src="../../images/bt7_q_sub3.gif" id="m2_1" onclick="javascript:q_move();" style="cursor: pointer;"></a></td>
					<td id="m2_4">
					</td>
					<td>
						<img src="../../images/bt7_q_sub4.gif" id="m2_2" onclick="javascript:q_copy();" style="cursor: pointer;">
					</td>
					<td>
						<img src="../../images/bt7_q_sub5.gif" id="m2_3" onclick="javascript:q_delete();" style="cursor: pointer;">
					</td>
				</tr>
			</table>
		</div>

		
		<div id='subMenu3' style="position:absolute; z-index:1; display: none; margin-top: 27px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<img src="../../images/bt7_q_sub6.gif" onclick="javascript:cpt_insert();" id="m3_1" style="cursor: pointer;">
					</td>
					<td>
						<img src="../../images/bt7_q_sub7.gif" onclick="javascript:cpt_view();" id="m3_2" style="cursor: pointer;">
					</td>
				</tr>
			</table>
		</div>
		
		<br>	
		<table border="0" width="100%">
			<tr>
				<td align="left"><img src="../../images/bt_q_list_yj1.gif" onClick="check_enable();">&nbsp;&nbsp;<img src="../../images/bt_q_list2_yj1.gif"  onClick="check_disable();">&nbsp;&nbsp;검색된 문제 수 : <input type="text" class="input" name="search_cnt" size="3">&nbsp;문제&nbsp;&nbsp;<b><font color="green">(문제를 클릭하면 등록된 문제를 편집할 수 있습니다.)</font></b><!--&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="문제엑셀다운로드" class="form" onClick="q_excel();">--></td>
				<td align="right"><span> <b>▶ <font color="red" size="3"><%=names.getSubject()%></b></font></span></div></td>
			</tr>
		</table>
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tb1" width="100%" onclick="sortColumn(event)">
			<THEAD>
			<tr id="trTOP1" height="30">
				<td width="50" align="center" bgcolor="#DDDDDD">선택</td>
				<td width="100" align="center" bgcolor="#DDDDDD">문제코드 ▲▼</td>
				<td width="80" align="center" bgcolor="#DDDDDD">문제유형 ▲▼</td>	
				<td width="80" align="center" bgcolor="#DDDDDD">출제횟수</td>
				<td align="center" bgcolor="#DDDDDD">문제 ▲▼</td>
			</tr>
			</THEAD>

			<% if(rst == null) { %>
			<TBODY>
			<tr bgcolor="#FFFFFF">
				<td colspan="5" align="center" height="40" valign="middle">등록된 문제가 없습니다.</td>
			</tr>
			</TBODY>
			<% 
				} else {
					for(int i=0; i<rst.length; i++) {
			%>
			<tr id="trDATA1">
				<td align="center"><input type="checkbox" value="<%=rst[i].getId_q()%>" name="inwon_lists"></td>
				<td align="center"><%=rst[i].getId_q()%></td>
				<td align="center"><%=rst[i].getQtype()%></td>
				<td align="center">0</td>
				<td align="left">&nbsp;<%if(rst[i].getInput_text().equals("Y")) { %><a href="javascript:onClick=dbl_selects_text('<%=rst[i].getId_q()%>');"><% } else { %><a href="javascript:onClick=dbl_selects('<%=rst[i].getId_q()%>');"><% } %><%=rst[i].getQ()%></a></font></td>
			</tr>
			<%
					}
				}
			%>
			
		</table>
		
		</form>
	</div>
	<jsp:include page="../../copyright.jsp"/>
 </BODY>
</HTML>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
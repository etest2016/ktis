<%
//******************************************************************************
//   프로그램 : q_list1.jsp
//   모 듈 명 : 문제 관리
//   설    명 : 문제 목록 및 추가,수정,삭제
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-04-16
//   작 성 자 : 이테스트 강진아
//   수 정 일 :
//   수 정 자 :
//	 수정사항 :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.qman.question.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	if (id_q_subject.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }	

	if (id_q_chapter.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%
	}

    NameBean names = null;

	try {
		names = NameUtil.getChapter1(id_q_chapter);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// 담당자 권한 체크	
	String pt_q_edit = "";
	String pt_q_delete = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getQ_work(id_q_subject, userid);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	pt_q_edit = bean.getPt_q_edit();
	pt_q_delete = bean.getPt_q_delete();
	
	// 단원에 해당하는 문제 가져오기

	QListBean[] rst = null;

    try {
	    rst = QListUtil.getUBeans(userid, id_q_subject, id_q_chapter);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }

%>

<HTML>
 <HEAD>
  <TITLE> QMAN 과목 문제 관리 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
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
			document.getElementById("m1_1").disabled = true;
		    document.getElementById("m1_1").style.display = "none"; 
			document.getElementById("m1_2").style.display = "block";

			document.getElementById("m1_3").disabled = true;
			document.getElementById("m1_3").style.display = "none"; 
			document.getElementById("m1_4").style.display = "block";

			document.getElementById("m2_1").disabled = true;
			document.getElementById("m2_1").style.display = "none"; 
			document.getElementById("m2_2").style.display = "block";

			document.getElementById("m2_3").disabled = true;
			document.getElementById("m2_3").style.display = "none"; 
			document.getElementById("m2_4").style.display = "block";			

			document.getElementById("m3_1").disabled = true;
			document.getElementById("m3_1").style.display = "none"; 
			document.getElementById("m3_2").style.display = "block";

			document.getElementById("m3_3").disabled = true;
			document.getElementById("m3_3").style.display = "none"; 
			document.getElementById("m3_4").style.display = "block";
			
		} else {
			document.getElementById("m1_1").disabled = true;
		    document.getElementById("m1_1").style.display = "block"; 
			document.getElementById("m1_2").style.display = "none";		 

			document.getElementById("m1_3").disabled = true;
			document.getElementById("m1_3").style.display = "block"; 
			document.getElementById("m1_4").style.display = "none";			

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
		}

		if(pt_q_delete == "Y") {
			document.getElementById("m2_5").disabled = true;
			document.getElementById("m2_5").style.display = "none"; 
			document.getElementById("m2_6").style.display = "block";
		} else {
			document.getElementById("m2_5").disabled = true;
			document.getElementById("m2_5").style.display = "block"; 
			document.getElementById("m2_6").style.display = "none";
		}

		menuNo = eval("menu"+viewNum);
		subMenu = eval("document.all.subMenu"+viewNum);
	  
	    for (i=1; i<=3;i++)  // 2를 서브메뉴 개수만큼 넣어야함
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

	function m1_2_pop() {
		
	}

	function m1_4_pop() {
	
	}

	function subManuClear()
	{
	  for (i=1; i<=3;i++)
	  {
		  eval("document.all.subMenu"+i).style.display = 'none';
	  }
	}
	
	function QInsert(){
		window.open("q_qtype.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","QInsert","width=500,height=500,scrollbars=yes");
	}

	function QSearch(){
		window.open("q_search.jsp?id_q_subject=<%=id_q_subject%>","QSearch","width=900,height=650, scrollbars=yes");
	}

	function QEdit(){
		window.open("q_edit.jsp?id_q_subject=<%=id_q_subject%>","QEdit","width=740,height=500");
	}

	function q_delete() {
		subManuClear();

		var frmx = document.form1;
		var lngLen = frmx.inwon_lists.length -1;

		var selectId = "";
		var k = 0;

		for (i=0; i<=lngLen; i++) {
		   if (frmx.inwon_lists[i].selected == true) {
			   selectId = selectId + frmx.inwon_lists[i].value + ",";
			   k = k + 1;
		   }
		}

		if(k == 0) {
		    alert("삭제할 문제를 선택해주세요.");
		} else {
		    var st = confirm("이미 시험으로 출제된 문항은 삭제되지 않습니다.\n\n선택한 문항을 삭제하시겠습니까?" );

			if (st == true) {
				window.open("q_delete.jsp?qs="+selectId.substring(0,selectId.length-1),"qs_del","width=600, height=250");
				//del_list(selectId.substring(0,selectId.length-1));
			}
	    }
	}

	function q_move() {
		subManuClear();

		var frmx = document.form1;
		var lngLen = frmx.inwon_lists.length -1;

		var selectId = "";
		var k = 0;

		for (i=0; i<=lngLen; i++) {
		  if (frmx.inwon_lists[i].selected == true) {
			 selectId = selectId + frmx.inwon_lists[i].value + ",";
			 k = k + 1;
		  }
		}

		if(k == 0) {
		   alert("이동할 문제를 선택해주세요.");
		} else {
		   window.open("q_move.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=600, height=250");
		}
	}

	function q_copy() {
		subManuClear();

		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("복사할 문제를 선택해주세요.");
		 } else {
			 window.open("q_copy.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=600, height=250");
		 }
	}

	function q_static() {
		subManuClear();

		var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = frmx.inwon_lists[i].value;
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("문항분석 확인할 문제를 선택해주세요.");
		 } else {
			 window.open("q_static_view.jsp?id_q="+selectId,"q_static","width=850, height=650 scrollbars=auto");
		 }
	}
	
	function cpt_insert() {
		subManuClear();

		window.open("../../admin2/q_tree/chapter2/chapter_insert.jsp?id_q_chapter=<%=id_q_chapter%>","insert","width=400, height=250, scrollbars=no");
    }

	function cpt_view() {
		subManuClear();

		window.open("../../admin2/q_tree/chapter/chapter_view.jsp?id_q_chapter=<%=id_q_chapter%>","view","width=400, height=250, scrollbars=no");
    }

	function q_info() {
		subManuClear();

		var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("문제정보 변경할 문제를 선택해주세요.");
		 } else {
			 window.open("q_info_edit.jsp?id_qs="+selectId.substring(0,selectId.length-1),"info_q","width=550, height=500");
		 }
	}

	function q_preview() {
		subManuClear();

		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
			 }
		 }

		 if(k == 0) {
			 alert("미리보기 할 문제를 선택해주세요.");
		 } else {
			 window.open("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","width=850, height=600, scrollbars=yes");
		 }
	 }

	 function html_saves() {
		 subManuClear();

		 var frmx = document.form1;
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 if (frmx.inwon_lists[i].selected == true) {
				 selectId = selectId + frmx.inwon_lists[i].value + ",";
				 k = k + 1;
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
		 var lngLen = frmx.inwon_lists.length -1;

		 var selectId = "";
		 var k = 0;

		 for (i=0; i<=lngLen; i++) {
			 k = k + 1;
		 }

		 frmx.search_cnt.value = k;
	 }

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onLoad = "selects();" id="qman">
	<div id="main">
		<FORM NAME="form1">
		<div id="mainTop">
		<div class="title">문제관리</div>
		<div class="location">>> <%=names.getSubject()%> >><span> <%=names.getChapter1()%></span></div>
		</div>

		<!--table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt">
				<td width="13%" align="center" name='menu1' id='menu1' onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)' onClick='subManuView(1)'><img src="../../../images/bt_q_list_view(menu1)_yj1.gif"></td>
				<td width="13%" align="center" name='menu2' id='menu2' onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)' onClick='subManuView(2)'><img src="../../../images/bt_q_list_view(menu2)_yj1.gif"></td>
				<td width="13%" align="center" name='menu3' id='menu3' onMouseOver='menuColorChange(3)' onMouseOut='menuColorBack(3)' onClick='subManuView(3)'><img src="../../../images/bt_q_list_view(menu3)_yj1.gif"></td>
				<td width="13%" align="center" onClick='q_static();'><img src="../../../images/bt_q_list_view(menu4)_yj1.gif"></td>
				<td width="17%" align="center" <% if(pt_q_edit.equals("Y")) { %> onClick='q_info();' <% } %>><img src="../../../images/bt_q_list_view(menu5)_yj1.gif"></td>
				<td width="13%" align="center" onClick='q_preview();'><img src="../../../images/bt_q_list_view(menu6)_yj1.gif"></td>
				<td width="18%" align="center" onClick='html_saves();'><img src="../../../images/bt_q_list_view(menu7)_yj1.gif"></td>
			</tr>
	 	</table-->

		<table border="0" cellpadding ="0" cellspacing="0">
			<tr>
				<td name='menu1' id='menu1' onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)' onClick='subManuView(1)'><img src="../../../images/bt6_qman_1.gif" style="cursor: hand;"></td>
				<td name='menu2' id='menu2' onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)' onClick='subManuView(2)'><img src="../../../images/bt6_qman_2.gif" style="cursor: hand;"></td>
				<td name='menu3' id='menu3' onMouseOver='menuColorChange(3)' onMouseOut='menuColorBack(3)' onClick='subManuView(3)'><img src="../../../images/bt6_qman_3.gif" style="cursor: hand;"></td>
				<td onClick='q_static();'><img src="../../../images/bt6_qman_4.gif" style="cursor: hand;"></td>
				<td <% if(pt_q_edit.equals("Y")) { %> onClick='q_info();' <% } %>><img src="../../../images/bt6_qman_5.gif" style="cursor: hand;"></td>
				<td onClick='q_preview();'><img src="../../../images/bt6_qman_6.gif" style="cursor: hand;"></td>
				<td onClick='html_saves();'><img src="../../../images/bt6_qman_7.gif" style="cursor: hand;"></td>
			</tr>
	 	</table>

		<!--div><img src="../../../images/bt6_qman_1.gif" name='menu1' id='menu1' onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)' onClick='subManuView(1)'><img src="../../../images/bt6_qman_2.gif" name='menu2' id='menu2' onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)' onClick='subManuView(2)'><img src="../../../images/bt6_qman_3.gif" name='menu3' id='menu3' onMouseOver='menuColorChange(3)' onMouseOut='menuColorBack(3)' onClick='subManuView(3)'><img src="../../../images/bt6_qman_4.gif" onClick='q_static();'><img src="../../../images/bt6_qman_5.gif" <% if(pt_q_edit.equals("Y")) { %> onClick='q_info();' <% } %>><img src="../../../images/bt6_qman_6.gif" onClick='q_preview();'><img src="../../../images/bt6_qman_7.gif" onClick='html_saves();'></div-->


		<div id='subMenu1' style="position:absolute; width: 13%; z-index:1; display: none; margin-top: 27px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#FFFFFF" height="20" id="m1_1" style="display: none;">
					<td align="center" ><img src="../../../images/bt_q_list_subview(menu1)_yj1.gif"></td>
				</tr>
				<tr bgcolor="#FFFFFF" height="20">
					<td id="m1_2"><a href="javascript:m1_2_pop();"><img src="../../../images/bt7_q_sub1.gif"></a></td>
					<td id="m1_4"><a href="javascript:m1_4_pop();"><img src="../../../images/bt7_q_sub2.gif"></a></td>
				</tr>
				<tr bgcolor="#FFFFFF" height="20" id="m1_3" style="display: none;">
					<td align="center"><img src="../../../images/bt_q_list_subview(menu1)_yj2.gif"></td>
				</tr>
			</table>
		</div>

		<div id='subMenu2' style="position:absolute; width: 13%; z-index:1; background-color: #FFFFFF; display: none; margin-top: 27px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
			<tr bgcolor="#FFFFFF" height="20" id="m2_1" style="display: none;">
				<td align="center"><img src="../../../images/bt_q_list_subview(menu2)_yj1.gif"></td>
			</tr>
			<tr bgcolor="#FFFFFF" height="20">
				<td id="m2_2"><a href="javascript:q_move();;"><img src="../../../images/bt7_q_sub3.gif"></a></td>
				<td id="m2_4"><a href="javascript:q_copy();;"><img src="../../../images/bt7_q_sub4.gif"></a></td>
				<td id="m2_6"><a href="javascript:q_delete();"><img src="../../../images/bt7_q_sub5.gif"></a></td>
			</tr>
			<tr bgcolor="#FFFFFF" height="20" id="m2_3" style="display: none;">
				<td align="center"><img src="../../../images/bt_q_list_subview(menu2)_yj2.gif"></td>
			</tr>
			<tr bgcolor="#FFFFFF" height="21" id="m2_5" style="display: none;">
				<td align="center"><img src="../../../images/bt_q_list_subview(menu2)_yj3.gif"></td>
			</tr>
		</table>
		</div>

		<div id='subMenu3' style="position:absolute; width: 13%; z-index:1; background-color: #FFFFFF; display: none; margin-top: 27px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
			<tr bgcolor="#FFFFFF" height="20" id="m3_1" style="display: none;">
				<td align="center"><img src="../../../images/bt_q_list_subview(menu3)_yj1.gif"></td>
			</tr>
			<tr bgcolor="#FFFFFF" height="20">
				<td id="m3_2"><a href="javascript:cpt_insert();;"><img src="../../../images/bt7_q_sub6.gif"></a></td>
				<td id="m3_4"><a href="javascript:cpt_view();;"><img src="../../../images/bt7_q_sub7.gif"></a></td>
			</tr>
			<tr bgcolor="#FFFFFF" height="20" id="m3_3" style="display: none;">
				<td align="center"><img src="../../../images/bt_q_list_subview(menu3)_yj2.gif"></td>
			</tr>
		</table>
		</div>
		
		<br>
		<table border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC" width="100%" onClick="subManuClear();">
			<tr bgcolor="#FFFFFF" height="27" style="height: 27px; text-align: center; background-image: url(../../../images/tablea_top.gif); background-repeat: repeat-x;">
				<td width="100" align="center" bgcolor="#DDDDDD">문제코드</td>
				<td width="100" align="center" bgcolor="#DDDDDD">문제유형</td>
				<td width="100" align="center" bgcolor="#DDDDDD">지문여부</td>
				<td align="center" bgcolor="#DDDDDD">문제</td>
			</tr>
		</table>

		<table border="0" width="100%" onClick="subManuClear();">
		<tr>
			<td>
			<select name="inwon_lists" multiple size="25" style="width:100%;" ondblclick = "selects(this.value);" >
			<%
				if(rst == null) {
			%>
			<%
				} else {

					String idqs = "";
					String qs = "";
					String qtypes = "";

					for(int i=0; i<rst.length; i++) {
						if(String.valueOf(rst[i].getId_q()).length() == 1) {
							idqs = String.valueOf(rst[i].getId_q()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						} else if(String.valueOf(rst[i].getId_q()).length() == 2) {
							idqs = String.valueOf(rst[i].getId_q()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						} else if(String.valueOf(rst[i].getId_q()).length() == 3) {
							idqs = String.valueOf(rst[i].getId_q()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						} else if(String.valueOf(rst[i].getId_q()).length() == 4) {
							idqs = String.valueOf(rst[i].getId_q()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						} else if(String.valueOf(rst[i].getId_q()).length() == 5) {
							idqs = String.valueOf(rst[i].getId_q()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						} else if(String.valueOf(rst[i].getId_q()).length() == 6) {
							idqs = String.valueOf(rst[i].getId_q()) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						} else {
							idqs = String.valueOf(rst[i].getId_q()) + "&nbsp;&nbsp;&nbsp;";
						}

						if(rst[i].getQ().length() > 71) {
							qs = rst[i].getQ().substring(0,70);
						} else {
							qs = rst[i].getQ();
						}

						if(rst[i].getQtype().equals("복수 답안형")) {
							qtypes = "&nbsp;&nbsp;&nbsp;"+rst[i].getQtype()+"&nbsp;&nbsp;&nbsp;";
						} else {
							qtypes = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+rst[i].getQtype()+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						}

						qs = qs.replace("<","&lt");
						qs = qs.replace(">","&gt");
			%>
				<option value="<%=rst[i].getId_q()%>" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=idqs%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=qtypes%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rst[i].getRefs()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=qs%></option>
			<%
					}
				}
			%>
			</select>
			</td>
		</tr>
		<tr height="30">
			<td align="right">검색된 문항 수 : <input type="text" class="input" name="search_cnt" size="6">&nbsp;문항&nbsp;&nbsp;</td>
		</tr>
		</table>
		</form>
	</div>
	<jsp:include page="../../copyright.jsp"/>
 </BODY>
</HTML>
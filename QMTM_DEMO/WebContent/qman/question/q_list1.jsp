<%
//******************************************************************************
//   프로그램 : q_list1.jsp
//   모 듈 명 : 문제 관리
//   설    명 : 문제 목록 및 추가,수정,삭제
//   테 이 블 : q
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameBean, qmtm.common.NameUtil, 
//             qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil
//   작 성 일 : 2010-06-22
//   작 성 자 : 이테스트 석준호
//   수 정 일 :
//   수 정 자 :
//	 수정사항 :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.NameBean, qmtm.common.NameUtil, qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil" %>
     
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = (String)session.getAttribute("userid");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
    NameBean names = null;

	try {
		names = NameUtil.getChapter1(id_q_chapter);
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
	
%>

<HTML>
 <HEAD>
  <TITLE> QMAN 과목 문제 관리 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT type="text/JavaScript" src="../../js/Script.js"></Script>

  <link rel="STYLESHEET" type="text/css" href="../../codebase/dhtmlxgrid.css">
  <link rel="stylesheet" type="text/css" href="../../dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_web.css">
  <script src="../../dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
  <script src="../../dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
  <script src="../../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
  <script src="../../dhtmlxGrid/codebase/ext/dhtmlxgrid_srnd.js"></script>

  <SCRIPT type="text/JavaScript">
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
		    //document.getElementById("m1_1").style.display = "block";
			//document.getElementById("m1_2").style.display = "block";

			document.getElementById("m2_1").style.display = "block"; 
			document.getElementById("m2_2").style.display = "block";
			document.getElementById("m2_3").style.display = "block"; 

			document.getElementById("m3_1").style.display = "block";
			document.getElementById("m3_2").style.display = "block";
			
		} else {
			//document.getElementById("m1_1").style.display = "none";
			//document.getElementById("m1_2").style.display = "none";

			document.getElementById("m2_1").style.display = "none"; 
			document.getElementById("m2_2").style.display = "none";
			document.getElementById("m2_3").style.display = "none"; 

			document.getElementById("m3_1").style.display = "none";
			document.getElementById("m3_2").style.display = "none";
		}

		if(pt_q_delete == "Y") {
			document.getElementById("m2_3").style.display = "block";
		} else {
			document.getElementById("m2_3").style.display = "none";
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

	function m1_1_pop() {
		window.open("q_qtype.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","QInsert","width=500,height=500,scrollbars=yes");
	}

	function m1_2_pop() {
		window.open("../editor/batchFile.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","BatchInsert","width=700,height=730,scrollbars=yes");
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
		   alert("이동할 문제를 선택해주세요.");
		} else {
		   window.open("q_move.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=540, height=350");
		}
	}

	function q_copy() {
		subManuClear();

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
			 alert("복사할 문제를 선택해주세요.");
		 } else {
			 window.open("q_copy.jsp?id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=540, height=350");
		 }
	}

	function q_static() {
		subManuClear();

		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";
		var input_text = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			if(ArrIds.length > 1) {
				alert("문제분석은 여러개의 문제를 확인할 수 없습니다.\n\n문제분석 확인할 문제만 선택해주세요.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();					
				}
			}
			
		}		 		
		
		if(strs == "" || strs == null) {
			 alert("문제분석 확인할 문제를 선택해주세요.");
			 return;		 
		 } else { 	
			 window.open("q_static_view.jsp?id_q="+selectId,"q_static","width=850, height=600 scrollbars=yes");
		 }
	}
	
	function cpt_insert() {
		subManuClear();

		window.open("../../admin/q_tree/chapter2/chapter_insert.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","insert","width=400, height=250, scrollbars=no");
    }

	function cpt_view() {
		subManuClear();

		window.open("../../admin/q_tree/chapter/chapter_view.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","view","width=400, height=250, scrollbars=no");
    }

	function q_info() {
		subManuClear();		
		 
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
			alert("정보를 변경할 문제를 선택해주세요.");
		} else {
			 window.open("q_info_edit.jsp?id_qs="+selectId.substring(0,selectId.length-1),"info_q","top=0, left=0, width=520, height=560");
		 }
	}

	function q_preview() {
		subManuClear();

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
			 alert("미리보기 할 문제를 선택해주세요.");
		 } else {
			 window.open("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","top=0, left=0, width=800, height=640, scrollbars=yes");
		 }
	 }

	 function html_saves() {
		subManuClear();

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
			 alert("HTML 저장 할 문제를 선택해주세요.");
		 } else {
			 location.href = "q_html_save.jsp?id_qs="+selectId.substring(0,selectId.length-1);
		 }
	 }
	 
	 function dbl_selects() {
		subManuClear();
		
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";
		var input_text = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			if(ArrIds.length > 1) {
				alert("문제편집은 여러개의 문제를 진행할 수 없습니다.\n\n편집 할 문제만 선택해주세요.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();
				}
			}
			
		}		 		
		
		if(strs == "" || strs == null) {
			alert("편집 할 문제를 선택해주세요.");
		} else {	
			window.open("../editor/edit_form.jsp?id_q="+selectId+"&id_subject=<%=id_q_subject%>","q_edit","1020", "700", "no");
		
		}
	 }	 
	 
	 function q_search() {
		window.open("q_search1.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>","q_search","width=1000, height=600, scrollbars=yes");
	 }

	 var gridQString = "";//we'll save here the last url with query string we used for loading grid (see step 5 for details)
      //we'll use this script block for functions
	  var mygrid = "";
	  function init(){
		
		mygrid = new dhtmlXGridObject('products_grid');
        mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");        
		mygrid.setHeader("문제코드,문제유형,문제,정답,등록일자");
        mygrid.setInitWidths("80,80,*,100,80");
        mygrid.setColAlign("center,center,left,center,center");
		mygrid.setColTypes("ro,ro,ro,ro,ro");
		mygrid.setColSorting("int,int,str,str,str")
		mygrid.attachEvent("onRowDblClicked", doOnRowDblClicked);
		mygrid.setStyle("text-align:center;", "","", "");
        mygrid.setSkin("dhx_web");
		mygrid.setMultiselect(!mygrid.selMultiRows);
		mygrid.init();
        mygrid.enableSmartRendering(true);
		if (mygrid.setColspan);
	    mygrid.attachEvent("onXLE", setCounter);
		gridQString = "dyngrid_getXML.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>";
		mygrid.loadXML(gridQString);	
		
	  }

	  function doOnRowDblClicked(rowId) {
		subManuClear();
		
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";
		var input_text = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			if(ArrIds.length > 1) {
				alert("문제편집은 여러개의 문제를 진행할 수 없습니다.\n\n편집 할 문제만 선택해주세요.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();
				}
			}
			
		}		 		

		if(strs == "" || strs == null) {
			alert("편집 할 문제를 선택해주세요.");
		} else {	
			window.open("../editor/edit_form.jsp?id_q="+selectId+"&id_subject=<%=names.getId_subject()%>","q_edit","width=1020, height=740, scrollbars=yes");
		
		}
	  }

	  function setCounter() {
	    document.form1.search_cnt.value = mygrid.getRowsNum();
	  }

	  function excel_save() {
		
		subManuClear();

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
		    alert("엑셀로 저장할 문제를 선택해주세요.");			
		 } else {
			document.form1.q_excels.value = selectId.substring(0,selectId.length-1);
			document.form1.action = 'q_excel_save.jsp';
			document.form1.method = 'post';
			document.form1.submit();
	     }
	}

	function check_enable() {
		if(mygrid) {
			mygrid.selectAll();
		}
	}

	function check_disable() {
		if(mygrid) {
			mygrid.clearSelection();
		}
	}

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onload="init()" id="qman">
	<div id="main">
		<form name = "form1">
			<input type="hidden" name="q_excels">
		<div id="mainTop">
		<div class="title">문제관리 <span>선택 카테고리의 단원 수정 및 신규문제 등록,수정,삭제,분석등의 작업을 진행합니다. </span></div>
		</div>

		<!--table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt">
				<td width="13%" align="center" name='menu1' id='menu1' onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)' onClick='subManuView(1)'><img src="../../images/bt_q_list_view(menu1)_yj1.gif"></td>
				<td width="13%" align="center" name='menu2' id='menu2' onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)' onClick='subManuView(2)'><img src="../../images/bt_q_list_view(menu2)_yj1.gif"></td>
				<td width="13%" align="center" name='menu3' id='menu3' onMouseOver='menuColorChange(3)' onMouseOut='menuColorBack(3)' onClick='subManuView(3)'><img src="../../images/bt_q_list_view(menu3)_yj1.gif"></td>
				<td width="13%" align="center" onClick='q_static();'><img src="../../images/bt_q_list_view(menu4)_yj1.gif"></td>
				<td width="17%" align="center" <% if(pt_q_edit.equals("Y")) { %> onClick='q_info();' <% } %>><img src="../../images/bt_q_list_view(menu5)_yj1.gif"></td>
				<td width="13%" align="center" onClick='q_preview();'><img src="../../images/bt_q_list_view(menu6)_yj1.gif"></td>
				<td width="18%" align="center" onClick='html_saves();'><img src="../../images/bt_q_list_view(menu7)_yj1.gif"></td>
			</tr>
	 	</table-->
		
		<table border="0" cellpadding ="0" cellspacing="0">
			<tr>
				<td name='menu1' id='menu1' onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)' onClick='subManuView(1)'><img src="../../images/bt6_qman_1.gif" style="cursor: hand;"></td>
				<td name='menu2' id='menu2' onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)' onClick='subManuView(2)'><img src="../../images/bt6_qman_2.gif" style="cursor: hand;"></td>
				<td name='menu3' id='menu3' onMouseOver='menuColorChange(3)' onMouseOut='menuColorBack(3)' onclick="subManuView(3);"><img src="../../images/bt6_qman_3.gif" style="cursor: hand;"></td>
				<td onClick='q_static();'><img src="../../images/bt6_qman_4.gif" style="cursor: hand;"></td>
				<td <% if(pt_q_edit.equals("Y")) { %> onClick='q_info();' <% } %>><img src="../../images/bt6_qman_5.gif" style="cursor: hand;"></td>
				<td onClick='q_preview();'><img src="../../images/bt6_qman_6.gif" style="cursor: hand;"></td>
				<td onClick='html_saves();'><img src="../../images/bt6_qman_7.gif" style="cursor: hand;"></td>
				<td onClick='q_search();'><img src="../../images/bt6_qman_8.gif" style="cursor: hand;"></td>
			</tr>
	 	</table>

		<div id='subMenu1' style="position:absolute; z-index:1; display: none; margin-top: 27px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<img src="../../images/bt7_q_sub1.gif" id="m1_1" onclick="javascript:m1_1_pop();" style="cursor: hand;">
					</td>
					<td>
						<img src="../../images/bt7_q_sub2.gif" id="m1_2" onclick="javascript:m1_2_pop();" style="cursor: hand;">
					</td>
				</tr>
			</table>
		</div>

		<div id='subMenu2' style="position:absolute; z-index:1; background-color: #FFFFFF; display: none; margin-top: 27px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<img src="../../images/bt7_q_sub3.gif" id="m2_1" onclick="javascript:q_move();" style="cursor: hand;"></a></td>
					<td id="m2_4">
					</td>
					<td>
						<img src="../../images/bt7_q_sub4.gif" id="m2_2" onclick="javascript:q_copy();" style="cursor: hand;">
					</td>
					<td>
						<img src="../../images/bt7_q_sub5.gif" id="m2_3" onclick="javascript:q_delete();" style="cursor: hand;">
					</td>
				</tr>
			</table>
		</div>

		<div id='subMenu3' style="position:absolute; z-index:1; display: none; margin-top: 27px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<img src="../../images/bt7_q_sub6.gif" onclick="javascript:cpt_insert();" id="m3_1" style="cursor: hand;">
					</td>
					<td>
						<img src="../../images/bt7_q_sub7.gif" onclick="javascript:cpt_view();" id="m3_2" style="cursor: hand;">
					</td>
				</tr>
			</table>
		</div>
		
		<br>	
		<table border="0" width="100%">
			<tr>
				<td align="left"><img src="../../images/bt_q_list_yj1.gif" onClick="check_enable();">&nbsp;&nbsp;<img src="../../images/bt_q_list2_yj1.gif"  onClick="check_disable();">&nbsp;&nbsp;검색된 문제 수 : <input type="text" readonly class="input" name="search_cnt" size="3">&nbsp;문제&nbsp;&nbsp;<input type="button" value="문제편집" class="form" onClick="dbl_selects();">&nbsp;<input type="button" value="문제삭제" class="form" onClick="q_delete();">&nbsp;<input type="button" value="엑셀파일저장" class="form" onClick="excel_save();"></td>
				<td align="right"><span> </td>
			</tr>
		</table>
			
		<div id="contents">
			<div id="products_grid" style="width:100%;height:550px;"></div>
		</div>
		
		</form>
	</div>
	<jsp:include page="../../copyright.jsp"/>
 </BODY>
</HTML>

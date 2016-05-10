<%
//******************************************************************************
//   ���α׷� : q_list1.jsp
//   �� �� �� : ��� ����
//   ��    �� : ��� ��� �� �߰�,����,����
//   �� �� �� : q, q_subject, q_chapter, t_worker_subj
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameBean, qmtm.common.NameUtil, 
//              qmtm.LoginProcBean, qmtm.LoginProc, qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil
//   �� �� �� : 2010-06-22
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� :
//   �� �� �� :
//	 �������� :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, qmtm.common.NameBean, qmtm.common.NameUtil, qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	String usergrade = (String)session.getAttribute("usergrade"); // ����

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
    NameBean names = null;

	try {
		names = NameUtil.getChapter1(id_q_chapter);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	// ����� ���� üũ	
	String pt_q_edit = "";
	String pt_q_delete = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getExam_work(names.getId_course(), userid, usergrade);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	pt_q_edit = bean.getPt_q_edit();
	pt_q_delete = bean.getPt_q_delete();
	
	// ��⿡ �ش��ϴ� ���� ��������

	QListBean[] rst = null;

    try {
	    rst = QListUtil.getUBeans(userid, id_q_subject, id_q_chapter);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<HTML>
 <HEAD>
  <TITLE> QMAN ���� ���� ���� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>

  <link rel="STYLESHEET" type="text/css" href="../../codebase/dhtmlxgrid.css">
  <link rel="stylesheet" type="text/css" href="../../dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_web.css">
  <script src="../../dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
  <script src="../../dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
  <script src="../../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
  <script src="../../dhtmlxGrid/codebase/ext/dhtmlxgrid_srnd.js"></script>

  <script type="text/javascript">
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
	  
	    for (i=1; i<=3;i++)  // 2�� ����޴� ������ŭ �־����
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
		$.posterPopup("q_qtype.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","QInsert","width=500,height=500,scrollbars=yes, top='+(screen.height-500)/2+', left='+(screen.width-500)/2);");
	}

	function m1_2_pop() {
		$.posterPopup("../editor/batchFile.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>","BatchInsert","width=700,height=730,scrollbars=yes, top='+(screen.height-700)/2+', left='+(screen.width-730)/2);");
	}

	function subManuClear()
	{
	  for (i=1; i<=3;i++)
	  {
		  eval("document.all.subMenu"+i).style.display = 'none';
	  }
	}
	
	function QSearch(){
		$.posterPopup("q_search.jsp?id_q_subject=<%=id_q_subject%>","QSearch","width=900,height=650, scrollbars=yes,top='+(screen.height-900)/2+', left='+(screen.width-650)/2);");
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
		    alert("������ ������ �������ּ���.");
		 } else {
		    var st = confirm("�̹� �������� ������ ������ �������� �ʽ��ϴ�.\n\n������ ������ �����Ͻðڽ��ϱ�?" );

			if (st == true) {
				$.posterPopup("q_delete.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&qs="+selectId.substring(0,selectId.length-1),"qs_del","width=600, height=250,top='+(screen.height-600)/2+', left='+(screen.width-250)/2);");
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
		   alert("�̵��� ������ �������ּ���.");
		} else {
		   $.posterPopup("q_move.jsp?id_category=<%=names.getId_category()%>&id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=540, height=250,top='+(screen.height-540)/2+', left='+(screen.width-250)/2);");
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
			 alert("������ ������ �������ּ���.");
		 } else {
			 $.posterPopup("q_copy.jsp?id_category=<%=names.getId_category()%>&id_qs="+selectId.substring(0,selectId.length-1),"move_q","width=540, height=250,top='+(screen.height-540)/2+', left='+(screen.width-250)/2);");
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
				alert("�����м��� �������� ������ Ȯ���� �� �����ϴ�.\n\n�����м� Ȯ���� ������ �������ּ���.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();					
				}
			}
			
		}		 		
		
		if(strs == "" || strs == null) {
			 alert("�����м� Ȯ���� ������ �������ּ���.");
			 return;		 
		 } else { 	
			 $.posterPopup("q_static_view.jsp?id_q="+selectId,"q_static","width=850, height=600 scrollbars=yes,top='+(screen.height-850)/2+', left='+(screen.width-600)/2);");
		 }
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
			alert("������ ������ ������ �������ּ���.");
		} else {
		    $.posterPopup("q_info_edit.jsp?id_q_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_qs="+selectId.substring(0,selectId.length-1),"info_q","width=520, height=450,top='+(screen.height-520)/2+', left='+(screen.width-450)/2);");
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
			 alert("�̸����� �� ������ �������ּ���.");
		 } else {
			 $.posterPopup("q_preview.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_qs="+selectId.substring(0,selectId.length-1),"preview_q","width=800, height=640, scrollbars=yes,top='+(screen.height-800)/2+', left='+(screen.width-640)/2);");
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
			 alert("HTML ���� �� ������ �������ּ���.");
		 } else {
			 location.href = "q_html_save.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_qs="+selectId.substring(0,selectId.length-1);
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
				alert("���������� �������� ������ ������ �� �����ϴ�.\n\n���� �� ������ �������ּ���.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();
				}
			}
			
		}		 		
		
		if(strs == "" || strs == null) {
			alert("���� �� ������ �������ּ���.");
		} else {	
				$.posterPopup("../editor/edit_form.jsp?move_id_q="+selectId+"&id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>","q_edit_txt","width=1220, height=720, scrollbars=yes,top='+(screen.height-1220)/2+', left='+(screen.width-760)/2);");
		
		}
	 }

	 function q_search() {
		$.posterPopup("q_search1.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>","q_search","width=1300, height=800, scrollbars=yes,top='+(screen.height-1300)/2+', left='+(screen.width-780)/2);");
	 }
	 
	 function src_info() {
		 subManuClear();
		
		strs = mygrid.getSelectedId();

		var ArrIds = new Array();

		var selectId = "";
		var input_text = "";

		if(strs != null) {
		
			ArrIds = strs.split(",");

			if(ArrIds.length > 1) {
				alert("���������� �������� ������ Ȯ���� �� �����ϴ�.\n\n��������Ȯ�� �� ������ �������ּ���.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();
				}
			}
			
		}		 		
		
		if(strs == "" || strs == null) {
			alert("�������� Ȯ�� �� ������ �����ϼ���.");
		} else {
			$.posterPopup("q_src_info.jsp?id_q="+selectId,"q_src_info","width=1000, height=650, scrollbars=yes,top='+(screen.height-1000)/2+', left='+(screen.width-650)/2);");
		}
	 }

	  var gridQString = "";//we'll save here the last url with query string we used for loading grid (see step 5 for details)
      //we'll use this script block for functions
	  var mygrid = "";
	  function init(){
		
		mygrid = new dhtmlXGridObject('products_grid');
        mygrid.setImagePath("../../dhtmlxGrid/codebase/imgs/");        
		mygrid.setHeader("�����ڵ�,����Ƚ��,����,��������,���̵�,����,�����,�������");
        mygrid.setInitWidths("5%,5%,46%,10%,7%,10%,7%,10%");
        mygrid.setColAlign("center,center,left,center,center,left,center,center");
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("int,int,str,str,str,str,int,str")
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
				alert("���������� �������� ������ ������ �� �����ϴ�.\n\n���� �� ������ �������ּ���.");

				return;
			} else {
				for(var i=0; i<ArrIds.length; i++) {
					selectId = mygrid.cells(ArrIds[i],0).getValue();
				}
			}
			
		}		 		

		if(strs == "" || strs == null) {
			alert("���� �� ������ �������ּ���.");
		} else {	
			$.posterPopup("../editor/edit_form.jsp?move_id_q="+selectId+"&id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>","q_edit_txt","width=1220, height=720, scrollbars=yes,top='+(screen.height-1220)/2+', left='+(screen.width-720)/2);");
		
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
		    alert("������ ������ ������ �������ּ���.");			
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
		<div class="title">�������� <span>���� ī�װ��� ���� �ܿ� ���� �� �űԹ��� ���,����,����,�м����� �۾��� �����մϴ�. </span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../../images/icon_location.gif"> <%=names.getSubject()%> > <%=names.getChapter1()%></div> 
		</div>
		
		<table border="0" cellpadding ="0" cellspacing="0">
			<tr>
				<td name='menu1' id='menu1' onMouseOver='menuColorChange(1)' onMouseOut='menuColorBack(1)' onClick='subManuView(1)' ><img src="../../images/bt6_qman_1.gif" style="cursor: pointer;"></td>
				<td name='menu2' id='menu2' onMouseOver='menuColorChange(2)' onMouseOut='menuColorBack(2)' onClick='subManuView(2)'><img src="../../images/bt6_qman_2.gif" style="cursor: pointer;"></td>
				<!--<td onClick='cpt_view();'><img src="../../images/bt6_qman_3.gif" style="cursor: pointer;"></td>-->
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
				<td align="left"><img src="../../images/bt_q_list_yj1.gif" onClick="check_enable();">&nbsp;&nbsp;<img src="../../images/bt_q_list2_yj1.gif"  onClick="check_disable();">&nbsp;&nbsp;�˻��� ���� �� : <input type="text" readonly class="input" name="search_cnt" size="3">&nbsp;����&nbsp;&nbsp;<input type="button" value="��������" class="form" onClick="dbl_selects();">&nbsp;<input type="button" value="��������" class="form" onClick="q_delete();">&nbsp;<input type="button" value="������������" class="form" onClick="excel_save();"></td>
				<td align="right"><li><strong>�˼����� : �̰˼�</strong>&nbsp;&nbsp;&nbsp;<input type="button" class="form6" value="�˼��Ϸ�ó��"></td>
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

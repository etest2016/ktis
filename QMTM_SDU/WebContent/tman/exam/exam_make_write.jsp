<%
//******************************************************************************
//   ���α׷� : exam_make_write.jsp
//   �� �� �� : ������ ���� ������
//   ��    �� : ������ ���� ������
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2013-02-17
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.paper.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// ������, ����, ���������� ������´�.
	ExamCreateBean rst = null;

    try {
	    rst = ExamUtil.getAllotBean(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	int q_counts = rst.getQcount();
	double allots = rst.getAllotting();
	String randomtypes = rst.getId_randomtype();
	int qcntperpage = rst.getQcntperpage();

	// ������ ����� �۾��� �ִ��� Ȯ���մϴ�.

	boolean paperPre = false;

	try {
		paperPre = ExamPaperQ.getPapers(id_exam);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    } 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<TITLE> :: ���� ���� ���� ���� :: </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<style type="text/css">
	#wrapper {width:950px;}
	#popup2 #wrapper #contents {width:920px;}
	#id_qs { width: 900px;}
</style>
<link rel="STYLESHEET" type="text/css" href="../../dhtmlxGrid/codebase/dhtmlxgrid.css">
<link rel="stylesheet" type="text/css" href="../../dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_web.css">
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<script type="text/javascript" src="../../dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
<script type="text/javascript" src="../../dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
<script type="text/javascript" src="../../dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
<!--
<script type="text/javascript" src="../../dhtmlxGrid/codebase/ext/dhtmlxgrid_srnd.js"></script>
-->
 
  <script type="text/javascript">
	var qlist1_grid;
	var qlist2_grid;
	var qlist1_json = {};
	qlist1_json.rows = [];
	var qlist2_json = {};
	qlist2_json.rows = [];

	var temp_qlist_js_array = [];
	var temp_qlist_js_array2 = [];

	var qlist = {};

	function qlist1_data_save() {
		qlist1_json = {};
		qlist1_json.rows = [];

		for(i = 0; i < temp_qlist_js_array[0].length; i++){
			temp_obj = {};
			temp_obj.id = temp_qlist_js_array[0][i];
			temp_obj.data = temp_qlist_js_array[1][i];
			qlist1_json.rows.push(temp_obj);
		}
	}

	function qlist1_init_qlist_grid() {
		qlist1_grid = new dhtmlXGridObject('qlist1_grid');
        qlist1_grid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
        qlist1_grid.setHeader("�����ڵ�,��������,���̵�,����,����Ƚ��,����");
        qlist1_grid.setInitWidths("80,80,80,80,80,480");
        qlist1_grid.setColAlign("center,center,center,center,center,left");
		qlist1_grid.setColTypes("ro,ro,ro,ro,ro,ro");
		qlist1_grid.setColSorting("int,str,str,str,str,str");
		qlist1_grid.enableMultiselect(true);
		qlist1_grid.attachEvent("onRowSelect", function(){
			
		});
		qlist1_grid.setStyle("text-align:center;", "","", "");
        qlist1_grid.setSkin("dhx_web");		
		qlist1_grid.init();	
	}
	
	function qlist1_reload() {
		qlist1_grid.clearAll();
		qlist1_grid.parse(qlist1_json,"json");
	}

	function qlist2_init_qlist_grid() {
		qlist2_grid = new dhtmlXGridObject('qlist2_grid');
        qlist2_grid.setImagePath("../../dhtmlxGrid/codebase/imgs/");
        qlist2_grid.setHeader("�����ڵ�,��������,���̵�,����,����Ƚ��,����");
        qlist2_grid.setInitWidths("80,80,80,80,80,480");
        qlist2_grid.setColAlign("center,center,center,center,center,left");
		qlist2_grid.setColTypes("ro,ro,ro,ro,ro,ro");
		qlist2_grid.setColSorting("int,str,str,str,str,str");
		qlist2_grid.enableMultiselect(true);
		qlist2_grid.attachEvent("onRowSelect", function(){
			//alert("Selected row ID is "+rowID+"\nUser clicked cell with index "+celInd);
		});
		qlist2_grid.setStyle("text-align:center;", "","", "");
        qlist2_grid.setSkin("dhx_web");		
		qlist2_grid.init();	
	}
	
	function qlist2_reload() {
		qlist2_grid.clearAll();
		qlist2_grid.parse(qlist2_json,"json");

		//2. ������ �������� ���� �հ踦 ����.
		var total = 0.0;

		qlist2_grid.forEachRow(function(row_id){
			total = total + parseFloat(qlist2_grid.cells(row_id,3).getValue());
		});
				
		document.form1.qcnts2.value = qlist2_grid.getRowsNum();
		document.form1.qcnts3.value = Math.round(total);
	}
 
	function qlist2_data_save() {
		qlist2_json = {};
		qlist2_json.rows = [];
	
		for(i = 0; i < temp_qlist_js_array2[0].length; i++){
			temp_obj = {};
			temp_obj.id = temp_qlist_js_array2[0][i];
			temp_obj.data = temp_qlist_js_array2[1][i];
			qlist2_json.rows.push(temp_obj);
		}
	}
	function ref_extract(orders, refCnt, refGroupCnt, orderCnt, orderCnt2) {

		var frm = document.form1;		
		var all_qcnt = 0;
		var all_score = 0;
		window.open("ref_extract.jsp?orders="+orders+"&refCnt="+refCnt+"&refGroupCnt="+refGroupCnt+"&orderCnt="+orderCnt+"&orderCnt2="+orderCnt2+"&q_counts=<%=q_counts%>&allots=<%=allots%>","q_extract","width=350, height=200, scrollbars=no, top="+(screen.height-200)/2+", left="+(screen.width-350)/2);
	}

	function q_extract(orders, qCnt, orderCnt, orderCnt2) {

		var frm = document.form1;		
		var all_qcnt = 0;
		var all_score = 0;

		window.open("q_extract.jsp?orders="+orders+"&qCnt="+qCnt+"&orderCnt="+orderCnt+"&orderCnt2="+orderCnt2+"&q_counts=<%=q_counts%>&allots=<%=allots%>","q_extract","width=400, height=220, scrollbars=no, top="+(screen.height-220)/2+", left="+(screen.width-400)/2);
	}
	
	function q_search() {
		$.posterPopup("q_search.jsp?id_exam=<%=id_exam%>","q_search","width=600, height=570, scrollbars=no, top="+(screen.height-570)/2+", left="+(screen.width-600)/2);
    }

	function get_result(argSel)
	{
		formSel=eval("document.form1."+argSel);

		res=new Array();

		for(var i=0;i<formSel.length;i++)
		{
			res[i]=formSel.options[i].value;
		}
	}

	function gou(argSel)
	{
		formSel = eval("document.form1."+argSel);

        if(!formSel.value)
        {
	        return;
        }

		thisIndex = formSel.selectedIndex;

        if(!thisIndex)
        {
	        return;
        }

		formSel.value=null;

		prevIndex=thisIndex-1;

		tempText=formSel.options[prevIndex].text;
		tempValue=formSel.options[prevIndex].value;

		formSel.options[prevIndex] = new Option(formSel.options[thisIndex].text,formSel.options[thisIndex].value);
		
		formSel.options[thisIndex] = new Option(tempText,tempValue);

		formSel.value=formSel.options[prevIndex].value;

		get_result(argSel);
	}

	function god(argSel)
	{
		formSel = eval("document.form1."+argSel);

        if(!formSel.value)
        {
	        return;
        }

		thisIndex = formSel.selectedIndex;

        if(thisIndex+1>=formSel.length)
        {
	        return;
        }

		formSel.value=null;

		prevIndex=thisIndex+1;

		tempText=formSel.options[prevIndex].text;
		tempValue=formSel.options[prevIndex].value;

		formSel.options[prevIndex]        = new Option(formSel.options[thisIndex].text,formSel.options[thisIndex].value);

		formSel.options[thisIndex]        = new Option(tempText,tempValue);

		formSel.value=formSel.options[prevIndex].value;

		get_result(argSel);
	}


	function selectAll(argSel)
	{
		if(argSel == 'q_list1') {
			qlist1_grid.selectAll();
		} else if (argSel == 'q_list2') {
			qlist2_grid.selectAll();
		}
	}

	function q_preview() {
		var selected_id_for_preview = qlist1_grid.getSelectedRowId();
	
		 if(selected_id_for_preview) {
			 $.posterPopup("q_preview.jsp?id_qs=" + selected_id_for_preview, "preview_q", "width=800, height=640, scrollbars=yes, top="+(screen.height-640)/2+", left="+(screen.width-800)/2);
		 } else {
			 alert("�̸����� �� ������ �������ּ���.");
		 }
		 		 
	 }

	 function allott_ins() {

		var selected_id_for_allott = qlist2_grid.getSelectedRowId();
		
		if(selected_id_for_allott) {
			$.posterPopup("q_allotting.jsp","allot","width=330, height=180, top="+(screen.height-180)/2+", left="+(screen.width-330)/2);
		} else {
			 alert("�������� �� ������ �������ּ���.");
		}		 
		 
	 }
	 
	 function q_preview2() {
	
		var selected_id_for_preview = qlist2_grid.getSelectedRowId();

		 if(selected_id_for_preview) {
			 $.posterPopup("q_preview.jsp?id_qs=" + selected_id_for_preview, "preview_q", "width=800, height=640, scrollbars=yes, top="+(screen.height-640)/2+", left="+(screen.width-800)/2);
		 } else {
			 alert("�̸����� �� ������ �������ּ���.");
		}
	 }

	function selectRemove(argSel)
	{
		qlist2_grid.clearAll();

		document.form1.qcnts2.value = 0;
		document.form1.qcnts3.value = 0;
	}

	function ftnAdd() {
		var selectedRowIds;

		// 1. ������ �׸��� id ����� �����ͼ� qlist2_grid�� �ش�ID�� ���� ���� �����ϴ��� Ȯ�� �� �������� ������ row�� add�Ѵ�.
		if(qlist1_grid.getRowsNum() == 0) {
			alert("���� �˻� �� �߰� �Ŀ� ������ �������� �߰����ּ���.");
			return false;
		}

		if(qlist1_grid.getSelectedRowId()) {
			selectedRowIds = qlist1_grid.getSelectedRowId().split(",");
		} else {
			alert("���õ� ������ �����ϴ�.");
		}

		for(var i in selectedRowIds) {
			if (qlist2_grid.doesRowExist(selectedRowIds[i])) {
				continue;
			} else {

				var colNum = qlist1_grid.getColumnsNum();
				var tempDataArray = [colNum];

				for(j=0; j < colNum; j++) {
					tempDataArray[j] = qlist1_grid.cells(selectedRowIds[i],j).getValue();
				}
		
				qlist2_grid.addRow(selectedRowIds[i],tempDataArray);
				qlist1_grid.deleteRow(selectedRowIds[i]);
			}
		}

		//2. ������ �������� ���� �հ踦 ����.
		var total = 0.0;

		qlist2_grid.forEachRow(function(row_id){
			total = total + parseFloat(qlist2_grid.cells(row_id,3).getValue());
		});
				
		document.form1.qcnts.value = qlist1_grid.getRowsNum();
		document.form1.qcnts2.value = qlist2_grid.getRowsNum();
		document.form1.qcnts3.value = Math.round(total);	
	} 

	function ftnRemove() {
		var selectedRowIds;

		// 1. ������ �׸��� id ����� �����ͼ� qlist1_grid�� �ش�ID�� ���� ���� �����ϴ��� Ȯ�� �� �������� ������ row�� add�Ѵ�.
		if(qlist2_grid.getRowsNum() == 0) {
			alert("������󿡼� ������ ������ �����ϴ�..");
			return false;
		}

		if(qlist2_grid.getSelectedRowId()) {
			selectedRowIds = qlist2_grid.getSelectedRowId().split(",");
		} else {
			alert("���õ� ������ �����ϴ�.");
		}

		for(var i in selectedRowIds) {
			if (qlist1_grid.doesRowExist(selectedRowIds[i])) {
				qlist2_grid.deleteRow(selectedRowIds[i]);
				continue;
			} else {
				var colNum = qlist2_grid.getColumnsNum();
				var tempDataArray = [colNum];
				for(j=0; j<colNum; j++) {
					tempDataArray[j] = qlist2_grid.cells(selectedRowIds[i],j).getValue();
				}

				qlist1_grid.addRow(selectedRowIds[i],tempDataArray);
				qlist2_grid.deleteRow(selectedRowIds[i]);
			}
	
		}

		//2. ������ �������� ���� �հ踦 ����.
		var total = 0.0;
	
		qlist2_grid.forEachRow(function(row_id){
			total = total + parseFloat(qlist2_grid.cells(row_id,3).getValue());
		});

		document.form1.qcnts.value = qlist1_grid.getRowsNum();
		document.form1.qcnts2.value = qlist2_grid.getRowsNum();
		document.form1.qcnts3.value = Math.round(total);	
	}

	// �޴����� ������ �����ֱ�..
	function movieLayout(obj) {
		
		var corrects;

		corrects = confirm("�����ɼǼ������� �ݵ�� ���ʿ� �������� ��ư�� Ŭ���ؼ�\n\n������ �����Ͻñ� �ٶ��ϴ�.\n\n���������� �Ǿ�߸� �ش���迡 �����ɼǼ�����\n\n������ �� �ֽ��ϴ�.\n\n\n�����ɼ��� �����Ͻðڽ��ϱ�?");

		if(!corrects) {
			return false;
		}

		var frmx = document.form1;

		if(frmx.saveYN.value == "N") {
			alert("���������� �ϼž߸� �����ɼ��� ������ �� �ֽ��ϴ�.\n\n���ʿ� �������� ��ư�� Ŭ���ؼ� ������ �����Ͻñ� �ٶ��ϴ�.");
			return false;
		}

		var qs = "";
		var allots = "";

		if(obj == "qs") {
			document.all.id_qs.style.display = "block";
			document.all.id_options.style.display = "none";
			document.all.id_details.style.display = "none";
			document.all.papers.style.display = "none";
			document.all.qcnts_chk.style.display = "none";
		} else if(obj == "options") {			
			if(qlist2_grid.getRowsNum() != <%=q_counts%> && ("<%=randomtypes%>" == "NN" || "<%=randomtypes%>" == "NQ" || "<%=randomtypes%>" == "NT")) {
				alert("���� ���� ���� " + <%=q_counts%> + " �������� �մϴ�.");
				return false;
			} else if(qlist2_grid.getRowsNum() < <%=q_counts%> && ("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT")) {
				alert("���� ���� ���� " + <%=q_counts%> + " �����̻� �̾�� �մϴ�.");
				return false;
			} else if(<%=allots%> != document.form1.qcnts3.value && ("<%=randomtypes%>" == "NN" || "<%=randomtypes%>" == "NQ" || "<%=randomtypes%>" == "NT")) {
				alert("������ ������ " + <%=allots%> + " �� �̾�� �մϴ�.");
				return false;
			} else {
				document.all.id_qs.style.display = "none";
				document.all.id_options.style.display = "block";
				if("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT") {
					document.all.id_details.style.display = "block";
					document.all.papers.style.display = "block";
					document.all.qcnts_chk.style.display = "block";
				} else {
					document.all.id_details.style.display = "none";
					document.all.papers.style.display = "block";
					document.all.qcnts_chk.style.display = "none";
				}

				temp_id_array = [];
				temp_allots_array = [];


				qlist2_grid.forEachRow(function(id){
					temp_id_array.push(id);
					temp_allots_array.push(qlist2_grid.cells(id,3).getValue());
				});

				qs = temp_id_array.join();
				allots = temp_allots_array.join();

				frmx.q_allotting.value = allots;

				// �������ı��� ���� ���� ����Ʈ ���������
				get_qs_list(1);
			}
		}
	}

	function q_save() {
		
		var qs = "";		// ����ID����Ʈ
		var allots = "";	// ��������Ʈ

		if(qlist2_grid.getRowsNum() != <%=q_counts%> && ("<%=randomtypes%>" == "NN" || "<%=randomtypes%>" == "NQ" || "<%=randomtypes%>" == "NT")) {
			alert("���� ���� ���� " + <%=q_counts%> + " �������� �մϴ�.");
			return;
		} else if(qlist2_grid.getRowsNum() < <%=q_counts%> && ("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT")) {
			alert("���� ���� ���� " + <%=q_counts%> + " �����̻� �̾�� �մϴ�.");
			return;
		} else if(<%=allots%> != document.form1.qcnts3.value && ("<%=randomtypes%>" == "NN" || "<%=randomtypes%>" == "NQ" || "<%=randomtypes%>" == "NT")) {
			alert("������ ������ " + <%=allots%> + " �� �̾�� �մϴ�.");
			return;
		} else {
			temp_id_array = [];
			temp_allots_array = [];

			qlist2_grid.forEachRow(function(id){
				temp_id_array.push(id);
				temp_allots_array.push(qlist2_grid.cells(id,3).getValue());
			});

			qs = temp_id_array.join();
			allots = temp_allots_array.join();

			// ������ ��� ���� ���̺� ����ϱ�
			if("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT") { // ����ɼ��� ���..
					save_qs_list2(qs);
			} else {
					save_qs_list(qs, allots);
			}
		}
	}
	
	function q_basic_chk(q_basic) {
		var frmx = document.form1;
		var qs2 = "";
		var allots = "";

		temp_id_array = [];
		temp_allots_array = [];

		qlist2_grid.forEachRow(function(id){
			temp_id_array.push(id);
			temp_allots_array.push(qlist2_grid.cells(id,3).getValue());
		});

		qs = temp_id_array.join();
		allots = temp_allots_array.join();

		// �������ı��� ���� ���� ����Ʈ ���������
		get_qs_list(q_basic);
	}

	var qs = "";
	var qs1;

	function save_qs_list(qs, allotts) {

		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = save_qs_list_callback;
		qs2.open("POST", "save_qs_lists.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=EUC-KR");
		qs2.send("id_exam=<%=id_exam%>&qs1="+qs+"&allotts1="+allotts);
	}

	function save_qs_list_callback() {
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				if(typeof(document.all.qs_saves) == "object") {
					Show_LayerProgressBar(false);
					document.form1.saveYN.value = "Y";
					alert("�������� ����� �Ϸ�Ǿ����ϴ�.\n\n������ �����ɼǼ����� Ŭ���ϼż� �����Ͻ� ������ ������ �����ϼž� �մϴ�.");
				}
			}
	    }
	}

	// ����ɼ��� ���...
	function save_qs_list2(qs) {

		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = save_qs_list_callback2;
		qs2.open("POST", "save_qs_lists2.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=EUC-KR");
		qs2.send("id_exam=<%=id_exam%>&qs1="+qs);
	}

	function save_qs_list_callback2() {
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {			
				if(typeof(document.all.qs_saves) == "object") {
					Show_LayerProgressBar(false);
					document.form1.saveYN.value = "Y";
					alert("�������� ����� �Ϸ�Ǿ����ϴ�.\n\n������ �����ɼǼ����� Ŭ���ϼż� �����Ͻ� ������ ������ �����ϼž� �մϴ�.");
				}
			}
	    }
	}

	function get_qs_list(q_basic) {		
		
		Show_LayerProgressBar(true);

		qs1 = new ActiveXObject("Microsoft.XMLHTTP");
		qs1.onreadystatechange = get_qs_list_callback;
		if("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT") {
			document.form1.qcnts4.value = "";
			document.form1.qcnts5.value = "";

			qs1.open("GET", "qs_lists2.jsp?id_exam=<%=id_exam%>&bigos="+q_basic, true);
		} else { 
			qs1.open("GET", "qs_lists.jsp?id_exam=<%=id_exam%>&bigos="+q_basic, true);
		}
		qs1.send();
	}

	function get_qs_list_callback() {
		if(qs1.readyState == 4) {
			if(qs1.status == 200) {
				if(typeof(document.all.qs_lists) == "object") {
					Show_LayerProgressBar(false);
					document.all.qs_lists.innerHTML = qs1.responseText;
				}
			}
		}
	}

	function option_init(obj) {
		
		Show_LayerProgressBar(false);
		
		// ������ �������̾��� �۾��� �־����� Ȯ���Ѵ�.
		var paperPre = <%=paperPre%>;		
		
		if(paperPre) {
			$.posterPopup("paperPre.jsp?id_exam=<%=id_exam%>","prewin","width=350, height=250, top="+(screen.height-250)/2+", left="+(screen.width-350)/2);
		}
		
		var frm = document.form1;

		document.all.id_details.style.display = "none";

		if(obj == "NN") {
			frm.allot_basic[0].checked = true;
			frm.allot_basic[1].disabled = true;
			frm.q_basic[0].checked = true;
			frm.q_basic[1].disabled = true;
			frm.q_basic[2].disabled = true;
			frm.q_basic[3].disabled = true;
			frm.q_basic[4].disabled = true;
			frm.q_basic[5].disabled = true;
			frm.q_basic[6].disabled = true;
			//frm.q_options[0].checked = true;
			//frm.q_options[0].readOnly = true;
			//frm.q_options[1].disabled = true;
			//frm.q_options[2].disabled = true;
			//frm.q_ref_cnts.readOnly = true;
			frm.paper_cnts.value = 1;
			frm.paper_cnts.readOnly = true;
		} else if(obj == "NQ" || obj == "NT") {
			frm.allot_basic[0].checked = true;
			frm.allot_basic[1].disabled = true;
			frm.q_basic[0].disabled = true;
			frm.q_basic[1].checked = true;
			//frm.q_options[0].checked = true;
			//frm.q_options[0].disabled = true;
			//frm.q_options[1].disabled = true;
			//frm.q_options[2].disabled = true;
			//frm.q_ref_cnts.readOnly = true;
			frm.paper_cnts.value = 1;
		} else if(obj == "YQ" || obj == "YT") {
			frm.allot_basic[0].disabled = true;
			frm.allot_basic[1].checked = true;
			frm.q_basic[0].disabled = true;
			frm.q_basic[1].checked = true;
			//frm.q_options[0].checked = true;
			//frm.q_ref_cnts.readOnly = true;
		}

		qlist1_init_qlist_grid();
		qlist2_init_qlist_grid();
	}

	function creates() {
		var q_counts = <%=q_counts%>;
		var allots = <%=allots%>;

		if("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT") {
			if(Number(document.form1.qcnts4.value) != q_counts) {
				alert("������������ ���� �ʽ��ϴ�. \n\n�ش���迡 ������������ "+q_counts+"�����Դϴ�.\n\n������������ Ȯ���� �� �ٽ� �������ּ���.");
				return false;
			} 

			if(Number(document.form1.qcnts5.value) != allots) {
				alert("���������� ���� �ʽ��ϴ�. \n\n�ش���迡 ���������� "+allots+"���Դϴ�.\n\n���������� Ȯ���� �� �ٽ� �������ּ���.");
				return false;
			}
		}

		var st = confirm("������ ����� �۾��� �����Ͻðڽ��ϱ�? \n\n������ ����� �۾��� �ҿ�ð��� �����ɸ� �� �ֽ��ϴ�." );

		if (st == true) {
			var frmx = document.form1;

			frmx.qs_lists2.value = qlist2_grid.getAllRowIds();

			frmx.submit();
		}
	}

	function allott_insert(allott) {

		// qlist2_grid ���� ���õ� row�� �����´�.
		// ���õ� row�� 3�� �÷��� ���� ���� ������Ʈ �Ѵ�.	
		var selectedRowIds;

		if(qlist2_grid.getRowsNum() == 0) {
			alert("���� �˻� �� �߰� �Ŀ� ������ �������� �������� ���ּ���.");
			return false;
		}

		if(qlist2_grid.getSelectedRowId()) {
			selectedRowIds = qlist2_grid.getSelectedRowId().split(",");
		} else {
			alert("���õ� ������ �����ϴ�.");
		}

		for(var i in selectedRowIds) {
			qlist2_grid.cells(selectedRowIds[i],3).setValue(allott);
			}
			
		// ������ �������� ���� �հ踦 ����.
		var total = 0.0;

		qlist2_grid.forEachRow(function(row_id){
			total = total + parseFloat(qlist2_grid.cells(row_id,3).getValue());
		});

		document.form1.qcnts3.value = Math.round(total);	
	}

	HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
               + '<img src="../../images/loading.gif" style="position:absolute; top:35%; left:35%;"/>' 
               + '</DIV>'; 
  
	document.write(HTML_P); 
	  
	function Show_LayerProgressBar(isView) { 
			
		var obj = document.getElementById("ProgressBar"); 
		if (isView) { 
			obj.style.display = "block"; 
		}else{ 
			obj.style.display = "none"; 
		} 
	} 
</script>

</HEAD>

<BODY onLoad="option_init('<%=randomtypes%>');" id="popup2">
<div id="wrapper">
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� ���� <span>���� ���� ���� ���� �� �����ɼ� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<% if(randomtypes.equals("YQ") || randomtypes.equals("YT")) { %>
			<form name="form1" method="post" action="exam_make_insert_new.jsp">
		<% } else { %>
			<form name="form1" method="post" action="exam_make_insert.jsp">
		<% } %>

		<input type="hidden" name="qs_lists2">
		<input type="hidden" name="ref_lists2">
		<input type="hidden" name="q_allotting">
		<input type="hidden" name="id_exam" value="<%=id_exam%>">
		<input type="hidden" name="randomtypes" value="<%=randomtypes%>">
		<input type="hidden" name="qcntperpage" value="<%=qcntperpage%>">
		<input type="hidden" name="saveYN" value="N">

		<div style="display:block;" id="id_qs">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="360"><div class="F2">�������� �˻�</div></td>
					<td align="right"><a href="javascript:q_search();" onfocus="this.blur();"><img src="../../images/bt_q_search_yj1.gif"></a>&nbsp;<a href="javascript:selectAll('q_list1');" onfocus="this.blur();"><img src="../../images/bt_q_list_yj1.gif"></a>&nbsp;<a href="javascript:q_preview();" onfocus="this.blur();"><img src="../../images/bt_q_preview.gif" onfocus="this.blur();"></a></td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="qlist1_grid" style="width:900px; height:190px;"></div>
					</td>
				</tr>
				<tr height="46">
					<td valign="top" style="padding-top: 2px;" width="40%"><input type="text" class="input" name="qcnts" size="5" readonly> ���� �˻�</td>
					<td align="right" valign="middle"><img src="../../images/bt_ftnAdd_yj1.gif" onclick="ftnAdd();" style="cursor:pointer;">&nbsp;<a href="javascript:ftnRemove();"><img src="../../images/bt_ftnRemove_yj1.gif"></a></td>
				</tr>
				<tr>
					<td colspan="2"><div id="id_details"></div></td>
				</tr>
				<tr>
					<td><div class="F2">������ ����</div></td>
					<td align="right"><img src="../../images/bt_q_list_yj1.gif" onclick="selectAll('q_list2');" style="cursor:pointer;">&nbsp;<a href="javascript:selectRemove('q_list2');"><img src="../../images/bt_q_list2_yj1.gif"></a>&nbsp;<a href="javascript:q_preview2();" onfocus="this.blur();"><img src="../../images/bt_q_preview.gif" onfocus="this.blur();"></a>&nbsp;<%if(randomtypes.equals("YQ") || randomtypes.equals("YT")) { %><a href="javascript:alert('���� �ش� ���迡 ���������� �����������Դϴ�.\n\n���������� �����������ϰ�쿡��\n�ϴܿ� ���������� �����ɼǼ����� Ŭ���ϰ��� ������ �����ϼž� �մϴ�.\n\n���������� �� �� �����ϼ�����쿡�� �ش� â�� �����ð�\n���������޴����� ���������� �������ֽð� ������ �ֽñ� �ٶ��ϴ�.');"><% } else { %><a href="javascript:allott_ins();"><% } %><img src="../../images/bt_q_allotting_yj1.gif"  style="cursor: pointer;"></a></td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="qlist2_grid" style="width:900px; height:190px;"></div>
					</td>
				</tr>
				<tr>
					<td>
						������ ������ <input type="text" class="input" name="qcnts2" size="5" readonly>, 
						���� �� :&nbsp;&nbsp;<input type="text" class="input" name="qcnts3" size="5" readonly>&nbsp;��
						<hr>
						<font class="point">���� ������ : <%=q_counts%> ����&nbsp;&nbsp;&nbsp;���� : <%=allots%> ��</font>
					</td>
					<td align="right" valign="bottom">						
						<a href="javascript:q_save();"><img src="../../images/bt_q_save_yj1.gif"></a>
						<!--input type="image" value="������������" onClick="movieLayout('qs')" src="../../images/bt_layout_qs_yj1.gif">&nbsp;&nbsp;--><img src="../../images/bt_layout_options_yj1.gif" onClick="movieLayout('options')" >
					</td>
				</tr>
			
			</table>
		
		</div>

		<div style="display:none;" id="id_options">

			
			<table cellspacing="1" cellpadding="1" border="0" bgcolor="#7F9DB9" width="100%">
				<tr bgcolor="#FFFFFF" style="height: 29px; text-align: left; background-image: url(../../images/tablea_top3_exmake_yj1.gif);">
					<td height="25">&nbsp;&nbsp;&nbsp;��������</td>
				</tr>
				<tr bgcolor="#FFFFFF">
				<td height="55" bgcolor="#FFFFFF">
				<table border="0">
				<tr>				
					<td height="25">&nbsp;&nbsp;&nbsp;<input type="radio" name="allot_basic" value="1" >&nbsp;������ ����(���� ����� ���� ���)</td>
				</tr>
				<tr>
					<td height="25">&nbsp;&nbsp;&nbsp;<input type="radio" name="allot_basic" value="2" >&nbsp;�������⿡�� ���� ����</td>
				</tr>
				</table>
				</td>
				</tr>
			</table>
			<br>
			
			<table cellspacing="1" cellpadding="1" border="0" bgcolor="#7F9DB9" width="100%">
				<tr bgcolor="#FFFFFF" style="height: 29px; text-align: left; background-image: url(../../images/tablea_top3_exmake_yj1.gif);">
					<td height="25">&nbsp;&nbsp;&nbsp;���� ���ı���</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="75" bgcolor="#FFFFFF">
					<table border="0">
						<tr>
							<td colspan="3">&nbsp;&nbsp;&nbsp;<input type="radio" name="q_basic" value="1" onClick="get_qs_list(1);" checked>&nbsp;���� ��� ���� �������</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;&nbsp;<input type="radio" name="q_basic" value="2" onClick="get_qs_list(2);">&nbsp;���� ����</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="q_basic" value="3" onClick="get_qs_list(3);">&nbsp;ī�װ�</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="q_basic" value="4" onClick="get_qs_list(4);">&nbsp;ī�װ� + ��������</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;&nbsp;<input type="radio" name="q_basic" value="6" onClick="get_qs_list(6);">&nbsp;ī�װ� + ���̵�</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="q_basic" value="7" onClick="get_qs_list(7);">&nbsp;ī�װ� + �������� + ���̵�</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="q_basic" value="5" onClick="get_qs_list(5);">&nbsp;���ı��� ����</td>
						</tr>
					</table>
						
					</td>
				</tr>
			</table>			
			<br>

			<table cellspacing="1" cellpadding="1" border="0" bgcolor="#7F9DB9" width="100%">
				<tr bgcolor="#FFFFFF">
					<td bgcolor="#FFFFFF">
					<div id = "qs_saves"></div>					
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="25">&nbsp;<b>�� �������� ������ ���ļ����� �Է��Ͻ� �� �ֽ��ϴ�.</b></td>
				</tr>
				
				<tr bgcolor="#FFFFFF">
					<td bgcolor="#FFFFFF">
					<div id = "qs_lists"></div>	
					</td>
				</tr>
			</table>

			<!--
			<br>
			<table cellspacing="1" cellpadding="1" border="0" bgcolor="#CCCCCC" width="100%">
				<tr bgcolor="#FFFFFF">
					<td height="25">&nbsp;���� �� �ɼ�</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="35" bgcolor="#FFFFFF">
					<table border="0">
						<tr >
							<td>&nbsp;&nbsp;&nbsp;<input type="checkbox" name="q_options" value="1">&nbsp;��������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="q_options" value="2">&nbsp;�ܿ�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="q_options" value="3">&nbsp;���̵�</td>
						</tr>
					</table>
						
					</td>
				</tr>
			</table>
			-->

			<div style="display:none;" id="papers">

				<table cellspacing="1" cellpadding="1" border="0" bgcolor="#7F9DB9" width="100%">
					<tr bgcolor="#FFFFFF">
						<td height="35"><input type="checkbox" name="rdox" value="Y">&nbsp;<b>OX�� ���⼯��</b>&nbsp;&nbsp;&nbsp;<font color=green><b>������ ��</b></font>&nbsp;&nbsp;:&nbsp;&nbsp;<select name="paper_cnts">
						<% for(int paperCnt = 1; paperCnt <= 200; paperCnt++) { %>  
						<option value="<%=paperCnt%>">&nbsp;<%=paperCnt%>&nbsp;</option>
						<% } %>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/bt_tman_creates_yj2.gif" align="absmiddle" border="0" onClick="creates();"></td>
					</tr>
				</table>

			</div>
			<BR>
			<div style="display:none;" id="qcnts_chk">
			
				���ù����� :&nbsp;&nbsp;<input type="text" class="input" name="qcnts4" size="5" readonly>&nbsp;&nbsp;����&nbsp;&nbsp;���ù��� ���� �� :&nbsp;&nbsp;<input type="text" class="input" name="qcnts5" size="5" readonly>&nbsp;��&nbsp;&nbsp;&nbsp;<b>������ ������ : <%=q_counts%> ����&nbsp;&nbsp;&nbsp;������ ���� : <%=allots%> ��</b>

			</div>

		</div>

	</div>
	<div id="button">

	</div>
</div>
</body>
</html>
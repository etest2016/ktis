<%
//******************************************************************************
//   ���α׷� : exam_make_write.jsp
//   �� �� �� : ������ ���� ������
//   ��    �� : ������ ���� ������
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2008-04-17
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// ���׼�, ����, ���������� ������´�.
	ExamCreateBean rst = null;

    try {
	    rst = ExamUtil.getAllotBean(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

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
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    } 
%>

<HTML>
<HEAD>
<TITLE> :: ���� ���� ���� ���� :: </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function ref_extract(orders, refCnt, refGroupCnt, orderCnt, orderCnt2) {

		var frm = document.form1;		
		var all_qcnt = 0;
		var all_score = 0;
		window.open("ref_extract.jsp?orders="+orders+"&refCnt="+refCnt+"&refGroupCnt="+refGroupCnt+"&orderCnt="+orderCnt+"&orderCnt2="+orderCnt2+"&q_counts=<%=q_counts%>&allots=<%=allots%>","q_extract","width=350, height=200, scrollbars=no, top=0, left=0");
	}

	function q_extract(orders, qCnt, orderCnt, orderCnt2) {

		var frm = document.form1;		
		var all_qcnt = 0;
		var all_score = 0;
		
		window.open("q_extract.jsp?orders="+orders+"&qCnt="+qCnt+"&orderCnt="+orderCnt+"&orderCnt2="+orderCnt2+"&q_counts=<%=q_counts%>&allots=<%=allots%>","q_extract","width=350, height=200, scrollbars=no, top=0, left=0");
	}
	
	function q_search() {
		window.open("q_search.jsp?id_exam=<%=id_exam%>","q_search","width=600, height=570, scrollbars=no, top=0, left=0");
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
		var selectBox = eval("document.form1."+argSel);

		try
		{
			for (var index=0;index<selectBox.options.length ;index++)
			{
			   selectBox.options[index].selected = "selected";
			}
		} catch (e) {
			alert(e.description);
		}
	}

	function q_preview() {
	
		var frmx = document.form1;
		var lngLen = frmx.q_list.length -1;
		
		var i;
		var tmp;
		var strs;

		var selectId = "";
		var k = 0;
		
		for (i=0; i<=lngLen; i++) {
			if (frmx.q_list[i].selected == true) {				
				tmp = frmx.q_list[i].value;
				strs=tmp.split('||');
				selectId = selectId + strs[0] + ",";
				
				k = k + 1;
			}
		}
			
					
		 if(k == 0) {
			 alert("�̸����� �� ������ �������ּ���.");
		 } else {
			 window.open("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","top=0, left=0, width=800, height=640, scrollbars=yes");
		 }
		 		 
	 }

	 function allott_ins() {

		var frmx = document.form1;
		var lngLen = frmx.q_list2.length -1;
		
		var i;

		var k = 0;
		
		for (i=0; i<=lngLen; i++) {
			if (frmx.q_list2[i].selected == true) {				
				k = k + 1;
			}
		}			
					
		if(k == 0) {
			 alert("�������� �� ������ �������ּ���.");
		} else {
			 window.open('q_allotting.jsp','allot','width=330, height=180');
		}		 
		 
	 }
	 
	 function q_preview2() {
	
		var frmx = document.form1;
		var lngLen = frmx.q_list2.length -1;
		
		var i;
		var tmp;
		var strs;

		var selectId = "";
		var k = 0;
		
		for (i=0; i<=lngLen; i++) {
			if (frmx.q_list2[i].selected == true) {				
				tmp = frmx.q_list2[i].value;
				strs=tmp.split('||');
				selectId = selectId + strs[0] + ",";
				
				k = k + 1;
			}
		}			
					
		if(k == 0) {
			 alert("�̸����� �� ������ �������ּ���.");
		} else {
			 window.open("q_preview.jsp?id_qs="+selectId.substring(0,selectId.length-1),"preview_q","top=0, left=0, width=800, height=640, scrollbars=yes");
		}
		 		 
	 }

	function selectRemove(argSel)
	{
		formSel=eval("document.form1."+argSel);

		buff=new Array();
		j=0;

		for(var i=formSel.length-1;i>=0;i--)
		{
			formSel.options[i] = null;
		}

		//document.form1.qcnts2.value = "������� ���� �� : " + document.form1.q_list2.length + " ����";
		document.form1.qcnts2.value = document.form1.q_list2.length;
		get_result(argSel);
	}

	function ftnAdd() {

		var frmx = document.form1;
		var lngLen = frmx.q_list.length -1;
		var lngLen2 = frmx.q_list2.length -1;
		var i, j;
		var tmp1, tmp2, tmp3, objx;
		var flagx;
		var lngMax=0;
		var strs;
		var strs_tot = 0;
		var strs2;
		var strs_tot2 = 0;
		var strs_imsi;		

		for (i=0; i<=lngLen2; i++) {
			tmp3 = frmx.q_list2[i].value;
			strs2=tmp3.split('||');
			strs_tot2 = strs_tot2 + Number(strs2[3]);
			objx = new Option(tmp1, tmp2);
		}
		
		for (i=0; i<=lngLen; i++) {
			var eres = 0;
			if (frmx.q_list[i].selected == true) {
				tmp1 = frmx.q_list[i].text;				
				tmp2 = frmx.q_list[i].value;
				strs=tmp2.split('||');

				for (j=0; j<=lngLen2; j++) {				
					tmp3 = frmx.q_list2[j].value;
					strs_imsi = tmp3.split('||');
					if(strs_imsi[0] == strs[0]) {
						eres = eres + 1;
						break;
					}
				}

				if(eres == 0) {
					strs_tot = strs_tot + Number(strs[3]);
					objx = new Option(tmp1, tmp2);

					frmx.q_list2.add(objx);			
				} 

				frmx.q_list.remove(i);
				lngLen = lngLen -1;
				i = i -1;
			}
		}

		//document.form1.qcnts.value = "�˻��� ���� �� : " + document.form1.q_list.length + " ����";
		//document.form1.qcnts2.value = "������� ���� �� : " + document.form1.q_list2.length + " ����";
		document.form1.qcnts.value = document.form1.q_list.length;
		document.form1.qcnts2.value = document.form1.q_list2.length;
		document.form1.qcnts3.value = Math.round((strs_tot + strs_tot2));
	}

	function ftnRemove() {
		var frmx = document.form1;
		var lngLen = frmx.q_list2.length -1;
		var lngLen2 = frmx.q_list.length -1;
		var i, j;
		var tmp1, tmp2, tmp3, objx;
		var flagx;
		var strs;
		var strs_tot = 0;
		var strs2;
		var strs_tot2 = 0;
		
		for (i=0; i<=lngLen; i++) {
			tmp3 = frmx.q_list2[i].value;
			strs2=tmp3.split('||');
			strs_tot2 = strs_tot2 + Number(strs2[3]);

			if (frmx.q_list2[i].selected == true) {
				tmp1 = frmx.q_list2[i].text;
				tmp2 = frmx.q_list2[i].value;
				strs=tmp2.split('||');
				strs_tot = strs_tot + Number(strs[3]);

				objx = new Option(tmp1, tmp2);
	
				frmx.q_list.add(objx);
				frmx.q_list2.remove(i);
				lngLen = lngLen -1;
				i = i -1;
			}
		}

		//document.form1.qcnts.value = "�˻��� ���� �� : " + document.form1.q_list.length + " ����";
		//document.form1.qcnts2.value = "������� ���� �� : " + document.form1.q_list2.length + " ����";
		document.form1.qcnts.value = document.form1.q_list.length;
		document.form1.qcnts2.value = document.form1.q_list2.length;
		document.form1.qcnts3.value = (strs_tot2 - strs_tot);
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

		var lngLen = frmx.q_list2.length -1;
		var tmp;
		var strs;
		var subjects = "";
		var qs2 = "";
		var strs3 = "";
		var strs4 = "";

		if(obj == "qs") {
			document.all.id_qs.style.display = "block";
			document.all.id_options.style.display = "none";
			document.all.id_details.style.display = "none";
			document.all.papers.style.display = "none";
			document.all.qcnts_chk.style.display = "none";
		} else if(obj == "options") {			
			if(document.form1.q_list2.length != <%=q_counts%> && ("<%=randomtypes%>" == "NN" || "<%=randomtypes%>" == "NQ" || "<%=randomtypes%>" == "NT")) {
				alert("���� ���� ���� " + <%=q_counts%> + " �����̾�� �մϴ�.");
				return false;
			} else if(document.form1.q_list2.length < <%=q_counts%> && ("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT")) {
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

				for (i=0; i<=lngLen; i++) {
					tmp = frmx.q_list2[i].value;
					strs=tmp.split('||');
					qs = qs + strs[0] + ",";
					strs3 = strs3 + strs[3] + ",";
				}

				frmx.q_allotting.value = strs3;

				// �������ı��� ���� ���� ����Ʈ ���������
				get_qs_list(1);
			}
		}
	}

	function q_save() {
		
		var frmx = document.form1;
		var lngLen = frmx.q_list2.length -1;
		var tmp;
		var strs;
		var subjects = "";
		var qs2 = "";
		var strs3 = "";
		var strs4 = "";

		if(document.form1.q_list2.length != <%=q_counts%> && ("<%=randomtypes%>" == "NN" || "<%=randomtypes%>" == "NQ" || "<%=randomtypes%>" == "NT")) {
			alert("���� ���� ���� " + <%=q_counts%> + " �����̾�� �մϴ�.");
			return;
		} else if(document.form1.q_list2.length < <%=q_counts%> && ("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT")) {
			alert("���� ���� ���� " + <%=q_counts%> + " �����̻� �̾�� �մϴ�.");
			return;
		} else if(<%=allots%> != document.form1.qcnts3.value && ("<%=randomtypes%>" == "NN" || "<%=randomtypes%>" == "NQ" || "<%=randomtypes%>" == "NT")) {
			alert("������ ������ " + <%=allots%> + " �� �̾�� �մϴ�.");
			return;
		} else {

		for (i=0; i<=lngLen; i++) {
			tmp = frmx.q_list2[i].value;
			strs=tmp.split('||');
			qs = qs + strs[0] + ",";
			strs3 = strs3 + strs[3] + ",";
		}

		// ������ ��� ���� ���̺� ����ϱ�
		if("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT") { // ����ɼ��� ���..
			save_qs_list2(qs.substring(0,qs.length-1));
		} else {
			save_qs_list(qs.substring(0,qs.length-1), strs3.substring(0,strs3.length-1));
		}

		}
	}
	
	function q_basic_chk(q_basic) {
		var frmx = document.form1;
		var lngLen = frmx.q_list2.length -1;
		var tmp;
		var strs;
		var subjects = "";
		var qs2 = "";
		var strs3 = "";

		for (i=0; i<=lngLen; i++) {
			tmp = frmx.q_list2[i].value;
			strs=tmp.split('||');
			qs = qs + strs[0].replace(" ") + ",";
			strs3 = strs3 + strs[3] + ",";
		}

		frmx.q_allotting.value = strs3;

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
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
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
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
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
			window.open("paperPre.jsp?id_exam=<%=id_exam%>","prewin","width=350, height=250");
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
	}

	function creates() {
		var q_counts = <%=q_counts%>;
		var allots = <%=allots%>;

		if("<%=randomtypes%>" == "YQ" || "<%=randomtypes%>" == "YT") {
			if(Number(document.form1.qcnts4.value) != q_counts) {
				alert("�������׼��� ���� �ʽ��ϴ�. \n\n�ش���迡 �������׼��� "+q_counts+"�����Դϴ�.\n\n�������׼��� Ȯ���� �� �ٽ� �������ּ���.");
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
			var lngLen = frmx.q_list2.length -1;
			var res = "";
			var res2 = "";
			var tmp = "";
			var strs = "";

			selectAll('q_list2');

			for (i=0; i<=lngLen; i++) {
				tmp = frmx.q_list2[i].value;
				strs=tmp.split('||');
				res = res + strs[0] + ",";
				res2 = res2 + strs[7] + ",";
			}

			frmx.qs_lists2.value = res;
			frmx.ref_lists2.value = res2;

			frmx.submit();
		}
	}

	function allott_insert(allott) {
		var frmx = document.form1;
		var lngLen = frmx.q_list2.length -1;

		var res;
		var tmp;
		var strs;
		var strs_tot = 0;
		var select_cnt = 0;

		for (i=0; i<=lngLen; i++) {
			tmp = frmx.q_list2[i].value;

			strs=tmp.split('||');

			var addOpt = document.createElement("OPTION");

			if (frmx.q_list2[i].selected == true) {
				strs[3] = allott;
				addOpt.text = ""+strs[0]+" "+strs[1]+strs[2]+strs[3]+strs[4]+strs[5];
				addOpt.value = strs[0]+"||"+strs[1]+"||"+strs[2]+"||"+strs[3]+"||"+strs[4]+"||"+strs[5]+"||"+strs[6]+"||"+strs[7];
			} else {
				addOpt.text = ""+strs[0]+" "+strs[1]+strs[2]+strs[3]+strs[4]+strs[5];
				addOpt.value = strs[0]+"||"+strs[1]+"||"+strs[2]+"||"+strs[3]+"||"+strs[4]+"||"+strs[5]+"||"+strs[6]+"||"+strs[7];
			}
			
			frmx.q_list2[i].text = addOpt.text;
			frmx.q_list2[i].value = addOpt.value;
			//frmx.q_list2.add(addOpt);

			strs_tot = strs_tot + Number(strs[3]);
		}

		document.form1.qcnts3.value = strs_tot;
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
					<td align="right"><a href="javascript:q_search();" onfocus="this.blur();"><img src="../../images/bt_q_search_yj1.gif"></a>&nbsp;<a href="javascript:selectAll('q_list');" onfocus="this.blur();"><img src="../../images/bt_q_list_yj1.gif"></a>&nbsp;<a href="javascript:q_preview();" onfocus="this.blur();"><img src="../../images/bt_q_preview.gif" onfocus="this.blur();"></a></td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="0" cellpadding="0" border="0" id="tableD">
							<tr align="center" id="tr">		
								<td width="2%">NO</td>
								<td width="15%">����</td>
								<td width="10%">���̵�</td>
								<td width="7%">����</td>
								<td width="20%">����Ƚ��</td>
								<td width="*">����</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2"><select name="q_list" multiple size="12" style="width:580px;"></select></td>
				</tr>
				<tr height="46">
					<td valign="top" style="padding-top: 2px;"><input type="text" class="input" name="qcnts" size="5" readonly> ���� �˻�</td>
					<td align="right" valign="middle"><a href="javascript:ftnAdd();"><img src="../../images/bt_ftnAdd_yj1.gif"></a>&nbsp;<a href="javascript:ftnRemove();"><img src="../../images/bt_ftnRemove_yj1.gif"></a></td>
				</tr>
				<tr>
					<td colspan="2"><div id="id_details"></div></td>
				</tr>
				<tr>
					<td><div class="F2">������ ����</div></td>
					<td align="right"><a href="javascript:selectAll('q_list2');"><img src="../../images/bt_q_list_yj1.gif"></a>&nbsp;<a href="javascript:selectRemove('q_list2');"><img src="../../images/bt_q_list2_yj1.gif"></a>&nbsp;<a href="javascript:q_preview2();" onfocus="this.blur();"><img src="../../images/bt_q_preview.gif" onfocus="this.blur();"></a>&nbsp;<%if(randomtypes.equals("YQ") || randomtypes.equals("YT")) { %><a href="javascript:alert('���� �ش� ���迡 ���������� �����������Դϴ�.\n\n���������� �����������ϰ�쿡��\n�ϴܿ� ���������� �����ɼǼ����� Ŭ���ϰ��� ������ �����ϼž� �մϴ�.\n\n���������� �� �� �����ϼ�����쿡�� �ش� â�� �����ð�\n���������޴����� ���������� �������ֽð� ������ �ֽñ� �ٶ��ϴ�.');"><% } else { %><a href="javascript:allott_ins();"><% } %><img src="../../images/bt_q_allotting_yj1.gif"  style="cursor: hand;"></a></td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="0" cellpadding="0" border="0" id="tableD" width="100%">
							<tr align="center" id="tr">		
								<td width="2%">NO</td>
								<td width="15%">����</td>
								<td width="10%">���̵�</td>
								<td width="7%">����</td>
								<td width="20%">����Ƚ��</td>
								<td width="*">����</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2"><select name="q_list2" multiple size="12" style="width:580px;"></select></td>
				</tr>
				<tr>
					<td>
						������ ���׼� <input type="text" class="input" name="qcnts2" size="5" readonly>, 
						���� �� :&nbsp;&nbsp;<input type="text" class="input" name="qcnts3" size="5" readonly>&nbsp;��
						<hr>
						<font class="point">���� ���׼� : <%=q_counts%> ����&nbsp;&nbsp;&nbsp;���� : <%=allots%> ��</font>
					</td>
					<td align="right" valign="bottom">						
						<a href="javascript:q_save();"><img src="../../images/bt_q_save_yj1.gif"></a>
						<!--input type="image" value="�������׼���" onClick="movieLayout('qs')" src="../../images/bt_layout_qs_yj1.gif">&nbsp;&nbsp;--><img src="../../images/bt_layout_options_yj1.gif" onClick="movieLayout('options')" >
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
					<td height="25">&nbsp;&nbsp;&nbsp;<input type="radio" name="allot_basic" value="1" >&nbsp;���׺� ����(���� ����� ���� ���)</td>
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
					<td height="25">&nbsp;* �������� ������ ���ļ����� �Է��Ͻ� �� �ֽ��ϴ�.</td>
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
						<td height="35"><input type="checkbox" name="rdox" value="Y">&nbsp;<b>OX�� ���⼯��</b>&nbsp;&nbsp;&nbsp;������ ��&nbsp;&nbsp;:&nbsp;&nbsp;<select name="paper_cnts">
						<% for(int paperCnt = 1; paperCnt <= 50; paperCnt++) { %>  
						<option value="<%=paperCnt%>">&nbsp;<%=paperCnt%>&nbsp;</option>
						<% } %>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../images/bt_tman_creates_yj2.gif" align="absmiddle" border="0" onClick="creates();"></td>
					</tr>
				</table>

			</div>

			<div style="display:none;" id="qcnts_chk">
			
				���ù��׼� :&nbsp;&nbsp;<input type="text" class="input" name="qcnts4" size="5" readonly>&nbsp;&nbsp;����&nbsp;&nbsp;���ù��� ���� �� :&nbsp;&nbsp;<input type="text" class="input" name="qcnts5" size="5" readonly>&nbsp;��<br><b>������ ���׼� : <%=q_counts%> ����&nbsp;&nbsp;&nbsp;������ ���� : <%=allots%> ��</b>

			</div>

		</div>

	</div>
	<div id="button">

	</div>

</body>
</html>
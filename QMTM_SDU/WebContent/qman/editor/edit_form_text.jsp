<%
//******************************************************************************
//   ���α׷� : edit_form_text.jsp
//   �� �� �� : �������� �ؽ�Ʈ ����
//   ��    �� : �������� �ؽ�Ʈ ����ȭ��
//   �� �� �� : r_difficulty, r_q_use, q_standard_a, q_standard_b, q, q_ref
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.QuseUtil, qmtm.admin.etc.QuseBean, qmtm.tman.exam.RdifficultUtil, 
//              qmtm.tman.exam.RdifficultBean, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil, 
//              qmtm.qman.editor.QUtil, qmtm.qman.editor.QBean
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="qmtm.QmTm, qmtm.ComLib, qmtm.admin.etc.QuseUtil, qmtm.admin.etc.QuseBean, qmtm.tman.exam.RdifficultUtil, qmtm.tman.exam.RdifficultBean, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil, qmtm.qman.editor.QUtil, qmtm.qman.editor.QBean, qmtm.qman.editor.QMsgBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }

	if (id_q.length() == 0 || id_subject.length() == 0 || id_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	QBean bean = null;

	try {
		bean = QUtil.getBean(id_q);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	String q = bean.getQ().replaceAll("<BR>","\n");
	String ex1 = QmTm.getNullChk(bean.getEx1());
	String ex2 = QmTm.getNullChk(bean.getEx2());
	String ex3 = QmTm.getNullChk(bean.getEx3());
	String ex4 = QmTm.getNullChk(bean.getEx4());
	String ex5 = QmTm.getNullChk(bean.getEx5());	
	String explain = QmTm.getNullChk(bean.getExplain());
	String hint = QmTm.getNullChk(bean.getHint());

	int excount = bean.getExcount();
	int cacount = bean.getCacount();

	String id_ref = QmTm.getNullChk(bean.getId_ref());

	int id_qtype = bean.getId_qtype();
	double allotting = bean.getAllotting();
	int limittime = bean.getLimittime();

	int intTmp = (int)Math.floor((limittime % 3600) / 60);

	int mm, ss;

	if(intTmp <= 0) {
		mm = 0;
	} else {
		mm = intTmp;
	}

	int intTmp2 = (int)Math.floor(limittime % 60);

	if(intTmp2 <= 0) {
		ss = 0;
	} else {
		ss = intTmp2;
	}
	String id_difficulty1 = String.valueOf(bean.getId_difficulty1());
	
	String ca = QmTm.getNullChk(bean.getCa());

	String yn_caorder = QmTm.getNullChk(bean.getYn_caorder());
	String yn_case = QmTm.getNullChk(bean.getYn_case());
	String yn_blank = QmTm.getNullChk(bean.getYn_blank());

	String src_book = QmTm.getNullChk(bean.getSrc_book());
	String src_author = QmTm.getNullChk(bean.getSrc_author());
	String src_page = QmTm.getNullChk(bean.getSrc_page());
	String src_pub_comp = QmTm.getNullChk(bean.getSrc_pub_comp());
	String src_pub_year2 = QmTm.getNullChk(bean.getSrc_pub_year());
	int src_pub_year;
	if(src_pub_year2.equals("")) {
		src_pub_year = 2008;
	} else {
		src_pub_year = Integer.parseInt(src_pub_year2);
	}
	String src_misc = QmTm.getNullChk(bean.getSrc_misc());
	String find_kwd = QmTm.getNullChk(bean.getFind_kwd());
	String userid = QmTm.getNullChk(bean.getUserid());

	int id_valid_type = bean.getId_valid_type();
	String valid_types = "";

	if(id_valid_type == 0) {
		valid_types = "<font color='blue'>������</font>";
	} else if(id_valid_type == 1) {
		valid_types = "<font color='red'>��������� ó��</font>";
	} else if(id_valid_type == 2) {
		valid_types = "<font color='red'>�������ó��</font>";
	}

	String id_q_use = String.valueOf(bean.getId_q_use());
	String q_use_detail = QmTm.getNullChk(bean.getQ_use_detail());
	int ex_rowcnt = bean.getEx_rowcnt();
	String yn_single_line = QmTm.getNullChk(bean.getYn_single_line());
	
	String q_ks = QmTm.getNullChk(bean.getQ_ks());
	String q_to = QmTm.getNullChk(bean.getQ_to());
	String yn_ex_set = QmTm.getNullChk(bean.getYn_ex_set());
	String yn_practice = QmTm.getNullChk(bean.getYn_practice());
	
	String reftitle = QmTm.getNullChk(bean.getReftitle());
	String refbody1 = QmTm.getNullChk(bean.getRefbody1());
	String refbody2 = QmTm.getNullChk(bean.getRefbody2());
	String refbody3 = QmTm.getNullChk(bean.getRefbody3());

	StringBuffer refbody = new StringBuffer();

	refbody = refbody.append(refbody1);
	refbody = refbody.append(refbody2);
	refbody = refbody.append(refbody3);

	String qtype = String.valueOf(bean.getId_qtype());
	String qtype_msg = "";

	if(qtype.equals("1")) {
		qtype_msg = "OX��";
	} else if(qtype.equals("2")) {
		qtype_msg = "������";
	} else if(qtype.equals("3")) {
		qtype_msg = "���������";
	} else if(qtype.equals("4")) {
		qtype_msg = "�ܴ���";
	} else if(qtype.equals("5")) {
		if(yn_practice.equals("Y")) {
			qtype_msg = "�Ǳ���";
		} else {
			qtype_msg = "�����";
		}
	}

	int make_cnt = bean.getMake_cnt();

	String multi_sel = "";

	if(cacount > 1) {
		multi_sel = "checkbox";
	} else {
		multi_sel = "radio";
	}

	int heights = 590;

	String[] ArrFrontMsg = new String[cacount];
	String[] ArrBackMsg = new String[cacount];
	String[] ArrBoxSize = new String[cacount];

	String msg_yn = "Y";

	if(qtype.equals("4")) {
		// �ܴ����ϰ�� �޽����� ������´�.(�Է»��� ����Ʈ, �� �޽���, �� �޽���..)		
		QMsgBean[] qmsg = null;

		try {
			qmsg = QUtil.getMsgBeans(id_q);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

		    if(true) return;
		}

		if(qmsg == null) {
			ArrFrontMsg[0] = "";
			ArrBackMsg[0] = "";
			ArrBoxSize[0] = "20";
			msg_yn = "N";
		} else {
			for(int i=0; i<qmsg.length; i++) {
				ArrFrontMsg[i] = qmsg[i].getFront_msg();
				if(ArrFrontMsg[i] == null) {
					ArrFrontMsg[i] = "";
				}
				ArrBackMsg[i] = qmsg[i].getBack_msg();
				if(ArrBackMsg[i] == null) {
					ArrBackMsg[i] = "";
				}
				ArrBoxSize[i] = qmsg[i].getBox_size();
				if(ArrBoxSize[i] == null) {
					ArrBoxSize[i] = "20";
				}
			}
		}
	}

	// �����뵵��� ���������
	QuseBean[] quse = null;

	try {
		quse = QuseUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	// ���̵� ���� ���������
	RdifficultBean[] diffs = null;

    try {
	    diffs = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	// ��з� ����Ʈ ��������
	QstandardABean[] rst = null;

    try {
	    rst = QstandardAUtil.getSelectBeans(id_chapter);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

%>

<html>
<head>
<title>��������</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=EUC-KR">
<link rel="StyleSheet" href="../../css/style_q.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>
<script>
<!--

var qtype = "<%=qtype%>";
var excount = <%=excount%>;
var cacount = <%=cacount%>;

var id_qtype = <%=id_qtype%>;
var ca = "<%=ca%>";
	
var yn_caorder = "<%=yn_caorder%>";
var yn_case = "<%=yn_case%>";
var yn_blank = "<%=yn_blank%>";
var yn_single_line = "<%=yn_single_line%>";

function OnSave()
{
	var form = document.writeForm;

	if(form.q.value.replace(/\s/g, "")==""){
		 alert("������ ������ּ���.");
		 form.q.focus();
		 return;
    }

	if(qtype == "2" || qtype == "3") {
		if(excount == 3) {
			var str2 = form.ex1.value;
			var str3 = form.ex2.value;
			var str4 = form.ex3.value;

			if(str2.replace(/\s/g, "")==""){
			    alert("���� 1���� ������ּ���.");
			    form.ex1.focus();
			    return;
		    }

			if(str3.replace(/\s/g, "")==""){
			    alert("���� 2���� ������ּ���.");
			    form.ex2.focus();
			    return;
		    }

			if(str4.replace(/\s/g, "")==""){
			    alert("���� 3���� ������ּ���.");
			    form.ex3.focus();
			    return;
		    }

		} else if(excount == 4) {
			var str2 = form.ex1.value;
			var str3 = form.ex2.value;
			var str4 = form.ex3.value;
			var str5 = form.ex4.value;

			if(str2.replace(/\s/g, "")==""){
			    alert("���� 1���� ������ּ���.");
			    form.ex1.focus();
			    return;
		    }

			if(str3.replace(/\s/g, "")==""){
			    alert("���� 2���� ������ּ���.");
			    form.ex2.focus();
			    return;
		    }

			if(str4.replace(/\s/g, "")==""){
			    alert("���� 3���� ������ּ���.");
			    form.ex3.focus();
			    return;
		    }

			if(str5.replace(/\s/g, "")==""){
			    alert("���� 4���� ������ּ���.");
			    form.ex4.focus();
			    return;
		    }

		} else if(excount == 5) {
			var str2 = form.ex1.value;
			var str3 = form.ex2.value;
			var str4 = form.ex3.value;
			var str5 = form.ex4.value;
			var str6 = form.ex5.value;

			if(str2.replace(/\s/g, "")==""){
			    alert("���� 1���� ������ּ���.");
			    form.ex1.focus();
			    return;
		    }

			if(str3.replace(/\s/g, "")==""){
			    alert("���� 2���� ������ּ���.");
			    form.ex2.focus();
			    return;
		    }

			if(str4.replace(/\s/g, "")==""){
			    alert("���� 3���� ������ּ���.");
			    form.ex3.focus();
			    return;
		    }

			if(str5.replace(/\s/g, "")==""){
			    alert("���� 4���� ������ּ���.");
			    form.ex4.focus();
			    return;
		    }

			if(str6.replace(/\s/g, "")==""){
			    alert("���� 5���� ������ּ���.");
			    form.ex5.focus();
			    return;
		    }

		}
	} 

	if(id_qtype > 0 && id_qtype < 4) {

		var checkCnt = 0;

		for(var i = 0; i < excount; i++) {
			if(form.corrects[i].checked) {
				checkCnt = checkCnt + 1;
			}
		}

		if(checkCnt == 0) {
			alert("������ üũ�ϼ���.");
			return;
		}

		if(checkCnt != cacount) {
			alert("���� ������ ���� ������ " + checkCnt + " �� �Դϴ�.\n\n ������ " + cacount + " �� �����ϼž� �մϴ�.");
			return;
		}
	}

	// XSS Filter	
	form.q.value = XSSfilter(form.q.value);

	if(qtype == "2" || qtype == "3") {
		if(excount == 3) {

			form.ex1.value = XSSfilter(form.ex1.value);
			form.ex2.value = XSSfilter(form.ex2.value);
			form.ex3.value = XSSfilter(form.ex3.value);	

		} else if(excount == 4) {
			
			form.ex1.value = XSSfilter(form.ex1.value);
			form.ex2.value = XSSfilter(form.ex2.value);
			form.ex3.value = XSSfilter(form.ex3.value);			
			form.ex4.value = XSSfilter(form.ex4.value);			

		} else if(excount == 5) {

			form.ex1.value = XSSfilter(form.ex1.value);
			form.ex2.value = XSSfilter(form.ex2.value);
			form.ex3.value = XSSfilter(form.ex3.value);			
			form.ex4.value = XSSfilter(form.ex4.value);	
			form.ex5.value = XSSfilter(form.ex5.value);	

		} 
	} 
		
	form.submit();
}

function XSSfilter(content) {
    return content.replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

// �޴����� ������ �����ֱ�..
function movieLayout(obj) {
	if(obj == "q") {
		document.all.id_q.style.display = "block";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "none";
		document.all.id_refbody.style.display = "none";
		document.all.id_infos.style.display = "none";
		document.all.id_prints.style.display = "none";
	} else if(obj == "explain") {
		document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "block";
		document.all.id_hint.style.display = "none";
		document.all.id_refbody.style.display = "none";
		document.all.id_infos.style.display = "none";
		document.all.id_prints.style.display = "none";
	} else if(obj == "hint"){
	    document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "block";
		document.all.id_refbody.style.display = "none";
		document.all.id_infos.style.display = "none";
		document.all.id_prints.style.display = "none";
	} else if(obj == "refbody"){
	    document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "none";
		document.all.id_refbody.style.display = "block";
		document.all.id_infos.style.display = "none";
		document.all.id_prints.style.display = "none";
	} else if(obj == "infos"){
	    document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "none";
		document.all.id_refbody.style.display = "none";
		document.all.id_infos.style.display = "block";
		document.all.id_prints.style.display = "none";
	} else if(obj == "prints"){
	    document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "none";
		document.all.id_refbody.style.display = "none";
		document.all.id_infos.style.display = "none";
		document.all.id_prints.style.display = "block";
	}
}

function movieLayout2(obj) {
	if(cacount == 1) {
		if(obj == "1") {
			document.all.id_correct1.style.display = "block";
		}
	} else if(cacount == 2) {
		if(obj == "1") {
			document.all.id_correct1.style.display = "block";
			document.all.id_correct2.style.display = "none";
		} else if(obj == "2") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "block";
		} 
	} else if(cacount == 3) {	
		if(obj == "1") {
			document.all.id_correct1.style.display = "block";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
		} else if(obj == "2") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "block";
			document.all.id_correct3.style.display = "none";
		} else if(obj == "3") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "block";
		} 
	} else if(cacount == 4) {		
		if(obj == "1") {
			document.all.id_correct1.style.display = "block";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
		} else if(obj == "2") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "block";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
		} else if(obj == "3") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "block";
			document.all.id_correct4.style.display = "none";
		} else if(obj == "4") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "block";
		} 
	} else if(cacount == 5) {	
		if(obj == "1") {
			document.all.id_correct1.style.display = "block";		
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
		} else if(obj == "2") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "block";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
		} else if(obj == "3") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "block";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
		} else if(obj == "4") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "block";
			document.all.id_correct5.style.display = "none";
		} else if(obj == "5") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "block";
		} 
	}
}

function inits() {

	var ArrCa = new Array();
	var ArrCa2 = new Array();

	var frm = document.writeForm;
	
	movieLayout("q");

	if(id_qtype < 4) {		
		for(var i = 0; i < excount; i++) {
			if(cacount > 1) {
				
				ArrCa = ca.split("{|}");

				for (var k = 0; k < ArrCa.length; k++) { 
					if(i+1 == parseInt(ArrCa[k])) {					
						frm.corrects[i].checked = true;
					}
				}

			} else {
				
				if(i+1 == parseInt(ca)) {					
					frm.corrects[i].checked = true;
				}

			}
		}
	} else if(id_qtype == 4) {
		movieLayout2('1');

		if(yn_caorder == "Y") {
			frm.yn_caorder.checked = true;
		}

		if(yn_case == "Y") {
			frm.yn_case.checked = true;
		}

		if(yn_blank == "Y") {
			frm.yn_blank.checked = true;
		}

		if(yn_single_line == "Y") {
			frm.yn_single_line.checked = true;
		}

		// �ܴ��� ����� ������ �ϰ��..
		if(cacount > 1) {

			ArrCa = ca.split("{|}");
			
			for(var i = 0; i < ArrCa.length; i++) {
				ArrCa2 = ArrCa[i].split("{^}");
				for(var j = 0; j < ArrCa2.length; j++) {
					adds(i+1, ArrCa2[j]);
				}
			}

		} else { // �ܴ��� ����� �Ѱ� �ϰ��..

			ArrCa = ca.split("{^}");

			for (var i = 0; i < ArrCa.length; i++) { 
				adds(1, ArrCa[i]);
			}
		}		
	}

	get_standard_list("<%=q_ks%>");
}

function moveFocus(index, values)
{	
	if(event.keyCode == 13) {
		var frm = document.writeForm;
		var opts=eval("frm.ans_list" + index + ".options");
		var opt=document.createElement("option");    
		opt.value = opts.length + 1;
		opt.innerText = values;
		opts.insertAdjacentElement("beforeEnd",opt);
		
		eval("frm.ans" + index + ".value = '' ");

		setting_val(index);
	}
}

function adds(index, values)
{	
	var frm = document.writeForm;
	var opts=eval("frm.ans_list" + index + ".options");
    var opt=document.createElement("option");    
	opt.value = opts.length + 1;
 	opt.innerText = values;
    opts.insertAdjacentElement("beforeEnd",opt);
	
	eval("frm.ans" + index + ".value = '' ");

	setting_val(index);
}

function setting_val(index)
{
	var frm = document.writeForm;
	var tmp = "";
	var opts=eval("frm.ans_list" + index + ".options");
	for (var i=0; i<opts.length; i++) {		
		tmp += eval("frm.ans_list" + index + "[" + i + "].innerText");

		if(i+1 != opts.length) {
			tmp += "{^}";
		}	
	}
	
	eval("frm.ans_list2" + index + ".value = tmp;");
}

function dels(index)
{
	var frm = document.writeForm;
	var opts=eval("frm.ans_list" + index + ".options");
	for (var i=0; i<opts.length; i++) {
		if (opts[i].selected) {
			opts[i--].removeNode(true);
	    }
	}

	setting_val(index);
}

function up_move(index)
{
	var frm = document.writeForm;
	var opts=eval("frm.ans_list" + index + ".options");

    for (var i=0; i<opts.length; i++) {
		if (opts[i].selected && i>0) {
			tmp=opts[i].cloneNode(true);
	        opts[i].removeNode(true);
            opts[i-1].insertAdjacentElement("beforeBegin",tmp).selected=true;
		}
	}

	setting_val(index);
}

function down_move(index)
{
	var frm = document.writeForm;
	var opts=eval("frm.ans_list" + index + ".options");

    for (var i=opts.length-1; i>=0; i--) {
		if (opts[i].selected && i<opts.length-1) {
			tmp=opts[i].cloneNode(true);
		    opts[i].removeNode(true);
			opts[i].insertAdjacentElement("afterEnd",tmp).selected=true;
	    }
	}

	setting_val(index);
}

function q_static() {
	$.posterPopup('../question/q_static_view.jsp?id_q=<%=id_q%>','q_static','width=850, height=650 scrollbars=auto, top='+(screen.height-650)/2+', left='+(screen.width-850)/2);
}

function q_preview() {
	$.posterPopup('../question/q_preview.jsp?id_qs=<%=id_q%>','preview_q','width=800, height=640, scrollbars=yes, top='+(screen.height-640)/2+', left='+(screen.width-800)/2);
}

function q_refs() {
	$.posterPopup('q_ref_select.jsp?id_subject=<%=id_subject%>', 'q_refs', 'width=950, height=600, scrollbars=yes, top='+(screen.height-600)/2+', left='+(screen.width-950)/2);
}

function q_refs_init() {
	document.writeForm.id_ref.value = "0";
	document.writeForm.ref_name.value = "";
	document.writeForm.twe12.HtmlValue = "";
}

var standard1;

// �ҿ��� �����ڵ����� ���������
function get_standard_list(strs) {
	
	var selects = "<%=q_to%>";

	standard1 = new ActiveXObject("Microsoft.XMLHTTP");
	standard1.onreadystatechange = get_standard_list_callback;
	standard1.open("GET", "../standard/standard.jsp?id_standarda="+strs+"&selects="+selects, true);
	standard1.send();
}

function get_standard_list_callback() {

	if(standard1.readyState == 4) {
		if(standard1.status == 200) {
			if(typeof(document.all.div_standard) == "object") {
				document.all.div_standard.innerHTML = standard1.responseText;
			}
		}
	}
}

function src_info(id_q) {
    $.posterPopup('../question/q_src_info.jsp?id_q='+id_q,'q_src_info','width=1000, height=650, scrollbars=yes, top='+(screen.height-650)/2+', left='+(screen.width-1000)/2);
}

-->
</script>

<style>
	
	BODY { background-image: url(../../images/bg_qman_editor.gif); background-repeat: repeat-x; 
		margin: 0px; padding: 0px 15px 30px 15px; 
		scrollbar-face-color: #ededea; /*�⺻����*/
		scrollbar-highlight-color: #FFFFFF; /*��� �� ���� ���϶���Ʈ*/
		scrollbar-3dlight-color: #f0f0f0; /*��� �� ���� ����*/
		scrollbar-shadow-color: #cccdc7; /*�ϴ� �� ���� �ο����Ʈ*/
		scrollbar-darkshadow-color: #f0f0f0; /*�ϴ� �� ���� ����*/
		scrollbar-track-color: #fafafa; /*������*/
		scrollbar-arrow-color: #a8a798; /*ȭ��ǥ����*/
	}
	.tab { width: 100%; background-image: url(../../images/bg_editor_tab.gif); background-repeat: repeat-x; height: 32px; }
	
</style>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
</head>

<body onLoad="inits();">

	<form name="writeForm" method="post" action="edit_text.jsp">
	
	<input type="hidden" name="id_qs" value="<%=id_q%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">
	<input type="hidden" name="id_chapter" value="<%=id_chapter%>">
	
	<input type="hidden" name="qtype2" value="<%=qtype%>">
	<input type="hidden" name="excount2" value="<%=excount%>">
	<input type="hidden" name="cacount2" value="<%=cacount%>">
	
	<input type="hidden" name="msg_yn" value="<%=msg_yn%>">
	
	<% 
		if(qtype.equals("4")) { 
			for(int i=0; i<cacount; i++) {
	%>
	<input type="hidden" name="ans_list2<%=i+1%>">
	<% 
			}
		} 
	%>

	<table border="0" width="100%" cellpadding="0" cellspacing="0" height="38">
		<tr>
			<td>
				<a href="javascript:q_preview();" border="0"><img src="../../images/bt_editor3.gif"></a><a href="javascript:" onclick="$.posterPopup('../question/incorrect.jsp?id_q=<%=id_q%>&id_qtype=<%=qtype%>&ca=<%=ca%>&excount=<%=excount%>&cacount=<%=cacount%>&id_valid_type=<%=id_valid_type%>','q_incorrect','width=750, height=500, top='+(screen.height-500)/2+', left='+(screen.width-750)/2);" style="cursor: pointer;"><img src="../../images/bt_editor4.gif" border="0"></a><a href="javascript:q_static();"><img src="../../images/bt_editor5.gif" border="0"></a><a href="javascript:src_info(<%=id_q%>);"><img src="../../images/bt_editor9.gif" border="0"></a></td>
			<td align="right"><% if(id_valid_type > 0) { %><img src="../../images/bt_editor6.gif" onClick="alert('���� ���� �Ǵ� ��� ����ó�� �� ������ ������ �� �����ϴ�.\n\n�ش� ������ �̿��Ͻ÷��� �������� �� ����Ͻñ� �ٶ��ϴ�.');" style="cursor: pointer;"><% } else { %><img src="../../images/bt_editor6.gif" onclick="OnSave();" style="cursor: pointer;"><% } %><img src="../../images/bt_editor7.gif" onclick="javascript:window.close()" style="cursor: pointer;"></td>
		</tr>
	</table>

	<br>	

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top">
				<div style="height:32px; background-image: url(../../images/editor_newq.gif); background-repeat: no-repeat; padding: 6px 0px 0px 90px; font: bold 16px dotum; color: #000000;"> <%=id_q%>&nbsp;-&nbsp;<%=valid_types%>&nbsp;(<%=make_cnt%>ȸ ����)</div>
				<table border="0">
					<tr>
						<td width="500" height="600" valign="top">
						<textarea name="q" rows="35" cols="65"><%=q%></textarea>
						</td>			
					</tr>
				</table>
			</td>
			<td width="20"></td>
			<td width="500" align="left" valign="top" bgcolor="ffffff">
				
				<div id="id_q">

					<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>			
					
					<div style="overflow-y:scroll; height:500px;">

					<% if(qtype.equals("2") || qtype.equals("3")) { %>
					<table border="0" width="97%" cellspacing="0" cellpadding="0" align="center">
						<tr>
							<td height=25 valign="top"><input type="checkbox" name="yn_ex_set" <% if(yn_ex_set.equals("Y")) { %> checked <% } %> value="Y"> <B>���������� ���⼯�� ����</B></td>
						</tr>
					</table>					
					<% } %>
					
					<table border="0" width="97%" cellspacing="0" cellpadding="3" id="tableD" align="center">
						<% if(qtype.equals("1")) { %>
						<tr>
							<td width="85" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1" <%if(ca.equals("1")) { %>checked<% } %>>&nbsp;���� ��
							</td>
							<td width="400" height="<%=200/2%>" valign="middle" align="left">
								&nbsp;&nbsp;<br><font size="7"><b>O</b></font>
							</td>
						</tr>
						<tr>
							<td width="85" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2" <%if(ca.equals("2")) { %>checked<% } %>>&nbsp;���� ��
							</td>
							<td width="400" height="<%=200/2%>" valign="middle" align="left"><br>
							<font size="7"><b>X</b></font>
							</td>
						</tr>
						<% 
							} else if(qtype.equals("2") || qtype.equals("3")) { 
								if(excount == 3) {
						%>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex1" cols="56" rows="9" style="font-family:Arial"><%=ex1%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex2" cols="56" rows="9" style="font-family:Arial"><%=ex2%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3" >&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex3" cols="56" rows="9" style="font-family:Arial"><%=ex3%></textarea>
							</td>
						</tr>
						<% } else if(excount == 4) { %>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex1" cols="56" rows="7" style="font-family:Arial"><%=ex1%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex2" cols="56" rows="7" style="font-family:Arial"><%=ex2%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex3" cols="56" rows="7" style="font-family:Arial"><%=ex3%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex4" cols="56" rows="7" style="font-family:Arial"><%=ex4%></textarea>
							</td>
						</tr>
						<% } else if(excount == 5) { %>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex1" cols="56" rows="5" style="font-family:Arial"><%=ex1%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex2" cols="56" rows="5" style="font-family:Arial"><%=ex2%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex3" cols="56" rows="5" style="font-family:Arial"><%=ex3%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex4" cols="56" rows="5" style="font-family:Arial"><%=ex4%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=450/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;���� ��
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex5" cols="56" rows="5" style="font-family:Arial"><%=ex5%></textarea>
							</td>
						</tr>						
						<% 
								} 
							} else if(qtype.equals("4")) {
						%>
						<tr>
							<td width="500" valign="top" colspan="2">
								<table width="100%" border="0">
									<tr>
										<td align="left" width="100%">
										<% for(int i=0; i<cacount; i++) { %>
										<input type="button" value="����<%=i+1%>" onClick="movieLayout2('<%=i+1%>');" class="form">&nbsp;
										<% } %>
										</td>
									</tr>
								</table>
							</td>
						</tr>
									<tr>
									<td width="520" valign="top" colspan="2">
										<% for(int i=0; i<cacount; i++) { %>
										<table width="100%" border="0" style="display:none;" id="id_correct<%=i+1%>" cellpadding=0 cellspacing=0>
											<tr>	
												<td><input type="text" class="input" name="ans<%=i+1%>" size="45" onkeydown="moveFocus('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);"></td>
												<td rowspan="2" valign="top"><input type="button" value="�߰��ϱ�" onClick="adds('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);" class="form2"><br><input type="button" value="�����ϱ�" onClick="dels('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);" class="form2"><!--<br><input type="button" value="���� ���" onClick="up_move('<%=i+1%>');" class="form2"><br><input type="button" value="���� ���" onClick="down_move('<%=i+1%>');" class="form2">--></td>
											</tr>
											<tr>
												<td colspan="2"><select name="ans_list<%=i+1%>" multiple="multiple" size="5" style="width:300;"></select></td>
											</tr>
											<tr>
												<td colspan="2"><textarea cols="65" rows="4">�� ������ ���䰹����� ������ �Է��ϼ���.
�ܴ��� ������ ��� ����� ������ ���� �� �ִ� ��찡 �����ϴ�. �������� ������ �� �ִ� �ܾ ��� �Է��Ͻø� ä���� �� �ڵ����� ����ó�� �˴ϴ�. 
���� ��� ������ '�ΰ�' �̶�� �ϸ� '���' �̶�� �ܾ �������� �����ȴٰ� �����Ǹ� ��� �Է��ϼ���.</textarea></td>
											</tr>
											<tr height="25">
												<td colspan="2">���� �Է� �ؽ�Ʈ �ڽ� ũ�� : <input type="text" class="input" name="ans_size<%=i+1%>" size="4" value="<%=ArrBoxSize[i]%>"></td>
											</tr>						
											<tr height="25">
												<td colspan="2">�� �޽��� : <input type="text" class="input" name="front_msg<%=i+1%>" size="43" value="<%=ArrFrontMsg[i]%>"></td>
											</tr>
											<tr height="25">
												<td colspan="2">�� �޽��� : <input type="text" class="input" name="back_msg<%=i+1%>" size="43" value="<%=ArrBackMsg[i]%>"></td>
											</tr>
										</table>
										<% } %>
									</td>
								</tr>
							<tr>
								<td width="500" valign="top" >
								<table width="100%" border="0">
								<tr>
									<td>�ܴ��� �Է� �ڽ� 1�ٿ� ǥ�ÿ��� : <input type="checkbox" name="yn_single_line" value="Y" <% if(yn_single_line.equals("Y")) { %>checked<% } %>></td>
								</tr>
								<tr>
									<td>������� ���� <input type="checkbox" name="yn_caorder" value="Y" <% if(yn_caorder.equals("Y")) { %>checked<% } %>>&nbsp;��ҹ��� ���� ���� <input type="checkbox" name="yn_case" value="Y" <% if(yn_case.equals("Y")) { %>checked<% } %>>&nbsp;���� ���� ���� <input type="checkbox" name="yn_blank" value="Y" <% if(yn_blank.equals("Y")) { %>checked<% } %>></td>
								</tr>
								<tr>
									<td>
										<textarea cols="65" rows="6">�� ������� 
������ 2�� �̻��� �������� ������ ������� �Է��ؾ� ���� ������ ������ ������ ������� �ش� �ܾ ��� ������ �������� ������ ������ �����ϴ� �ɼ��Դϴ�.
��)  ������ '����, ���' �̰�, '���� ���� ����' ���� �� ���  '���, ����' �� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.

�� ��ҹ��� ����
��������� ��� ��ҹ��ڸ� ������ ������ �����ϴ� �ɼ��Դϴ�.
��)  ������ 'eTEST' �̰�, '��ҹ��� ���� ����' ���� �� ���  'etest' �� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.

�� ���� ����
������ ���⸦ ������ ������ �����ϴ� �ɼ��Դϴ�.
��)  ������ '�ܴ��� ���� �Է�' �̰�, '���� ���� ����' ���� �� ��� '�ܴ������� �Է�' ���� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.			
										</textarea>
									</td>
								</tr>					
							</table>
						</td>			
					</tr>
					<% } else if(qtype.equals("5")) { %>
					<tr bgcolor="#FFFFFF">
						<td width="525" valign="top" colspan="2"><input type="checkbox" name="yn_practice" <% if(yn_practice.equals("Y")) { %> checked <% } %> value="Y"> <B>�Ǳ��� ������ ����</B><BR><BR><B>'�Ǳ��� ������ ����' �� üũ�ϸ� ������ ��������<BR>��� �Է��ϴ� �ڽ��� ��Ÿ���� �ʴ� ���·� �����˴ϴ�.</B></td>
					</tr>
					<% } %>
				</table>
				</div>
			</div>

			<!-- �ؼ� ���� -->
			<div style="display:;" id="id_explain">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>

				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">		
					<tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* �ؼ����</b></td>			
					</tr>
					<tr>
						<td width="500" height="600" valign="top">
						<textarea name="explain" rows="31" cols="65"><%=explain%></textarea>
						</td>
					</tr>
				</table>
			</div>
			<!-- �ؼ� ���� -->

			<!-- ��Ʈ ���� -->
			<div style="display:;" id="id_hint">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>

				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��Ʈ���</b></td>			
					</tr>
					<tr>
						<td width="500" height="600" valign="top">
						<textarea name="hint" rows="31" cols="65"><%=hint%></textarea>
						</td>
					</tr>
				</table>
			</div>
			<!-- ��Ʈ ���� -->

			<!-- ���� ���� -->
			<div style="display:;" id="id_refbody">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>

				<table border="0" width="95%" cellspacing="0" cellpadding="0" align="center">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left"><input type="button" value="�����ʱ�ȭ" onClick="q_refs_init();" class="form2">&nbsp;&nbsp;<input type="button" value="������������"  class="form2" onClick="q_refs();"></td>			
					</tr>
					<tr height="25">				
						<td bgcolor="FFFFFF" align="left">�����ڵ� : <input type="text" class="input" name="id_ref" size="57" value="<%=id_ref%>" readonly></td>
					</tr>
					<tr height="25">				
						<td bgcolor="FFFFFF" align="left">�������� : <input type="text" class="input" name="ref_name" size="57" value="<%=reftitle%>"></td>
					</tr>
					<tr height="10">				
						<td bgcolor="FFFFFF" align="left"></td>
					</tr>
					<tr>				
						<td width="500" height="600" valign="top">
						<textarea name="refbody" rows="28" cols="65"><%=refbody%></textarea>
						</td>
					</tr>	
				</table>
			</div>
			<!-- ���� ���� -->

			<!-- �������� ���� -->
			<div style="display:none;" id="id_infos">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>
				
				<table border="0" border="1" width="95%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��������</b></td>			
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">����</td>
						<td bgcolor="FFFFFF" align="left" width="35%"><input type="text" class="input" name="allotts" size="5" value="<%=allotting%>"> ��</td>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">��������</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="id_qtype" size="10" value="<%=qtype_msg%>" readonly></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" id="left">�����</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="excount" size="10" value="<%=excount%>" readonly></td>
						<td bgcolor="FFFFFF" align="right" id="left">�����</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="cacount" size="10" value="<%=cacount%>" readonly></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">���̵�</td>
						<td bgcolor="FFFFFF" align="left"><select name="id_difficulty1">
						<% for(int i=0; i<diffs.length; i++) { %>
						<option value="<%=diffs[i].getId_difficulty()%>" <%if(id_difficulty1.equals(diffs[i].getId_difficulty())) { %>selected<% } %>><%=diffs[i].getDifficulty()%></option>
						<% } %>
						</select></td>
						<td bgcolor="FFFFFF" align="right" id="left">�����뵵</td>
						<td bgcolor="FFFFFF" align="left"><select name="id_q_use">				
						<% for(int i=0; i<quse.length; i++) { %>
						<option value="<%=quse[i].getId_q_use()%>" <% if(id_q_use.equals(quse[i].getId_q_use())) { %>selected<% } %>><%=quse[i].getQ_use()%></option>
						<% } %>
						</select></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" id="left">����Ƚ��</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="make_cnt" size="10" value="0" value="<%=make_cnt%>" readonly></td>
						<td bgcolor="FFFFFF" align="right" id="left">1�ٿ� ǥ���� ���� ��</td>
						<td bgcolor="FFFFFF" align="left" ><input type="text" class="input" name="ex_rowcnt" size="10" value="<%=ex_rowcnt%>"></td>
					</tr>					
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">�˻�Ű����</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="find_kwd" size="50" value="<%=find_kwd%>"></td>
					</tr>					
				</table>
			</div>
			<!-- �������� ���� -->

			<!-- ��ó���� ���� -->
			<div style="display:none;" id="id_prints">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06.gif" style="cursor: pointer;"></div>

				<table border="0" border="1" width="95%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��ó����</b></td>			
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">��з�</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><select name="q_ks" style="width:300" onChange="get_standard_list(this.value);">
						<% if(rst == null) { %>
						<option value="">��� ��з� ����</option>
						<% } else { %>
						<option value="">��з��� �����ϼ���</option>						
						<%	 for(int i=0; i<rst.length; i++) { %>
								<option value="<%=rst[i].getId_standarda()%>" <%if(q_ks.equals(rst[i].getId_standarda())) {%>selected<%}%>><%=rst[i].getStandarda()%></option>
						<%	 }
						   }	
						%>
					</select></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">�Һз�</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><div id="div_standard">
						<select name="q_to" style="width:300">
							<option value=""></option>
						</select>
					</div></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">��ó</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_pub_comp" size="48" value="<%=src_pub_comp%>"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">��Ÿ</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><textarea name="src_misc" cols="47" rows="12"><%=src_misc%></textarea></td>
					</tr>
				</table>
			</div>
			<!-- ��ó���� ���� -->

		</td>
	</tr>	
</table>
</form>
</body>
</html>

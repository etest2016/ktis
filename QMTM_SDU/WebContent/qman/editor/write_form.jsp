<%
//******************************************************************************
//   ���α׷� : write_form.jsp
//   �� �� �� : �������� ��Ƽ�̵�� ���
//   ��    �� : �������� ��Ƽ�̵�� ���ȭ��
//   �� �� �� : r_difficulty, r_q_use, q_standard_a, q_standard_b
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.QuseUtil, qmtm.admin.etc.QuseBean, qmtm.tman.exam.RdifficultUtil, 
//              qmtm.tman.exam.RdifficultBean, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil 
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.QuseUtil, qmtm.admin.etc.QuseBean, qmtm.tman.exam.RdifficultUtil, qmtm.tman.exam.RdifficultBean, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = "-1"; } else { id_q_subject = id_q_subject.trim(); }	

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = "-1"; } else { id_q_chapter = id_q_chapter.trim(); }	

	String id_q_chapter2 = request.getParameter("id_q_chapter2");
	if (id_q_chapter2 == null) { id_q_chapter2 = "-1"; } else { id_q_chapter2 = id_q_chapter2.trim(); }	

	String id_q_chapter3 = request.getParameter("id_q_chapter3");
	if (id_q_chapter3 == null) { id_q_chapter3 = "-1"; } else { id_q_chapter3 = id_q_chapter3.trim(); }	

	String id_q_chapter4 = request.getParameter("id_q_chapter4");
	if (id_q_chapter4 == null) { id_q_chapter4 = "-1"; } else { id_q_chapter4 = id_q_chapter4.trim(); }	
	
	String qtype = request.getParameter("qtype");
	if (qtype == null) { qtype = "0"; } else { qtype = qtype.trim(); }	

	if (id_q_subject.length() == 0 || id_q_chapter.length() == 0 || id_q_chapter2.length() == 0 || id_q_chapter3.length() == 0 || id_q_chapter4.length() == 0 || qtype.length() == 0 ) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

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
		qtype_msg = "�����";
	}

	int excount = Integer.parseInt(request.getParameter("excount"));
	int cacount = Integer.parseInt(request.getParameter("cacount"));

	String multi_sel = "";

	if(cacount > 1) {
		multi_sel = "checkbox";
	} else {
		multi_sel = "radio";
	}

	int heights = 540;

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
%>

<html>
<head>
<title>�������</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=EUC-KR">
<link rel="StyleSheet" href="../../css/style_q.css" type="text/css">
<link rel="StyleSheet" href="tagfree.css" type="text/css">
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<script>
<!--

var qtype = "<%=qtype%>";
var excount = <%=excount%>;
var cacount = <%=cacount%>;

function OnSave()
{
	var form = document.writeForm;
	
	var str = document.twe.MimeValue();

	if(document.twe.textvalue.replace(/\s/g, "")==""){
         alert("������ ������ּ���.");
		 document.twe.SetFocus();
		 return;
    }

	form.mime_contents.value = str;

	if(qtype == "2" || qtype == "3") {
		if(excount == 3) {

			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();

			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    if(str2.length < 202) { 
					alert("1�� ���⸦ ������ּ���.");
					document.twe2.SetFocus();
					return;
				}
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    if(str3.length < 202) { 
					alert("2�� ���⸦ ������ּ���.");
					document.twe3.SetFocus();
					return;
				}
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    if(str4.length < 202) { 
					alert("3�� ���⸦ ������ּ���.");
					document.twe4.SetFocus();
					return;
				}
		    }

			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;

			form.mime_contents2_1.value = document.twe2.BodyValue2;
			form.mime_contents3_1.value = document.twe3.BodyValue2;
			form.mime_contents4_1.value = document.twe4.BodyValue2;
			
			form.temps2.value = document.twe2.GetLocalFiles; // �������� ��� ��������
			form.temps3.value = document.twe3.GetLocalFiles; // �������� ��� ��������
			form.temps4.value = document.twe4.GetLocalFiles; // �������� ��� ��������

		} else if(excount == 4) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();
			var str5 = document.twe5.MimeValue();
		
			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    if(str2.length < 202) {
					alert("1�� ���⸦ ������ּ���.");
					document.twe2.SetFocus();
					return;
				}
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
				if(str3.length < 202) {
					alert("2�� ���⸦ ������ּ���.");
					document.twe3.SetFocus();
					return;
				}
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
				if(str4.length < 202) {
					alert("3�� ���⸦ ������ּ���.");
					document.twe4.SetFocus();
					return;
				}
		    }

			if(document.twe5.textvalue.replace(/\s/g, "")==""){
				if(str5.length < 202) {
					alert("4�� ���⸦ ������ּ���.");
					document.twe5.SetFocus();
					return;
				}
		    }

			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
			form.mime_contents5.value = str5;

			form.mime_contents2_1.value = document.twe2.BodyValue2;
			form.mime_contents3_1.value = document.twe3.BodyValue2;
			form.mime_contents4_1.value = document.twe4.BodyValue2;
			form.mime_contents5_1.value = document.twe5.BodyValue2;

			form.temps2.value = document.twe2.GetLocalFiles; // �������� ��� ��������
			form.temps3.value = document.twe3.GetLocalFiles; // �������� ��� ��������
			form.temps4.value = document.twe4.GetLocalFiles; // �������� ��� ��������
			form.temps5.value = document.twe5.GetLocalFiles; // �������� ��� ��������

		} else if(excount == 5) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();
			var str5 = document.twe5.MimeValue();
			var str6 = document.twe6.MimeValue();
			
			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    if(str2.length < 202) {
					alert("1�� ���⸦ ������ּ���.");
					document.twe2.SetFocus();
					return;
				}
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    if(str3.length < 202) {
					alert("2�� ���⸦ ������ּ���.");
					document.twe3.SetFocus();
					return;
				}
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    if(str4.length < 202) {
					alert("3�� ���⸦ ������ּ���.");
					document.twe4.SetFocus();
					return;
				}
		    }

			if(document.twe5.textvalue.replace(/\s/g, "")==""){
			    if(str5.length < 202) {
					alert("4�� ���⸦ ������ּ���.");
					document.twe5.SetFocus();
					return;
				}
		    }

			if(document.twe6.textvalue.replace(/\s/g, "")==""){
			    if(str6.length < 202) {
					alert("5�� ���⸦ ������ּ���.");
					document.twe6.SetFocus();
					return;
				}
		    }
			
			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
			form.mime_contents5.value = str5;
			form.mime_contents6.value = str6;

			form.mime_contents2_1.value = document.twe2.BodyValue2;
			form.mime_contents3_1.value = document.twe3.BodyValue2;
			form.mime_contents4_1.value = document.twe4.BodyValue2;
			form.mime_contents5_1.value = document.twe5.BodyValue2;
			form.mime_contents6_1.value = document.twe6.BodyValue2;

			form.temps2.value = document.twe2.GetLocalFiles; // �������� ��� ��������
			form.temps3.value = document.twe3.GetLocalFiles; // �������� ��� ��������
			form.temps4.value = document.twe4.GetLocalFiles; // �������� ��� ��������
			form.temps5.value = document.twe5.GetLocalFiles; // �������� ��� ��������
			form.temps6.value = document.twe6.GetLocalFiles; // �������� ��� ��������
		
		} 
	} 

	if(qtype == "2" || qtype == "3") {

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

	var str10 = document.twe10.MimeValue();
	var str11 = document.twe11.MimeValue();
	var str12 = document.twe12.MimeValue();
	
	form.mime_contents10.value = str10;
	form.mime_contents11.value = str11;	
	form.mime_contents12.value = str12;
	form.submit();
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
	} else if(cacount == 6) {	
		if(obj == "1") {
			document.all.id_correct1.style.display = "block";		
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
		} else if(obj == "2") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "block";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
		} else if(obj == "3") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "block";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
		} else if(obj == "4") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "block";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
		} else if(obj == "5") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "block";
			document.all.id_correct6.style.display = "none";
		} else if(obj == "6") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "block";
		} 
	} else if(cacount == 7) {	
		if(obj == "1") {
			document.all.id_correct1.style.display = "block";		
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
			document.all.id_correct7.style.display = "none";
		} else if(obj == "2") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "block";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
			document.all.id_correct7.style.display = "none";
		} else if(obj == "3") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "block";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
			document.all.id_correct7.style.display = "none";
		} else if(obj == "4") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "block";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
			document.all.id_correct7.style.display = "none";
		} else if(obj == "5") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "block";
			document.all.id_correct6.style.display = "none";
			document.all.id_correct7.style.display = "none";
		} else if(obj == "6") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "block";
			document.all.id_correct7.style.display = "none";
		} else if(obj == "7") {
			document.all.id_correct1.style.display = "none";
			document.all.id_correct2.style.display = "none";
			document.all.id_correct3.style.display = "none";
			document.all.id_correct4.style.display = "none";
			document.all.id_correct5.style.display = "none";
			document.all.id_correct6.style.display = "none";
			document.all.id_correct7.style.display = "block";
		} 
	}
}

function inits() {
	
	resizeTo('1220','800');
	movieLayout("q");
	
	// �ܴ����ϰ��
	if(qtype == "4") {
		movieLayout2('1');
	}
}

function qtype_pop(){
	$.posterPopup("../question/q_qtype.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>&id_q_chapter2=<%=id_q_chapter2%>&id_q_chapter3=<%=id_q_chapter3%>&id_q_chapter4=<%=id_q_chapter4%>","QInsert","width=500,height=500,scrollbars=yes");
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

// ���� ���� ����...
function save_ref() {

	var frm = document.writeForm;

	var ref_name = frm.ref_name.value;
	var ref_body = document.twe12.MimeValue();	

	qs.onreadystatechange = save_ref_callback;
	qs.open("POST", "save_ref.jsp", true);
	qs.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=EUC-KR");
	qs.send("id_subject=<%=id_q_subject%>&ref_name="+ref_name+"&ref_body="+ref_body);
}

function save_ref_callback() {
	if(qs.readyState == 4) {
		if(qs.status == 200) {			
		}
    }
}

function q_refs() {
	$.posterPopup("q_ref_select.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_chapter2=<%=id_q_chapter2%>&id_chapter3=<%=id_q_chapter3%>&id_chapter4=<%=id_q_chapter4%>", "q_refs", "width=1100, height=600, scrollbars=yes");
}

function q_refs_init() {
	document.writeForm.id_ref.value = "0";
	document.writeForm.ref_name.value = "";
	document.writeForm.twe12.HtmlValue = "";
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
</head>

<body onLoad="inits();">

	<form name="writeForm" method="post" action="write.jsp">
	<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">
	<input type="hidden" name="id_q_chapter" value="<%=id_q_chapter%>">
	<input type="hidden" name="id_q_chapter2" value="<%=id_q_chapter2%>">
	<input type="hidden" name="id_q_chapter3" value="<%=id_q_chapter3%>">
	<input type="hidden" name="id_q_chapter4" value="<%=id_q_chapter4%>">

	<input type="hidden" name="qtype2" value="<%=qtype%>">
	<input type="hidden" name="excount2" value="<%=excount%>">
	<input type="hidden" name="cacount2" value="<%=cacount%>">

	<input type="hidden" name="mime_contents">
	<input type="hidden" name="mime_contents2">
	<input type="hidden" name="mime_contents3">
	<input type="hidden" name="mime_contents4">
	<input type="hidden" name="mime_contents5">
	<input type="hidden" name="mime_contents6">
	<input type="hidden" name="mime_contents10">
	<input type="hidden" name="mime_contents11">
	<input type="hidden" name="mime_contents12">

	<input type="hidden" name="mime_contents_1">
	<input type="hidden" name="mime_contents2_1">
	<input type="hidden" name="mime_contents3_1">
	<input type="hidden" name="mime_contents4_1">
	<input type="hidden" name="mime_contents5_1">
	<input type="hidden" name="mime_contents6_1">

	<input type="hidden" name="temps">
	<input type="hidden" name="temps2">
	<input type="hidden" name="temps3">
	<input type="hidden" name="temps4">
	<input type="hidden" name="temps5">
	<input type="hidden" name="temps6">

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
			<td align="right">
				<!--<img src="../../images/bt_editor2.gif" style="cursor:pointer;" onclick="javascript:qtype_pop()">--><img src="../../images/bt_editor8.gif" onclick="javascript:OnSave()" style="cursor:pointer;"><img src="../../images/bt_editor7.gif"  style="cursor:pointer;" onclick="javascript:window.close()">
			</td>				
		</tr>
	</table>

	<br>	

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top">
				<div style="height:32px; background-image: url(../../images/editor_newq.gif); background-repeat: no-repeat; padding: 6px 0px 0px 90px; font: bold 16px dotum; color: #000000;"></div>
				<table border="0" cellspacing="1" cellpadding="0" align="center" bgcolor="#CCCCCC">
					<tr>
						<td width="600" height="590" bgcolor="#FFFFFF">
						<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
						<script language="jscript" src="tweditor.js"></script>
						<!-- Active Designer �߰� �� -->
						</td>			
					</tr>
				</table>
			</td>
			<td width="20"></td>
			<td width="55%" align="left" valign="top" id="tableD" >

				<div id="id_q">
									
					<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>	
									
					<div style="overflow-y:scroll; height:600px;">
					
					<table border="0" width="100%" cellspacing="1" cellpadding="0" align="center" id="tableD">
						<% if(qtype.equals("1")) { %>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>
							<td width="100%" height="<%=200/2%>" valign="middle"><br>
							<font size="7"><b>O</b></font>
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="100%" height="<%=200/2%>" valign="middle"><br>
							<font size="7"><b>X</b></font>
							</td>
						</tr>
						<% 
							} else if(qtype.equals("2") || qtype.equals("3")) { 
								if(excount == 3) {
						%>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% } else if(excount == 4) { %>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor5.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% } else if(excount == 5) { %>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;��
							</td>
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor5.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr bgcolor="#FFFFFF">
							<td width="10" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;��
							</td>			
							<td width="100%" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor6.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>						
						<% 
								} 
							} else if(qtype.equals("4")) {
						%>
						<tr bgcolor="#FFFFFF">
							<td width="100%" valign="top" colspan="2">
							&nbsp;&nbsp;&nbsp;
									<% for(int i=0; i<cacount; i++) { %>
									<input type="button" value="����<%=i+1%>" onClick="movieLayout2('<%=i+1%>');" class="form">&nbsp;
									<% } %>
							
							</td>
						</tr>
								
								<tr>
									<td width="650" valign="top" colspan="2">
									<% for(int i=0; i<cacount; i++) { %>
									<table width="100%" border="0" style="display:none;" id="id_correct<%=i+1%>" cellpadding=0 cellspacing=0>
										<tr>											
												<td><input type="text" class="input" name="ans<%=i+1%>" size="78" onkeydown="moveFocus('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);"></td>
												<td rowspan="2" valign="top"><input type="button" value="�߰��ϱ�" onClick="adds('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);" class="form2"><br><input type="button" value="�����ϱ�" onClick="dels('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);" class="form2"><!--<br><input type="button" value="���� ���" onClick="up_move('<%=i+1%>');" class="form2"><br><input type="button" value="���� ���" onClick="down_move('<%=i+1%>');" class="form2">--></td>
											</tr>
											<tr>
												<td colspan="2"><select name="ans_list<%=i+1%>" multiple="multiple" size="5" style="width:478;"></select></td>
											</tr>
											
										<tr>
											<td colspan="2"><textarea cols="77" rows="5">�� ������ ���䰹����� ������ �Է��ϼ���.
�ܴ��� ������ ��� ����� ������ ���� �� �ִ� ��찡 �����ϴ�. �������� ������ �� �ִ� �ܾ ��� �Է��Ͻø� ä���� �� �ڵ����� ����ó�� �˴ϴ�. 
���� ��� ������ '�ΰ�' �̶�� �ϸ� '���' �̶�� �ܾ �������� �����ȴٰ� �����Ǹ� ��� �Է��ϼ���.</textarea></td>
										</tr>
										<tr height="25">
											<td colspan="2">���� �Է� �ؽ�Ʈ �ڽ� ũ�� : <input type="text" class="input" name="ans_size<%=i+1%>" size="5" value="20"></td>
										</tr>						
										<tr height="25">
											<td colspan="2">�� �޽��� : <input type="text" class="input" name="front_msg<%=i+1%>" size="68"></td>
										</tr>
										<tr height="25">
										<td colspan="2">�� �޽��� : <input type="text" class="input" name="back_msg<%=i+1%>" size="68"></td>
										</tr>
									</table>
									<% } %>
									</td>
								</tr>
										
								<tr>
									<td width="650" valign="top" >
									<table width="100%" border="0">
										<tr>
											<td>�ܴ��� �Է� �ڽ� 1�ٿ� ǥ�ÿ��� : <input type="checkbox" name="yn_single_line" value="Y"></td>
										</tr>
										<tr>
											<td align="left" width="100%">������� ���� <input type="checkbox" name="yn_caorder" value="Y">&nbsp;��ҹ��� ���� ���� <input type="checkbox" name="yn_case" value="Y">&nbsp;���� ���� ���� <input type="checkbox" name="yn_blank" value="Y"></td>
										</tr>
										<tr>
											<td align="left" width="100%"><textarea cols="77" rows="8">�� ������� 
������ 2�� �̻��� �������� ������ ������� �Է��ؾ� ���� ������ ������ ������ ������� �ش� �ܾ ��� ������ �������� ������ ������ �����ϴ� �ɼ��Դϴ�.
��)  ������ '����, ���' �̰�, '���� ���� ����' ���� �� ���  '���, ����' �� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.

�� ��ҹ��� ����
��������� ��� ��ҹ��ڸ� ������ ������ �����ϴ� �ɼ��Դϴ�.
��)  ������ 'eTEST' �̰�, '��ҹ��� ���� ����' ���� �� ���  'etest' �� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.

�� ���� ����
������ ���⸦ ������ ������ �����ϴ� �ɼ��Դϴ�.
��)  ������ '�ܴ��� ���� �Է�' �̰�, '���� ���� ����' ���� �� ��� '�ܴ������� �Է�' ���� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.</textarea>
											</td>
										</tr>				
									</table>
									</td>
								</tr>
								
							
					<% } else if(qtype.equals("5")) { %>
					<tr bgcolor="#FFFFFF">
						<td width="650" valign="top" colspan="2">&nbsp;</td>
					</tr>
					<% } %>
				</table>
				</div>
			</div>


			<div style="display:;" id="id_explain">
				<!-- �ؼ� ���� -->

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>

			
				<table border="0" width="100%" cellspacing="1" cellpadding="0" align="center" bgcolor="#CCCCCC">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* �ؼ����</b></td>			
					</tr-->
					<tr bgcolor="#FFFFFF">
						<td width="650" height="580">
						<script language="jscript" src="tweditor10.js"></script>
						</td>
					</tr>
				</table>
				<!-- �ؼ� ���� -->
			</div>

			<div style="display:;" id="id_hint">

				<!-- ��Ʈ ���� -->

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>


				<table border="0" width="100%" cellspacing="1" cellpadding="0" align="center" bgcolor="#CCCCCC">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��Ʈ���</b></td>			
					</tr-->
					<tr bgcolor="#FFFFFF">
						<td width="650" height="580">
						<script language="jscript" src="tweditor11.js"></script>
						</td>
					</tr>
				</table>
				<!-- ��Ʈ ���� -->
			</div>
				
			<div style="display:;" id="id_refbody">
				<!-- ���� ���� -->

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>


				<table border="0" border="0" width="95%" cellspacing="1" cellpadding="1" id="tableD" align="center">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left"><input type="button" value="�����ʱ�ȭ" onClick="q_refs_init();" class="form2">&nbsp;&nbsp;<input type="button" value="������������" onClick="q_refs();" class="form2"></td>			
					</tr>					
					<tr height="25">
						<td bgcolor="FFFFFF" align="left">&nbsp;�����ڵ� : <input type="text" class="input" name="id_ref" size="80" value="0" readonly></td>
					</tr>
					<tr height="25">
						<td bgcolor="FFFFFF" align="left">&nbsp;�������� : <input type="text" class="input" name="ref_name" size="80"></td>
					</tr>
					<tr height="10">				
						<td bgcolor="FFFFFF" align="left"></td>
					</tr>
					<tr>				
						<td width="600" height="470">
						<script language="jscript" src="tweditor12.js"></script>
						</td>
					</tr>	
				</table>
				<!-- ���� ���� -->
			</div>
				
			<div style="display:;" id="id_infos"> 

				<!-- �������� ���� -->
				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: pointer;"></div>


				<table border="0" border="1" width="95%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��������</b></td>			
					</tr-->
					<tr>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">����</td>
						<td bgcolor="FFFFFF" align="left" width="35%"><input type="text" class="input" name="allotts" size="5" value="1"> ��</td>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">��������</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="id_qtype" size="10" value="<%=qtype_msg%>" readonly></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">�����</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="excount" size="10" value="<%=excount%>" readonly></td>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">�����</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="cacount" size="10" value="<%=cacount%>" readonly></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">���̵�</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><select name="id_difficulty1">
						<% for(int i=0; i<diffs.length; i++) { %>
						<option value="<%=diffs[i].getId_difficulty()%>"><%=diffs[i].getDifficulty()%></option>
						<% } %>
						</select></td>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">�����뵵</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><select name="id_q_use">
						<% for(int i=0; i<quse.length; i++) { %>
						<option value="<%=quse[i].getId_q_use()%>"><%=quse[i].getQ_use()%></option>
						<% } %>
						</select></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">����Ƚ��</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="make_cnt" size="10" value="0" readonly></td>
						<td bgcolor="FFFFFF" align="right" id="left">1��ǥ�ú����</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="ex_rowcnt" size="10" value="1"></td>
					</tr>							
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">�˻�Ű����</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="find_kwd" size="76" style="font-family:Arial"></td>
					</tr>
				</table>
				<!-- �������� ���� -->
			</div>

			<div style="display:;" id="id_prints" >

				<!-- ��ó���� ���� -->
				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: pointer;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: pointer;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: pointer;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: pointer;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: pointer;"><img onClick="movieLayout('prints');" src="../../images/tabC06.gif" style="cursor: pointer;"></div>


				<table border="0" border="1" width="95%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��ó����</b></td>			
					</tr-->
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">������</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_book" size="45"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">���ڸ�</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_author" size="45"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">������</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="src_page" size="15"  maxlength="5"></td>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">���ǿ���</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><select name="src_pub_year">
						<% for(int i = 2013; i <= 2020; i++) { %>
						<option value="<%=i%>"><%=i%>��</option>
						<% } %>
						</select>
						</td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">��ó</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_pub_comp" size="72"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">���</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><textarea name="src_misc" cols="70" rows="12"></textarea></td>
					</tr>
				</table>
				<!-- ��ó���� ���� -->
			</div>
	
			</td>
		</tr>	
	</table>
</form>
</body></html>
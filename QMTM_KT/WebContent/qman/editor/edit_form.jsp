<%
//******************************************************************************
//   ���α׷� : edit_form.jsp
//   �� �� �� : �������� ����
//   ��    �� : �������� ����ȭ��
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-09-01
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,com.tagfree.util.*,org.w3c.tidy.*,org.w3c.dom.*, qmtm.*, qmtm.qman.editor.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*, qmtm.admin.etc.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_q.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	QBean bean = null;

	try {
		bean = QUtil.getBean(id_q);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String q = bean.getQ();
	String ex1 = QmTm.getReplace(QmTm.getNullChk(bean.getEx1()));
	String ex2 = QmTm.getReplace(QmTm.getNullChk(bean.getEx2()));
	String ex3 = QmTm.getReplace(QmTm.getNullChk(bean.getEx3()));
	String ex4 = QmTm.getReplace(QmTm.getNullChk(bean.getEx4()));
	String ex5 = QmTm.getReplace(QmTm.getNullChk(bean.getEx5()));	
	String ex6 = QmTm.getReplace(QmTm.getNullChk(bean.getEx6()));	
	String ex7 = QmTm.getReplace(QmTm.getNullChk(bean.getEx7()));	
	String ex8 = QmTm.getReplace(QmTm.getNullChk(bean.getEx8()));	
	String explain = QmTm.getReplace(QmTm.getNullChk(bean.getExplain()));
	String hint = QmTm.getReplace(QmTm.getNullChk(bean.getHint()));
	
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

	ca = ca.replaceAll("&amp;","&");
	ca = ca.replaceAll("&lt;","<");
	ca = ca.replaceAll("&gt;",">");

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
		src_pub_year = 2013;
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
	String reftitle = QmTm.getNullChk(bean.getReftitle());
	String refbody1 = QmTm.getReplace(QmTm.getNullChk(bean.getRefbody1()));
	String refbody2 = QmTm.getReplace(QmTm.getNullChk(bean.getRefbody2()));
	String refbody3 = QmTm.getReplace(QmTm.getNullChk(bean.getRefbody3()));

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
		qtype_msg = "������";
	}

	int make_cnt = bean.getMake_cnt();
	
	String multi_sel = "";

	if(cacount > 1) {
		multi_sel = "checkbox";
	} else {
		multi_sel = "radio";
	}

	int heights = 505;

	String[] ArrFrontMsg = new String[cacount];
	String[] ArrBackMsg = new String[cacount];
	String[] ArrBoxSize = new String[cacount];

	String msg_yn = "Y";

	if(qtype.equals("4")) {
		// �ܴ����ϰ�� �޽����� �������´�.(�Է»��� ����Ʈ, �� �޽���, �� �޽���..)		
		QMsgBean[] qmsg = null;

		try {
			qmsg = QUtil.getMsgBeans(id_q);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

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

	// �����뵵��� ����������
	QuseBean[] quse = null;

	try {
		quse = QuseUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	// ���̵� ���� ����������
	RdifficultBean[] diffs = null;

    try {
	    diffs = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<html>
<head>
<title>��������</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
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
	
	var str = document.twe.MimeValue();

	form.mime_contents.value = str;

	if(qtype == "2" || qtype == "3") {
		if(excount == 3) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();

			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    alert("1�� ���⸦ ������ּ���.");
			    document.twe2.SetFocus();
			    return;
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    alert("2�� ���⸦ ������ּ���.");
			    document.twe3.SetFocus();
			    return;
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    alert("3�� ���⸦ ������ּ���.");
			    document.twe4.SetFocus();
			    return;
		    }

			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
		} else if(excount == 4) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();
			var str5 = document.twe5.MimeValue();

			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    alert("1�� ���⸦ ������ּ���.");
			    document.twe2.SetFocus();
			    return;
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    alert("2�� ���⸦ ������ּ���.");
			    document.twe3.SetFocus();
			    return;
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    alert("3�� ���⸦ ������ּ���.");
			    document.twe4.SetFocus();
			    return;
		    }

			if(document.twe5.textvalue.replace(/\s/g, "")==""){
			    alert("4�� ���⸦ ������ּ���.");
			    document.twe5.SetFocus();
			    return;
		    }

			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
			form.mime_contents5.value = str5;
		} else if(excount == 5) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();
			var str5 = document.twe5.MimeValue();
			var str6 = document.twe6.MimeValue();

			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    alert("1�� ���⸦ ������ּ���.");
			    document.twe2.SetFocus();
			    return;
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    alert("2�� ���⸦ ������ּ���.");
			    document.twe3.SetFocus();
			    return;
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    alert("3�� ���⸦ ������ּ���.");
			    document.twe4.SetFocus();
			    return;
		    }

			if(document.twe5.textvalue.replace(/\s/g, "")==""){
			    alert("4�� ���⸦ ������ּ���.");
			    document.twe5.SetFocus();
			    return;
		    }

			if(document.twe6.textvalue.replace(/\s/g, "")==""){
			    alert("5�� ���⸦ ������ּ���.");
			    document.twe6.SetFocus();
			    return;
		    }
			
			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
			form.mime_contents5.value = str5;
			form.mime_contents6.value = str6;
		} else if(excount == 6) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();
			var str5 = document.twe5.MimeValue();
			var str6 = document.twe6.MimeValue();
			var str7 = document.twe7.MimeValue();

			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    alert("1�� ���⸦ ������ּ���.");
			    document.twe2.SetFocus();
			    return;
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    alert("2�� ���⸦ ������ּ���.");
			    document.twe3.SetFocus();
			    return;
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    alert("3�� ���⸦ ������ּ���.");
			    document.twe4.SetFocus();
			    return;
		    }

			if(document.twe5.textvalue.replace(/\s/g, "")==""){
			    alert("4�� ���⸦ ������ּ���.");
			    document.twe5.SetFocus();
			    return;
		    }

			if(document.twe6.textvalue.replace(/\s/g, "")==""){
			    alert("5�� ���⸦ ������ּ���.");
			    document.twe6.SetFocus();
			    return;
		    }

			if(document.twe7.textvalue.replace(/\s/g, "")==""){
			    alert("6�� ���⸦ ������ּ���.");
			    document.twe7.SetFocus();
			    return;
		    }
			
			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
			form.mime_contents5.value = str5;
			form.mime_contents6.value = str6;
			form.mime_contents7.value = str7;
		} else if(excount == 7) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();
			var str5 = document.twe5.MimeValue();
			var str6 = document.twe6.MimeValue();
			var str7 = document.twe7.MimeValue();
			var str8 = document.twe8.MimeValue();

			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    alert("1�� ���⸦ ������ּ���.");
			    document.twe2.SetFocus();
			    return;
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    alert("2�� ���⸦ ������ּ���.");
			    document.twe3.SetFocus();
			    return;
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    alert("3�� ���⸦ ������ּ���.");
			    document.twe4.SetFocus();
			    return;
		    }

			if(document.twe5.textvalue.replace(/\s/g, "")==""){
			    alert("4�� ���⸦ ������ּ���.");
			    document.twe5.SetFocus();
			    return;
		    }

			if(document.twe6.textvalue.replace(/\s/g, "")==""){
			    alert("5�� ���⸦ ������ּ���.");
			    document.twe6.SetFocus();
			    return;
		    }

			if(document.twe7.textvalue.replace(/\s/g, "")==""){
			    alert("6�� ���⸦ ������ּ���.");
			    document.twe7.SetFocus();
			    return;
		    }

			if(document.twe8.textvalue.replace(/\s/g, "")==""){
			    alert("7�� ���⸦ ������ּ���.");
			    document.twe8.SetFocus();
			    return;
		    }

			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
			form.mime_contents5.value = str5;
			form.mime_contents6.value = str6;
			form.mime_contents7.value = str7;
			form.mime_contents8.value = str8;
		} else if(excount == 8) {
			var str2 = document.twe2.MimeValue();
			var str3 = document.twe3.MimeValue();
			var str4 = document.twe4.MimeValue();
			var str5 = document.twe5.MimeValue();
			var str6 = document.twe6.MimeValue();
			var str7 = document.twe7.MimeValue();
			var str8 = document.twe8.MimeValue();
			var str9 = document.twe9.MimeValue();

			if(document.twe2.textvalue.replace(/\s/g, "")==""){
			    alert("1�� ���⸦ ������ּ���.");
			    document.twe2.SetFocus();
			    return;
		    }

			if(document.twe3.textvalue.replace(/\s/g, "")==""){
			    alert("2�� ���⸦ ������ּ���.");
			    document.twe3.SetFocus();
			    return;
		    }

			if(document.twe4.textvalue.replace(/\s/g, "")==""){
			    alert("3�� ���⸦ ������ּ���.");
			    document.twe4.SetFocus();
			    return;
		    }

			if(document.twe5.textvalue.replace(/\s/g, "")==""){
			    alert("4�� ���⸦ ������ּ���.");
			    document.twe5.SetFocus();
			    return;
		    }

			if(document.twe6.textvalue.replace(/\s/g, "")==""){
			    alert("5�� ���⸦ ������ּ���.");
			    document.twe6.SetFocus();
			    return;
		    }

			if(document.twe7.textvalue.replace(/\s/g, "")==""){
			    alert("6�� ���⸦ ������ּ���.");
			    document.twe7.SetFocus();
			    return;
		    }

			if(document.twe8.textvalue.replace(/\s/g, "")==""){
			    alert("7�� ���⸦ ������ּ���.");
			    document.twe8.SetFocus();
			    return;
		    }

			if(document.twe9.textvalue.replace(/\s/g, "")==""){
			    alert("8�� ���⸦ ������ּ���.");
			    document.twe9.SetFocus();
			    return;
		    }
			
			form.mime_contents2.value = str2;
			form.mime_contents3.value = str3;
			form.mime_contents4.value = str4;
			form.mime_contents5.value = str5;
			form.mime_contents6.value = str6;
			form.mime_contents7.value = str7;
			form.mime_contents8.value = str8;
			form.mime_contents9.value = str9;
		} 
	} 

	if(id_qtype > 1 && id_qtype < 4) {

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
	
	form.mime_contents9.value = str9;
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
	}
}

function inits() {

	var ArrCa = new Array();
	var ArrCa2 = new Array();

	var frm = document.writeForm;
	
	resizeTo('1020','740');

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
	window.open("../question/q_static_view.jsp?id_q=<%=id_q%>","q_static","width=850, height=650 scrollbars=auto");	
}

function q_preview() {
	window.open("../question/q_preview.jsp?id_qs=<%=id_q%>","preview_q","top=0, left=0, width=800, height=640, scrollbars=yes");
}

function q_refs() {
	window.open("q_ref_select.jsp?id_subject=<%=id_subject%>", "q_refs", "width=1100, height=600, scrollbars=yes");
}

function q_refs_init() {
	document.writeForm.id_ref.value = "0";
	document.writeForm.ref_name.value = "";
	document.writeForm.twe12.HtmlValue = "";
}

-->
</script>

<script language="JScript" FOR="twe" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe.HtmlValue = form.mime_contents.value;
</script>

<script language="JScript" FOR="twe2" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe2.HtmlValue = form.mime_contents2.value;
</script>

<script language="JScript" FOR="twe3" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe3.HtmlValue = form.mime_contents3.value;
</script>

<script language="JScript" FOR="twe4" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe4.HtmlValue = form.mime_contents4.value;
</script>

<script language="JScript" FOR="twe5" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe5.HtmlValue = form.mime_contents5.value;
</script>

<script language="JScript" FOR="twe6" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe6.HtmlValue = form.mime_contents6.value;
</script>

<script language="JScript" FOR="twe7" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe7.HtmlValue = form.mime_contents7.value;
</script>

<script language="JScript" FOR="twe8" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe8.HtmlValue = form.mime_contents8.value;
</script>

<script language="JScript" FOR="twe9" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe9.HtmlValue = form.mime_contents9.value;
</script>

<script language="JScript" FOR="twe10" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe10.HtmlValue = form.mime_contents10.value;
</script>

<script language="JScript" FOR="twe11" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe11.HtmlValue = form.mime_contents11.value;
</script>

<script language="JScript" FOR="twe12" EVENT="OnControlInit()">
	var form = document.writeForm;
	form.twe12.HtmlValue = form.mime_contents12.value;
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

	<form name="writeForm" method="post" action="edit.jsp">
	
	<input type="hidden" name="id_qs" value="<%=id_q%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">
	
	<input type="hidden" name="qtype2" value="<%=qtype%>">
	<input type="hidden" name="excount2" value="<%=excount%>">
	<input type="hidden" name="cacount2" value="<%=cacount%>">

	<input type="hidden" name="mime_contents" value="<%=q%>">
	<input type="hidden" name="mime_contents2" value="<%=ex1%>">
	<input type="hidden" name="mime_contents3" value="<%=ex2%>">
	<input type="hidden" name="mime_contents4" value="<%=ex3%>">
	<input type="hidden" name="mime_contents5" value="<%=ex4%>">
	<input type="hidden" name="mime_contents6" value="<%=ex5%>">
	<input type="hidden" name="mime_contents7" value="<%=ex6%>">
	<input type="hidden" name="mime_contents8" value="<%=ex7%>">
	<input type="hidden" name="mime_contents9" value="<%=ex8%>">
	<input type="hidden" name="mime_contents10" value="<%=explain%>">
	<input type="hidden" name="mime_contents11" value="<%=hint%>">
	<input type="hidden" name="mime_contents12" value="<%=refbody.toString()%>">

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
				<img src="../../images/bt_editor3.gif" onClick='q_preview();'><a href="javascript:" onclick="window.open('../question/incorrect.jsp?id_q=<%=id_q%>&id_qtype=<%=qtype%>&ca=<%=ca%>&excount=<%=excount%>&cacount=<%=cacount%>&id_valid_type=<%=id_valid_type%>','q_incorrect','width=750, height=500')" style="cursor: hand;"><img src="../../images/bt_editor4.gif" ></a><img src="../../images/bt_editor5.gif" onclick="javascript:q_static();" style="cursor: ha nd;"></td>
			<td align="right"><% if(id_valid_type > 0) { %><img src="../../images/bt_editor6.gif" onClick="alert('���� ���� �Ǵ� ��� ����ó�� �� ������ ������ �� �����ϴ�.\n\n�ش� ������ �̿��Ͻ÷��� ���׺��� �� ����Ͻñ� �ٶ��ϴ�.');" style="cursor: hand;"><% } else { %><img src="../../images/bt_editor6.gif" onclick="OnSave();" style="cursor: hand;"><% } %><img src="../../images/bt_editor7.gif" onclick="javascript:window.close()" style="cursor: hand;"></td>
		</tr>
	</table>

	<br>	

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top">
				<div style="height:32px; background-image: url(../../images/editor_newq.gif); background-repeat: no-repeat; padding: 6px 0px 0px 90px; font: bold 16px dotum; color: #000000;">�����ڵ� : <%=id_q%>&nbsp;-&nbsp;<%=valid_types%>&nbsp;(<%=make_cnt%>ȸ ����)</div>
				<table border="0">
					<tr>
						<td width="500" height="550">
						<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
						<script language="jscript" src="tweditor.js"></script>
						<!-- Active Designer �߰� �� -->
						</td>			
					</tr>
				</table>
			</td>
			<td width="20"></td>
			<td width="500" align="left" valign="top" bgcolor="ffffff">
				
				<div id="id_q">

					<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>			
					
					<div style="overflow-y:scroll; height:520px;">

					<table border="0" width="97%" align="center">
						<% if(qtype.equals("1")) { %>
						<tr>
							<td width="25" height="<%=200/2%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1" <%if(ca.equals("1")) { %>checked<% } %>>&nbsp;��
							</td>
							<td width="500" height="<%=200/2%>" valign="top">
								&nbsp;&nbsp;<br><font size="7"><b>O</b></font>
							</td>
						</tr>
						<tr>
							<td width="15" height="<%=200/2%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2" <%if(ca.equals("2")) { %>checked<% } %>>&nbsp;��
							</td>
							<td width="500" height="<%=200/2%>"  valign="top"><br>
							<font size="7"><b>X</b></font>
							</td>
						</tr>
						<% 
							} else if(qtype.equals("2") || qtype.equals("3")) { 
								if(excount == 3) {
						%>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% } else if(excount == 4) { %>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor5.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% } else if(excount == 5) { %>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor5.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor6.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% } else if(excount == 6) { %>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor5.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor6.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="6">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor7.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% } else if(excount == 7) { %>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor5.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor6.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="6">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor7.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="7">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor8.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% } else if(excount == 8) { %>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor2.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor3.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor4.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor5.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor6.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="6">&nbsp;��
							</td>
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor7.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="7">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor8.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<tr>
							<td width="25" height="<%=heights/excount%>" valign="top">
								<input type="<%=multi_sel%>" name="corrects" value="8">&nbsp;��
							</td>			
							<td width="500" height="<%=heights/excount%>">
							<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->
							<script language="jscript" src="tweditor9.js"></script>
							<!-- Active Designer �߰� �� -->
							</td>
						</tr>
						<% 
								} 
							} else if(qtype.equals("4")) {
						%>
						<tr>
							<td width="525" valign="top" colspan="2">
								<table width="100%" border="0">
									<tr>
										<td align="left" width="80%">
										<% for(int i=0; i<cacount; i++) { %>
										<input type="button" value="����<%=i+1%>" onClick="movieLayout2('<%=i+1%>');">&nbsp;
										<% } %>
										</td>
									</tr>
									<tr>
										<td>
										<% for(int i=0; i<cacount; i++) { %>
										<table width="100%" border="0" style="display:none;" id="id_correct<%=i+1%>">
											<tr>
												<td>
													<table width="100%" border="0">
														<tr>
															<td><input type="text" class="input" name="ans<%=i+1%>" size="52"></td>
															<td rowspan="2" valign="top"><input type="button" value="�߰��ϱ�" onClick="adds('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);"><br><input type="button" value="�����ϱ�" onClick="dels('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);"><br><input type="button" value="���� ���" onClick="up_move('<%=i+1%>');"><br><input type="button" value="���� ���" onClick="down_move('<%=i+1%>');"></td>
														</tr>
														<tr>
															<td ><select name="ans_list<%=i+1%>" multiple="multiple" size="7" style="width:375;"></select></td>
														</tr>
													</table>
																			
												</td>
											</tr>
											<tr>
												<td><textarea cols="65" rows="5">�� ������ ���䰹����� ������ �Է��ϼ���.<BR>
					�ܴ��� ������ ��� ����� ������ ���� �� �ִ� ��찡 �����ϴ�. �������� ������ �� �ִ� �ܾ ��� �Է��Ͻø� ä���� �� �ڵ����� ����ó�� �˴ϴ�.<BR> 
					���� ��� ������ '�ΰ�' �̶�� �ϸ� '���' �̶�� �ܾ �������� �����ȴٰ� �����Ǹ� ��� �Է��ϼ���.</textarea></td>
											</tr>
											<tr height="30">
												<td>���� �Է� �ؽ�Ʈ �ڽ� ũ�� : <input type="text" class="input" name="ans_size<%=i+1%>" size="4" value="<%=ArrBoxSize[i]%>"></td>
											</tr>						
											<tr height="30">
												<td>�� �޽��� : <input type="text" class="input" name="front_msg<%=i+1%>" size="43" value="<%=ArrFrontMsg[i]%>"></td>
											</tr>
											<tr height="30">
												<td>�� �޽��� : <input type="text" class="input" name="back_msg<%=i+1%>" size="43" value="<%=ArrBackMsg[i]%>"></td>
											</tr>
										</table>
										<% } %>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="yn_single_line" value="Y" <% if(yn_single_line.equals("Y")) { %>checked<% } %>>&nbsp;�ܴ��� �Է� �ڽ� 1�ٿ� ǥ�ÿ���</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="yn_caorder" value="Y" <% if(yn_caorder.equals("Y")) { %>checked<% } %>>&nbsp;������� ����&nbsp;&nbsp; <input type="checkbox" name="yn_case" value="Y" <% if(yn_case.equals("Y")) { %>checked<% } %>>&nbsp;��ҹ��� ���� ����&nbsp;&nbsp;<input type="checkbox" name="yn_blank" value="Y" <% if(yn_blank.equals("Y")) { %>checked<% } %>>&nbsp;���� ���� ����</td>
								</tr>
								<tr>
									<td>
										<textarea cols="65" rows="10">�� �������<BR> 
			������ 2�� �̻��� �������� ������ ������� �Է��ؾ� ���� ������ ������ ������ ������� �ش� �ܾ ��� ������ �������� ������ ������ �����ϴ� �ɼ��Դϴ�.<BR>
			��)  ������ '����, ���' �̰�, '���� ���� ����' ���� �� ���  '���, ����' �� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.<BR><BR><BR>�� ��ҹ��� ����<BR>
			��������� ��� ��ҹ��ڸ� ������ ������ �����ϴ� �ɼ��Դϴ�.<BR>
			��)  ������ 'eTEST' �̰�, '��ҹ��� ���� ����' ���� �� ���  'etest' �� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.<BR><BR><BR>
			�� ���� ����<BR>
			������ ���⸦ ������ ������ �����ϴ� �ɼ��Դϴ�.<BR>
			��)  ������ '�ܴ��� ���� �Է�' �̰�, '���� ���� ����' ���� �� ��� '�ܴ������� �Է�' ���� ����� �����ϸ� Ʋ�� ������� ä���� �˴ϴ�.
										</textarea>
									</td>
								</tr>					
							</table>
						</td>			
					</tr>
					<% } else if(qtype.equals("5")) { %>
					<tr>
						<td width="525" valign="top" colspan="2"></td>
					</tr>
					<% } %>
				</table>
				</div>
			</div>

			<!-- �ؼ� ���� -->
			<div style="display:;" id="id_explain">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>

				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">		
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* �ؼ����</b></td>			
					</tr-->
					<tr>
						<td width="500" height="520"><script language="jscript" src="tweditor10.js"></script></td>
					</tr>
				</table>
			</div>
			<!-- �ؼ� ���� -->

			<!-- ��Ʈ ���� -->
			<div style="display:;" id="id_hint">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>

				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��Ʈ���</b></td>			
					</tr-->
					<tr>
						<td width="500" height="520">
						<script language="jscript" src="tweditor11.js"></script>
						</td>
					</tr>
				</table>
			</div>
			<!-- ��Ʈ ���� -->

			<!-- ���� ���� -->
			<div style="display:;" id="id_refbody">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>

				<table border="0" width="95%" cellspacing="0" cellpadding="0" align="center">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left"><input type="button" value="�����ʱ�ȭ" onClick="q_refs_init();">&nbsp;&nbsp;<input type="button" value="������������" onClick="q_refs();"></td>			
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
						<td width="500" height="480">
						<script language="jscript" src="tweditor12.js"></script>
						</td>
					</tr>	
				</table>
			</div>
			<!-- ���� ���� -->

			<!-- �������� ���� -->
			<div style="display:none;" id="id_infos">

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>
				
				<table border="0" border="1" width="95%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��������</b></td>			
					</tr-->
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

				<div class="tab"><!-------�� ����---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06.gif" style="cursor: hand;"></div>


				<table border="0" border="1" width="90%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* ��ó����</b></td>			
					</tr-->
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">������</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_book" size="45" value="<%=src_book%>"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">���ڸ�</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_author" size="45" value="<%=src_author%>"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">������</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="src_page" size="15" value="<%=src_page%>" maxlength="5"></td>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">���ǿ���</td>
						<td bgcolor="FFFFFF" align="left" width="30%"><select name="src_pub_year">
						<% for(int i = 2013; i <= 2020; i++) { %>
						<option value="<%=i%>" <%if(src_pub_year == i) { %> selected <% } %>><%=i%>��</option>
						<% } %>
						</select>
						</td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">���ǻ�</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_pub_comp" size="45" value="<%=src_pub_comp%>"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">��Ÿ</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><textarea name="src_misc" cols="45" rows="12"><%=src_misc%></textarea></td>
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

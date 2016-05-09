<%
//******************************************************************************
//   프로그램 : edit_form_text.jsp
//   모 듈 명 : 개별문제 수정
//   설    명 : 개별문제 수정화면
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-09-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*, qmtm.*, qmtm.qman.editor.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*, qmtm.admin.etc.*" %>

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
		valid_types = "<font color='blue'>정상문제</font>";
	} else if(id_valid_type == 1) {
		valid_types = "<font color='red'>정답오류로 처리</font>";
	} else if(id_valid_type == 2) {
		valid_types = "<font color='red'>모두정답처리</font>";
	}

	String id_q_use = String.valueOf(bean.getId_q_use());
	String q_use_detail = QmTm.getNullChk(bean.getQ_use_detail());
	int ex_rowcnt = bean.getEx_rowcnt();
	String yn_single_line = QmTm.getNullChk(bean.getYn_single_line());	
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
		qtype_msg = "OX형";
	} else if(qtype.equals("2")) {
		qtype_msg = "선다형";
	} else if(qtype.equals("3")) {
		qtype_msg = "복수답안형";
	} else if(qtype.equals("4")) {
		qtype_msg = "단답형";
	} else if(qtype.equals("5")) {
		qtype_msg = "논술형";
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
		// 단답형일경우 메시지를 가지고온다.(입력상자 사이트, 앞 메시지, 뒷 메시지..)		
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

	// 문제용도목록 가지고오기
	QuseBean[] quse = null;

	try {
		quse = QuseUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	// 난이도 정보 가지고오기
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
<title>문제수정</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=euc-kr">
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
		 alert("문제를 등록해주세요.");
		 form.q.focus();
		 return;
    }

	if(qtype == "2" || qtype == "3") {
		if(excount == 3) {
			var str2 = form.ex1.value;
			var str3 = form.ex2.value;
			var str4 = form.ex3.value;

			if(str2.replace(/\s/g, "")==""){
			    alert("보기 1번을 등록해주세요.");
			    form.ex1.focus();
			    return;
		    }

			if(str3.replace(/\s/g, "")==""){
			    alert("보기 2번을 등록해주세요.");
			    form.ex2.focus();
			    return;
		    }

			if(str4.replace(/\s/g, "")==""){
			    alert("보기 3번을 등록해주세요.");
			    form.ex3.focus();
			    return;
		    }

		} else if(excount == 4) {
			var str2 = form.ex1.value;
			var str3 = form.ex2.value;
			var str4 = form.ex3.value;
			var str5 = form.ex4.value;

			if(str2.replace(/\s/g, "")==""){
			    alert("보기 1번을 등록해주세요.");
			    form.ex1.focus();
			    return;
		    }

			if(str3.replace(/\s/g, "")==""){
			    alert("보기 2번을 등록해주세요.");
			    form.ex2.focus();
			    return;
		    }

			if(str4.replace(/\s/g, "")==""){
			    alert("보기 3번을 등록해주세요.");
			    form.ex3.focus();
			    return;
		    }

			if(str5.replace(/\s/g, "")==""){
			    alert("보기 4번을 등록해주세요.");
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
			    alert("보기 1번을 등록해주세요.");
			    form.ex1.focus();
			    return;
		    }

			if(str3.replace(/\s/g, "")==""){
			    alert("보기 2번을 등록해주세요.");
			    form.ex2.focus();
			    return;
		    }

			if(str4.replace(/\s/g, "")==""){
			    alert("보기 3번을 등록해주세요.");
			    form.ex3.focus();
			    return;
		    }

			if(str5.replace(/\s/g, "")==""){
			    alert("보기 4번을 등록해주세요.");
			    form.ex4.focus();
			    return;
		    }

			if(str6.replace(/\s/g, "")==""){
			    alert("보기 5번을 등록해주세요.");
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
			alert("정답을 체크하세요.");
			return;
		}

		if(checkCnt != cacount) {
			alert("현재 선택한 정답 갯수는 " + checkCnt + " 개 입니다.\n\n 정답을 " + cacount + " 개 선택하셔야 합니다.");
			return;
		}
	}
		
	form.submit();
}

// 메뉴별로 페이지 보여주기..
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
	
	resizeTo('1020','750');

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

		// 단답형 답안이 여러개 일경우..
		if(cacount > 1) {

			ArrCa = ca.split("{|}");
			
			for(var i = 0; i < ArrCa.length; i++) {
				ArrCa2 = ArrCa[i].split("{^}");
				for(var j = 0; j < ArrCa2.length; j++) {
					adds(i+1, ArrCa2[j]);
				}
			}

		} else { // 단답형 답안이 한개 일경우..

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
	window.open("q_ref_select.jsp?id_subject=<%=id_subject%>", "q_refs", "width=950, height=600, scrollbars=yes");
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
		scrollbar-face-color: #ededea; /*기본색상*/
		scrollbar-highlight-color: #FFFFFF; /*상단 및 좌측 하일라이트*/
		scrollbar-3dlight-color: #f0f0f0; /*상단 및 좌측 색상*/
		scrollbar-shadow-color: #cccdc7; /*하단 및 우측 로우라이트*/
		scrollbar-darkshadow-color: #f0f0f0; /*하단 및 우측 색상*/
		scrollbar-track-color: #fafafa; /*배경색상*/
		scrollbar-arrow-color: #a8a798; /*화살표색상*/
	}
	.tab { width: 100%; background-image: url(../../images/bg_editor_tab.gif); background-repeat: repeat-x; height: 32px; }
	
</style>
</head>

<body onLoad="inits();">

	<form name="writeForm" method="post" action="edit_text.jsp">
	
	<input type="hidden" name="id_qs" value="<%=id_q%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">
	
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
				<a href="javascript:q_preview();" border="0"><img src="../../images/bt_editor3.gif"></a><a href="javascript:" onclick="window.open('../question/incorrect.jsp?id_q=<%=id_q%>&id_qtype=<%=qtype%>&ca=<%=ca%>&excount=<%=excount%>&cacount=<%=cacount%>&id_valid_type=<%=id_valid_type%>','q_incorrect','width=750, height=500')" style="cursor: hand;"><img src="../../images/bt_editor4.gif" ></a><a href="javascript:q_static();" border="0"><img src="../../images/bt_editor5.gif" ></a></td>
			<td align="right"><% if(id_valid_type > 0) { %><img src="../../images/bt_editor6.gif" onClick="alert('정답 오류 또는 모두 정답처리 된 문항은 수정할 수 없습니다.\n\n해당 문항을 이용하시려면 문항복사 후 사용하시기 바랍니다.');" style="cursor: hand;"><% } else { %><img src="../../images/bt_editor6.gif" onclick="OnSave();" style="cursor: hand;"><% } %><img src="../../images/bt_editor7.gif" onclick="javascript:window.close()" style="cursor: hand;"></td>
		</tr>
	</table>

	<br>	

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top">
				<div style="height:32px; background-image: url(../../images/editor_newq.gif); background-repeat: no-repeat; padding: 6px 0px 0px 90px; font: bold 16px dotum; color: #000000;">문제코드 : <%=id_q%>&nbsp;-&nbsp;<%=valid_types%>&nbsp;(<%=make_cnt%>회 출제)</div>
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

					<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>			
					
					<div style="overflow-y:scroll; height:520px;">

					<table border="0" width="97%" cellspacing="0" cellpadding="3" id="tableD" align="center">
						<% if(qtype.equals("1")) { %>
						<tr>
							<td width="85" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1" <%if(ca.equals("1")) { %>checked<% } %>>&nbsp;보기 ①
							</td>
							<td width="400" height="<%=200/2%>" valign="middle" align="left">
								&nbsp;&nbsp;<br><font size="7"><b>O</b></font>
							</td>
						</tr>
						<tr>
							<td width="85" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2" <%if(ca.equals("2")) { %>checked<% } %>>&nbsp;보기 ②
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
							<td width="145" height="<%=230/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;보기 ①
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex1" cols="56" rows="4" style="font-family:Arial"><%=ex1%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=230/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;보기 ②
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex2" cols="56" rows="4" style="font-family:Arial"><%=ex2%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=230/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3" >&nbsp;보기 ③
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex3" cols="56" rows="4" style="font-family:Arial"><%=ex3%></textarea>
							</td>
						</tr>
						<% } else if(excount == 4) { %>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;보기 ①
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex1" cols="56" rows="4" style="font-family:Arial"><%=ex1%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;보기 ②
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex2" cols="56" rows="4" style="font-family:Arial"><%=ex2%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;보기 ③
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex3" cols="56" rows="4" style="font-family:Arial"><%=ex3%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;보기 ④
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex4" cols="56" rows="4" style="font-family:Arial"><%=ex4%></textarea>
							</td>
						</tr>
						<% } else if(excount == 5) { %>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;보기 ①
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex1" cols="56" rows="4" style="font-family:Arial"><%=ex1%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;보기 ②
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex2" cols="56" rows="4" style="font-family:Arial"><%=ex2%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;보기 ③
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex3" cols="56" rows="4" style="font-family:Arial"><%=ex3%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;보기 ④
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex4" cols="56" rows="4" style="font-family:Arial"><%=ex4%></textarea>
							</td>
						</tr>
						<tr>
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;보기 ⑤
							</td>
							<td width="340" height="30" valign="top">
								<textarea name="ex5" cols="56" rows="4" style="font-family:Arial"><%=ex5%></textarea>
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
										<input type="button" value="정답<%=i+1%>" onClick="movieLayout2('<%=i+1%>');">&nbsp;
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
															<td rowspan="2" valign="top"><input type="button" value="추가하기" onClick="adds('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);"><br><input type="button" value="삭제하기" onClick="dels('<%=i+1%>',document.writeForm.ans<%=i+1%>.value);"><br><input type="button" value="순서 ▲로" onClick="up_move('<%=i+1%>');"><br><input type="button" value="순서 ▼로" onClick="down_move('<%=i+1%>');"></td>
														</tr>
														<tr>
															<td ><select name="ans_list<%=i+1%>" multiple="multiple" size="7" style="width:375;"></select></td>
														</tr>
													</table>
																			
												</td>
											</tr>
											<tr>
												<td><textarea cols="65" rows="5">※ 설정한 정답갯수대로 정답을 입력하세요.
					단답형 문제의 경우 비슷한 정답이 여러 개 있는 경우가 많습니다. 정답으로 인정될 수 있는 단어를 모두 입력하시면 채점할 때 자동으로 정답처리 됩니다. 
					예를 들어 정답이 '인간' 이라고 하면 '사람' 이라는 단어도 정답으로 인정된다고 생각되면 모두 입력하세요.</textarea></td>
											</tr>
											<tr height="30">
												<td>정답 입력 텍스트 박스 크기 : <input type="text" class="input" name="ans_size<%=i+1%>" size="4" value="<%=ArrBoxSize[i]%>"></td>
											</tr>						
											<tr height="30">
												<td>앞 메시지 : <input type="text" class="input" name="front_msg<%=i+1%>" size="43" value="<%=ArrFrontMsg[i]%>"></td>
											</tr>
											<tr height="30">
												<td>뒷 메시지 : <input type="text" class="input" name="back_msg<%=i+1%>" size="43" value="<%=ArrBackMsg[i]%>"></td>
											</tr>
										</table>
										<% } %>
									</td>
								</tr>
								<tr>
									<td>단답형 입력 박스 1줄에 표시여부 : <input type="checkbox" name="yn_single_line" value="Y" <% if(yn_single_line.equals("Y")) { %>checked<% } %>></td>
								</tr>
								<tr>
									<td>정답순서 있음 <input type="checkbox" name="yn_caorder" value="Y" <% if(yn_caorder.equals("Y")) { %>checked<% } %>>&nbsp;대소문자 구분 있음 <input type="checkbox" name="yn_case" value="Y" <% if(yn_case.equals("Y")) { %>checked<% } %>>&nbsp;띄어쓰기 구분 있음 <input type="checkbox" name="yn_blank" value="Y" <% if(yn_blank.equals("Y")) { %>checked<% } %>></td>
								</tr>
								<tr>
									<td>
										<textarea cols="65" rows="10">※ 정답순서 
			정답이 2개 이상인 문제에서 정답을 순서대로 입력해야 정답 인정할 것인지 순서와 관계없이 해당 단어가 들어 있으면 정답으로 인정할 것인지 설정하는 옵션입니다.
			예)  정답이 '국가, 기업' 이고, '정답 순서 있음' 으로 할 경우  '기업, 국가' 로 답안을 제출하면 틀린 답안으로 채점이 됩니다.

			※ 대소문자 구분
			영문답안일 경우 대소문자를 구분할 것인지 설정하는 옵션입니다.
			예)  정답이 'eTEST' 이고, '대소문자 구분 있음' 으로 할 경우  'etest' 로 답안을 제출하면 틀린 답안으로 채점이 됩니다.

			※ 띄어쓰기 구분
			정답의 띄어쓰기를 구분할 것인지 설정하는 옵션입니다.
			예)  정답이 '단답형 정답 입력' 이고, '띄어쓰기 구분 있음' 으로 할 경우 '단답형정답 입력' 으로 답안을 제출하면 틀린 답안으로 채점이 됩니다.			
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

			<!-- 해설 시작 -->
			<div style="display:;" id="id_explain">

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>

				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">		
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 해설등록</b></td>			
					</tr-->
					<tr>
						<td width="500" height="600" valign="top">
						<textarea name="explain" rows="35" cols="65"><%=explain%></textarea>
						</td>
					</tr>
				</table>
			</div>
			<!-- 해설 종료 -->

			<!-- 힌트 시작 -->
			<div style="display:;" id="id_hint">

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>

				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 힌트등록</b></td>			
					</tr-->
					<tr>
						<td width="500" height="600" valign="top">
						<textarea name="hint" rows="35" cols="65"><%=hint%></textarea>
						</td>
					</tr>
				</table>
			</div>
			<!-- 힌트 종료 -->

			<!-- 지문 시작 -->
			<div style="display:;" id="id_refbody">

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>

				<table border="0" width="95%" cellspacing="0" cellpadding="0" align="center">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left"><input type="button" value="지문초기화" onClick="q_refs_init();">&nbsp;&nbsp;<input type="button" value="기존지문선택" onClick="q_refs();"></td>			
					</tr>
					<tr height="25">				
						<td bgcolor="FFFFFF" align="left">지문코드 : <input type="text" class="input" name="id_ref" size="57" value="<%=id_ref%>" readonly></td>
					</tr>
					<tr height="25">				
						<td bgcolor="FFFFFF" align="left">지문제목 : <input type="text" class="input" name="ref_name" size="57" value="<%=reftitle%>"></td>
					</tr>
					<tr height="10">				
						<td bgcolor="FFFFFF" align="left"></td>
					</tr>
					<tr>				
						<td width="500" height="500" valign="top">
						<textarea name="refbody" rows="30" cols="65"><%=refbody%></textarea>
						</td>
					</tr>	
				</table>
			</div>
			<!-- 지문 종료 -->

			<!-- 문제정보 시작 -->
			<div style="display:none;" id="id_infos">

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>
				
				<table border="0" border="1" width="95%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 문제정보</b></td>			
					</tr-->
					<tr>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">배점</td>
						<td bgcolor="FFFFFF" align="left" width="35%"><input type="text" class="input" name="allotts" size="5" value="<%=allotting%>"> 점</td>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">문제유형</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="id_qtype" size="10" value="<%=qtype_msg%>" readonly></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" id="left">보기수</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="excount" size="10" value="<%=excount%>" readonly></td>
						<td bgcolor="FFFFFF" align="right" id="left">정답수</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="cacount" size="10" value="<%=cacount%>" readonly></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">난이도</td>
						<td bgcolor="FFFFFF" align="left"><select name="id_difficulty1">
						<% for(int i=0; i<diffs.length; i++) { %>
						<option value="<%=diffs[i].getId_difficulty()%>" <%if(id_difficulty1.equals(diffs[i].getId_difficulty())) { %>selected<% } %>><%=diffs[i].getDifficulty()%></option>
						<% } %>
						</select></td>
						<td bgcolor="FFFFFF" align="right" id="left">문제용도</td>
						<td bgcolor="FFFFFF" align="left"><select name="id_q_use">				
						<% for(int i=0; i<quse.length; i++) { %>
						<option value="<%=quse[i].getId_q_use()%>" <% if(id_q_use.equals(quse[i].getId_q_use())) { %>selected<% } %>><%=quse[i].getQ_use()%></option>
						<% } %>
						</select></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" id="left">출제횟수</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="make_cnt" size="10" value="0" value="<%=make_cnt%>" readonly></td>
						<td bgcolor="FFFFFF" align="right" id="left">1줄에 표시할 보기 수</td>
						<td bgcolor="FFFFFF" align="left" ><input type="text" class="input" name="ex_rowcnt" size="10" value="<%=ex_rowcnt%>"></td>
					</tr>					
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">검색키워드</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="find_kwd" size="50" value="<%=find_kwd%>"></td>
					</tr>
					
				</table>
			</div>
			<!-- 문제정보 종료 -->

			<!-- 출처정보 시작 -->
			<div style="display:none;" id="id_prints">

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06.gif" style="cursor: hand;"></div>


				<table border="0" border="1" width="90%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 출처정보</b></td>			
					</tr-->
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">도서명</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_book" size="45" value="<%=src_book%>"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">저자명</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_author" size="45" value="<%=src_author%>"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">페이지</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="src_page" size="15" value="<%=src_page%>" maxlength="5"></td>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">출판연도</td>
						<td bgcolor="FFFFFF" align="left" width="30%"><select name="src_pub_year">
						<% for(int i = 2013; i <= 2020; i++) { %>
						<option value="<%=i%>" <%if(src_pub_year == i) { %> selected <% } %>><%=i%>년</option>
						<% } %>
						</select>
						</td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">출판사</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_pub_comp" size="45" value="<%=src_pub_comp%>"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">기타</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><textarea name="src_misc" cols="45" rows="12"><%=src_misc%></textarea></td>
					</tr>
				</table>
			</div>
			<!-- 출처정보 종료 -->

		</td>
	</tr>	
</table>
</form>
</body>
</html>

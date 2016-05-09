<%
//******************************************************************************
//   프로그램 : write_form_text.jsp
//   모 듈 명 : 개별문제 등록
//   설    명 : 개별문제 등록화면
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2010-06-23
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*, java.util.*, qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*, qmtm.admin.etc.*, etest.* " %>

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
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

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

	int excount = Integer.parseInt(request.getParameter("excount"));
	int cacount = Integer.parseInt(request.getParameter("cacount"));

	String multi_sel = "";

	if(cacount > 1) {
		multi_sel = "checkbox";
	} else {
		multi_sel = "radio";
	}

	int heights = 590;

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
<title>문제등록</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=euc-kr">
<link rel="StyleSheet" href="../../css/style_q.css" type="text/css">
<link rel="StyleSheet" href="tagfree.css" type="text/css">
<script>
<!--

var qtype = "<%=qtype%>";
var excount = <%=excount%>;
var cacount = <%=cacount%>;

function OnSave()
{

	var form = document.writeForm;
	
	if(form.q.value.replace(/\s/g, "")=="") {
		 alert("문제를 등록해주세요.");
		 form.q.focus();
		 return;
	}

	if(qtype == "2" || qtype == "3") {
		if(excount == 3) {
			
			if(form.ex1.value.replace(/\s/g, "")=="") {
				alert("1번 보기를 등록해주세요.");
				form.ex1.focus();
				return;
		    }

			if(form.ex2.value.replace(/\s/g, "")=="") {
				alert("2번 보기를 등록해주세요.");
				form.ex2.focus();
				return;
		    }

			if(form.ex3.value.replace(/\s/g, "")=="") {
				alert("3번 보기를 등록해주세요.");
				form.ex3.focus();
				return;
		    }			
			
		} else if(excount == 4) {
			
			if(form.ex1.value.replace(/\s/g, "")=="") {
				alert("1번 보기를 등록해주세요.");
				form.ex1.focus();
				return;
		    }

			if(form.ex2.value.replace(/\s/g, "")=="") {
				alert("2번 보기를 등록해주세요.");
				form.ex2.focus();
				return;
		    }

			if(form.ex3.value.replace(/\s/g, "")=="") {
				alert("3번 보기를 등록해주세요.");
				form.ex3.focus();
				return;
		    }			

			if(form.ex4.value.replace(/\s/g, "")=="") {
				alert("4번 보기를 등록해주세요.");
				form.ex4.focus();
				return;
		    }			

		} else if(excount == 5) {
			
			if(form.ex1.value.replace(/\s/g, "")=="") {
				alert("1번 보기를 등록해주세요.");
				form.ex1.focus();
				return;
		    }

			if(form.ex2.value.replace(/\s/g, "")=="") {
				alert("2번 보기를 등록해주세요.");
				form.ex2.focus();
				return;
		    }

			if(form.ex3.value.replace(/\s/g, "")=="") {
				alert("3번 보기를 등록해주세요.");
				form.ex3.focus();
				return;
		    }			

			if(form.ex4.value.replace(/\s/g, "")=="") {
				alert("4번 보기를 등록해주세요.");
				form.ex4.focus();
				return;
		    }

			if(form.ex5.value.replace(/\s/g, "")=="") {
				alert("5번 보기를 등록해주세요.");
				form.ex5.focus();
				return;
		    }

		} 
	} 

	if(qtype == "1" || qtype == "2" || qtype == "3") {

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
	} else if(obj == "hint") {
	    document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "block";
		document.all.id_refbody.style.display = "none";
		document.all.id_infos.style.display = "none";
		document.all.id_prints.style.display = "none";
	} else if(obj == "refbody") {
	    document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "none";
		document.all.id_refbody.style.display = "block";
		document.all.id_infos.style.display = "none";
		document.all.id_prints.style.display = "none";
	} else if(obj == "infos") {
	    document.all.id_q.style.display = "none";
		document.all.id_explain.style.display = "none";
		document.all.id_hint.style.display = "none";
		document.all.id_refbody.style.display = "none";
		document.all.id_infos.style.display = "block";
		document.all.id_prints.style.display = "none";
	} else if(obj == "prints") {
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
	
	resizeTo('1020','750');
	movieLayout("q");
	
	// 단답형일경우
	if(qtype == "4") {
		movieLayout2('1');
	}
}

function qtype_pop(){
	window.open("../question/q_qtype.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>&id_q_chapter2=<%=id_q_chapter2%>&id_q_chapter3=<%=id_q_chapter3%>&id_q_chapter4=<%=id_q_chapter4%>","QInsert","width=500,height=500,scrollbars=yes");
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

// 지문 별도 저장...
function save_ref() {

	var frm = document.writeForm;

	var ref_name = frm.ref_name.value;
	var ref_body = document.twe12.MimeValue();	

	qs.onreadystatechange = save_ref_callback;
	qs.open("POST", "save_ref.jsp", true);
	qs.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
	qs.send("id_subject=<%=id_q_subject%>&ref_name="+ref_name+"&ref_body="+ref_body);
}

function save_ref_callback() {
	if(qs.readyState == 4) {
		if(qs.status == 200) {			
		}
    }
}

function q_refs() {
	window.open("q_ref_select.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_chapter2=<%=id_q_chapter2%>&id_chapter3=<%=id_q_chapter3%>&id_chapter4=<%=id_q_chapter4%>", "q_refs", "width=950, height=600, scrollbars=yes");
}

function q_refs_init() {
	document.writeForm.id_ref.value = "0";
	document.writeForm.ref_name.value = "";
	document.writeForm.refbody.value = "";
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

	<form name="writeForm" method="post" action="write_text.jsp">
	<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">
	<input type="hidden" name="id_q_chapter" value="<%=id_q_chapter%>">
	<input type="hidden" name="id_q_chapter2" value="<%=id_q_chapter2%>">
	<input type="hidden" name="id_q_chapter3" value="<%=id_q_chapter3%>">
	<input type="hidden" name="id_q_chapter4" value="<%=id_q_chapter4%>">

	<input type="hidden" name="qtype2" value="<%=qtype%>">
	<input type="hidden" name="excount2" value="<%=excount%>">
	<input type="hidden" name="cacount2" value="<%=cacount%>">
	
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
				<!--<img src="../../images/bt_editor2.gif" style="cursor:hand;" onclick="javascript:qtype_pop()">--><img src="../../images/bt_editor8.gif" onclick="javascript:OnSave()" style="cursor:hand;"><img src="../../images/bt_editor7.gif"  style="cursor:hand;" onclick="javascript:window.close()">
			</td>				
		</tr>
	</table>

	<br>	

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top">
				<div style="height:32px; background-image: url(../../images/editor_newq.gif); background-repeat: no-repeat; padding: 6px 0px 0px 90px; font: bold 16px dotum; color: #000000;"></div>
				<table border="0">
					<tr>
						<td width="500" height="600" valign="top">						
						<textarea name="q" rows="35" cols="65" style="ime-mode:active;"></textarea>						
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
						<tr >
							<td width="85" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;보기 ①
							</td>
							<td width="400" height="<%=200/2%>" valign="middle" align="left"><br>
							<font size="7"><b>O</b></font>
							</td>
						</tr>
						<tr >
							<td width="85" height="<%=200/2%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;보기 ②
							</td>
							<td width="400" height="<%=200/2%>" valign="middle" align="left"><br>
							<font size="7"><b>X</b></font>
							</td>
						</tr>
						<% 
							} else if(qtype.equals("2") || qtype.equals("3")) { 
								if(excount == 3) {
						%>
						<tr >
							<td width="145" height="<%=230/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;보기 ①
							</td>			
							<td width="340" height="30" valign="top">							
								<textarea name="ex1" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=230/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;보기 ②
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex2" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=230/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;보기 ③
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex3" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<% } else if(excount == 4) { %>
						<tr >
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;보기 ①
							</td>			
							<td width="340" height="30" valign="top">							
								<textarea name="ex1" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;보기 ②
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex2" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;보기 ③
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex3" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=300/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;보기 ④
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex4" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>						
						<% } else if(excount == 5) { %>
						<tr >
							<td width="145" height="<%=380/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="1">&nbsp;보기 ①
							</td>			
							<td width="340" height="30" valign="top">							
								<textarea name="ex1" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=380/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="2">&nbsp;보기 ②
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex2" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=380/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="3">&nbsp;보기 ③
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex3" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						<tr >
							<td width="145" height="<%=380/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="4">&nbsp;보기 ④
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex4" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>			
						<tr >
							<td width="145" height="<%=380/excount%>" valign="middle">
								<input type="<%=multi_sel%>" name="corrects" value="5">&nbsp;보기 ⑤
							</td>
							<td width="340" height="30" valign="top">							
								<textarea name="ex5" cols="56" rows="4" style="ime-mode:active;"></textarea>
							</td>
						</tr>
						
						<% 
								} 
							} else if(qtype.equals("4")) {
						%>
						<tr bgcolor="#FFFFFF">
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
											<td>정답 입력 텍스트 박스 크기 : <input type="text" class="input" name="ans_size<%=i+1%>" size="4" value="20"></td>
										</tr>						
										<tr height="30">
											<td>앞 메시지 : <input type="text" class="input" name="front_msg<%=i+1%>" size="43"></td>
										</tr>
										<tr height="30">
											<td>뒷 메시지 : <input type="text" class="input" name="back_msg<%=i+1%>" size="43"></td>
										</tr>
										</table>
										<% } %>
										</td>
									</tr>
									<tr>
										<td>단답형 입력 박스 1줄에 표시여부 : <input type="checkbox" name="yn_single_line" value="Y"></td>
									</tr>
									<tr>
										<td>정답순서 있음 <input type="checkbox" name="yn_caorder" value="Y">&nbsp;대소문자 구분 있음 <input type="checkbox" name="yn_case" value="Y">&nbsp;띄어쓰기 구분 있음 <input type="checkbox" name="yn_blank" value="Y"></td>
									</tr>
									<tr>
										<td><textarea cols="65" rows="10">※ 정답순서 
				정답이 2개 이상인 문제에서 정답을 순서대로 입력해야 정답 인정할 것인지 순서와 관계없이 해당 단어가 들어 있으면 정답으로 인정할 것인지 설정하는 옵션입니다.
				예)  정답이 '국가, 기업' 이고, '정답 순서 있음' 으로 할 경우  '기업, 국가' 로 답안을 제출하면 틀린 답안으로 채점이 됩니다.

				※ 대소문자 구분
				영문답안일 경우 대소문자를 구분할 것인지 설정하는 옵션입니다.
				예)  정답이 'eTEST' 이고, '대소문자 구분 있음' 으로 할 경우  'etest' 로 답안을 제출하면 틀린 답안으로 채점이 됩니다.

				※ 띄어쓰기 구분
				정답의 띄어쓰기를 구분할 것인지 설정하는 옵션입니다.
				예)  정답이 '단답형 정답 입력' 이고, '띄어쓰기 구분 있음' 으로 할 경우 '단답형정답 입력' 으로 답안을 제출하면 틀린 답안으로 채점이 됩니다.</textarea>
									</td>
								</tr>					
							</table>
						</td>			
					</tr>
					<% } else if(qtype.equals("5")) { %>
					<tr bgcolor="#FFFFFF">
						<td width="525" valign="top" colspan="2"></td>
					</tr>
					<% } %>
				</table>
				</div>
			</div>


			<div style="display:;" id="id_explain">
				<!-- 해설 시작 -->

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>

			
				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">		
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 해설등록</b></td>			
					</tr-->
					<tr bgcolor="#FFFFFF">
						<td width="500" height="600" valign="top">
						<textarea name="explain" rows="35" cols="65" style="ime-mode:active;"></textarea>
						</td>
					</tr>
				</table>
				<!-- 해설 종료 -->
			</div>

			<div style="display:;" id="id_hint">

				<!-- 힌트 시작 -->

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>


				<table border="0" border="0" width="100%" cellspacing="0" cellpadding="10">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 힌트등록</b></td>			
					</tr-->
					<tr bgcolor="#FFFFFF">
						<td width="500" height="600" valign="top">
						<textarea name="hint" rows="35" cols="65" style="ime-mode:active;"></textarea>
						</td>
					</tr>
				</table>
				<!-- 힌트 종료 -->
			</div>
				
			<div style="display:;" id="id_refbody">
				<!-- 지문 시작 -->

				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>


				<table border="0" border="0" width="95%" cellspacing="0" cellpadding="0" align="center">
					<tr height="30">
						<td bgcolor="FFFFFF" align="left"><input type="button" value="지문초기화" onClick="q_refs_init();">&nbsp;&nbsp;<input type="button" value="기존지문선택" onClick="q_refs();"></td>			
					</tr>					
					<tr height="25">
						<td bgcolor="FFFFFF" align="left">&nbsp;지문코드 : <input type="text" class="input" name="id_ref" size="57" value="0" readonly></td>
					</tr>
					<tr height="25">
						<td bgcolor="FFFFFF" align="left">&nbsp;지문제목 : <input type="text" class="input" name="ref_name" size="57" style="ime-mode:active;"></td>
					</tr>
					<tr height="10">				
						<td bgcolor="FFFFFF" align="left"></td>
					</tr>
					<tr>				
						<td width="500" height="500" valign="top">
						<textarea name="refbody" rows="30" cols="65" style="ime-mode:active;"></textarea>
						</td>
					</tr>	
				</table>
				<!-- 지문 종료 -->
			</div>
				
			<div style="display:;" id="id_infos"> 

				<!-- 문제정보 시작 -->
				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06_.gif" style="cursor: hand;"></div>


				<table border="0" border="1" width="95%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 문제정보</b></td>			
					</tr-->
					<tr>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">배점</td>
						<td bgcolor="FFFFFF" align="left" width="35%"><input type="text" class="input" name="allotts" size="5" value="1"> 점</td>
						<td bgcolor="FFFFFF" align="right" width="20%" id="left">문제유형</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="id_qtype" size="10" value="<%=qtype_msg%>" readonly></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">보기수</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="excount" size="10" value="<%=excount%>" readonly></td>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">정답수</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="cacount" size="10" value="<%=cacount%>" readonly></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">난이도</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><select name="id_difficulty1">
						<% for(int i=0; i<diffs.length; i++) { %>
						<option value="<%=diffs[i].getId_difficulty()%>"><%=diffs[i].getDifficulty()%></option>
						<% } %>
						</select></td>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">문제용도</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><select name="id_q_use">
						<% for(int i=0; i<quse.length; i++) { %>
						<option value="<%=quse[i].getId_q_use()%>"><%=quse[i].getQ_use()%></option>
						<% } %>
						</select></td>
					</tr>
					<tr>						
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">출제횟수</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="make_cnt" size="10" value="0" readonly></td>
						<td bgcolor="FFFFFF" align="right" id="left">1줄표시보기수</td>
						<td bgcolor="FFFFFF" align="left"><input type="text" class="input" name="ex_rowcnt" size="10" value="1"></td>
					</tr>							
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">검색키워드</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="find_kwd" size="60" style="font-family:Arial"></td>
					</tr>
				</table>
				<!-- 문제정보 종료 -->
			</div>

			<div style="display:;" id="id_prints" >

				<!-- 출처정보 시작 -->
				<div class="tab"><!-------텝 영역---------><img onClick="movieLayout('q');" src="../../images/tabC01_.gif" style="cursor: hand;"><img onClick="movieLayout('explain');" src="../../images/tabC02_.gif" style="cursor: hand;"><img onClick="movieLayout('hint');" src="../../images/tabC03_.gif" style="cursor: hand;"><img onClick="movieLayout('refbody');" src="../../images/tabC04_.gif" style="cursor: hand;"><img onClick="movieLayout('infos')" src="../../images/tabC05_.gif" style="cursor: hand;"><img onClick="movieLayout('prints');" src="../../images/tabC06.gif" style="cursor: hand;"></div>


				<table border="0" border="1" width="90%" cellspacing="0" cellpadding="3" id="tableD" align="center">
					<!--tr height="30">
						<td bgcolor="FFFFFF" align="left" colspan="4"><b>* 출처정보</b></td>			
					</tr-->
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">도서명</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_book" size="45"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">저자명</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_author" size="45"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">페이지</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><input type="text" class="input" name="src_page" size="15"  maxlength="5"></td>
						<td bgcolor="FFFFFF" align="right" width="22%" id="left">출판연도</td>
						<td bgcolor="FFFFFF" align="left" width="28%"><select name="src_pub_year">
						<% for(int i = 2013; i <= 2020; i++) { %>
						<option value="<%=i%>"><%=i%>년</option>
						<% } %>
						</select>
						</td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">출판사</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><input type="text" class="input" name="src_pub_comp" size="45"></td>
					</tr>
					<tr>
						<td bgcolor="FFFFFF" align="right" id="left">기타</td>
						<td bgcolor="FFFFFF" align="left" colspan="3"><textarea name="src_misc" cols="45" rows="12"></textarea></td>
					</tr>
				</table>
				<!-- 출처정보 종료 -->
			</div>
	
			</td>
		</tr>	
	</table>
</form>

</body>
</html>
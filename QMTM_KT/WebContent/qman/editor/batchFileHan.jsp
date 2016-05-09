<%
//******************************************************************************
//   프로그램 : batchFile.jsp
//   모 듈 명 : 일괄문제 등록
//   설    명 : 일괄문제 등록화면
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2010-06-18
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,com.tagfree.util.*,org.w3c.tidy.*,org.w3c.dom.*, qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*, qmtm.admin.etc.*" %>

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

	if (id_q_subject.length() == 0 || id_q_chapter.length() == 0 || id_q_chapter2.length() == 0 || id_q_chapter3.length() == 0 || id_q_chapter4.length() == 0 || qtype.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<html>
<head>
<title>문제일괄등록</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=euc-kr">
<link rel="StyleSheet" href="../../css/style_q.css" type="text/css">
<link rel="StyleSheet" href="../../css/button_q.css" type="text/css">
<link rel="StyleSheet" href="tagfree.css" type="text/css">
<script>
<!--

var arrId_ref = new Array();
var arrId_refs = new Array();
var arrQ = new Array();
var arrQs = new Array();
var arrEx1 = new Array();
var arrEx2 = new Array();
var arrEx3 = new Array();
var arrEx4 = new Array();
var arrEx5 = new Array();
var arrCa = new Array();
var arrExplain = new Array();
var arrHint = new Array();
var arrDifficulty = new Array();
var arrQtype = new Array();
var arrExcount = new Array();
var arrCacount = new Array();
var arrResult = new Array();
var arrPattern = new Array();

var arrQchk = new Array();

var arrImsi = new Array();

var ArrRefNoAll = new Array();
var ArrRefTitleAll = new Array();
var ArrRefContentAll = new Array();

var ref, ref_sel; // 지문패턴
var q1, q2, q3, q4; // 문제패턴
var e1, e2, e3, e4; // 보기패턴
var c1, c2, c4, ca_ptn; // 정답패턴
var p1, p2, p4, explain_ptn; // 해설패턴
var h1, h2, h4, hint_ptn; // 힌트패턴
var d1, d2, d4, diff_ptn; // 난이도패턴

var explain_sel, hint_sel, diff_sel; // 패턴적용유무

var qcounts; // 문항수

var refNoAll = "";
var refTitleAll = "";
var refContentAll = "";

function trim(str) {
	str = str.replace(/(^\s*)|(\s*$)/g,"");
	
	return str;
}

function parser() 
{	
	var form = document.writeForm;
	
	if(form.qcounts.value.length == 0) {
		alert("일괄등록할 문항수를 입력하셔야 합니다.");
		form.qcounts.focus();
		return;
	}

	if(form.pattern_yn.value == "N") {
		alert("패턴적용을 하셔야만 저장하실 수 있습니다.\n\n원본문서에 대해서 패턴설정 메뉴를 통해서\n\n패턴을 적용하신후 이용하시기 바랍니다.");
		return;
	}

	var message = confirm("*******************************주의*******************************\n\n반드시 작업결과화면에서 문항별로 패턴적용이 되었는지 확인하셔야 합니다.\n\n문항별로 패턴적용이 정상적으로 되지 않았을경우에는 문제일괄등록이 되지 않습니다.\n\n\n문제 일괄등록하시려면 확인을 문항을 검수하시려면 취소를 클릭하세요.");

	if(!message) {
		return;
	}
	
	var strs = document.twe13.MimeValue();

	form.mime_contents2.value = strs;
	
	var source = document.twe13.BodyValue2;
	
	document.writeForm.mime_contents.value = source;
	
	document.writeForm.submit();

}

function ref_dels(strs) {

    var form = document.writeForm;
	  
	// 지문패턴
	refs = form.ref_gubun.value;
	refs2 = form.ref_gubun2.value; 	

	var no1 = "";
	var no2 = "";

	var strTitle = "";
	var strContent = "";

	var str2 = "";

	var str = "";
	
	if(ref_sel) {
		if(strs.indexOf(refs) == -1) {
			str = "";
		} else {
			str = strs.substring(strs.lastIndexOf(refs),strs.indexOf(refs2)+1);
		}
	} 

	if(str != "") {
		no1 = str.substring(str.lastIndexOf("(")+1,str.indexOf("~"));
		no2 = str.substring(str.lastIndexOf("~")+1,str.indexOf(")"));

		str2 = strs.substring(0,strs.indexOf(refs));
	} else {
		if(strs.indexOf(refs) == -1) {
			str2 = strs;
		} else {
			str2 = strs.substring(0, strs.indexOf(refs));
		}
	}

	if(no1 != "") {
		
		strTitle = str.substring(1,str.indexOf("(")).replaceAll("\r\n","<BR>");
		strContent = strs.substring(strs.lastIndexOf(refs2)+1).replaceAll("\r\n","<BR>");

		for(var k=parseInt(no1);k<=parseInt(no2);k++) {
			if(k == parseInt(no2)) {
				refNoAll += k;
			} else {
				refNoAll += k + "{:}";
			}
		}

		refNoAll += "{^}";
		refTitleAll += removeBR(strTitle) + "{^}";
		refContentAll += removeBR(strContent) + "{^}";

	}
	
	return str2;
}

function blank_remove(s,q1,q2,str1,str2) {

	var str = s;

	for(var k=0;k<=100;k++) {

		str = str.replace(q1+""+str1+k+""+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+k+"   "+q2, q1+str1+q4);

		str = str.replace(q1+" "+str1+k+""+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+k+"   "+q2, q1+str1+q4);

		str = str.replace(q1+"  "+str1+k+""+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+k+"   "+q2, q1+str1+q4);


		
		str = str.replace(q1+""+str1+" "+k+""+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+" "+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+" "+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+" "+k+"   "+q2, q1+str1+q4);

		str = str.replace(q1+" "+str1+" "+k+""+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+" "+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+" "+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+" "+k+"   "+q2, q1+str1+q4);

		str = str.replace(q1+"  "+str1+" "+k+""+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+" "+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+" "+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+" "+k+"   "+q2, q1+str1+q4);



		str = str.replace(q1+""+str1+"  "+k+""+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+"  "+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+"  "+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+""+str1+"  "+k+"   "+q2, q1+str1+q4);

		str = str.replace(q1+" "+str1+"  "+k+""+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+"  "+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+"  "+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+" "+str1+"  "+k+"   "+q2, q1+str1+q4);

		str = str.replace(q1+"  "+str1+"  "+k+""+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+"  "+k+" "+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+"  "+k+"  "+q2, q1+str1+q4);
		str = str.replace(q1+"  "+str1+"  "+k+"   "+q2, q1+str1+q4);

	}

	return str;
}

function OnSave()
{		
	var form = document.writeForm;
	
	if(form.qcounts.value.length == 0) {
		alert("일괄등록할 문항수를 입력하셔야 합니다.");
		form.qcounts.focus();
		return;
	}

	movieLayout('div_1');

	Show_LayerProgressBar(true);
	
	var bigos = confirm("해당 문서에 패턴을 적용합니다.\n\n패턴 설정이 원본문서에 맞게 되었는지 확인하십시요\n\n정상적으로 패턴을 설정하셨으면 확인하기를 클릭하시고\n\n패턴을 변경하시려면 취소하기를 클릭하세요.\n\n\n일괄등록 할 문항수가 많을경우 패턴 적용하는데 시간이 좀 걸릴수 있습니다.");

	if(!bigos) {
		Show_LayerProgressBar(false);
		return; 
	}
		
	document.twe13.TagDiet("font",false,true,true,true,true,true);
	document.twe13.TagDiet("div",false,true,true,true,true,true);
	
	var tmp = form.twe13.BaseUrl; // 이진파일 저장되는 로컬경로 가져오기
		
	form.temps.value = tmp;

	form.temps2.value = document.twe13.GetLocalFiles; // 이진파일 경로 가져오기

	var q = document.twe13.BodyValue2;

	// 지문 정보 초기화
	refNoAll = "";
	refTitleAll = "";
	refContentAll = "";
	
	// 지문패턴
	refs = form.ref_gubun.value;
	refs2 = form.ref_gubun2.value;
	
	qcounts = parseInt(form.qcounts.value);
	
	// 문제패턴
	q1 = form.q1.value;
	q2 = form.q2.value;
	q3 = form.q3.value;
	q4 = form.q4.value;
	var q_res = q1+q2+q4;

	q = blank_remove(q,q1,q4,q2,q_res);

	//q = blank_remove(q,q_res,q2); 

	// 보기패턴
	e1 = form.e1.value;
	e2 = form.e2.value;
	e3 = form.e3.value;
	e4 = form.e4.value;

	// 정답패턴
	c1 = form.c1.value;
	c2 = form.c2.value;
	c4 = form.c4.value;
	ca_ptn = c1+c2+c4;

	//q = balnk_remove(q,ca_ptn,c2);

	// 해설패턴
	p1 = form.p1.value;
	p2 = form.p2.value;
	p4 = form.p4.value;
	explain_ptn = p1+p2+p4;

	//q = balnk_remove(q,explain_ptn,p2);

	// 힌트패턴
	h1 = form.h1.value;
	h2 = form.h2.value;
	h4 = form.h4.value;
	hint_ptn = h1+h2+h4;

	//q = balnk_remove(q,hint_ptn,h2); 

	// 난이도패턴
	d1 = form.d1.value;
	d2 = form.d2.value;
	d4 = form.d4.value;
	diff_ptn = d1+d2+d4;

	//q = balnk_remove(q,diff_ptn,d2); 

	ref_sel = form.ref_sel.checked;	
	explain_sel = form.explain_sel.checked;
	hint_sel = form.hint_sel.checked;
	diff_sel = form.diff_sel.checked;

	var arrImsiQs = new Array();
	var arrImsiQs2 = new Array();
	var arrQcntChk = new Array();

	arrImsiQs = q.split(q_res,-1);

	var qcounts2 = arrImsiQs.length-1

	var qs = "";
	var qstrs = "";

	for(var j=0;j<qcounts-qcounts2;j++) {

		q = blank_remove(q,q1,q4,q2,q_res);
	}

	arrImsiQs2 = q.split(q_res,-1);

	for(var i=1;i<arrImsiQs2.length;i++) {
		
		qstrs = q_res+" "+arrImsiQs2[i];

		qs = qs + qstrs.replace(q_res, q1+q2+i+q4);
	}

	var pattern_cnt = 1;
	
	for(n=1;n<=100;n++) {
		if(qs.indexOf(q1+q2+n+q4) > 0) {
			pattern_cnt = pattern_cnt + 1;
		}
	}

	if(qcounts != pattern_cnt) {
		alert("패턴적용시 오류가 발생했습니다.\n\n입력하신 문항수 : "+qcounts+" 문항, 패턴적용 후 문항수 : "+pattern_cnt+" 문항\n\n\n원인1. 입력하신 문항수와 패턴적용시 문항수가 틀린경우\n\n원인2. 문제패턴에 숫자값이 100 이상일경우 ( ex) (문제101) )\n\n원인3. 문제 패턴사이에 공백이 있을경우 ( ex) (문 제1) )\n\n원인4. 문제 패턴사이에 공백이 클경우 ( ex) (   문제     100   ) )\n\n\n위와 같은 원인외에 패턴 적용이 안될 경우에는 관리자에게 문의하시기 바랍니다.");
		Show_LayerProgressBar(false);
		return;
	}

	q = qs;
	
	var munje_res = 0;

	var munje_strs = "";
	
	for(var munje2=1; munje2<=qcounts; munje2++) {
		if(q.trim().indexOf(q1+q2+(munje2)+q4) == -1) {
			continue;
		}

		munje_strs = munje_strs + munje2 +",";
	}

	document.writeForm.munje_result.value = munje_strs;

	var arrMunje_strs = new Array();

	arrMunje_strs = munje_strs.split(",");

	for(var munje=0; munje<qcounts; munje++) {
				
		if(q.trim().indexOf(q1+q2+arrMunje_strs[munje]+q4) == -1) {
			//munje_res += (munje+1) + "번 ";
			munje_res = munje_res + 1;
		}
	}

	document.all.patterndiv.innerHTML = "";

	if(munje_res != "") {
		strArea = ""
		strArea += "<table border='0' width='95%' align='center' bgcolor='#CCCCCC'>";
		strArea += "<tr id='td2' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>문제패턴오류</b></td>";
		strArea += "<td valign='left' heigh='30'>&nbsp;<font color=red><b>"+munje_res+" 개 문제 패턴 오류 (원본문서에 문제패턴을 확인해주세요.)</b></font></td></tr>";
		strArea += "</table>";

		document.all.patterndiv.innerHTML = strArea;
		alert("문제패턴 적용시 설정된 패턴과 일치하지 않습니다.\n\n아래 패턴오류내용을 확인하시고\n\n작업파일을 수정하신 후 패턴적용을 다시 진행하시기 바랍니다.");
		movieLayout('div_1');
		return;
	}

	var jungdab_res = "";
	var hasul_res = "";
	var hinte_res = "";
	var nanedo_res = "";

	for(var jungdab=0; jungdab<qcounts; jungdab++) {
		
		if(jungdab == (qcounts - 1)) {
			arrQ[jungdab] = q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[jungdab]+q4));
		} else {
			arrQ[jungdab] = q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[jungdab]+q4),q.indexOf(q1+q2+arrMunje_strs[jungdab+1]+q4));
		}			
				
		if(arrQ[jungdab].indexOf(c1+c2+c4) == -1) {
			jungdab_res += (jungdab+1) + "번 ";
		}

		if(explain_sel) { // 해설 패턴 선택시
			if(arrQ[jungdab].indexOf(p1+p2+p4) == -1) {
				hasul_res += (jungdab+1) + "번 ";
			}
		}

		if(hint_sel) { // 힌트 패턴 선택시
			if(arrQ[jungdab].indexOf(h1+h2+h4) == -1) {
				hinte_res += (jungdab+1) + "번 ";
			}
		}

		if(diff_sel) { // 난이도 패턴 선택시
			if(arrQ[jungdab].indexOf(d1+d2+d4) == -1) {
				nanedo_res += (jungdab+1) + "번 ";
			}
		}
	}

	var non_qs = "N";

	if(document.writeForm.non_q.checked == true) {
		non_qs = "Y";
	} else {
		non_qs = "N";
	}
	
	if(jungdab_res != "") {
		document.all.non_chk.style.display = "block";
	} else {
		document.all.non_chk.style.display = "none";
	}
	
	if(non_qs == "N") {	

		if(jungdab_res != "" || hasul_res != "" || hinte_res != "" || nanedo_res != "") {
			strArea2 = ""
			strArea2 += "<table border='1' width='95%' align='center' bgcolor='#CCCCCC'>";
			
			if(jungdab_res != "") {
				strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>정답패턴오류</b></td>";
				strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+jungdab_res+" 패턴 오류</b></font></td></tr>";			
			}
			
			if(hasul_res != "") {
				if(explain_sel) { // 해설 패턴에 오류가 있을경우
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>해설패턴오류</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hasul_res+" 패턴 오류</b></font></td></tr>";
				}
			}

			if(hinte_res != "") {
				if(hint_sel) { // 힌트 패턴에 오류가 있을경우
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>힌트패턴오류</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hinte_res+" 패턴 오류</b></font></td></tr>";
				}
			}
			
			if(nanedo_res != "") {
				if(diff_sel) { // 난이도 패턴에 오류가 있을경우
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>난이도패턴오류</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+nanedo_res+" 패턴 오류</b></font></td></tr>";
				}
			}

			strArea2 += "</table>";

			document.all.patterndiv.innerHTML = strArea2;
			alert("패턴 적용시 설정된 패턴과 일치하지 않습니다.\n\n아래 패턴오류내용을 확인하시고\n\n작업파일을 수정하신 후 패턴적용을 다시 진행하시기 바랍니다.");
			movieLayout('div_1');
			return;
		}

	} else {

		if(hasul_res != "" || hinte_res != "" || nanedo_res != "") {
			strArea2 = ""
			strArea2 += "<table border='1' width='95%' align='center' bgcolor='#CCCCCC'>";
						
			if(hasul_res != "") {
				if(explain_sel) { // 해설 패턴에 오류가 있을경우
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>해설패턴오류</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hasul_res+" 패턴 오류</b></font></td></tr>";
				}
			}

			if(hinte_res != "") {
				if(hint_sel) { // 힌트 패턴에 오류가 있을경우
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>힌트패턴오류</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hinte_res+" 패턴 오류</b></font></td></tr>";
				}
			}
			
			if(nanedo_res != "") {
				if(diff_sel) { // 난이도 패턴에 오류가 있을경우
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>난이도패턴오류</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+nanedo_res+" 패턴 오류</b></font></td></tr>";
				}
			}

			strArea2 += "</table>";

			document.all.patterndiv.innerHTML = strArea2;
			alert("패턴 적용시 설정된 패턴과 일치하지 않습니다.\n\n아래 패턴오류내용을 확인하시고\n\n작업파일을 수정하신 후 패턴적용을 다시 진행하시기 바랍니다.");
			movieLayout('div_1');
			return;
		}
	}

	if(non_qs == "N") {	
		arrQchk = q.split(c1+c2+c4,-1);

		var Qchk = arrQchk.length;
	
		if((Qchk-1) != qcounts) {
			alert("입력하신 문항수와 원본문서의 문항수가 맞지 않습니다.\n\n확인 후 다시 진행해주시기 바랍니다.");
			Show_LayerProgressBar(false);
			return;
		}
	}
	
	document.writeForm.pattern_yn.value = "Y";

	if(q3 == "[0-9]") { 

		for(var a=0; a<qcounts; a++) {
			
			var k = 0;
					
			if(ref_sel) {

				var ref_str = "";
				var ref_del = "";

				//if(arrId_refs[a] == null) {

					if(a == (qcounts - 1)) {
						arrId_refs[a] = "";
						ref_del = "";
						
						arrQ[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[a]+q4));
					} else {
						if(a == 0) {						
							if(q.substring(0,q.indexOf(q1+q2+arrMunje_strs[a]+q4)).indexOf(refs) == -1) {								
								arrId_refs[a] = "";
								ref_del = "";
							} else {								
								ref_strs = ref_dels(q.substring(0,q.indexOf(q1+q2+arrMunje_strs[a]+q4)));
								ref_str = q.substring(0,q.indexOf(q1+q2+arrMunje_strs[a]+q4));
								arrId_refs[a] = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2));					
								ref_del = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2)+1);
						
							}
						} else {						
							if(q.substring(q.lastIndexOf(q1+q2+a+q4),q.indexOf(q1+q2+arrMunje_strs[a]+q4)).indexOf(refs) == -1) {
								arrId_refs[a] = "";
								ref_del = "";
							} else {
								ref_str = q.substring(q.lastIndexOf(q1+q2+a+q4),q.indexOf(q1+q2+arrMunje_strs[a]+q4));
								arrId_refs[a] = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2));
								ref_del = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2)+1);

						
							}
						}
						
						arrQ[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[a]+q4),q.indexOf(q1+q2+arrMunje_strs[a+1]+q4));
					}			

				//}

			} else {

				arrId_refs[a] = "";
				ref_del = "";

				if(a == (qcounts - 1)) {
					arrQ[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[a]+q4));
				} else {
					arrQ[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[a]+q4),q.indexOf(q1+q2+arrMunje_strs[a+1]+q4));
				}			

			}
			

			if(arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4) == -1) {	// 단답형인지, 논술형인지 체크한다.		
			
				if(arrQ[a].indexOf(ca_ptn) == -1) { // 정답이 없으면 논술형임.
					// 논술형일경우 정답이 없음
					arrCa[a] = "";
					arrQtype[a] = 5;
					arrCacount[a] = 0;
					arrExcount[a] = 0;

					if(diff_sel) {

						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(hint_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(diff_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}					

						}
						
					} else {
					
						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(hint_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrExplain[a] = "";
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								if(a == (qcounts - 1)) {
									arrQs[a] = ref_dels(q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[a]+q4)).replace(q1+q2+arrMunje_strs[a]+q4,""));
								} else {
									arrQs[a] = ref_dels(q.substring(q.lastIndexOf(q1+q2+arrMunje_strs[a]+q4),q.indexOf(q1+q2+arrMunje_strs[a+1]+q4)).replace(q1+q2+arrMunje_strs[a]+q4,""));
								}
								
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}					

						}

					}			
										

				} else { // 단답형일경우 정답이 있으므로 문제에서 부터 정답영역까지 추출				    

					arrQtype[a] = 4;					
					arrExcount[a] = 0;
					
					if(diff_sel) {

						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}					

						}
						
					} else {
					
						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_strs[a]+q4,"");
								arrCa[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,""));
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}					

						}

					}		

					if(arrCa[a].indexOf("{|}") == -1) { 
						arrCacount[a] = 1;						
					} else {
						arrImsi[a] = arrCa[a].split("{|}");
						arrCacount[a] = arrImsi[a].length;
					}					

				}

				continue;

			}

			if(arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4) == -1) { // 선다형 2번 보기가 없을 경우
				alert((a+1)+"번 문제 오류입니다.\n\n선다형일경우 보기가 두개이상 존재해야 합니다."); // 선다형일경우 보기가 두개이상 존재해야 한다.
				break;
			}
			
			
			if(arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4) == -1) { // 선다형 3번 보기가 없을 경우(OX형문제)
								
				arrQtype[a] = 1;
				arrExcount[a] = 2;
								
				
				if(diff_sel) { // 난이도패턴 선택 했을경우

					if(explain_sel) { // 해설패턴 선택 했을경우
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}					

					}
						
				} else { // 난이도패턴 선택 안했을경우
					
					if(explain_sel) { // 해설패턴 선택 했을경우							
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,""));
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}					

					}								

				}	

				if(arrCa[a].indexOf("{|}") == -1) { 
					arrCacount[a] = 1;						
				} else {
					arrImsi[a] = arrCa[a].split("{|}");
					arrCacount[a] = arrImsi[a].length;
				}

				continue;

			} 

			
			if(arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4) == -1) { // 선다형 4번 보기가 없을 경우

				arrExcount[a] = 3;				
				
				
				if(diff_sel) { // 난이도패턴 선택 했을경우

					if(explain_sel) { // 해설패턴 선택 했을경우
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}					

					}
						
				} else { // 난이도패턴 선택 안했을경우
					
					if(explain_sel) { // 해설패턴 선택 했을경우							
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,""));
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}					

					}
					
				}

				if(arrCa[a].indexOf("{|}") == -1) { 
					arrCacount[a] = 1;
					arrQtype[a] = 2;
				} else {
					arrImsi[a] = arrCa[a].split("{|}");
					arrCacount[a] = arrImsi[a].length;
					arrQtype[a] = 3;
				}

				continue;

			} 


			if(arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4) == -1) { // 선다형 5번 보기가 없을 경우
				
				arrExcount[a] = 4;
								
				
				if(diff_sel) { // 난이도패턴 선택 했을경우

					if(explain_sel) { // 해설패턴 선택 했을경우
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}					

					}
						
				} else { // 난이도패턴 선택 안했을경우
					
					if(explain_sel) { // 해설패턴 선택 했을경우							
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,""));
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}					

					}					
				
				}

				if(arrCa[a].indexOf("{|}") == -1) { 
					arrCacount[a] = 1;						
					arrQtype[a] = 2;
				} else {
					arrImsi[a] = arrCa[a].split("{|}");
					arrCacount[a] = arrImsi[a].length;
					arrQtype[a] = 3;
				}

				continue;

			} else { // 선다형 5번 보기가 있을 경우

				arrExcount[a] = 5;


				if(diff_sel) { // 난이도패턴 선택 했을경우

					if(explain_sel) { // 해설패턴 선택 했을경우
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}					

					}
						
				} else { // 난이도패턴 선택 안했을경우
					
					if(explain_sel) { // 해설패턴 선택 했을경우							
							
						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // 해설패턴 선택 안했을경우

						if(hint_sel) { // 힌트패턴 선택 했을경우
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // 힌트패턴 선택 안했을경우

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,""));
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}					

					}

				}	

				if(arrCa[a].indexOf("{|}") == -1) { 
					arrCacount[a] = 1;
					arrQtype[a] = 2;
				} else {
					arrImsi[a] = arrCa[a].split("{|}");
					arrCacount[a] = arrImsi[a].length;
					arrQtype[a] = 3;
				}
					
			}
			
		}

	}

	Show_LayerProgressBar(false);
	
	parm_ins();

	workResult(0);

	//document.all.id_buttons.style.display = "none";
	//document.all.id_buttons2.style.display = "block";
}

function parm_ins() {
		
	document.writeForm.refNoAll.value = refNoAll;
	document.writeForm.refTitleAll.value = refTitleAll;
	document.writeForm.refContentAll.value = refContentAll;
}

function htmlDel(Word) {
	
	a = Word.indexOf("<");
	b = Word.indexOf(">");
	len = Word.length;
	c = Word.substring(0, a);
	if(b == -1)
	b = a;
	d = Word.substring((b + 1), len);
	Word = c + d;
	tagCheck = Word.indexOf("<");
	if(tagCheck != -1)
	Word = htmlDel(Word);

	return Word;
}

String.prototype.trim = function()
{
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.endsWith = function(str) 
{
	return (this.match(str+"$")==str)
}

String.prototype.replaceAll = function(str1, str2)
{
	var temp_str = this.trim();
	temp_str = temp_str.replace(eval("/" + str1 + "/gi"), str2);
	
	return temp_str;
}

function removeBR(str) 
{

	str = str.replaceAll("\\n","<BR>");

	for(var i=0; i<10; i++) {
			
		if(str.toUpperCase().endsWith("<BR>")) {
			str = str.substring(0,str.length-4);
			continue;
		} else {
			break;
		}
	}

	return str;
}

function workResult(codes) 
{	
	document.all.workdivAll.style.display = "none";
	document.all.workdiv.style.display = "block";
	
	var form = document.writeForm;
	
	var strArea = "";
	var i = parseInt(codes);	
	var qtypes = "";
	var id_diffs = "";
	var refYN = false;

	var refTitles = "";
	var refContents = "";

	if(arrQtype[i] == 1) {
		qtypes = "OX형("+arrQtype[i]+")";
	} else if(arrQtype[i] == 2) {
		if(arrCacount[i] > 1) {
			qtypes = "복수답안형("+arrQtype[i]+")";
		} else {
			qtypes = "선다형("+arrQtype[i]+")";
		}
	} else if(arrQtype[i] == 4) {
		qtypes = "단답형("+arrQtype[i]+")";
	} else if(arrQtype[i] == 5) {
		qtypes = "논술형("+arrQtype[i]+")";
	}
	
	strArea += "<table border='0' width='100%'>";
	strArea += "<tr><td valign='center'>";
	strArea += "<table border='0' width='100%'>";
	strArea += "<tr>";
	strArea += "<td><a href='javascript:workResult(0)'>[ 처음으로 ]</a>";
	if((i-1) < 0) {
		strArea += "[ 이전 ]";
	} else {
		strArea += "<a href='javascript:workResult("+(i-1)+")'>[ 이전 ]</a>";
	}
	if((qcounts-1) <= i) {
		strArea += "[ 다음 ]";
	} else {
		strArea += "<a href='javascript:workResult("+(i+1)+")'>[ 다음 ]</a>";
	}
	strArea += "<a href='javascript:workResult("+(qcounts-1)+")'>[ 마지막으로 ]</a>&nbsp;&nbsp;&nbsp;<a href='javascript:workResultAll()'>[ 전체문제보기 ]</a></td>";	
	strArea += "<tr>";
	strArea += "</table>";
	strArea += "</td>";	
	strArea += "</tr>";
	strArea += "<tr>";
	strArea += "<td>";
	strArea += "<table border='0' cellpadding='3' cellspacing='1' bgcolor='#CCCCCC' align='left' valign='top' width='610'>";
	
	// 지문형 문항 유무
	if(refNoAll != "") {		
		ArrRefNoAll = refNoAll.substring(0,refNoAll.length-3).split("{^}", -1);
		ArrRefTitleAll = refTitleAll.substring(0,refTitleAll.length-3).split("{^}", -1);
		ArrRefContentAll = refContentAll.substring(0,refContentAll.length-3).split("{^}", -1);

		var ArrRefNoAll2 = new Array();

		for(var x=0;x<ArrRefNoAll.length;x++) {			
			ArrRefNoAll2 = ArrRefNoAll[x].split("{:}", -1); 
			for(var y=0;y<ArrRefNoAll[x].length;y++) {
				if(ArrRefNoAll2[y] != "" || ArrRefNoAll2[y] != undefind) {
					if((i+1) == parseInt(ArrRefNoAll2[y])) {
						refYN = true;
						break;
					}
				}
			}

			if(refYN) {
				refTitles = ArrRefTitleAll[x];
				refContents = ArrRefContentAll[x];
				break;
			}
		}

	}
	
	if(refYN) { // 지문이 있을경우 지문내용을 보여줍니다.
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>지문제목</td>";
		strArea += "<td>"+refTitles+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>지문내용</td>";
		strArea += "<td>"+refContents+"</td>";
		strArea += "</tr>";
	}
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' width='20%' bgcolor='#EEEEEE'><font color=red><b>"+(i+1)+".</b></font></td>";
	strArea += "<td>"+removeBR(arrQs[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	if(arrExcount[i] == 2) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 3) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>③</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 4) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>③</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>④</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 5) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>③</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>④</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>⑤</td>";
		strArea += "<td>"+removeBR(arrEx5[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} 
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>정답</td>";
	strArea += "<td>"+htmlDel(arrCa[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>해설</td>";
	strArea += "<td>"+removeBR(arrExplain[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>힌트</td>";
	strArea += "<td>"+removeBR(arrHint[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>난이도</td>";
	strArea += "<td>"+removeBR(arrDifficulty[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>문제유형</td>";
	strArea += "<td>"+qtypes+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>보기갯수</td>";
	strArea += "<td>"+arrExcount[i]+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>정답갯수</td>";
	strArea += "<td>"+arrCacount[i]+"</td>";
	strArea += "</tr>";	
	strArea += "</table>";
	strArea += "</td>";	
	strArea += "</tr>";	
	strArea += "</table>";
	
	document.all.workdiv.innerHTML = strArea;

	movieLayout('div_4');	
}

function workResultAll() 
{
	document.all.workdiv.style.display = "none";
	document.all.workdivAll.style.display = "block";
	
	var form = document.writeForm;
	
	var strArea = "";	
	var qtypes = "";
	var id_diffs = "";

	strArea += "<table border='0' width='100%'>";
	strArea += "<tr>";
	strArea += "<td><a href='javascript:workResult(0)'>[ 한문항씩 보기 ]</a></td>";
	strArea += "</tr>";
	strArea += "</table>";
	
	for(var i=0; i<qcounts; i++) {

	var refYN = false;

	var refTitles = "";
	var refContents = "";

	if(arrQtype[i] == 1) {
		qtypes = "OX형("+arrQtype[i]+")";
	} else if(arrQtype[i] == 2) {
		if(arrCacount[i] > 1) {
			qtypes = "복수답안형("+arrQtype[i]+")";
		} else {
			qtypes = "선다형("+arrQtype[i]+")";
		}
	} else if(arrQtype[i] == 4) {
		qtypes = "단답형("+arrQtype[i]+")";
	} else if(arrQtype[i] == 5) {
		qtypes = "논술형("+arrQtype[i]+")";
	}
	
	strArea += "<table border='0' width='100%'>";
	strArea += "<tr><td valign='center'>";	
	strArea += "<table border='0' cellpadding='3' cellspacing='1' bgcolor='#CCCCCC' align='left' valign='top' width='610'>";
	
	// 지문형 문항 유무
	if(refNoAll != "") {		
		ArrRefNoAll = refNoAll.substring(0,refNoAll.length-3).split("{^}", -1);
		ArrRefTitleAll = refTitleAll.substring(0,refTitleAll.length-3).split("{^}", -1);
		ArrRefContentAll = refContentAll.substring(0,refContentAll.length-3).split("{^}", -1);

		var ArrRefNoAll2 = new Array();

		for(var x=0;x<ArrRefNoAll.length;x++) {			
			ArrRefNoAll2 = ArrRefNoAll[x].split("{:}", -1); 
			for(var y=0;y<ArrRefNoAll[x].length;y++) {
				if(ArrRefNoAll2[y] != "" || ArrRefNoAll2[y] != undefind) {
					if((i+1) == parseInt(ArrRefNoAll2[y])) {
						refYN = true;
						break;
					}
				}
			}

			if(refYN) {
				refTitles = ArrRefTitleAll[x];
				refContents = ArrRefContentAll[x];
				break;
			}
		}

	}
	
	if(refYN) { // 지문이 있을경우 지문내용을 보여줍니다.
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>지문제목</td>";
		strArea += "<td>"+refTitles+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>지문내용</td>";
		strArea += "<td>"+refContents+"</td>";
		strArea += "</tr>";
	}

	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' width='20%' bgcolor='#EEEEEE'><font color=red><b>"+(i+1)+".</b></font></td>";
	strArea += "<td>"+removeBR(arrQs[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	if(arrExcount[i] == 2) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 3) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>③</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 4) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>③</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>④</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 5) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>①</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>②</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>③</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>④</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>⑤</td>";
		strArea += "<td>"+removeBR(arrEx5[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} 
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>정답</td>";
	strArea += "<td>"+htmlDel(arrCa[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>해설</td>";
	strArea += "<td>"+removeBR(arrExplain[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>힌트</td>";
	strArea += "<td>"+removeBR(arrHint[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>난이도</td>";
	strArea += "<td>"+removeBR(arrDifficulty[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>문제유형</td>";
	strArea += "<td>"+qtypes+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>보기갯수</td>";
	strArea += "<td>"+arrExcount[i]+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>정답갯수</td>";
	strArea += "<td>"+arrCacount[i]+"</td>";
	strArea += "</tr>";	
	strArea += "</table>";
	strArea += "</td>";	
	strArea += "</tr>";
	strArea += "</table>";

	}
	
	document.all.workdivAll.innerHTML = strArea;

	movieLayout('div_4');	
}

function pattern_extract(a, b, c, d, e, f) {
				
	window.open("pattern_extract.jsp?a="+a+"&b="+b+"&c="+c+"&d="+d+"&e="+e+"&f="+f,"pattern_extract","width=500, height=250, scrollbars=no, top=0, left=0");
}

function diff_extract() {
				
	var a = document.writeForm.diff0.value;
	var b = document.writeForm.diff1.value;
	var c = document.writeForm.diff2.value;
	var d = document.writeForm.diff3.value;
	var e = document.writeForm.diff4.value;
	var f = document.writeForm.diff5.value;

	window.open("diff_extract.jsp?a="+a+"&b="+b+"&c="+c+"&d="+d+"&e="+e+"&f="+f,"diff_extract","width=200, height=400, scrollbars=no, top=0, left=0");
}

// 메뉴별로 페이지 보여주기..
function movieLayout(obj) {
	
	if(obj == "div_0" || obj == "div_1") {
		Show_LayerProgressBar(false);
	}
	
	var num = obj.charAt(4);
	
	for(var i = 0; i < 5 ; i++) {
		
		var divj = "div_" + i;
		var btj = "bt_" + i;

		if (i == num){
			document.all[divj].style.display = "block";
			document.all[btj].className = "tab_new_div_";
		} else {
			document.all[divj].style.display = "none";
			document.all[btj].className = "tab_new_div";
		}
	}
}

HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
       + '<img src="../../images/loading.gif" style="position:absolute; top:20%; left:30%;"/>' 
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

-->
</script>
</head>

<body onLoad="movieLayout('div_0');" id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제 일괄 등록<span>이미 작성된 문제 파일을 업로드합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>	

	<div id="contents" style="height: 420px;">
		
		<form name="writeForm" method="post" action="batchFileHan_ok.jsp">
		<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">
		<input type="hidden" name="id_q_chapter" value="<%=id_q_chapter%>">
		<input type="hidden" name="id_q_chapter2" value="<%=id_q_chapter2%>">
		<input type="hidden" name="id_q_chapter3" value="<%=id_q_chapter3%>">
		<input type="hidden" name="id_q_chapter4" value="<%=id_q_chapter4%>">

		<input type="hidden" name="mime_contents">
		<input type="hidden" name="mime_contents2">

		<input type="hidden" name="temps">
		<input type="hidden" name="temps2">

		<input type="hidden" name="pattern_yn" value="N">
		<input type="hidden" name="save_yn" value="N">

		<input type="hidden" name="refNoAll">
	    <input type="hidden" name="refTitleAll">
	    <input type="hidden" name="refContentAll">

		<input type="hidden" name="munje_result">

		<div class="tab">
			<div onclick="javascript:movieLayout('div_0');" onfocus="this.blur();" id="bt_0" class="tab_new_div_">작업파일선택</div>
			<div onclick="javascript:movieLayout('div_1');" onfocus="this.blur();" id="bt_1" class="tab_new_div">패턴설정</div>
			<div onclick="javascript:movieLayout('div_3');" onfocus="this.blur();" id="bt_3" class="tab_new_div">지문설정</div>
			<div onclick="javascript:movieLayout('div_2');" onfocus="this.blur();" id="bt_2" class="tab_new_div">난이도설정</div>
			<div onclick="javascript:movieLayout('div_4');" onfocus="this.blur();" id="bt_4" class="tab_new_div">작업결과</div>
		</div>
		
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td>* 문항수 : <input type="text" name="qcounts" size="3"> 문항&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="sample.hwp" target="_blank">[등록샘플파일 다운로드]</a>&nbsp;&nbsp;<a href="guide.hwp" target="_blank">[등록가이드 다운로드]</a></td>
				<td align="right">
					<span class="btA80" onclick="javascript:OnSave();">패턴적용</span>
					<span class="btA80" onclick="javascript:parser();">저장하기</span>
					<span class="btA50" onclick="window.close()">나가기</span>					
				</td>
			</tr>
		</table>

		<br>
		
		<div style="display:none;" id="div_0">
			
			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">&nbsp;&nbsp;▶ 작업파일선택&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="input_text" value="Y">&nbsp;텍스트문서로 일괄등록(일괄등록 파일에 이미지가 없을경우 체크)</td>
				</tr>
				<tr>
					<td valign="top">
						
						<table border="0">
							<tr>
								<td width="610" height="530">
								<!-- Active Designer를 실제로 추가하는 부분입니다. 반드시 API 문서를 읽어본 후, 적절히 설정하시기 바랍니다. -->						
								<script language="jscript" src="tweditor13.js"></script>						
								<!-- Active Designer 추가 끝 -->
								</td>			
							</tr>
						</table>
					</td>
					<td width="20"></td>
				</tr>	
			</table>

		</div>

		<div style="display:none;" id="div_1">

			<table border="0" width="100%" cellspacing="0" cellpadding="0" style="display:none;">
				<tr>
					<td align="left">&nbsp;&nbsp;▶ 패턴설정</td>
				</tr>
			</table>
			
			<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tableA">
				<tr align="center" id="tr3">
					<td>유형</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>적용</td>
					<td>선택</td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="q_sel" checked disabled> 문제</td>
					<td height="30"><input type="text" name="q1" size="2" value="" readonly></td>
					<td height="30"><input type="text" name="q2" size="5" value="문제" readonly></td>
					<td height="30"><input type="text" name="q3" size="12" value="[0-9]" readonly></td>
					<td height="30"><input type="text" name="q4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="q5" size="40" value="문제1),문제2),문제3),문제4),문제5)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('q', document.writeForm.q1.value, document.writeForm.q2.value, document.writeForm.q3.value, document.writeForm.q4.value, document.writeForm.q5.value);">변경</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="ex_sel" checked disabled> 보기</td>
					<td height="30"><input type="text" name="e1" size="2" readonly></td>
					<td height="30"><input type="text" name="e2" size="5" readonly></td>
					<td height="30"><input type="text" name="e3" size="12" value="①②③④⑤" readonly></td>
					<td height="30"><input type="text" name="e4" size="2" readonly></td>
					<td height="30"><input type="text" name="e5" size="40" value="①,②,③,④,⑤" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('e', document.writeForm.e1.value, document.writeForm.e2.value, document.writeForm.e3.value, document.writeForm.e4.value, document.writeForm.e5.value);">변경</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="ca_sel" checked disabled> 정답</td>
					<td height="30"><input type="text" name="c1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="c2" size="5" value="정답" readonly></td>
					<td height="30"><input type="text" name="c3" size="12" readonly></td>
					<td height="30"><input type="text" name="c4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="c5" size="40" value="(정답)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('c', document.writeForm.c1.value, document.writeForm.c2.value, document.writeForm.c3.value, document.writeForm.c4.value, document.writeForm.c5.value);">변경</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="explain_sel"> 해설</td>
					<td height="30"><input type="text" name="p1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="p2" size="5" value="해설" readonly></td>
					<td height="30"><input type="text" name="p3" size="12" readonly></td>
					<td height="30"><input type="text" name="p4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="p5" size="40" value="(해설)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('p', document.writeForm.p1.value, document.writeForm.p2.value, document.writeForm.p3.value, document.writeForm.p4.value, document.writeForm.p5.value);">변경</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="hint_sel"> 힌트</td>
					<td height="30"><input type="text" name="h1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="h2" size="5" value="힌트" readonly></td>
					<td height="30"><input type="text" name="h3" size="12" readonly></td>
					<td height="30"><input type="text" name="h4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="h5" size="40" value="(힌트)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('h', document.writeForm.h1.value, document.writeForm.h2.value, document.writeForm.h3.value, document.writeForm.h4.value, document.writeForm.h5.value);">변경</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="diff_sel"> 난이도</td>
					<td height="30"><input type="text" name="d1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="d2" size="5" value="난이도" readonly></td>
					<td height="30"><input type="text" name="d3" size="12" readonly></td>
					<td height="30"><input type="text" name="d4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="d5" size="40" value="(난이도)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('d', document.writeForm.d1.value, document.writeForm.d2.value, document.writeForm.d3.value, document.writeForm.d4.value, document.writeForm.d5.value);">변경</span></td>						
				</tr>
			</table>
			
			<table border="0" width="100%" cellspacing="0" cellpadding="0" >
				<tr>
					<td align="left">&nbsp;&nbsp;▶ 패턴설정오류사항 <font color=red><b>(오류가 있을경우 작업파일을 수정하신후 패턴설정을 진행하시기 바랍니다.)</b></font></td>
				</tr>
			</table>

			<div style="display:none;" id="non_chk">
				<table border="0" width="95%" align="center">
				<tr>
					<td><input type="checkbox" name="non_q" value="Y"> <font color=green><b>정답패턴에 오류가 발생한 문항이 모두 논술형일경우 체크해주시기 바랍니다.</b></font></td>			
				</tr>
			</table>	
			</div>

			<table border="0" width="100%">
				<tr>
					<td>
						<div id="patterndiv" style="width: 100%;"></div>
					</td>			
				</tr>
			</table>

		</div>

		<div style="display:none;" id="div_2">

			<table border="0" width="100%" cellspacing="0" cellpadding="0" style="display:none;">
				<tr>
					<td align="left">&nbsp;&nbsp;▶ 난이도설정</td>
				</tr>
			</table>
	
			
			<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tableA">
				<tr id="tr3" align="center">
					<td width="150">유형</td>
					<td width="50">코드</td>
					<td width="80">값</td>
					<td width="320">&nbsp;</td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">난이도 없음&nbsp;</td>
					<td height="30" align="center">0</td>
					<td height="30" align="center"><input type="text" name="diff0" size="8" value="없음" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">변경하기</span></td>
				</tr>				
				<tr id="td2">
					<td height="30" align="center">아주 어려움&nbsp;</td>
					<td height="30" align="center">1</td>
					<td height="30" align="center"><input type="text" name="diff1" size="8" value="최상" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">변경하기</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">어려움&nbsp;</td>
					<td height="30" align="center">2</td>
					<td height="30" align="center"><input type="text" name="diff2" size="8" value="상" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">변경하기</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">보통&nbsp;</td>
					<td height="30" align="center">3</td>
					<td height="30" align="center"><input type="text" name="diff3" size="8" value="중" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">변경하기</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">쉬움&nbsp;</td>
					<td height="30" align="center">4</td>
					<td height="30" align="center"><input type="text" name="diff4" size="8" value="하" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">변경하기</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">아주 쉬움&nbsp;</td>
					<td height="30" align="center">5</td>
					<td height="30" align="center"><input type="text" name="diff5" size="8" value="최하" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">변경하기</span></td>
				</tr>
			</table>
					

		</div>

		<div style="display:none;" id="div_3">

			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">&nbsp;&nbsp;▶ 지문설정</td>
				</tr>
			</table>
	
			<div class="box">
			※ 지문이 문서에 포함되어 있다면 프로그램이 지문 영역을 인식할 수 있게 지문 시작을 알 수 있는 패턴 문자를 설정해야 됩니다.<br>
			기본값은 '※' 입니다.</div>
			

			<table border="0">
				<tr bgcolor="#FFFFFF">
					<td><input type="checkbox" name="ref_sel"> 지문 처리함&nbsp;&nbsp;&nbsp;지문시작선택&nbsp;<select name="ref_gubun">
					<option value="※">※</option>
					<option value="＆">＆</option>
					<option value="＃">＃</option>
					<option value="§">§</option>
					<option value="▣">▣</option>
					<option value="◈">◈</option>
					</select>&nbsp;&nbsp;
					지문종료선택&nbsp;<select name="ref_gubun2">
					<option value="◆">◆</option>
					<option value="◇">◇</option>
					<option value="●">●</option>
					<option value="○">○</option>
					<option value="■">■</option>
					<option value="□">□</option>
					</select>
					&nbsp;※&nbsp;다음 글을 잘 읽고 물음에 답하세요. (1~2)&nbsp;◆ 
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="10"></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td>
						<div class="box">
							QM&TM은 Question Manager & Test Manager의 약자로 다양한 유형의 문제와 시험을 등록, 관리할 수 있는 이테스트 온라인 평가 솔루션의 상품명입니다. 
							시험성격에 따라 평가형, 모의고사형, 학습형 시험을 관리자가 선택하여 적용할 수 있습니다. 시험문제를 출제할 때 다양한 Random 방식 중 원하는 방식을 
							선택하여 출제할 수 있습니다.<br>
							시험지 탬플릿 디자인 제공으로 시험성격에 맞는 시험지 디자인을 선택하여 사용할 수 있습니다. 제출답안 조회 및 각종 통계자료가 Excel File로 지원되므로 
							원하는 보고서로 수정이 용이합니다.
						</div>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="10"></td>
				</tr>
				<tr>
					<td>1. QM&TM을 개발한 회사는?</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="5"></td>
				</tr>
				<tr>
					<td>① Microsoft ② Oracle ③ Sun Microsystems ④ etest</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="10"></td>
				</tr>
				<tr>
					<td>2. QM&TM에서 지원하는 시험 유형이 아닌 것은?</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="5"></td>
				</tr>
				<tr>
					<td>① 평가형 ② 모의고사형 ③ 학습형 ④ 실기형</td>
				</tr>

			</table>
		

		</div>

		<div style="display:none;" id="div_4">

			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">&nbsp;&nbsp;▶ 작업결과</td>
				</tr>
			</table>

						
			<table border="0">
				<tr>
					<td width="100%" >
					<div id="workdiv" style="width: 100%;"></div>
					</td>			
				</tr>
			</table>

			<table border="0">
				<tr>
					<td width="100%" >
					<div id="workdivAll" style="width: 100%;"></div>
					</td>			
				</tr>
			</table>		

		</div>

		</form>

	</div>

</body></html>
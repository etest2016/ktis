<%
//******************************************************************************
//   ���α׷� : batchFile.jsp
//   �� �� �� : �ϰ����� ���
//   ��    �� : �ϰ����� ���ȭ��
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2010-06-18
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
<title>�����ϰ����</title>
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

var ref, ref_sel; // ��������
var q1, q2, q3, q4; // ��������
var e1, e2, e3, e4; // ��������
var c1, c2, c4, ca_ptn; // ��������
var p1, p2, p4, explain_ptn; // �ؼ�����
var h1, h2, h4, hint_ptn; // ��Ʈ����
var d1, d2, d4, diff_ptn; // ���̵�����

var explain_sel, hint_sel, diff_sel; // ������������

var qcounts; // ���׼�

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
		alert("�ϰ������ ���׼��� �Է��ϼž� �մϴ�.");
		form.qcounts.focus();
		return;
	}

	if(form.pattern_yn.value == "N") {
		alert("���������� �ϼž߸� �����Ͻ� �� �ֽ��ϴ�.\n\n���������� ���ؼ� ���ϼ��� �޴��� ���ؼ�\n\n������ �����Ͻ��� �̿��Ͻñ� �ٶ��ϴ�.");
		return;
	}

	var message = confirm("*******************************����*******************************\n\n�ݵ�� �۾����ȭ�鿡�� ���׺��� ���������� �Ǿ����� Ȯ���ϼž� �մϴ�.\n\n���׺��� ���������� ���������� ���� �ʾ�����쿡�� �����ϰ������ ���� �ʽ��ϴ�.\n\n\n���� �ϰ�����Ͻ÷��� Ȯ���� ������ �˼��Ͻ÷��� ��Ҹ� Ŭ���ϼ���.");

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
	  
	// ��������
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
		alert("�ϰ������ ���׼��� �Է��ϼž� �մϴ�.");
		form.qcounts.focus();
		return;
	}

	movieLayout('div_1');

	Show_LayerProgressBar(true);
	
	var bigos = confirm("�ش� ������ ������ �����մϴ�.\n\n���� ������ ���������� �°� �Ǿ����� Ȯ���Ͻʽÿ�\n\n���������� ������ �����ϼ����� Ȯ���ϱ⸦ Ŭ���Ͻð�\n\n������ �����Ͻ÷��� ����ϱ⸦ Ŭ���ϼ���.\n\n\n�ϰ���� �� ���׼��� ������� ���� �����ϴµ� �ð��� �� �ɸ��� �ֽ��ϴ�.");

	if(!bigos) {
		Show_LayerProgressBar(false);
		return; 
	}
		
	document.twe13.TagDiet("font",false,true,true,true,true,true);
	document.twe13.TagDiet("div",false,true,true,true,true,true);
	
	var tmp = form.twe13.BaseUrl; // �������� ����Ǵ� ���ð�� ��������
		
	form.temps.value = tmp;

	form.temps2.value = document.twe13.GetLocalFiles; // �������� ��� ��������

	var q = document.twe13.BodyValue2;

	// ���� ���� �ʱ�ȭ
	refNoAll = "";
	refTitleAll = "";
	refContentAll = "";
	
	// ��������
	refs = form.ref_gubun.value;
	refs2 = form.ref_gubun2.value;
	
	qcounts = parseInt(form.qcounts.value);
	
	// ��������
	q1 = form.q1.value;
	q2 = form.q2.value;
	q3 = form.q3.value;
	q4 = form.q4.value;
	var q_res = q1+q2+q4;

	q = blank_remove(q,q1,q4,q2,q_res);

	//q = blank_remove(q,q_res,q2); 

	// ��������
	e1 = form.e1.value;
	e2 = form.e2.value;
	e3 = form.e3.value;
	e4 = form.e4.value;

	// ��������
	c1 = form.c1.value;
	c2 = form.c2.value;
	c4 = form.c4.value;
	ca_ptn = c1+c2+c4;

	//q = balnk_remove(q,ca_ptn,c2);

	// �ؼ�����
	p1 = form.p1.value;
	p2 = form.p2.value;
	p4 = form.p4.value;
	explain_ptn = p1+p2+p4;

	//q = balnk_remove(q,explain_ptn,p2);

	// ��Ʈ����
	h1 = form.h1.value;
	h2 = form.h2.value;
	h4 = form.h4.value;
	hint_ptn = h1+h2+h4;

	//q = balnk_remove(q,hint_ptn,h2); 

	// ���̵�����
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
		alert("��������� ������ �߻��߽��ϴ�.\n\n�Է��Ͻ� ���׼� : "+qcounts+" ����, �������� �� ���׼� : "+pattern_cnt+" ����\n\n\n����1. �Է��Ͻ� ���׼��� ��������� ���׼��� Ʋ�����\n\n����2. �������Ͽ� ���ڰ��� 100 �̻��ϰ�� ( ex) (����101) )\n\n����3. ���� ���ϻ��̿� ������ ������� ( ex) (�� ��1) )\n\n����4. ���� ���ϻ��̿� ������ Ŭ��� ( ex) (   ����     100   ) )\n\n\n���� ���� ���οܿ� ���� ������ �ȵ� ��쿡�� �����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
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
			//munje_res += (munje+1) + "�� ";
			munje_res = munje_res + 1;
		}
	}

	document.all.patterndiv.innerHTML = "";

	if(munje_res != "") {
		strArea = ""
		strArea += "<table border='0' width='95%' align='center' bgcolor='#CCCCCC'>";
		strArea += "<tr id='td2' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>�������Ͽ���</b></td>";
		strArea += "<td valign='left' heigh='30'>&nbsp;<font color=red><b>"+munje_res+" �� ���� ���� ���� (���������� ���������� Ȯ�����ּ���.)</b></font></td></tr>";
		strArea += "</table>";

		document.all.patterndiv.innerHTML = strArea;
		alert("�������� ����� ������ ���ϰ� ��ġ���� �ʽ��ϴ�.\n\n�Ʒ� ���Ͽ��������� Ȯ���Ͻð�\n\n�۾������� �����Ͻ� �� ���������� �ٽ� �����Ͻñ� �ٶ��ϴ�.");
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
			jungdab_res += (jungdab+1) + "�� ";
		}

		if(explain_sel) { // �ؼ� ���� ���ý�
			if(arrQ[jungdab].indexOf(p1+p2+p4) == -1) {
				hasul_res += (jungdab+1) + "�� ";
			}
		}

		if(hint_sel) { // ��Ʈ ���� ���ý�
			if(arrQ[jungdab].indexOf(h1+h2+h4) == -1) {
				hinte_res += (jungdab+1) + "�� ";
			}
		}

		if(diff_sel) { // ���̵� ���� ���ý�
			if(arrQ[jungdab].indexOf(d1+d2+d4) == -1) {
				nanedo_res += (jungdab+1) + "�� ";
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
				strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>�������Ͽ���</b></td>";
				strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+jungdab_res+" ���� ����</b></font></td></tr>";			
			}
			
			if(hasul_res != "") {
				if(explain_sel) { // �ؼ� ���Ͽ� ������ �������
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>�ؼ����Ͽ���</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hasul_res+" ���� ����</b></font></td></tr>";
				}
			}

			if(hinte_res != "") {
				if(hint_sel) { // ��Ʈ ���Ͽ� ������ �������
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>��Ʈ���Ͽ���</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hinte_res+" ���� ����</b></font></td></tr>";
				}
			}
			
			if(nanedo_res != "") {
				if(diff_sel) { // ���̵� ���Ͽ� ������ �������
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>���̵����Ͽ���</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+nanedo_res+" ���� ����</b></font></td></tr>";
				}
			}

			strArea2 += "</table>";

			document.all.patterndiv.innerHTML = strArea2;
			alert("���� ����� ������ ���ϰ� ��ġ���� �ʽ��ϴ�.\n\n�Ʒ� ���Ͽ��������� Ȯ���Ͻð�\n\n�۾������� �����Ͻ� �� ���������� �ٽ� �����Ͻñ� �ٶ��ϴ�.");
			movieLayout('div_1');
			return;
		}

	} else {

		if(hasul_res != "" || hinte_res != "" || nanedo_res != "") {
			strArea2 = ""
			strArea2 += "<table border='1' width='95%' align='center' bgcolor='#CCCCCC'>";
						
			if(hasul_res != "") {
				if(explain_sel) { // �ؼ� ���Ͽ� ������ �������
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>�ؼ����Ͽ���</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hasul_res+" ���� ����</b></font></td></tr>";
				}
			}

			if(hinte_res != "") {
				if(hint_sel) { // ��Ʈ ���Ͽ� ������ �������
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>��Ʈ���Ͽ���</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+hinte_res+" ���� ����</b></font></td></tr>";
				}
			}
			
			if(nanedo_res != "") {
				if(diff_sel) { // ���̵� ���Ͽ� ������ �������
					strArea2 += "<tr id='td2' height='30' bgcolor='#FFFFFF'><td align='center' width='20%' bgcolor='#E8E8E8'><b>���̵����Ͽ���</b></td>";
					strArea2 += "<td valign='middle'>&nbsp;<font color=red><b>"+nanedo_res+" ���� ����</b></font></td></tr>";
				}
			}

			strArea2 += "</table>";

			document.all.patterndiv.innerHTML = strArea2;
			alert("���� ����� ������ ���ϰ� ��ġ���� �ʽ��ϴ�.\n\n�Ʒ� ���Ͽ��������� Ȯ���Ͻð�\n\n�۾������� �����Ͻ� �� ���������� �ٽ� �����Ͻñ� �ٶ��ϴ�.");
			movieLayout('div_1');
			return;
		}
	}

	if(non_qs == "N") {	
		arrQchk = q.split(c1+c2+c4,-1);

		var Qchk = arrQchk.length;
	
		if((Qchk-1) != qcounts) {
			alert("�Է��Ͻ� ���׼��� ���������� ���׼��� ���� �ʽ��ϴ�.\n\nȮ�� �� �ٽ� �������ֽñ� �ٶ��ϴ�.");
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
			

			if(arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4) == -1) {	// �ܴ�������, ��������� üũ�Ѵ�.		
			
				if(arrQ[a].indexOf(ca_ptn) == -1) { // ������ ������ �������.
					// ������ϰ�� ������ ����
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
										

				} else { // �ܴ����ϰ�� ������ �����Ƿ� �������� ���� ���俵������ ����				    

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

			if(arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4) == -1) { // ������ 2�� ���Ⱑ ���� ���
				alert((a+1)+"�� ���� �����Դϴ�.\n\n�������ϰ�� ���Ⱑ �ΰ��̻� �����ؾ� �մϴ�."); // �������ϰ�� ���Ⱑ �ΰ��̻� �����ؾ� �Ѵ�.
				break;
			}
			
			
			if(arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4) == -1) { // ������ 3�� ���Ⱑ ���� ���(OX������)
								
				arrQtype[a] = 1;
				arrExcount[a] = 2;
								
				
				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}					

					}
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

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

			
			if(arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4) == -1) { // ������ 4�� ���Ⱑ ���� ���

				arrExcount[a] = 3;				
				
				
				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // ��Ʈ���� ���� ���������

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
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

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


			if(arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4) == -1) { // ������ 5�� ���Ⱑ ���� ���
				
				arrExcount[a] = 4;
								
				
				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // ��Ʈ���� ���� ���������

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

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // ��Ʈ���� ���� ���������

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
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

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

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_strs[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_strs[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

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

			} else { // ������ 5�� ���Ⱑ ���� ���

				arrExcount[a] = 5;


				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
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
								
						} else { // ��Ʈ���� ���� ���������

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

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
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
							
						} else { // ��Ʈ���� ���� ���������

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
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
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
								
						} else { // ��Ʈ���� ���� ���������

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

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
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
								
						} else { // ��Ʈ���� ���� ���������

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
		qtypes = "OX��("+arrQtype[i]+")";
	} else if(arrQtype[i] == 2) {
		if(arrCacount[i] > 1) {
			qtypes = "���������("+arrQtype[i]+")";
		} else {
			qtypes = "������("+arrQtype[i]+")";
		}
	} else if(arrQtype[i] == 4) {
		qtypes = "�ܴ���("+arrQtype[i]+")";
	} else if(arrQtype[i] == 5) {
		qtypes = "�����("+arrQtype[i]+")";
	}
	
	strArea += "<table border='0' width='100%'>";
	strArea += "<tr><td valign='center'>";
	strArea += "<table border='0' width='100%'>";
	strArea += "<tr>";
	strArea += "<td><a href='javascript:workResult(0)'>[ ó������ ]</a>";
	if((i-1) < 0) {
		strArea += "[ ���� ]";
	} else {
		strArea += "<a href='javascript:workResult("+(i-1)+")'>[ ���� ]</a>";
	}
	if((qcounts-1) <= i) {
		strArea += "[ ���� ]";
	} else {
		strArea += "<a href='javascript:workResult("+(i+1)+")'>[ ���� ]</a>";
	}
	strArea += "<a href='javascript:workResult("+(qcounts-1)+")'>[ ���������� ]</a>&nbsp;&nbsp;&nbsp;<a href='javascript:workResultAll()'>[ ��ü�������� ]</a></td>";	
	strArea += "<tr>";
	strArea += "</table>";
	strArea += "</td>";	
	strArea += "</tr>";
	strArea += "<tr>";
	strArea += "<td>";
	strArea += "<table border='0' cellpadding='3' cellspacing='1' bgcolor='#CCCCCC' align='left' valign='top' width='610'>";
	
	// ������ ���� ����
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
	
	if(refYN) { // ������ ������� ���������� �����ݴϴ�.
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��������</td>";
		strArea += "<td>"+refTitles+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��������</td>";
		strArea += "<td>"+refContents+"</td>";
		strArea += "</tr>";
	}
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' width='20%' bgcolor='#EEEEEE'><font color=red><b>"+(i+1)+".</b></font></td>";
	strArea += "<td>"+removeBR(arrQs[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	if(arrExcount[i] == 2) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 3) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 4) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 5) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx5[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} 
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>����</td>";
	strArea += "<td>"+htmlDel(arrCa[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>�ؼ�</td>";
	strArea += "<td>"+removeBR(arrExplain[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>��Ʈ</td>";
	strArea += "<td>"+removeBR(arrHint[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>���̵�</td>";
	strArea += "<td>"+removeBR(arrDifficulty[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>��������</td>";
	strArea += "<td>"+qtypes+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>���ⰹ��</td>";
	strArea += "<td>"+arrExcount[i]+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>���䰹��</td>";
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
	strArea += "<td><a href='javascript:workResult(0)'>[ �ѹ��׾� ���� ]</a></td>";
	strArea += "</tr>";
	strArea += "</table>";
	
	for(var i=0; i<qcounts; i++) {

	var refYN = false;

	var refTitles = "";
	var refContents = "";

	if(arrQtype[i] == 1) {
		qtypes = "OX��("+arrQtype[i]+")";
	} else if(arrQtype[i] == 2) {
		if(arrCacount[i] > 1) {
			qtypes = "���������("+arrQtype[i]+")";
		} else {
			qtypes = "������("+arrQtype[i]+")";
		}
	} else if(arrQtype[i] == 4) {
		qtypes = "�ܴ���("+arrQtype[i]+")";
	} else if(arrQtype[i] == 5) {
		qtypes = "�����("+arrQtype[i]+")";
	}
	
	strArea += "<table border='0' width='100%'>";
	strArea += "<tr><td valign='center'>";	
	strArea += "<table border='0' cellpadding='3' cellspacing='1' bgcolor='#CCCCCC' align='left' valign='top' width='610'>";
	
	// ������ ���� ����
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
	
	if(refYN) { // ������ ������� ���������� �����ݴϴ�.
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��������</td>";
		strArea += "<td>"+refTitles+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��������</td>";
		strArea += "<td>"+refContents+"</td>";
		strArea += "</tr>";
	}

	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' width='20%' bgcolor='#EEEEEE'><font color=red><b>"+(i+1)+".</b></font></td>";
	strArea += "<td>"+removeBR(arrQs[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	if(arrExcount[i] == 2) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 3) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 4) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} else if(arrExcount[i] == 5) {
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx1[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx2[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx3[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx4[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>��</td>";
		strArea += "<td>"+removeBR(arrEx5[i]).replaceAll("&NBSP;","")+"</td>";
		strArea += "</tr>";
	} 
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>����</td>";
	strArea += "<td>"+htmlDel(arrCa[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>�ؼ�</td>";
	strArea += "<td>"+removeBR(arrExplain[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>��Ʈ</td>";
	strArea += "<td>"+removeBR(arrHint[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>���̵�</td>";
	strArea += "<td>"+removeBR(arrDifficulty[i]).replaceAll("&NBSP;","")+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>��������</td>";
	strArea += "<td>"+qtypes+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>���ⰹ��</td>";
	strArea += "<td>"+arrExcount[i]+"</td>";
	strArea += "</tr>";	
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' bgcolor='#EEEEEE'>���䰹��</td>";
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

// �޴����� ������ �����ֱ�..
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
				<Td id="mid"><div class="title">���� �ϰ� ���<span>�̹� �ۼ��� ���� ������ ���ε��մϴ�.</span></div></td>
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
			<div onclick="javascript:movieLayout('div_0');" onfocus="this.blur();" id="bt_0" class="tab_new_div_">�۾����ϼ���</div>
			<div onclick="javascript:movieLayout('div_1');" onfocus="this.blur();" id="bt_1" class="tab_new_div">���ϼ���</div>
			<div onclick="javascript:movieLayout('div_3');" onfocus="this.blur();" id="bt_3" class="tab_new_div">��������</div>
			<div onclick="javascript:movieLayout('div_2');" onfocus="this.blur();" id="bt_2" class="tab_new_div">���̵�����</div>
			<div onclick="javascript:movieLayout('div_4');" onfocus="this.blur();" id="bt_4" class="tab_new_div">�۾����</div>
		</div>
		
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td>* ���׼� : <input type="text" name="qcounts" size="3"> ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="sample.hwp" target="_blank">[��ϻ������� �ٿ�ε�]</a>&nbsp;&nbsp;<a href="guide.hwp" target="_blank">[��ϰ��̵� �ٿ�ε�]</a></td>
				<td align="right">
					<span class="btA80" onclick="javascript:OnSave();">��������</span>
					<span class="btA80" onclick="javascript:parser();">�����ϱ�</span>
					<span class="btA50" onclick="window.close()">������</span>					
				</td>
			</tr>
		</table>

		<br>
		
		<div style="display:none;" id="div_0">
			
			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">&nbsp;&nbsp;�� �۾����ϼ���&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="input_text" value="Y">&nbsp;�ؽ�Ʈ������ �ϰ����(�ϰ���� ���Ͽ� �̹����� ������� üũ)</td>
				</tr>
				<tr>
					<td valign="top">
						
						<table border="0">
							<tr>
								<td width="610" height="530">
								<!-- Active Designer�� ������ �߰��ϴ� �κ��Դϴ�. �ݵ�� API ������ �о ��, ������ �����Ͻñ� �ٶ��ϴ�. -->						
								<script language="jscript" src="tweditor13.js"></script>						
								<!-- Active Designer �߰� �� -->
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
					<td align="left">&nbsp;&nbsp;�� ���ϼ���</td>
				</tr>
			</table>
			
			<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tableA">
				<tr align="center" id="tr3">
					<td>����</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>����</td>
					<td>����</td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="q_sel" checked disabled> ����</td>
					<td height="30"><input type="text" name="q1" size="2" value="" readonly></td>
					<td height="30"><input type="text" name="q2" size="5" value="����" readonly></td>
					<td height="30"><input type="text" name="q3" size="12" value="[0-9]" readonly></td>
					<td height="30"><input type="text" name="q4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="q5" size="40" value="����1),����2),����3),����4),����5)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('q', document.writeForm.q1.value, document.writeForm.q2.value, document.writeForm.q3.value, document.writeForm.q4.value, document.writeForm.q5.value);">����</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="ex_sel" checked disabled> ����</td>
					<td height="30"><input type="text" name="e1" size="2" readonly></td>
					<td height="30"><input type="text" name="e2" size="5" readonly></td>
					<td height="30"><input type="text" name="e3" size="12" value="������" readonly></td>
					<td height="30"><input type="text" name="e4" size="2" readonly></td>
					<td height="30"><input type="text" name="e5" size="40" value="��,��,��,��,��" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('e', document.writeForm.e1.value, document.writeForm.e2.value, document.writeForm.e3.value, document.writeForm.e4.value, document.writeForm.e5.value);">����</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="ca_sel" checked disabled> ����</td>
					<td height="30"><input type="text" name="c1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="c2" size="5" value="����" readonly></td>
					<td height="30"><input type="text" name="c3" size="12" readonly></td>
					<td height="30"><input type="text" name="c4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="c5" size="40" value="(����)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('c', document.writeForm.c1.value, document.writeForm.c2.value, document.writeForm.c3.value, document.writeForm.c4.value, document.writeForm.c5.value);">����</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="explain_sel"> �ؼ�</td>
					<td height="30"><input type="text" name="p1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="p2" size="5" value="�ؼ�" readonly></td>
					<td height="30"><input type="text" name="p3" size="12" readonly></td>
					<td height="30"><input type="text" name="p4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="p5" size="40" value="(�ؼ�)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('p', document.writeForm.p1.value, document.writeForm.p2.value, document.writeForm.p3.value, document.writeForm.p4.value, document.writeForm.p5.value);">����</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="hint_sel"> ��Ʈ</td>
					<td height="30"><input type="text" name="h1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="h2" size="5" value="��Ʈ" readonly></td>
					<td height="30"><input type="text" name="h3" size="12" readonly></td>
					<td height="30"><input type="text" name="h4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="h5" size="40" value="(��Ʈ)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('h', document.writeForm.h1.value, document.writeForm.h2.value, document.writeForm.h3.value, document.writeForm.h4.value, document.writeForm.h5.value);">����</span></td>
				</tr>
				<tr id="td2">
					<td height="30"><input type="checkbox" name="diff_sel"> ���̵�</td>
					<td height="30"><input type="text" name="d1" size="2" value="(" readonly></td>
					<td height="30"><input type="text" name="d2" size="5" value="���̵�" readonly></td>
					<td height="30"><input type="text" name="d3" size="12" readonly></td>
					<td height="30"><input type="text" name="d4" size="2" value=")" readonly></td>
					<td height="30"><input type="text" name="d5" size="40" value="(���̵�)" readonly></td>
					<td height="30"><span class="btB45" onClick="pattern_extract('d', document.writeForm.d1.value, document.writeForm.d2.value, document.writeForm.d3.value, document.writeForm.d4.value, document.writeForm.d5.value);">����</span></td>						
				</tr>
			</table>
			
			<table border="0" width="100%" cellspacing="0" cellpadding="0" >
				<tr>
					<td align="left">&nbsp;&nbsp;�� ���ϼ����������� <font color=red><b>(������ ������� �۾������� �����Ͻ��� ���ϼ����� �����Ͻñ� �ٶ��ϴ�.)</b></font></td>
				</tr>
			</table>

			<div style="display:none;" id="non_chk">
				<table border="0" width="95%" align="center">
				<tr>
					<td><input type="checkbox" name="non_q" value="Y"> <font color=green><b>�������Ͽ� ������ �߻��� ������ ��� ������ϰ�� üũ���ֽñ� �ٶ��ϴ�.</b></font></td>			
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
					<td align="left">&nbsp;&nbsp;�� ���̵�����</td>
				</tr>
			</table>
	
			
			<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tableA">
				<tr id="tr3" align="center">
					<td width="150">����</td>
					<td width="50">�ڵ�</td>
					<td width="80">��</td>
					<td width="320">&nbsp;</td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">���̵� ����&nbsp;</td>
					<td height="30" align="center">0</td>
					<td height="30" align="center"><input type="text" name="diff0" size="8" value="����" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">�����ϱ�</span></td>
				</tr>				
				<tr id="td2">
					<td height="30" align="center">���� �����&nbsp;</td>
					<td height="30" align="center">1</td>
					<td height="30" align="center"><input type="text" name="diff1" size="8" value="�ֻ�" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">�����ϱ�</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">�����&nbsp;</td>
					<td height="30" align="center">2</td>
					<td height="30" align="center"><input type="text" name="diff2" size="8" value="��" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">�����ϱ�</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">����&nbsp;</td>
					<td height="30" align="center">3</td>
					<td height="30" align="center"><input type="text" name="diff3" size="8" value="��" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">�����ϱ�</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">����&nbsp;</td>
					<td height="30" align="center">4</td>
					<td height="30" align="center"><input type="text" name="diff4" size="8" value="��" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">�����ϱ�</span></td>
				</tr>
				<tr id="td2">
					<td height="30" align="center">���� ����&nbsp;</td>
					<td height="30" align="center">5</td>
					<td height="30" align="center"><input type="text" name="diff5" size="8" value="����" readonly></td>
					<td height="30">&nbsp;&nbsp;&nbsp;<span class="btB70" onClick="diff_extract();">�����ϱ�</span></td>
				</tr>
			</table>
					

		</div>

		<div style="display:none;" id="div_3">

			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">&nbsp;&nbsp;�� ��������</td>
				</tr>
			</table>
	
			<div class="box">
			�� ������ ������ ���ԵǾ� �ִٸ� ���α׷��� ���� ������ �ν��� �� �ְ� ���� ������ �� �� �ִ� ���� ���ڸ� �����ؾ� �˴ϴ�.<br>
			�⺻���� '��' �Դϴ�.</div>
			

			<table border="0">
				<tr bgcolor="#FFFFFF">
					<td><input type="checkbox" name="ref_sel"> ���� ó����&nbsp;&nbsp;&nbsp;�������ۼ���&nbsp;<select name="ref_gubun">
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					</select>&nbsp;&nbsp;
					�������ἱ��&nbsp;<select name="ref_gubun2">
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					<option value="��">��</option>
					</select>
					&nbsp;��&nbsp;���� ���� �� �а� ������ ���ϼ���. (1~2)&nbsp;�� 
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="10"></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td>
						<div class="box">
							QM&TM�� Question Manager & Test Manager�� ���ڷ� �پ��� ������ ������ ������ ���, ������ �� �ִ� ���׽�Ʈ �¶��� �� �ַ���� ��ǰ���Դϴ�. 
							���輺�ݿ� ���� ����, ���ǰ����, �н��� ������ �����ڰ� �����Ͽ� ������ �� �ֽ��ϴ�. ���蹮���� ������ �� �پ��� Random ��� �� ���ϴ� ����� 
							�����Ͽ� ������ �� �ֽ��ϴ�.<br>
							������ ���ø� ������ �������� ���輺�ݿ� �´� ������ �������� �����Ͽ� ����� �� �ֽ��ϴ�. ������ ��ȸ �� ���� ����ڷᰡ Excel File�� �����ǹǷ� 
							���ϴ� ������ ������ �����մϴ�.
						</div>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="10"></td>
				</tr>
				<tr>
					<td>1. QM&TM�� ������ ȸ���?</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="5"></td>
				</tr>
				<tr>
					<td>�� Microsoft �� Oracle �� Sun Microsystems �� etest</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="10"></td>
				</tr>
				<tr>
					<td>2. QM&TM���� �����ϴ� ���� ������ �ƴ� ����?</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td height="5"></td>
				</tr>
				<tr>
					<td>�� ���� �� ���ǰ���� �� �н��� �� �Ǳ���</td>
				</tr>

			</table>
		

		</div>

		<div style="display:none;" id="div_4">

			<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">&nbsp;&nbsp;�� �۾����</td>
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
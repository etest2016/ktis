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

	if (id_q_subject.length() == 0 || id_q_chapter.length() == 0 || id_q_chapter2.length() == 0 || id_q_chapter3.length() == 0 || id_q_chapter4.length() == 0 || qtype.length() == 0 ) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<html>
<head>
<title>�����ϰ����</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
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

var arrImsi = new Array();

var ref, ref_sel; // ��������
var q1, q2, q3, q4; // ��������
var e1, e2, e3, e4; // ��������
var c1, c2, c4, ca_ptn; // ��������
var p1, p2, p4, explain_ptn; // �ؼ�����
var h1, h2, h4, hint_ptn; // ��Ʈ����
var d1, d2, d4, diff_ptn; // ���̵�����

var explain_sel, hint_sel, diff_sel; // ������������

var qcounts; // ���׼�

function parser() 
{	
	var form = document.writeForm;
	
	if(form.qcounts.value.length == 0) {
		alert("�ϰ������ ���׼��� �Է��ϼž� �մϴ�.");
		form.qcounts.focus();
		return;
	}
	
	var source = document.twe.BodyValue2;
	
	document.writeForm.mime_contents.value = source;
	
	document.writeForm.submit();
}

function balnk_remove(s,str1,str2) {

	var str = "";

	str = s.replace(eval("/" +str1+ " /gi"), str2);  
	str = str.replace(eval("/" +str1+ "  /gi"), str2);  
	str = str.replace(eval("/" +str1+ "   /gi"), str2);  

	str = str.replace(eval("/ " +str1+ "/gi"), str2);  
    str = str.replace(eval("/ " +str1+ " /gi"), str2);  
    str = str.replace(eval("/ " +str1+ "  /gi"), str2);  
	str = str.replace(eval("/ " +str1+ "   /gi"), str2);  

    str = str.replace(eval("/  " +str1+ "/gi"), str2);
	str = str.replace(eval("/  " +str1+ " /gi"), str2);  
    str = str.replace(eval("/  " +str1+ "  /gi"), str2);
	str = str.replace(eval("/  " +str1+ "   /gi"), str2);

	str = str.replace(eval("/   " +str1+ "/gi"), str2);
	str = str.replace(eval("/   " +str1+ " /gi"), str2);
	str = str.replace(eval("/   " +str1+ "  /gi"), str2);
	str = str.replace(eval("/   " +str1+ "   /gi"), str2);

	return str;
  }

  function ref_dels(strs) {
	  var form = document.writeForm;
	  
	  // ��������
	  refs = form.ref_gubun.value;
	  refs2 = form.ref_gubun2.value; 	
		
      var str = strs.substring(strs.lastIndexOf(refs),strs.indexOf(refs2)+1); 
	  
	  strs = strs.replace(str,"");

	  return strs;
  }

function OnSave()
{	
	var form = document.writeForm;
	
	if(form.qcounts.value.length == 0) {
		alert("�ϰ������ ���׼��� �Է��ϼž� �մϴ�.");
		form.qcounts.focus();
		return;
	}
	
	document.twe.TagDiet("font",false,true,true,true,true,true);
	document.twe.TagDiet("div",false,true,true,true,true,true);
	
	//var tmp = form.twe.BaseUrl; // �������� ����Ǵ� ���ð�� ��������

	document.twe.GetLocalFiles; // �������� ��� ��������

	var q = document.twe.BodyValue2;

	// ��������
	refs = form.ref_gubun.value;
	refs2 = form.ref_gubun2.value;
	
	// ��������
	q1 = form.q1.value;
	q2 = form.q2.value;
	q3 = form.q3.value;
	q4 = form.q4.value;
	var q_res = q1+q2+q4;

	q = balnk_remove(q,q_res,q2); 

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

	q = balnk_remove(q,ca_ptn,c2); 
	
	// �ؼ�����
	p1 = form.p1.value;
	p2 = form.p2.value;
	p4 = form.p4.value;
	explain_ptn = p1+p2+p4;
	
	q = balnk_remove(q,explain_ptn,p2); 

	// ��Ʈ����
	h1 = form.h1.value;
	h2 = form.h2.value;
	h4 = form.h4.value;
	hint_ptn = h1+h2+h4;

	q = balnk_remove(q,hint_ptn,h2); 

	// ���̵�����
	d1 = form.d1.value;
	d2 = form.d2.value;
	d4 = form.d4.value;
	diff_ptn = d1+d2+d4;

	q = balnk_remove(q,diff_ptn,d2); 

	ref_sel = form.ref_sel.checked;	
	explain_sel = form.explain_sel.checked;
	hint_sel = form.hint_sel.checked;
	diff_sel = form.diff_sel.checked;

	qcounts = parseInt(form.qcounts.value);

	if(q3 == "[0-9]") { 

		for(var a=0; a<qcounts; a++) {
			
			var k = 0;

			if(a == (qcounts - 1)) {
				arrQ[a] = q.substring(q.lastIndexOf(q1+q2+(a+1)+q4));
			} else {
				arrQ[a] = q.substring(q.lastIndexOf(q1+q2+(a+1)+q4),q.indexOf(q1+q2+(a+2)+q4));
			}			
			
			if(ref_sel) {

				var ref_str = "";
				var ref_del = "";

				if(arrId_refs[a] == null) {

					if(a == (qcounts - 1)) {
						arrId_refs[a] = "";
						ref_del = "";
						//arrQ[a] = q.substring(q.lastIndexOf(q1+q2+(a+1)+q4));
					} else {
						if(a == 0) {						
							if(q.substring(0,q.indexOf(q1+q2+(a+1)+q4)).indexOf(refs) == -1) {
								arrId_refs[a] = "";
								ref_del = "";
							} else {
								ref_str = q.substring(0,q.indexOf(q1+q2+(a+1)+q4));
								arrId_refs[a] = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2));					
								ref_del = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2)+1);

								for(var kk=5; kk<=7; kk++) {
									arrId_refs[kk-1] = arrId_refs[a];
								}
							}
						} else {						
							if(q.substring(q.lastIndexOf(q1+q2+a+q4),q.indexOf(q1+q2+(a+1)+q4)).indexOf(refs) == -1) {
								arrId_refs[a] = "";
								ref_del = "";
							} else {
								ref_str = q.substring(q.lastIndexOf(q1+q2+a+q4),q.indexOf(q1+q2+(a+1)+q4));
								arrId_refs[a] = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2));
								ref_del = ref_str.substring(ref_str.lastIndexOf(refs),ref_str.indexOf(refs2)+1);

								for(var kk=5; kk<=7; kk++) {
									arrId_refs[kk-1] = arrId_refs[a];
								}
							}
						}
						
						//arrQ[a] = q.substring(q.lastIndexOf(q1+q2+(a+1)+q4),q.indexOf(q1+q2+(a+2)+q4));
					}			

				}

			} else {

				arrId_refs[a] = "";
				ref_del = "";

				if(a == (qcounts - 1)) {
					arrQ[a] = q.substring(q.lastIndexOf(q1+q2+(a+1)+q4));
				} else {
					arrQ[a] = q.substring(q.lastIndexOf(q1+q2+(a+1)+q4),q.indexOf(q1+q2+(a+2)+q4));
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
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(hint_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(diff_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}					

						}
						
					} else {
					
						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(hint_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrExplain[a] = "";
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								if(a == (qcounts - 1)) {
									arrQs[a] = ref_dels(q.substring(q.lastIndexOf(q1+q2+(a+1)+q4)).replace(q1+q2+(a+1)+q4,""));
								} else {
									arrQs[a] = ref_dels(q.substring(q.lastIndexOf(q1+q2+(a+1)+q4),q.indexOf(q1+q2+(a+2)+q4)).replace(q1+q2+(a+1)+q4,""));
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
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
							}					

						}
						
					} else {
					
						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,""));
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,""));
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = ref_dels(arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,""));
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+(a+1)+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+(a+1)+q4,"");
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

	workResult(0);
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
	str = str.toUpperCase();

	for(var i=0; i<10; i++) {
			
		if(str.endsWith("<BR>")) {
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
	var form = document.writeForm;
	
	var strArea = "";
	var i = parseInt(codes);	
	var qtypes = "";
	var id_diffs = "";

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
	strArea += "<a href='javascript:workResult("+(qcounts-1)+")'>[ ���������� ]</a></td>";
	strArea += "<tr>";
	strArea += "</table>";
	strArea += "</td>";	
	strArea += "</tr>";
	strArea += "<tr>";
	strArea += "<td>";
	strArea += "<table border='0' cellpadding='3' cellspacing='1' bgcolor='#CCCCCC' align='left' valign='top' width='100%'>";
	if(arrId_refs[i] != "") { // ������ ������� ���������� �����ݴϴ�.
		strArea += "<tr bgcolor='#FFFFFF' height='30'>";
		strArea += "<td align='center' bgcolor='#EEEEEE'>����</td>";
		strArea += "<td>"+arrId_refs[i]+"</td>";
		strArea += "</tr>";
	}
	strArea += "<tr bgcolor='#FFFFFF' height='30'>";
	strArea += "<td align='center' width='20%' bgcolor='#EEEEEE'>"+(i+1)+".</td>";
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
	strArea += "<tr>";
	strArea += "<td>";
	strArea += "<table border='0' cellpadding='3' cellspacing='1' bgcolor='#CCCCCC' align='left' valign='top' width='100%'>";
	strArea += "<tr bgcolor='#FFFFFF' height='80'>";
	strArea += "<td align='center' width='20%' bgcolor='#EEEEEE'>�۾����</td>";
	strArea += "<td></td>";
	strArea += "</tr>";
	strArea += "</table>";
	
	document.all.workdiv.innerHTML = strArea;

	movieLayout('results');	
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
	
	if(obj == "files") {
		document.all.id_files.style.display = "block";
		document.all.id_patterns.style.display = "none";
		document.all.id_diffs.style.display = "none";
		document.all.id_refs.style.display = "none";
		document.all.id_results.style.display = "none";
	} else if(obj == "patterns") {
		document.all.id_files.style.display = "none";
		document.all.id_patterns.style.display = "block";
		document.all.id_diffs.style.display = "none";
		document.all.id_refs.style.display = "none";
		document.all.id_results.style.display = "none";
    } else if(obj == "diffs") {
		document.all.id_files.style.display = "none";
		document.all.id_patterns.style.display = "none";
		document.all.id_diffs.style.display = "block";
		document.all.id_refs.style.display = "none";
		document.all.id_results.style.display = "none";
	} else if(obj == "refs"){
	    document.all.id_files.style.display = "none";
		document.all.id_patterns.style.display = "none";
		document.all.id_diffs.style.display = "none";
		document.all.id_refs.style.display = "block";
		document.all.id_results.style.display = "none";
	} else if(obj == "results"){
	    document.all.id_files.style.display = "none";
		document.all.id_patterns.style.display = "none";
		document.all.id_diffs.style.display = "none";
		document.all.id_refs.style.display = "none";
		document.all.id_results.style.display = "block";
	}
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

<body onLoad="movieLayout('files');">

	<form name="writeForm" method="post" action="batchFile_ok.jsp">
	<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">
	<input type="hidden" name="id_q_chapter" value="<%=id_q_chapter%>">
	<input type="hidden" name="id_q_chapter2" value="<%=id_q_chapter2%>">
	<input type="hidden" name="id_q_chapter3" value="<%=id_q_chapter3%>">
	<input type="hidden" name="id_q_chapter4" value="<%=id_q_chapter4%>">

	<input type="hidden" name="mime_contents">
		
	<table border="0" width="100%" cellpadding="0" cellspacing="0" height="38">
		<tr>		
			<td align="right">
				<a href="javascript:" onclick="javascript:OnSave();" style="cursor:hand;">[��������]</a>&nbsp;&nbsp;<img src="../../images/bt_editor8.gif" onclick="javascript:parser();" style="cursor:hand;"><img src="../../images/bt_editor7.gif"  style="cursor:hand;" onclick="window.close();">
			</td>				
		</tr>
	</table>
	
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td>* ���׼� : <input type="text" name="qcounts" size="3"> ����</td>
		</tr>
	</table>
	
	<br>

	<div style="display:;" id="id_files">

	<div class="tab"><a href="javascript:movieLayout('files');" onfocus="this.blur();">[�۾����ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('patterns');" onfocus="this.blur();">[���ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('diffs');" onfocus="this.blur();">[���̵�����]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('refs');" onfocus="this.blur();">[��������]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('results');" onfocus="this.blur();">[�۾����]</a></div>
	
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">&nbsp;&nbsp;�� �۾����ϼ���</td>
		</tr>
		<tr>
			<td valign="top">
				
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
		</tr>	
	</table>

	</div>

	<div style="display:;" id="id_patterns">

	<div class="tab"><a href="javascript:movieLayout('files');" onfocus="this.blur();">[�۾����ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('patterns');" onfocus="this.blur();">[���ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('diffs');" onfocus="this.blur();">[���̵�����]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('refs');" onfocus="this.blur();">[��������]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('results');" onfocus="this.blur();">[�۾����]</a></div>

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">&nbsp;&nbsp;�� ���ϼ���</td>
		</tr>
	</table>

	<table border="0" width="650" height="300" cellspacing="1" cellpadding="3" bgcolor="#C3C3C3">
		<tr bgcolor="#FFFFFF">
			<td valign="top">
				<table border="0" width="600" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
					<tr bgcolor="#E3E3E3" align="center">
						<td height="35">����</td>
						<td height="35"></td>
						<td height="35"></td>
						<td height="35"></td>
						<td height="35"></td>
						<td height="35">����</td>
						<td height="35">����</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30"><input type="checkbox" name="q_sel" checked disabled> ����</td>
						<td height="30"><input type="text" name="q1" size="2" value="" readonly></td>
						<td height="30"><input type="text" name="q2" size="5" value="����" readonly></td>
						<td height="30"><input type="text" name="q3" size="12" value="[0-9]" readonly></td>
						<td height="30"><input type="text" name="q4" size="2" value=")" readonly></td>
						<td height="30"><input type="text" name="q5" size="40" value="����1),����2),����3),����4),����5)" readonly></td>
						<td height="30"><input type="button" value="����" onClick="pattern_extract('q', document.writeForm.q1.value, document.writeForm.q2.value, document.writeForm.q3.value, document.writeForm.q4.value, document.writeForm.q5.value);"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30"><input type="checkbox" name="ex_sel" checked disabled> ����</td>
						<td height="30"><input type="text" name="e1" size="2" readonly></td>
						<td height="30"><input type="text" name="e2" size="5" readonly></td>
						<td height="30"><input type="text" name="e3" size="12" value="������" readonly></td>
						<td height="30"><input type="text" name="e4" size="2" readonly></td>
						<td height="30"><input type="text" name="e5" size="40" value="��,��,��,��,��" readonly></td>
						<td height="30"><input type="button" value="����" onClick="pattern_extract('e', document.writeForm.e1.value, document.writeForm.e2.value, document.writeForm.e3.value, document.writeForm.e4.value, document.writeForm.e5.value);"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30"><input type="checkbox" name="ca_sel" checked disabled> ����</td>
						<td height="30"><input type="text" name="c1" size="2" value="(" readonly></td>
						<td height="30"><input type="text" name="c2" size="5" value="����" readonly></td>
						<td height="30"><input type="text" name="c3" size="12" readonly></td>
						<td height="30"><input type="text" name="c4" size="2" value=")" readonly></td>
						<td height="30"><input type="text" name="c5" size="40" value="(����)" readonly></td>
						<td height="30"><input type="button" value="����" onClick="pattern_extract('c', document.writeForm.c1.value, document.writeForm.c2.value, document.writeForm.c3.value, document.writeForm.c4.value, document.writeForm.c5.value);"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30"><input type="checkbox" name="explain_sel"> �ؼ�</td>
						<td height="30"><input type="text" name="p1" size="2" value="(" readonly></td>
						<td height="30"><input type="text" name="p2" size="5" value="�ؼ�" readonly></td>
						<td height="30"><input type="text" name="p3" size="12" readonly></td>
						<td height="30"><input type="text" name="p4" size="2" value=")" readonly></td>
						<td height="30"><input type="text" name="p5" size="40" value="(�ؼ�)" readonly></td>
						<td height="30"><input type="button" value="����" onClick="pattern_extract('p', document.writeForm.p1.value, document.writeForm.p2.value, document.writeForm.p3.value, document.writeForm.p4.value, document.writeForm.p5.value);"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30"><input type="checkbox" name="hint_sel"> ��Ʈ</td>
						<td height="30"><input type="text" name="h1" size="2" value="(" readonly></td>
						<td height="30"><input type="text" name="h2" size="5" value="��Ʈ" readonly></td>
						<td height="30"><input type="text" name="h3" size="12" readonly></td>
						<td height="30"><input type="text" name="h4" size="2" value=")" readonly></td>
						<td height="30"><input type="text" name="h5" size="40" value="(��Ʈ)" readonly></td>
						<td height="30"><input type="button" value="����" onClick="pattern_extract('h', document.writeForm.h1.value, document.writeForm.h2.value, document.writeForm.h3.value, document.writeForm.h4.value, document.writeForm.h5.value);"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30"><input type="checkbox" name="diff_sel"> ���̵�</td>
						<td height="30"><input type="text" name="d1" size="2" value="(" readonly></td>
						<td height="30"><input type="text" name="d2" size="5" value="���̵�" readonly></td>
						<td height="30"><input type="text" name="d3" size="12" readonly></td>
						<td height="30"><input type="text" name="d4" size="2" value=")" readonly></td>
						<td height="30"><input type="text" name="d5" size="40" value="(���̵�)" readonly></td>
						<td height="30"><input type="button" value="����" onClick="pattern_extract('d', document.writeForm.d1.value, document.writeForm.d2.value, document.writeForm.d3.value, document.writeForm.d4.value, document.writeForm.d5.value);"></td>						
					</tr>
				</table>
			 </td>
		   </tr>
		</table>
		
		<td width="20"></td>
	</tr>	
</table>

	</div>

	<div style="display:;" id="id_diffs">

	<div class="tab"><a href="javascript:movieLayout('files');" onfocus="this.blur();">[�۾����ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('patterns');" onfocus="this.blur();">[���ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('diffs');" onfocus="this.blur();">[���̵�����]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('refs');" onfocus="this.blur();">[��������]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('results');" onfocus="this.blur();">[�۾����]</a></div>

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">&nbsp;&nbsp;�� ���̵�����</td>
		</tr>
	</table>
	
	<table border="0" width="650" height="300" cellspacing="1" cellpadding="3" bgcolor="#C3C3C3">
		<tr bgcolor="#FFFFFF">
			<td valign="top">
				<table border="0" width="600" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
					<tr bgcolor="#E3E3E3" align="center">
						<td height="35" width="150">����</td>
						<td height="35" width="50">�ڵ�</td>
						<td height="35" width="80">��</td>
						<td height="35" width="320"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30" align="right">���̵� ����&nbsp;</td>
						<td height="30" align="center">0</td>
						<td height="30" align="center"><input type="text" name="diff0" size="8" value="0" readonly></td>
						<td height="30">&nbsp;<input type="button" value="�����ϱ�" onClick="diff_extract();"></td>
					</tr>				
					<tr bgcolor="#FFFFFF">
						<td height="30" align="right">���� �����&nbsp;</td>
						<td height="30" align="center">1</td>
						<td height="30" align="center"><input type="text" name="diff1" size="8" value="1" readonly></td>
						<td height="30">&nbsp;<input type="button" value="�����ϱ�" onClick="diff_extract();"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30" align="right">�����&nbsp;</td>
						<td height="30" align="center">2</td>
						<td height="30" align="center"><input type="text" name="diff2" size="8" value="2" readonly></td>
						<td height="30">&nbsp;<input type="button" value="�����ϱ�" onClick="diff_extract();"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30" align="right">����&nbsp;</td>
						<td height="30" align="center">3</td>
						<td height="30" align="center"><input type="text" name="diff3" size="8" value="3" readonly></td>
						<td height="30">&nbsp;<input type="button" value="�����ϱ�" onClick="diff_extract();"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30" align="right">����&nbsp;</td>
						<td height="30" align="center">4</td>
						<td height="30" align="center"><input type="text" name="diff4" size="8" value="4" readonly></td>
						<td height="30">&nbsp;<input type="button" value="�����ϱ�" onClick="diff_extract();"></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="30" align="right">���� ����&nbsp;</td>
						<td height="30" align="center">5</td>
						<td height="30" align="center"><input type="text" name="diff5" size="8" value="5" readonly></td>
						<td height="30">&nbsp;<input type="button" value="�����ϱ�" onClick="diff_extract();"></td>
					</tr>
				</table>
			 </td>
		   </tr>
		</table>		
		<td width="20"></td>
	</tr>	
</table>

	</div>

	<div style="display:;" id="id_refs">

	<div class="tab"><a href="javascript:movieLayout('files');" onfocus="this.blur();">[�۾����ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('patterns');" onfocus="this.blur();">[���ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('diffs');" onfocus="this.blur();">[���̵�����]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('refs');" onfocus="this.blur();">[��������]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('results');" onfocus="this.blur();">[�۾����]</a></div>

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">&nbsp;&nbsp;�� ��������</td>
		</tr>
	</table>
	
	<table border="0" width="650" height="500" cellspacing="1" cellpadding="3" bgcolor="#C3C3C3">
		<tr bgcolor="#FFFFFF">
			<td valign="top">
        <table border="0">
		<tr bgcolor="#FFFFFF">
			<td valign="top">
				<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
					<tr bgcolor="#FFFFFF">
						<td width="600" >
						�� ������ ������ ���ԵǾ� �ִٸ� ���α׷��� ���� ������ �ν��� �� �ְ� ���� ������ �� �� �ִ� ���� ���ڸ� �����ؾ� �˴ϴ�.<br>
						�⺻���� '��' �Դϴ�.
						</td>			
					</tr>
				 </table>
			 </td>
		 </tr>
		 <tr bgcolor="#FFFFFF">
			<td height="10"></td>
		  </tr>
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
				<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
					<tr bgcolor="#FFFFFF">
						<td width="600">
						QM&TM�� Question Manager & Test Manager�� ���ڷ� �پ��� ������ ������ ������ ���, ������ �� �ִ� ���׽�Ʈ �¶��� �� �ַ���� ��ǰ���Դϴ�. 
						���輺�ݿ� ���� ����, ���ǰ����, �н��� ������ �����ڰ� �����Ͽ� ������ �� �ֽ��ϴ�. ���蹮���� ������ �� �پ��� Random ��� �� ���ϴ� ����� 
						�����Ͽ� ������ �� �ֽ��ϴ�.<br>
						������ ���ø� ������ �������� ���輺�ݿ� �´� ������ �������� �����Ͽ� ����� �� �ֽ��ϴ�. ������ ��ȸ �� ���� ����ڷᰡ Excel File�� �����ǹǷ� 
						���ϴ� ������ ������ �����մϴ�.
						</td>			
					</tr>
				 </table>
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
		</td>
		</tr>
		</table>
		<td width="20"></td>
	</tr>	
</table>

	</div>

	<div style="display:;" id="id_results">

	<div class="tab"><a href="javascript:movieLayout('files');" onfocus="this.blur();">[�۾����ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('patterns');" onfocus="this.blur();">[���ϼ���]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('diffs');" onfocus="this.blur();">[���̵�����]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('refs');" onfocus="this.blur();">[��������]</a>&nbsp;&nbsp;<a href="javascript:movieLayout('results');" onfocus="this.blur();">[�۾����]</a></div>
		
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">&nbsp;&nbsp;�� �۾����</td>
		</tr>
	</table>

	<table border="0" width="650" height="500" cellspacing="1" cellpadding="3" bgcolor="#C3C3C3">
		<tr bgcolor="#FFFFFF">
			<td valign="top">				
				<table border="0">
					<tr>
						<td width="600" >
						<div id="workdiv" style="width: 100%;"></div>
						</td>			
					</tr>
				</table>
		     </td>
		   </tr>
		</table>
		<td width="20"></td>
	</tr>	
</table>

	</div>

</form>
</body></html>
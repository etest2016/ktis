<%
//******************************************************************************
//   ���α׷� : batchFile_ok.jsp
//   �� �� �� : �ϰ����� ���
//   ��    �� : 
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2010-06-20
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>    

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*, java.util.*, com.tagfree.util.*, org.w3c.tidy.*, org.w3c.dom.*, qmtm.*, qmtm.qman.editor.*, qmtm.qman.*, qmtm.admin.etc.EnvUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String web_path = "";
	
	try {
		web_path = EnvUtil.getWEB("qmtm");
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String ftp_path = "";
	
	// FTP ��� ����
	try {
		ftp_path = EnvUtil.getFTP("qmtm");
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>	


<script language="javascript">

function go(ing,end){

  document.all.div1.style.width = (ing+1)/end*100+"%";
  document.all.div2.innerHTML = parseInt((ing+1)/end*100,10)+"%������";
 //ing+1 �ϴ������� (ing+1)/end*100  =0 �̵Ǹ� ������ ���� ����
}

</script>

<Table width="550" height="50" border="0" align="center">

<tr>
 <td valign="middle">
  <div id ="div2" align="center" style="margin-top:10;width:100%;height:30px;color:#FF00FF;font-size:11px;"></div>
  <div id ="div1" style="whdth:0px;height:30px;background-color:#6666FF;"></div>
 </td>
</tr>

</table> 

<%	
	String q = "";

	try
	{		
		String userid = CommonUtil.get_Cookie(request, "userid");

		// ī�װ� ����
		String id_subject = request.getParameter("id_q_subject");
		if (id_subject == null) { id_subject = "-1"; } else { id_subject = id_subject.trim(); }
		String id_chapter = request.getParameter("id_q_chapter");
		if (id_chapter == null) { id_chapter = "-1"; } else { id_chapter = id_chapter.trim(); }
		String id_chapter2 = request.getParameter("id_q_chapter2");
		if (id_chapter2 == null) { id_chapter2 = "-1"; } else { id_chapter2 = id_chapter2.trim(); }
		String id_chapter3 = request.getParameter("id_q_chapter3");
		if (id_chapter3 == null) { id_chapter3 = "-1"; } else { id_chapter3 = id_chapter3.trim(); }
		String id_chapter4 = request.getParameter("id_q_chapter4");
		if (id_chapter4 == null) { id_chapter4 = "-1"; } else { id_chapter4 = id_chapter4.trim(); }

		String qcounts = request.getParameter("qcounts");
		if (qcounts == null) { qcounts = "0"; } else { qcounts = qcounts.trim(); }

		int qcount = 0;

		if(qcounts.equals("0"))	{
%>
		<script language="javascript">
			alert("���׼��� �Է��ϼž� �մϴ�.");
			history.back();
		</script>
<%
		} else {
			qcount = Integer.parseInt(qcounts);
		}

		String q1 = request.getParameter("q1");
		if (q1 == null) { q1 = ""; } else { q1 = q1.trim(); }
		String q2 = request.getParameter("q2");
		if (q2 == null) { q2 = ""; } else { q2 = q2.trim(); }
		String q3 = request.getParameter("q3");
		if (q3 == null) { q3 = ""; } else { q3 = q3.trim(); }
		String q4 = request.getParameter("q4");
		if (q4 == null) { q4 = ""; } else { q4 = q4.trim(); }

		String q_res = QmTm.Q_GUBUN;

		String e1 = request.getParameter("e1");
		if (e1 == null) { e1 = ""; } else { e1 = e1.trim(); }
		String e2 = request.getParameter("e2");
		if (e2 == null) { e2 = ""; } else { e2 = e2.trim(); }
		String e3 = request.getParameter("e3");
		if (e3 == null) { e3 = ""; } else { e3 = e3.trim(); }
		String e4 = request.getParameter("e4");
		if (e4 == null) { e4 = ""; } else { e4 = e4.trim(); }

		String c1 = request.getParameter("c1");
		if (c1 == null) { c1 = ""; } else { c1 = c1.trim(); }
		String c2 = request.getParameter("c2");
		if (c2 == null) { c2 = ""; } else { c2 = c2.trim(); }
		String c4 = request.getParameter("c4");
		if (c4 == null) { c4 = ""; } else { c4 = c4.trim(); }
		String ca_ptn = c1+c2+c4;

		String p1 = request.getParameter("p1");
		if (p1 == null) { p1 = ""; } else { p1 = p1.trim(); }
		String p2 = request.getParameter("p2");
		if (p2 == null) { p2 = ""; } else { p2 = p2.trim(); }
		String p4 = request.getParameter("p4");
		if (p4 == null) { p4 = ""; } else { p4 = p4.trim(); }
		String explain_ptn = p1+p2+p4;

		String h1 = request.getParameter("h1");
		if (h1 == null) { h1 = ""; } else { h1 = h1.trim(); }
		String h2 = request.getParameter("h2");
		if (h2 == null) { h2 = ""; } else { h2 = h2.trim(); }
		String h4 = request.getParameter("h4");
		if (h4 == null) { h4 = ""; } else { h4 = h4.trim(); }
		String hint_ptn = h1+h2+h4;

		String d1 = request.getParameter("d1");
		if (d1 == null) { d1 = ""; } else { d1 = d1.trim(); }
		String d2 = request.getParameter("d2");
		if (d2 == null) { d2 = ""; } else { d2 = d2.trim(); }
		String d4 = request.getParameter("d4");
		if (d4 == null) { d4 = ""; } else { d4 = d4.trim(); }
		String diff_ptn = d1+d2+d4;

		String diff0 = request.getParameter("diff0");
		if (diff0 == null) { diff0 = ""; } else { diff0 = diff0.trim(); }
		String diff1 = request.getParameter("diff1");
		if (diff1 == null) { diff1 = ""; } else { diff1 = diff1.trim(); }
		String diff2 = request.getParameter("diff2");
		if (diff2 == null) { diff2 = ""; } else { diff2 = diff2.trim(); }
		String diff3 = request.getParameter("diff3");
		if (diff3 == null) { diff3 = ""; } else { diff3 = diff3.trim(); }
		String diff4 = request.getParameter("diff4");
		if (diff4 == null) { diff4 = ""; } else { diff4 = diff4.trim(); }
		String diff5 = request.getParameter("diff5");
		if (diff5 == null) { diff5 = ""; } else { diff5 = diff5.trim(); }

		String explain_sel2 = request.getParameter("explain_sel");
		if (explain_sel2 == null) { explain_sel2 = "off"; } else { explain_sel2 = explain_sel2.trim(); }
		String hint_sel2 = request.getParameter("hint_sel");
		if (hint_sel2 == null) { hint_sel2 = "off"; } else { hint_sel2 = hint_sel2.trim(); }
		String diff_sel2 = request.getParameter("diff_sel");
		if (diff_sel2 == null) { diff_sel2 = "off"; } else { diff_sel2 = diff_sel2.trim(); }

		String ref_gubun = request.getParameter("ref_gubun");

		String munje_result = request.getParameter("munje_result");
		if (munje_result == null) { munje_result = ""; } else { munje_result = munje_result.trim(); }

		String[] arrMunje_result = munje_result.split(",");

		boolean explain_sel = false;
		boolean hint_sel = false;
		boolean diff_sel = false;

		if(explain_sel2.equals("on")) {
			explain_sel = true;
		}

		if(hint_sel2.equals("on")) {
			hint_sel = true;
		}

		if(diff_sel2.equals("on")) {
			diff_sel = true;
		}
				
		q = QmTm.getNullChk(request.getParameter("mime_contents"));
		
		File dir = new File(ftp_path+id_subject);

        try {
            if (!dir.exists()) {
                dir.mkdir();
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
		
		boolean bReaname = true; // ������ ���͸��� ������ ������ ��� ���ο� �̸��� �����Ѵ�.
		String strSavePath = ftp_path+id_subject; // ���� �� ������ ����Ǵ� ���͸��� �����Ѵ�.
		String strSaveUrl = web_path+id_subject; // ���� �� ������ ����Ǵ� ���͸��� �� URL ��θ� �����Ѵ�.
		
		String strMimeValue = request.getParameter("mime_contents2"); 

		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil ����		
		util.setMimeValue(strMimeValue); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util.setSavePath(strSavePath); // ���� ���͸� ����
		util.setSaveUrl(strSaveUrl); // URL ��� ����

		util.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�.

		strMimeValue = util.getDecodedHtml(false);

		strMimeValue = strMimeValue.replace("\"","");
				
		//�ܺΰ�ü�� ���ԵǾ������
		if(strMimeValue.indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			strMimeValue = strMimeValue.replace("<?xml","<xml");
			strMimeValue = strMimeValue.replace("\"","");

			strMimeValue = HtmlParser.html_parser(strMimeValue, strSaveUrl);
		}

		q = strMimeValue.replace("</BODY>","");
		q = strMimeValue.replace("</HTML>","");
		
		//*****************************************************************

		String results = q;

		for(int k=0; k<=100; k++) {

			results = results.replace(q1+""+q2+k+""+q4, q_res);			
			results = results.replace(q1+""+q2+k+" "+q4, q_res);
			results = results.replace(q1+""+q2+k+"  "+q4, q_res);
			results = results.replace(q1+""+q2+k+"   "+q4, q_res);

			results = results.replace(q1+" "+q2+k+""+q4, q_res);
			results = results.replace(q1+" "+q2+k+" "+q4, q_res);
			results = results.replace(q1+" "+q2+k+"  "+q4, q_res);
			results = results.replace(q1+" "+q2+k+"   "+q4, q_res);

			results = results.replace(q1+"  "+q2+k+""+q4, q_res);
			results = results.replace(q1+"  "+q2+k+" "+q4, q_res);
			results = results.replace(q1+"  "+q2+k+"  "+q4, q_res);
			results = results.replace(q1+"  "+q2+k+"   "+q4, q_res);

			
			results = results.replace(q1+""+q2+" "+k+""+q4, q_res);
			results = results.replace(q1+""+q2+" "+k+" "+q4, q_res);
			results = results.replace(q1+""+q2+" "+k+"  "+q4, q_res);
			results = results.replace(q1+""+q2+" "+k+"   "+q4, q_res);

			results = results.replace(q1+" "+q2+" "+k+""+q4, q_res);
			results = results.replace(q1+" "+q2+" "+k+" "+q4, q_res);
			results = results.replace(q1+" "+q2+" "+k+"  "+q4, q_res);
			results = results.replace(q1+" "+q2+" "+k+"   "+q4, q_res);

			results = results.replace(q1+"  "+q2+" "+k+""+q4, q_res);
			results = results.replace(q1+"  "+q2+" "+k+" "+q4, q_res);
			results = results.replace(q1+"  "+q2+" "+k+"  "+q4, q_res);
			results = results.replace(q1+"  "+q2+" "+k+"   "+q4, q_res);


			results = results.replace(q1+""+q2+"  "+k+""+q4, q_res);
			results = results.replace(q1+""+q2+"  "+k+" "+q4, q_res);
			results = results.replace(q1+""+q2+"  "+k+"  "+q4, q_res);
			results = results.replace(q1+""+q2+"  "+k+"   "+q4, q_res);

			results = results.replace(q1+" "+q2+"  "+k+""+q4, q_res);
			results = results.replace(q1+" "+q2+"  "+k+" "+q4, q_res);
			results = results.replace(q1+" "+q2+"  "+k+"  "+q4, q_res);
			results = results.replace(q1+" "+q2+"  "+k+"   "+q4, q_res);

			results = results.replace(q1+"  "+q2+"  "+k+""+q4, q_res);
			results = results.replace(q1+"  "+q2+"  "+k+" "+q4, q_res);
			results = results.replace(q1+"  "+q2+"  "+k+"  "+q4, q_res);
			results = results.replace(q1+"  "+q2+"  "+k+"   "+q4, q_res);				
		}

		q = results;
		
		String[] arrImsiQs;

		arrImsiQs = q.split(QmTm.Q_GUBUN_re, -1);

		String qImsi = "";
		String qstrs = "";

		for(int imsi=0;imsi<arrImsiQs.length;imsi++) {
		
			qstrs = q_res+" "+arrImsiQs[imsi];			

			//out.println(qstrs);

			qImsi = qImsi + qstrs.replace(q_res, q1+q2+imsi+q4);
		}

		q = qImsi.replace(q1+q2+"0"+q4,"");

		//*****************************************************************

		String[] arrQ = new String[qcount];
		String[] arrQs = new String[qcount];
		String[] arrEx1 = new String[qcount];
		String[] arrEx2 = new String[qcount];
		String[] arrEx3 = new String[qcount];
		String[] arrEx4 = new String[qcount];
		String[] arrEx5 = new String[qcount];
		String[] arrCa = new String[qcount];
		String[] arrExplain = new String[qcount];
		String[] arrHint = new String[qcount];
		String[] arrDifficulty = new String[qcount];
		int[] arrQtype = new int[qcount];
		int[] arrExcount = new int[qcount];
		int[] arrCacount = new int[qcount];
		
		if(q3.equals("[0-9]")) {
			
			for(int a=0; a<qcount; a++)
			{							
				if(a == (qcount - 1)) {
					arrQ[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_result[a]+q4));
				} else {
					arrQ[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_result[a]+q4),q.indexOf(q1+q2+arrMunje_result[a+1]+q4));
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
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(hint_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(diff_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							}					

						}
						
					} else {
					
						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(explain_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(hint_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = "";
								
							} else {

								if(a == (qcount - 1)) {
									arrQs[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_result[a]+q4)).replace(q1+q2+arrMunje_result[a]+q4,"");
								} else {
									arrQs[a] = q.substring(q.lastIndexOf(q1+q2+arrMunje_result[a]+q4),q.indexOf(q1+q2+arrMunje_result[a+1]+q4)).replace(q1+q2+arrMunje_result[a]+q4,"");
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
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
							}					

						}
						
					} else {
					
						if(explain_sel) {							
							
							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
								arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,"");
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}

						} else { 

							if(hint_sel) {
							
								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
								arrDifficulty[a] = "";
								
							} else {

								arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(ca_ptn)).replace(q1+q2+arrMunje_result[a]+q4,"");
								arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,"");
								arrExplain[a] = "";
								arrHint[a] = "";
								arrDifficulty[a] = "";
								
							}					

						}

					}		

					if(arrCa[a].indexOf("{|}") == -1) { 
						arrCacount[a] = 1;						
					} else {
						String[] arrImsi = arrCa[a].split(QmTm.OR_GUBUN_re,-1);
						arrCacount[a] = arrImsi.length;
					}					

				}

				continue;

			} 

			if(arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4) == -1) { // ������ 3�� ���Ⱑ ���� ���(OX������)

				arrQtype[a] = 1;
				arrExcount[a] = 2;								
				
				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}					

					}
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}					

					}								

				}	

				if(arrCa[a].indexOf("{|}") == -1) { 
					arrCacount[a] = 1;						
				} else {
					String[] arrImsi = arrCa[a].split(QmTm.OR_GUBUN_re,-1);
					arrCacount[a] = arrImsi.length;
				}

				continue;

			} 

			
			if(arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4) == -1) { // ������ 4�� ���Ⱑ ���� ���

				arrExcount[a] = 3;				
				
				
				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}					

					}
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,"");
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
					String[] arrImsi = arrCa[a].split(QmTm.OR_GUBUN_re,-1);
					arrCacount[a] = arrImsi.length;
					arrQtype[a] = 3;
				}

				continue;

			} 


			if(arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4) == -1) { // ������ 5�� ���Ⱑ ���� ���
				
				arrExcount[a] = 4;
								
				
				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}					

					}
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,"");
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
					String[] arrImsi = arrCa[a].split(QmTm.OR_GUBUN_re,-1);
					arrCacount[a] = arrImsi.length;
					arrQtype[a] = 3;
				}


				continue;

			} else { // ������ 5�� ���Ⱑ ���� ���

				arrExcount[a] = 5;


				if(diff_sel) { // ���̵����� ���� �������

					if(explain_sel) { // �ؼ����� ���� �������
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(diff_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn),arrQ[a].indexOf(diff_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
							
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(diff_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = "";
							arrDifficulty[a] = arrQ[a].substring(arrQ[a].lastIndexOf(diff_ptn)).replace(diff_ptn,"");
								
						}					

					}
						
				} else { // ���̵����� ���� ���������
					
					if(explain_sel) { // �ؼ����� ���� �������							
							
						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn),arrQ[a].indexOf(hint_ptn)).replace(explain_ptn,"");
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(explain_ptn)).replace(ca_ptn,"");
							arrExplain[a] = arrQ[a].substring(arrQ[a].lastIndexOf(explain_ptn)).replace(explain_ptn,"");
							arrHint[a] = "";
							arrDifficulty[a] = "";
								
						}

					} else { // �ؼ����� ���� ���������

						if(hint_sel) { // ��Ʈ���� ���� �������
							
							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn),arrQ[a].indexOf(hint_ptn)).replace(ca_ptn,"");
							arrExplain[a] = "";
							arrHint[a] = arrQ[a].substring(arrQ[a].lastIndexOf(hint_ptn)).replace(hint_ptn,"");
							arrDifficulty[a] = "";
								
						} else { // ��Ʈ���� ���� ���������

							arrQs[a] = arrQ[a].substring(arrQ[a].lastIndexOf(q1+q2+arrMunje_result[a]+q4),arrQ[a].indexOf(e1+e2+e3.substring(0,1)+e4)).replace(q1+q2+arrMunje_result[a]+q4,"");
							arrEx1[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(0,1)+e4),arrQ[a].indexOf(e1+e2+e3.substring(1,2)+e4)).replace(e1+e2+e3.substring(0,1)+e4,"");
							arrEx2[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(1,2)+e4),arrQ[a].indexOf(e1+e2+e3.substring(2,3)+e4)).replace(e1+e2+e3.substring(1,2)+e4,"");
							arrEx3[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(2,3)+e4),arrQ[a].indexOf(e1+e2+e3.substring(3,4)+e4)).replace(e1+e2+e3.substring(2,3)+e4,"");
							arrEx4[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(3,4)+e4),arrQ[a].indexOf(e1+e2+e3.substring(4,5)+e4)).replace(e1+e2+e3.substring(3,4)+e4,"");
							arrEx5[a] = arrQ[a].substring(arrQ[a].lastIndexOf(e1+e2+e3.substring(4,5)+e4),arrQ[a].indexOf(ca_ptn)).replace(e1+e2+e3.substring(4,5)+e4,"");
							arrCa[a] = arrQ[a].substring(arrQ[a].lastIndexOf(ca_ptn)).replace(ca_ptn,"");
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
					String[] arrImsi = arrCa[a].split(QmTm.OR_GUBUN_re,-1);
					arrCacount[a] = arrImsi.length;
					arrQtype[a] = 3;
				}
					
			}

		} // for�� ����
	} // if�� ����	
	
		String refNoAll = request.getParameter("refNoAll");
		if (refNoAll == null || refNoAll == "") { refNoAll = ""; } else { refNoAll = refNoAll.trim(); }
		String refTitleAll = request.getParameter("refTitleAll");
		String refContentAll = request.getParameter("refContentAll");

		String refCodeAll = "";

		String[] arrId_ref = null;
		String[] arrRefTitle = null;
		String[] arrRefContent = null;

		String[] arrRefCode = null;

		if(refNoAll == "") { // ������ �������
		} else { // ������ �������
			QRefBean beans = new QRefBean();

			arrId_ref = refNoAll.split(QmTm.LIKE_GUBUN_re,-1);
			arrRefTitle = refTitleAll.split(QmTm.LIKE_GUBUN_re,-1);
			arrRefContent = refContentAll.split(QmTm.LIKE_GUBUN_re,-1);

			for(int i=0; i<arrId_ref.length-1; i++) {
				String ref_code = CommonUtil.getMakeID("R");

				beans.setId_ref(ref_code);
				beans.setReftitle(arrRefTitle[i].replaceAll("\r\n",""));
	
				StringBuffer buf = new StringBuffer(arrRefContent[i].replaceAll("\r\n",""));

				String refbody1,refbody2, refbody3;

				if (buf.length() <= 2000) {
					refbody1 = buf.substring(0); refbody2 = ""; refbody3 = "";
				} else if (buf.length() <= 4000) {
					refbody1 = buf.substring(0, 2000);
					refbody2 = buf.substring(2000);
					refbody3 = "";
				} else {
					refbody1 = buf.substring(0, 2000);
					refbody2 = buf.substring(2000, 4000);
					refbody3 = buf.substring(4000); // �ִ� 6000 �� ����
				}
				if (refbody1.length() > 0) {			    
					beans.setRefbody1(refbody1);
					beans.setRefbody2(refbody2);
					beans.setRefbody3(refbody3);
				}

				refCodeAll += ref_code + "{^}";
				
				// ���� ���..				
				try {
					QUtil.insertRef(beans);
				} catch(Exception ex) {
					out.println(ComLib.getExceptionMsg(ex, "back"));
				
					if(true) return;
				}
			}			
		}
		
	for(int k=0; k < qcount; k++) {

		boolean refYN = false;

			String refNos = "";

			// ������ ���� ����
			if(refNoAll == "") { // ������ �������				
				refYN = false;
			} else { // ������ �������	
				
				String[] arrRefNo = null;
				arrRefCode = refCodeAll.split(QmTm.LIKE_GUBUN_re,-1);

				for(int x=0;x<arrId_ref.length-1;x++) {			
					arrRefNo = arrId_ref[x].split(QmTm.Q_GUBUN_re, -1); 
					for(int y=0;y<arrRefNo.length;y++) {
						if(arrRefNo[y] == null || arrRefNo[y].equals("")) {
							continue;
						} else {
							if((k+1) == Integer.parseInt(arrRefNo[y])) {
								refYN = true;
								break;
							}
						}
					}

					if(refYN) {
						refNos = arrRefCode[x];
						break;
					}
				}

			}
		
		int id_difficulty1 = 0;
		
		QBatchBean bean = new QBatchBean();

		if(arrDifficulty[k].indexOf(ref_gubun) == -1) {
			arrDifficulty[k] = arrDifficulty[k];
		} else {
			arrDifficulty[k] = arrDifficulty[k].substring(0,arrDifficulty[k].indexOf(ref_gubun));
		}

		arrDifficulty[k] = ComLib.removeNBSP(ComLib.removeBR(ComLib.nullChk(arrDifficulty[k])));
		
		if(arrDifficulty[k].trim().equals(diff0.trim())) {
			id_difficulty1 = 0;
		} else if(arrDifficulty[k].trim().equals(diff1.trim())) {
			id_difficulty1 = 1;
		} else if(arrDifficulty[k].trim().equals(diff2.trim())) {
			id_difficulty1 = 2;
		} else if(arrDifficulty[k].trim().equals(diff3.trim())) {
			id_difficulty1 = 3;
		} else if(arrDifficulty[k].trim().equals(diff4.trim())) {
			id_difficulty1 = 4;
		} else if(arrDifficulty[k].trim().equals(diff5.trim())) {
			id_difficulty1 = 5;
		}

		bean.setId_subject(id_subject);
		bean.setId_chapter(id_chapter);
		bean.setId_chapter2(id_chapter2);
		bean.setId_chapter3(id_chapter3);
		bean.setId_chapter4(id_chapter4);
		
		if(refYN) {
				bean.setId_ref(refNos);
			} else {
				bean.setId_ref("0");
			}

		bean.setId_qtype(arrQtype[k]);
		bean.setExcount(arrExcount[k]);
		bean.setCacount(arrCacount[k]);
		bean.setId_difficulty1(id_difficulty1);
		bean.setQ(ComLib.toStrHtml2(ComLib.removeNBSP(ComLib.nullChk(arrQs[k]))));
		bean.setEx1(ComLib.toStrHtml2(ComLib.removeNBSP(ComLib.removeBR(ComLib.nullChk(arrEx1[k])))));
		bean.setEx2(ComLib.toStrHtml2(ComLib.removeNBSP(ComLib.removeBR(ComLib.nullChk(arrEx2[k])))));
		bean.setEx3(ComLib.toStrHtml2(ComLib.removeNBSP(ComLib.removeBR(ComLib.nullChk(arrEx3[k])))));
		bean.setEx4(ComLib.toStrHtml2(ComLib.removeNBSP(ComLib.removeBR(ComLib.nullChk(arrEx4[k])))));
		bean.setEx5(ComLib.toStrHtml2(ComLib.removeNBSP(ComLib.removeBR(ComLib.nullChk(arrEx5[k])))));

		if(arrCa[k].indexOf(ref_gubun) == -1) {
			arrCa[k] = arrCa[k];
		} else {
			arrCa[k] = arrCa[k].substring(0,arrCa[k].indexOf(ref_gubun));
		}

		bean.setCa(ComLib.toStrHtml2(ComLib.removeNBSP(ComLib.removePre(ComLib.removeBR(ComLib.nullChk(arrCa[k]))))));

		if(arrExplain[k].indexOf(ref_gubun) == -1) {
			arrExplain[k] = arrExplain[k];
		} else {
			arrExplain[k] = arrExplain[k].substring(0,arrExplain[k].indexOf(ref_gubun));
		}

		bean.setExplain(ComLib.toStrHtml2(ComLib.removeBR(ComLib.nullChk(arrExplain[k]))));

		if(arrHint[k].indexOf(ref_gubun) == -1) {
			arrHint[k] = arrHint[k];
		} else {
			arrHint[k] = arrHint[k].substring(0,arrHint[k].indexOf(ref_gubun));
		}

		bean.setHint(ComLib.toStrHtml2(ComLib.removeBR(ComLib.nullChk(arrHint[k]))));
		bean.setUserid(userid);

		// ���� ��� ����
		try {
			QBatchUtil.insert(bean);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));
						
			if(true) return;
		}		
		// ���� ��� ����
	
		//out.println("<script>go("+k+","+(qcount-1)+")</script>");
	}

	// ����Ƚ�� ��� ����
	try {
		QUtil.makecntAdd();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));
		
		if(true) return;
	}
	// ����Ƚ�� ��� ����
	
	} catch(Exception e) 
	{
		e.printStackTrace();
	} 
	
	if(q.equals("")) {
%>
<script language="javascript">
	alert("���� �ϰ���� �۾��߿� ������ �߻��߽��ϴ�.\n\n�̹��� ������ ���������� ���ԵǾ� �������\n\n���� Size�� Ŭ��� ���ε尡 ���� �ʴ°�찡 �ֽ��ϴ�.\n\n�̹��� ������ ������ �� �ٽ� �������ֽñ� �ٶ��ϴ�.\n\n\n����ؼ� ������ �߻��� ��� �����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
	window.opener.location.reload();
	window.close();
</script>
<%
	} else {
%>
<script language="javascript">
	alert("���׵���� �Ϸ�Ǿ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>
<% } %>
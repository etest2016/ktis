<%
//******************************************************************************
//   ���α׷� : q_search_ok.jsp
//   �� �� �� : ���� �˻� ������
//   ��    �� : �˻��Ǿ��� ���� ������ ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2008-04-22
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String prof_userid = CommonUtil.get_Cookie(request, "userid");    
	if (prof_userid == null) { prof_userid= ""; } else { prof_userid = prof_userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String subjects = request.getParameter("subjects");

	String cpt1 = request.getParameter("cpt1");
	String chapter1 = request.getParameter("chapter1");	
	String cpt2 = request.getParameter("cpt2");
	String chapter2 = request.getParameter("chapter2");	
	String cpt3 = request.getParameter("cpt3");
	String chapter3 = request.getParameter("chapter3");	
	String cpt4 = request.getParameter("cpt4");
	String chapter4 = request.getParameter("chapter4");	

	String qte = request.getParameter("qte");
	String qtype = request.getParameter("qtype");

	String diff = request.getParameter("diff");
	String difficulty = request.getParameter("difficulty");
			
	String regdate = request.getParameter("regdate");
	String regdate1 = request.getParameter("regdate1");
	String regdate2 = request.getParameter("regdate2");

	String updates = request.getParameter("updates");
	String updates1 = request.getParameter("updates1");
	String updates2 = request.getParameter("updates2");

	String q_cnt = request.getParameter("q_cnt");
	String q_cnt1 = request.getParameter("q_cnt1");
	String q_cnt2 = request.getParameter("q_cnt2");

	String q_use = request.getParameter("q_use");	
	String q_uses = request.getParameter("q_uses");
	
	String q_use2 = request.getParameter("q_use2");
	String q_uses2 = request.getParameter("q_uses2");

	ExamSearchBean bean = new ExamSearchBean();
	
	bean.setSubjects(subjects);
	bean.setCpt1(cpt1);
	bean.setChapter1(chapter1);
	bean.setCpt2(cpt2);
	bean.setChapter2(chapter2);
	bean.setCpt3(cpt3);
	bean.setChapter3(chapter3);
	bean.setCpt4(cpt4);
	bean.setChapter4(chapter4);

	bean.setQte(qte);
	bean.setQtype(qtype);

	bean.setDiff(diff);
	bean.setDifficulty(difficulty);

	bean.setRegdate(regdate);
	bean.setRegdate1(regdate1);
	bean.setRegdate2(regdate2);

	bean.setUpdates(updates);
	bean.setUpdates1(updates1);
	bean.setUpdates2(updates2);

	bean.setQ_cnt(q_cnt);
	bean.setQ_cnt1(q_cnt1);
	bean.setQ_cnt2(q_cnt2);

	bean.setQ_use(q_use);
	bean.setQ_uses(q_uses);

	bean.setQ_use2(q_use2);
	bean.setQ_uses2(q_uses2);

	// ���� �˻�
	ExamSearchResBean[] rst = null;
	try {
	    rst = ExamUtil.getSearchBeans(bean, prof_userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	if(rst == null) {
%>
	<Script language="JavaScript">
		alert("��ϵǾ��� ������ �����ϴ�.");
		location.href="q_search.jsp?id_exam=<%=id_exam%>";
	</Script>	
<%
		if(true) return;

	} else {
		String idqs = "";
		String qtypes = "";
		String diffs = "";
		String id_refs = "";

		int lngcnt = rst.length;
	
		String[] arrId_qs = new String[lngcnt];
		String[] arrQs = new String[lngcnt];
		int[] arrId_qtypes = new int[lngcnt];
		int[] arrId_difficultys = new int[lngcnt];
		String[] arrDiffs = new String[lngcnt];
		String[] arrQtypes = new String[lngcnt];
		String[] arrId_refs = new String[lngcnt];
		String[] arrRefs = new String[lngcnt];
		double[] arrAllottings = new double[lngcnt]; 
		String[] arrQ = new String[lngcnt];
		String[] arrQ1 = new String[lngcnt];
		String[] arrId_subject = new String[lngcnt];
		String[] arrMake_cnt = new String[lngcnt];

		for(int k=0; k<lngcnt; k++) {
			arrId_qs[k] = String.valueOf(rst[k].getId_q());
			arrId_qtypes[k] = rst[k].getId_qtype();
			arrId_difficultys[k] = rst[k].getId_difficulty1();
			arrId_refs[k] = rst[k].getId_ref();
			arrAllottings[k] = rst[k].getAllotting();
			arrQ[k] = rst[k].getQ();
			arrQ[k] = arrQ[k].replace("&lt;","<");
			arrQ[k] = arrQ[k].replace("&gt;",">");
			arrQ[k] = arrQ[k].replace("&nbsp;","");
			arrQ[k] = arrQ[k].replace("(","");
			arrQ[k] = arrQ[k].replace(")","");
			arrQ[k] = arrQ[k].replace("'","");
			arrId_subject[k] = rst[k].getId_subject();
			arrMake_cnt[k] = String.valueOf(rst[k].getMake_cnt());
		}
%>

<script language="JavaScript">

	var obj = opener.document.getElementById("q_list");
	
	obj.length = 0; 

	var firstWin = window.opener;
	//firstWin.document.form1.qcnts.value = "    �˻��� ���� �� : " + <%=rst.length%> + " ����";
	firstWin.document.form1.qcnts.value = <%=lngcnt%>;
	
	<% 
		for(int i=0; i<lngcnt; i++) { 

			if(arrId_qs[i].length() == 1) {
				arrQs[i] = arrId_qs[i] + "        ";
			} else if(arrId_qs[i].length() == 2) {
				arrQs[i] = arrId_qs[i] + "      ";
			} else if(arrId_qs[i].length() == 3) {
				arrQs[i] = arrId_qs[i] + "    ";
			} else if(arrId_qs[i].length() == 4) {
				arrQs[i] = arrId_qs[i] + "   ";
			} else if(arrId_qs[i].length() == 5) {
				arrQs[i] = arrId_qs[i] + " ";
			} else if(arrId_qs[i].length() == 6) {
				arrQs[i] = arrId_qs[i] + "";
			} else {
				arrQs[i] = arrId_qs[i] + "";
			}
			
			if(arrId_qtypes[i] == 1) {
				arrQtypes[i] = "OX��          ";
			} else if(arrId_qtypes[i] == 2) {
				arrQtypes[i] = "������        ";
			} else if(arrId_qtypes[i] == 3) {
				arrQtypes[i] = "���������  ";
			} else if(arrId_qtypes[i] == 4) {
				arrQtypes[i] = "�ܴ���        ";
			} else if(arrId_qtypes[i] == 5) {
				arrQtypes[i] = "�����        ";
			} 

			if(arrId_difficultys[i] == 0) {
				arrDiffs[i] = "����         ";
			} else if(arrId_difficultys[i] == 1) {
				arrDiffs[i] = "�ֻ�         ";
			} else if(arrId_difficultys[i] == 2) {
				arrDiffs[i] = "��            ";
			} else if(arrId_difficultys[i] == 3) {
				arrDiffs[i] = "��            ";
			} else if(arrId_difficultys[i] == 4) {
				arrDiffs[i] = "��            ";
			} else if(arrId_difficultys[i] == 5) {
				arrDiffs[i] = "����         ";
			} 

			if(arrId_refs[i].length() == 1) {
				arrRefs[i] = "          "+arrId_refs[i]+"            ";
			} else {
				arrRefs[i] = arrId_refs[i]+"";
			}

			if(arrMake_cnt[i].length() == 1) {
				arrMake_cnt[i] = "          "+arrMake_cnt[i]+"            ";
			} else {
				arrMake_cnt[i] = "         "+arrMake_cnt[i]+"           ";
			}

			if(arrQ[i].length() > 20) {
				arrQ1[i] = arrQ[i].substring(0,20); 
			} else {
				arrQ1[i] = arrQ[i];
			}
				
	%>			
		var addOpt=opener.document.createElement("OPTION");
		addOpt.text = "<%=arrQs[i]%>   <%=arrQtypes[i]%><%=arrDiffs[i]%><%=arrAllottings[i]%>    <%=arrMake_cnt[i]%>    <%=QmTm.changeTag(QmTm.changeChar(arrQ1[i].trim()))%>";
		addOpt.name= "qs";		
		addOpt.value = "<%=arrQs[i]%>||<%=arrQtypes[i]%>||<%=arrDiffs[i]%>||<%=arrAllottings[i]%>||          <%=arrMake_cnt[i]%>||<%=QmTm.changeTag(QmTm.changeChar(arrQ1[i].trim()))%>||<%=arrId_subject[i]%>||<%=arrRefs[i]%>";
				
		obj.add(addOpt);

	<% } %>	

	//history.back();    
	window.close(this);
</script>

<% } %>
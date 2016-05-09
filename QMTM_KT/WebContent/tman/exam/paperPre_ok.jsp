<%
//******************************************************************************
//   ���α׷� : paperPre_ok.jsp
//   �� �� �� : ������������ ��������
//   ��    �� : ������������ ��������
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.paper.ExamPaperQ
//   �� �� �� : 2009-08-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");    
	
		if(true) return ;     
	}

	// ���� �˻�
	ExamSearchResBean[] rst = null;

	try {
	    rst = ExamUtil.getPrepapers(id_exam);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());

		//if(true) return;
    }

	if(rst == null) {
%>
	<Script language="JavaScript">
		alert("������ ������ ����� �۾����� ������ �����ϴ�.");
		window.close();
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
			arrId_subject[k] = rst[k].getId_subject();
			arrMake_cnt[k] = String.valueOf(rst[k].getMake_cnt());
		}
%>

<script language="JavaScript">

	var obj = opener.document.getElementById("q_list2");
	
	obj.length = 0; 

	var firstWin = window.opener;
	//firstWin.document.form1.qcnts.value = "    �˻��� ���� �� : " + <%=rst.length%> + " ����";
	firstWin.document.form1.qcnts2.value = <%=lngcnt%>;
	
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
				arrRefs[i] = arrId_refs[i]+"   ";
			}

			if(arrMake_cnt[i].length() == 1) {
				arrMake_cnt[i] = "          "+arrMake_cnt[i]+"            ";
			} else {
				arrMake_cnt[i] = "         "+arrMake_cnt[i]+"           ";
			}

			if(arrQ[i].length() > 55) {
				arrQ1[i] = arrQ[i].substring(0,54); 
			} else {
				arrQ1[i] = arrQ[i];
			}
				
	%>			
		var addOpt=opener.document.createElement("OPTION");
		addOpt.text = "<%=arrQs[i]%>   <%=arrQtypes[i]%><%=arrDiffs[i]%><%=arrAllottings[i]%>    <%=arrMake_cnt[i]%>    <%=QmTm.changeTag(QmTm.changeChar(arrQ1[i].trim()))%>";
		addOpt.name= "qs";		
		addOpt.value = "<%=arrQs[i]%>||<%=arrQtypes[i]%>||<%=arrDiffs[i]%>||<%=arrAllottings[i]%>||          <%=arrMake_cnt[i]%>||<%=QmTm.changeTag(QmTm.changeChar(arrQ1[i].trim()))%>||<%=arrId_subject[i]%>";
				
		obj.add(addOpt);

	<% } %>	

	//history.back();    
	window.close(this);
</script>

<% } %>
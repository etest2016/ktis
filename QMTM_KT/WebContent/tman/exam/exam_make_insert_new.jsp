<%
//******************************************************************************
//   ���α׷� : exam_make_insert.jsp
//   �� �� �� : ������ ����
//   ��    �� : ������ ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2008-04-29
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.paper.*, java.sql.*, java.util.*" %>

<html>

<head>

<title>������ �����</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<script>

	function go(){

	  Show_LayerProgressBar(false);

	  alert("������ ������ �Ϸ�Ǿ����ϴ�.\n\n���������� ��ܿ� �̸����� �޴��� ���ؼ�\n\n�ݵ�� ���������� ������ ����Ǿ����� Ȯ�����ֽñ� �ٶ��ϴ�.");
	  opener.parent.location.reload();   
	  //top.opener.opener.frames['fraMain'].location.reload(); 
	  window.close();
	  
	 //ing+1 �ϴ������� (ing+1)/end*100  =0 �̵Ǹ� ������ ���� ����
	}

	HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
		   + '<img src="../../images/loading.gif" style="position:absolute; top:35%; left:35%;"/>' 
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

</script>

</head>
<!-- ��������ٰ� ��ġ�� HTMl�ҽ� -->

<BODY onLoad = "Show_LayerProgressBar(true);">

<%
	out.flush();
	
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");
	
	String id_exam = request.getParameter("id_exam");
	int qcntperpage = Integer.parseInt(request.getParameter("qcntperpage"));
	String randomtypes = request.getParameter("randomtypes");
	String allot_basic = request.getParameter("allot_basic");
	String q_basic = request.getParameter("q_basic");
	String[] idxs = request.getParameterValues("idxs");	
	String[] id_subjects = request.getParameterValues("id_subjects");
	String[] id_qtypes = request.getParameterValues("id_qtypes");
	String[] id_chapters = request.getParameterValues("id_chapters");
	String[] align_orders = request.getParameterValues("align_orders");
	String[] id_difficultys = request.getParameterValues("id_difficultys");
	String q_options = request.getParameter("q_options");
	int paper_cnts = Integer.parseInt(request.getParameter("paper_cnts"));

	String[] idxs2 = request.getParameterValues("idxs2");	
	String[] ref_subject = request.getParameterValues("ref_subject");
	String[] ref_chapter = request.getParameterValues("ref_chapter");
	String[] ref_order = request.getParameterValues("ref_order");
	String ref_YN = request.getParameter("ref_YN");

	String rdox = request.getParameter("rdox");
	if(rdox == null) { rdox = ""; } else { rdox = rdox.trim(); }
	
	// ������ ������� �������� �����Ѵ�.
	try {
		ExamPaperUtil.delete(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// �����ڰ� ���� ���ļ������ ���ļ����� ������Ʈ �Ѵ�..
	for(int i=0; i<idxs.length; i++) {
		int ch_qs = Integer.parseInt(request.getParameter("ch_qs"+i));
		double ch_score = Double.parseDouble(request.getParameter("ch_score"+i));

		if(q_basic.equals("1") || q_basic.equals("2")) { // ���� ���� �Ǵ� ���� ��� ���� �������, �������� ����
			try {
				ExamPaperQ.updateOrders(id_exam, id_subjects[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("3")) { // �ܿ� ����
			try {
				ExamPaperQ.updateOrders2(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("4")) { // �ܿ� + �������� ����
			try {
				ExamPaperQ.updateOrders3(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("6")) { // �ܿ� + ���̵� ����
			try {
				ExamPaperQ.updateOrders4(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("7")) { // �ܿ� + �������� + ���̵� ����
			try {
				ExamPaperQ.updateOrders5(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("5")) { // �ܿ� + �������� + ���̵� ����
			try {
				ExamPaperQ.updateOrders6(id_exam, id_subjects[i], Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		}
	}

	if(ref_YN.equals("Y")) {
		for(int i=0; i<idxs2.length; i++) {
			int ref_qs = Integer.parseInt(request.getParameter("ref_qs"+i));
			double ref_score = Double.parseDouble(request.getParameter("ref_score"+i));	

			try {
				ExamPaperQ.updateRefOrders(id_exam, ref_subject[i], ref_chapter[i], Integer.parseInt(ref_order[i]), ref_qs, ref_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		}
	}

	StringBuffer id_q_list = new StringBuffer();
	StringBuffer id_subject_list = new StringBuffer();
	StringBuffer id_chapter_list = new StringBuffer();
	StringBuffer id_qtype_list = new StringBuffer();
	StringBuffer excount_list = new StringBuffer();
	StringBuffer ch_score_list = new StringBuffer();

	int[] arrId_q_cnt = new int[idxs.length];
	int[] arrCh_qs = new int[idxs.length];

    // ���ļ������ ������ ������´�.
	ExamOrderQBean[] qbean = null;

	for(int j=0; j<idxs.length; j++) {

		try {
			qbean = ExamPaperUtil.getOrderQs(id_exam, j+1);
		} catch(Exception ex) {
			out.println(ex.getMessage());
		}

		arrCh_qs[j] = qbean[0].getCh_qs();
				
		for(int k=0; k<qbean.length; k++) {			
			id_q_list.append(qbean[k].getId_q());
			id_q_list.append(",");

			id_subject_list.append(qbean[k].getId_subject());
			id_subject_list.append(",");

			id_chapter_list.append(qbean[k].getId_chapter());
			id_chapter_list.append(",");

			id_qtype_list.append(qbean[k].getId_qtype());
			id_qtype_list.append(",");

			excount_list.append(qbean[k].getExcount());
			excount_list.append(",");

			ch_score_list.append(String.valueOf(qbean[k].getCh_score()));
			ch_score_list.append(",");

			arrId_q_cnt[j] = arrId_q_cnt[j] + 1;
		}

		id_q_list.append("#");
		id_subject_list.append("#");
		id_chapter_list.append("#");
		id_qtype_list.append("#");
		excount_list.append("#");
		ch_score_list.append("#");
	}
	
	String[] arrId_qs = id_q_list.toString().split("#");
	String[] arrId_subject = id_subject_list.toString().split("#");
	String[] arrId_chapter = id_chapter_list.toString().split("#");
	String[] arrId_qtype = id_qtype_list.toString().split("#");
	String[] arrExcount = excount_list.toString().split("#");
	String[] arrCh_score = ch_score_list.toString().split("#");

	int imsi = 0;

	for(int a=0; a<paper_cnts; a++) {

		int pages = 0;
		int page_add = 0;
		int page_add_imsi = 0;
		String ex_orders = "";

		for(int i=0; i<idxs.length; i++) {

			String[] arrId_qs2 = arrId_qs[i].split(",");
			String[] arrId_subject2 = arrId_subject[i].split(",");
			String[] arrId_chapter2 = arrId_chapter[i].split(",");
			String[] arrId_qtype2 = arrId_qtype[i].split(",");
			String[] arrExcount2 = arrExcount[i].split(",");
			String[] arrCh_score2 = arrCh_score[i].split(",");

			Random random = new Random();
			int randomValue = 0;
			Vector vector = new Vector();
			
			for(int aa=imsi; aa<arrId_q_cnt[i]; aa++)
			{
				vector.addElement(new Integer(aa));			
			}		

			for( int k = 0; k < arrCh_qs[i]; k++ )
			{
				randomValue = random.nextInt(vector.size());
						
				// �������� üũ ����
				if(arrId_qtype2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))].equals("1")) {
					if(rdox.equals("Y")) {
						ex_orders = QmTm.ExRandom(2, randomtypes);
					} else {
						ex_orders = QmTm.ExRandom(2, "");
					}
				} else if(arrId_qtype2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))].equals("2") ||		     arrId_qtype2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))].equals("3")) {
					ex_orders = QmTm.ExRandom(Integer.parseInt(arrExcount2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))]), randomtypes);
				} else {
					ex_orders = "";
				} 

				if(arrId_qtype2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))].equals("5")) {				
					pages ++;
					
					page_add_imsi = qcntperpage;
				} else {
					
					if(page_add_imsi % qcntperpage == 0) { // �������� ���װ��� ��� ����
						pages ++;					
					} // ������ �� ���װ��� ��� ����	
					
					page_add_imsi ++;
				}
							
				// ������ DB�� ���� ����

				try {
					ExamPaperUtil.insert(id_exam, a+1, page_add+1, Integer.parseInt(arrId_qs2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))]), ex_orders, Double.parseDouble(arrCh_score2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))]), pages, 0, 0);
				} catch(Exception ex) {
					out.println(ex.getMessage());
				}
				
				page_add ++; // �������� ���װ��� ����ϱ� ���ؼ�...
						
				// �ߺ��� �����ϱ� ���ؼ� ������ ������ vector ���� �ӽû����Ѵ�.
				vector.removeElementAt(randomValue);
			
			}

		}

	}

	// ���� ���̺� ������ ������ ������Ʈ ���ش�.
	try {
		ExamPaperUtil.setCount(id_exam, paper_cnts);
	} catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	// ���׺� ����Ƚ���� ������Ų��.
	try {
		ExamPaperUtil.makecntUpdate(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	// �ӽ÷� ������ ���������� �����Ѵ�.
	try {
		ExamPaperQ.delete(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	out.println("<script>go()</script>");
%>
	
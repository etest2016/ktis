<%
//******************************************************************************
//   프로그램 : exam_make_insert.jsp
//   모 듈 명 : 시험지 생성
//   설    명 : 시험지 생성
//   테 이 블 : 
//   자바파일 : qmtm.tman.exam.ExamUtil
//   작 성 일 : 2008-04-29
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.paper.*, java.sql.*, java.util.*" %>

<html>

<head>

<title>시험지 만들기</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<script>

	function go(){

	  Show_LayerProgressBar(false);

	  alert("시험지 생성이 완료되었습니다.\n\n시험지관리 상단에 미리보기 메뉴를 통해서\n\n반드시 정상적으로 시험이 진행되었는지 확인해주시기 바랍니다.");
	  opener.parent.location.reload();   
	  //top.opener.opener.frames['fraMain'].location.reload(); 
	  window.close();
	  
	 //ing+1 하는이유는 (ing+1)/end*100  =0 이되면 에러가 나기 때문
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
<!-- 상태진행바가 위치할 HTMl소스 -->

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
	
	// 기존에 만들어진 시험지를 삭제한다.
	try {
		ExamPaperUtil.delete(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// 관리자가 정한 정렬순서대로 정렬순서를 업데이트 한다..
	for(int i=0; i<idxs.length; i++) {
		int ch_qs = Integer.parseInt(request.getParameter("ch_qs"+i));
		double ch_score = Double.parseDouble(request.getParameter("ch_score"+i));

		if(q_basic.equals("1") || q_basic.equals("2")) { // 섞지 않음 또는 출제 목록 문항 순서대로, 문제유형 정렬
			try {
				ExamPaperQ.updateOrders(id_exam, id_subjects[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("3")) { // 단원 정렬
			try {
				ExamPaperQ.updateOrders2(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("4")) { // 단원 + 문제유형 정렬
			try {
				ExamPaperQ.updateOrders3(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("6")) { // 단원 + 난이도 정렬
			try {
				ExamPaperQ.updateOrders4(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("7")) { // 단원 + 문제유형 + 난이도 정렬
			try {
				ExamPaperQ.updateOrders5(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]), ch_qs, ch_score);
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("5")) { // 단원 + 문제유형 + 난이도 정렬
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

    // 정렬순서대로 문제를 가지고온다.
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
						
				// 보기유형 체크 시작
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
					
					if(page_add_imsi % qcntperpage == 0) { // 페이지당 문항갯수 고려 시작
						pages ++;					
					} // 페이지 당 문항갯수 고려 종료	
					
					page_add_imsi ++;
				}
							
				// 시험지 DB에 저장 시작

				try {
					ExamPaperUtil.insert(id_exam, a+1, page_add+1, Integer.parseInt(arrId_qs2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))]), ex_orders, Double.parseDouble(arrCh_score2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))]), pages, 0, 0);
				} catch(Exception ex) {
					out.println(ex.getMessage());
				}
				
				page_add ++; // 페이지당 문항갯수 고려하기 위해서...
						
				// 중복을 방지하기 위해서 출제된 문항은 vector 에서 임시삭제한다.
				vector.removeElementAt(randomValue);
			
			}

		}

	}

	// 시험 테이블에 시험지 갯수를 업데이트 해준다.
	try {
		ExamPaperUtil.setCount(id_exam, paper_cnts);
	} catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	// 문항별 출제횟수를 증가시킨다.
	try {
		ExamPaperUtil.makecntUpdate(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	// 임시로 저장한 출제문제를 삭제한다.
	try {
		ExamPaperQ.delete(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	out.println("<script>go()</script>");
%>
	
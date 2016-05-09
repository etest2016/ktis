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
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");	

	out.flush();

	String id_exam = request.getParameter("id_exam");
	int qcntperpage = Integer.parseInt(request.getParameter("qcntperpage"));
	String ref_lists2 = request.getParameter("ref_lists2");
	String randomtypes2 = request.getParameter("randomtypes");
	String allot_basic = request.getParameter("allot_basic");
	String q_basic = request.getParameter("q_basic");
	String[] idxs = request.getParameterValues("idxs");	
	String[] id_subjects = request.getParameterValues("id_subjects");
	String[] id_qtypes = request.getParameterValues("id_qtypes");
	String[] id_chapters = request.getParameterValues("id_chapters");
	String[] align_orders = request.getParameterValues("align_orders");
	String[] id_difficultys = request.getParameterValues("id_difficultys");
	String q_options = request.getParameter("q_options");
	String q_ref_cnts = request.getParameter("q_ref_cnts");
	int paper_cnts = Integer.parseInt(request.getParameter("paper_cnts"));
	String ref_YN = request.getParameter("ref_YN");

	String rdox = request.getParameter("rdox");
	if(rdox == null) { rdox = ""; } else { rdox = rdox.trim(); }

	String[] Arr_refs;

	Arr_refs = ref_lists2.split(",");

	// 기존에 만들어진 시험지를 삭제한다.
	try {
		ExamPaperUtil.delete(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	// 관리자가 정한 정렬순서대로 정렬순서를 업데이트 한다..
	for(int i=0; i<idxs.length; i++) {
		if(q_basic.equals("1") || q_basic.equals("2")) { // 섞지 않음 또는 출제 목록 문항 순서대로, 문제유형 정렬
			try {
				ExamPaperQ.updateOrders(id_exam, id_subjects[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]), 0, 0);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		} else if(q_basic.equals("3")) { // 단원 정렬
			try {
				ExamPaperQ.updateOrders2(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(align_orders[i]), 0, 0);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		} else if(q_basic.equals("4")) { // 단원 + 문제유형 정렬
			try {
				ExamPaperQ.updateOrders3(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]), 0, 0);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		} else if(q_basic.equals("6")) { // 단원 + 난이도 정렬
			try {
				ExamPaperQ.updateOrders4(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]), 0, 0);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		} else if(q_basic.equals("7")) { // 단원 + 문제유형 + 난이도 정렬
			try {
				ExamPaperQ.updateOrders5(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]), 0, 0);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		} else if(q_basic.equals("5")) { // 정렬기준 없음
			try {
				ExamPaperQ.updateOrders6(id_exam, id_subjects[i], Integer.parseInt(align_orders[i]), 0, 0);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		} 
	}

	int bigo_cnt = idxs.length;

	if(ref_YN.equals("Y")) {
		bigo_cnt = idxs.length + 1;

		try {
			ExamPaperQ.updateRefOrders(id_exam, bigo_cnt);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
	}	

	StringBuffer id_q_list = new StringBuffer();
	StringBuffer id_subject_list = new StringBuffer();
	StringBuffer id_ref_list = new StringBuffer();
	StringBuffer id_chapter_list = new StringBuffer();
	StringBuffer id_qtype_list = new StringBuffer();
	StringBuffer excount_list = new StringBuffer();
	StringBuffer allotting_list = new StringBuffer();

	int[] arrId_q_cnt = new int[bigo_cnt];

	int q_no1 = 0;
	int q_no2 = 0;
	int ref_count = 0;

    // 정렬순서대로 문제를 가지고온다.
	ExamOrderQBean[] qbean = null;

	for(int j=0; j<bigo_cnt; j++) {

		try {
			qbean = ExamPaperUtil.getOrderQs(id_exam, j+1);
		} catch(Exception ex) {
			out.println(ex.getMessage()); 
		}

		for(int k=0; k<qbean.length; k++) {			
			id_q_list.append(qbean[k].getId_q());
			id_q_list.append(",");

			id_subject_list.append(qbean[k].getId_subject());
			id_subject_list.append(",");

			id_chapter_list.append(qbean[k].getId_chapter());
			id_chapter_list.append(",");

			id_ref_list.append(qbean[k].getId_ref());
			id_ref_list.append(",");

			id_qtype_list.append(qbean[k].getId_qtype());
			id_qtype_list.append(",");

			excount_list.append(qbean[k].getExcount());
			excount_list.append(",");

			allotting_list.append(qbean[k].getAllotting());
			allotting_list.append(",");

			arrId_q_cnt[j] = arrId_q_cnt[j] + 1;
		}

		id_q_list.append("#");
		id_subject_list.append("#");
		id_chapter_list.append("#");
		id_ref_list.append("#");
		id_qtype_list.append("#");
		excount_list.append("#");	
		allotting_list.append("#");	
	}
	
	String[] arrId_qs = id_q_list.toString().split("#");
	String[] arrId_subject = id_subject_list.toString().split("#");
	String[] arrId_chapter = id_chapter_list.toString().split("#");
	String[] arrId_ref = id_ref_list.toString().split("#");
	String[] arrId_qtype = id_qtype_list.toString().split("#");
	String[] arrExcount = excount_list.toString().split("#");
	String[] arrAllotting = allotting_list.toString().split("#");

	int imsi = 0;
	
	for(int a=0; a<paper_cnts; a++) {

		int pages = 0;
		int page_add = 0;
		int page_add_imsi = 0;
		String id_ref_comp = "";
		String ex_orders = "";

		for(int i=0; i<bigo_cnt; i++) {

			String[] arrId_qs2 = arrId_qs[i].split(",");
			String[] arrId_subject2 = arrId_subject[i].split(",");
			String[] arrId_chapter2 = arrId_chapter[i].split(",");
			String[] arrId_ref2 = arrId_ref[i].split(",");
			String[] arrId_qtype2 = arrId_qtype[i].split(",");
			String[] arrExcount2 = arrExcount[i].split(",");
			String[] arrAllotting2 = arrAllotting[i].split(",");

			Random random = new Random();  
			int randomValue = 0;
			Vector vector = new Vector();

			String randomtypes = "";

			if(ref_YN.equals("Y") && (i+1 == idxs.length+1)) { 
				randomtypes = "NN";
			} else {
				randomtypes = randomtypes2;
			}
			
			if(randomtypes.equals("NN")) { // 출제목록 그대로 
			
			for(int k=0; k<arrId_q_cnt[i]; k++)
			{
				
				int ref_cnts = 0;

				// 지문문항 체크
				if(arrId_ref2[k].equals("0")) { // 일반문항일 경우
					
					q_no1 = 0;
					q_no2 = 0;
					ref_count = 0;
					id_ref_comp = "";

				} else { // 지문문항일 경우

					if(id_ref_comp.equals(arrId_ref2[k])) {

						id_ref_comp = arrId_ref2[k];
						ref_count--;
						q_no1 = q_no1;
						q_no2 = q_no2;
					} else {						
						for(int refs=0; refs<Arr_refs.length; refs++) { // 지문문항 시작, 끝번호 구하기 시작
							if(arrId_ref2[k].equals(Arr_refs[refs].trim())) {
								ref_cnts = ref_cnts + 1;								
							}
						} // 지문문항 시작, 끝번호 구하기 종료

						q_no1 = page_add + 1;
						q_no2 = q_no1 + ref_cnts - 1;
						ref_count = ref_cnts - 1;
						id_ref_comp = qbean[k].getId_ref();
					}

				}

				// 보기유형 체크 시작
				if(arrId_qtype2[k].equals("1")) {
					ex_orders = QmTm.ExRandom(2, randomtypes);
				} else if(arrId_qtype2[k].equals("2") || arrId_qtype2[k].equals("3")) {
					ex_orders = QmTm.ExRandom(Integer.parseInt(arrExcount2[k]), randomtypes);
				} else {
					ex_orders = "";
				} 

				if(arrId_qtype2[k].equals("5")) {				
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
					ExamPaperUtil.insert(id_exam, a+1, page_add+1, Integer.parseInt(arrId_qs2[k]), ex_orders, Double.parseDouble(arrAllotting2[k]), pages, q_no1, q_no2);
				} catch(Exception ex) {
					out.println(ex.getMessage());
				}
				
				page_add ++; // 페이지당 문항갯수 고려하기 위해서...

			}		

			} else { // 문제 섞기가 포함되었을 경우

			
			for(int aa=imsi; aa<arrId_q_cnt[i]; aa++)
			{
				vector.addElement(new Integer(aa));
			}

			for(int k=0; k<arrId_q_cnt[i]; k++)
			{
				if(randomtypes.equals("NN")) {
					randomValue = k;
				} else {
					randomValue = random.nextInt(vector.size());
				}

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
					ExamPaperUtil.insert(id_exam, a+1, page_add+1, Integer.parseInt(arrId_qs2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))]), ex_orders, Double.parseDouble(arrAllotting2[Integer.parseInt(String.valueOf(vector.elementAt(randomValue)))]), pages, 0, 0);
				} catch(Exception ex) {
					out.println(ex.getMessage());
				}
				
				page_add ++; // 페이지당 문항갯수 고려하기 위해서...
						
				// 중복을 방지하기 위해서 출제된 문항은 vector 에서 임시삭제한다.
				vector.removeElementAt(randomValue);

			}	
			
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
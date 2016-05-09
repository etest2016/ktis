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

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.paper.*, java.sql.*, java.util.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	int qcntperpage = Integer.parseInt(request.getParameter("qcntperpage"));
	String ref_lists2 = request.getParameter("ref_lists2");
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
	String q_ref_cnts = request.getParameter("q_ref_cnts");
	int paper_cnts = Integer.parseInt(request.getParameter("paper_cnts"));

	String[] Arr_refs;

	Arr_refs = ref_lists2.split(",");
	
	// 기존에 만들어진 시험지를 삭제한다.
	try {
		ExamPaperUtil.delete(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// 관리자가 정한 정렬순서대로 정렬순서를 업데이트 한다..
	for(int i=0; i<idxs.length; i++) {
		if(q_basic.equals("1") || q_basic.equals("2") || q_basic.equals("5")) { // 섞지 않음 또는 출제 목록 문항 순서대로, 문제유형 정렬
			try {
				ExamPaperQ.updateOrders(id_exam, id_subjects[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("3")) { // 단원 정렬
			try {
				ExamPaperQ.updateOrders2(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("4")) { // 단원 + 문제유형 정렬
			try {
				ExamPaperQ.updateOrders3(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("6")) { // 단원 + 난이도 정렬
			try {
				ExamPaperQ.updateOrders4(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("7")) { // 단원 + 문제유형 + 난이도 정렬
			try {
				ExamPaperQ.updateOrders5(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		}
	}

	ExamOrderQBean[] q_lists = null;
	
	try {
		q_lists = ExamPaperUtil.getOrderQ(id_exam, "NN");
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	for(int q_list = 0; q_list < q_lists.length; q_list++) {
		
	}

	ExamPaper2Bean bean = new ExamPaper2Bean();

	// 정렬순서대로 문제를 가지고온다.
	ExamOrderQBean[] qbean = null;

	int q_no1 = 0;
	int q_no2 = 0;
	int ref_count = 0;

	// 시험지 갯수만큼 시험지를 생성한다.
	for(int paper_cnt=0; paper_cnt<paper_cnts; paper_cnt++) { // 시험지 갯수 루프 시작

		try {
			qbean = ExamPaperUtil.getOrderQ(id_exam, randomtypes);
		} catch(Exception ex) {
			out.println(ex.getMessage());
		}

		int pages = 1;
		int page_add = 1;
		String id_ref_comp = "";
		String ex_orders = "";

		for(int k=0; k<qbean.length; k++) { // 문항 리스트 시작
			int ref_cnts = 0;

			// 지문문항 체크
			if(!qbean[k].getId_ref().equals("0")) { // 지문문항일 경우

				if(id_ref_comp.equals(qbean[k].getId_ref())) {
					id_ref_comp = qbean[k].getId_ref();
					ref_count--;
					q_no1 = page_add;
					q_no2 = q_no1 + ref_count;
				} else {
					for(int refs=0; refs<Arr_refs.length; refs++) { // 지문문항 시작, 끝번호 구하기 시작
						if(qbean[k].getId_ref().equals(Arr_refs[refs].trim())) {
							ref_cnts = ref_cnts + 1;
						}
					} // 지문문항 시작, 끝번호 구하기 종료

					q_no1 = page_add;
					q_no2 = q_no1 + ref_cnts - 1;
					ref_count = ref_cnts - 1;
					id_ref_comp = qbean[k].getId_ref();
				}

			} else { // 지문문항이 아닐 경우
				q_no1 = 0;
				q_no2 = 0;
				ref_count = 0;
				id_ref_comp = "";
			} // 지문문항 체크 종료

			// 보기유형 체크 시작
			if(qbean[k].getId_qtype().equals("1")) {
				ex_orders = QmTm.ExRandom(2, randomtypes);
			} else if(qbean[k].getId_qtype().equals("2") || qbean[k].getId_qtype().equals("3")) {
				ex_orders = QmTm.ExRandom(Integer.parseInt(qbean[k].getExcount()), randomtypes);
			} else {
				ex_orders = "";
			} 
			// 보기유형 체크 종료

			// 시험지 DB에 저장 시작
			bean.setId_exam(id_exam);
			bean.setNr_set(paper_cnt+1);
			bean.setNr_q(page_add);
			bean.setId_q(Integer.parseInt(qbean[k].getId_q()));
			bean.setEx_order(ex_orders);
			bean.setAllotting(qbean[k].getAllotting());
			bean.setPage(pages);
			bean.setQ_no1(q_no1);
			bean.setQ_no2(q_no2);

			// 시험지 DB에 저장 시작
			try {
			    ExamPaperUtil.insert(bean);
		    } catch(Exception ex) {
			    out.println(ex.getMessage());
		    }

			//Thread.sleep(500);
			// 시험지 DB에 저장 종료

			if(page_add % qcntperpage == 0) { // 페이지 당 문항갯수 고려 시작
				pages ++;
			} // 페이지 당 문항갯수 고려 종료

			page_add ++; // 페이지당 문항갯수 고려하기 위해서...

		} // 문항 리스트 종료
	} // 시험지 갯수 루프 종료
%>
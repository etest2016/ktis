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
	
	// ������ ������� �������� �����Ѵ�.
	try {
		ExamPaperUtil.delete(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// �����ڰ� ���� ���ļ������ ���ļ����� ������Ʈ �Ѵ�..
	for(int i=0; i<idxs.length; i++) {
		if(q_basic.equals("1") || q_basic.equals("2") || q_basic.equals("5")) { // ���� ���� �Ǵ� ���� ��� ���� �������, �������� ����
			try {
				ExamPaperQ.updateOrders(id_exam, id_subjects[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("3")) { // �ܿ� ����
			try {
				ExamPaperQ.updateOrders2(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("4")) { // �ܿ� + �������� ����
			try {
				ExamPaperQ.updateOrders3(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_qtypes[i]), Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("6")) { // �ܿ� + ���̵� ����
			try {
				ExamPaperQ.updateOrders4(id_exam, id_subjects[i], id_chapters[i], Integer.parseInt(id_difficultys[i]), Integer.parseInt(align_orders[i]));
			} catch(Exception ex) {
				out.println(ex.getMessage());
			}
		} else if(q_basic.equals("7")) { // �ܿ� + �������� + ���̵� ����
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

	// ���ļ������ ������ ������´�.
	ExamOrderQBean[] qbean = null;

	int q_no1 = 0;
	int q_no2 = 0;
	int ref_count = 0;

	// ������ ������ŭ �������� �����Ѵ�.
	for(int paper_cnt=0; paper_cnt<paper_cnts; paper_cnt++) { // ������ ���� ���� ����

		try {
			qbean = ExamPaperUtil.getOrderQ(id_exam, randomtypes);
		} catch(Exception ex) {
			out.println(ex.getMessage());
		}

		int pages = 1;
		int page_add = 1;
		String id_ref_comp = "";
		String ex_orders = "";

		for(int k=0; k<qbean.length; k++) { // ���� ����Ʈ ����
			int ref_cnts = 0;

			// �������� üũ
			if(!qbean[k].getId_ref().equals("0")) { // ���������� ���

				if(id_ref_comp.equals(qbean[k].getId_ref())) {
					id_ref_comp = qbean[k].getId_ref();
					ref_count--;
					q_no1 = page_add;
					q_no2 = q_no1 + ref_count;
				} else {
					for(int refs=0; refs<Arr_refs.length; refs++) { // �������� ����, ����ȣ ���ϱ� ����
						if(qbean[k].getId_ref().equals(Arr_refs[refs].trim())) {
							ref_cnts = ref_cnts + 1;
						}
					} // �������� ����, ����ȣ ���ϱ� ����

					q_no1 = page_add;
					q_no2 = q_no1 + ref_cnts - 1;
					ref_count = ref_cnts - 1;
					id_ref_comp = qbean[k].getId_ref();
				}

			} else { // ���������� �ƴ� ���
				q_no1 = 0;
				q_no2 = 0;
				ref_count = 0;
				id_ref_comp = "";
			} // �������� üũ ����

			// �������� üũ ����
			if(qbean[k].getId_qtype().equals("1")) {
				ex_orders = QmTm.ExRandom(2, randomtypes);
			} else if(qbean[k].getId_qtype().equals("2") || qbean[k].getId_qtype().equals("3")) {
				ex_orders = QmTm.ExRandom(Integer.parseInt(qbean[k].getExcount()), randomtypes);
			} else {
				ex_orders = "";
			} 
			// �������� üũ ����

			// ������ DB�� ���� ����
			bean.setId_exam(id_exam);
			bean.setNr_set(paper_cnt+1);
			bean.setNr_q(page_add);
			bean.setId_q(Integer.parseInt(qbean[k].getId_q()));
			bean.setEx_order(ex_orders);
			bean.setAllotting(qbean[k].getAllotting());
			bean.setPage(pages);
			bean.setQ_no1(q_no1);
			bean.setQ_no2(q_no2);

			// ������ DB�� ���� ����
			try {
			    ExamPaperUtil.insert(bean);
		    } catch(Exception ex) {
			    out.println(ex.getMessage());
		    }

			//Thread.sleep(500);
			// ������ DB�� ���� ����

			if(page_add % qcntperpage == 0) { // ������ �� ���װ��� ��� ����
				pages ++;
			} // ������ �� ���װ��� ��� ����

			page_add ++; // �������� ���װ��� ����ϱ� ���ؼ�...

		} // ���� ����Ʈ ����
	} // ������ ���� ���� ����
%>
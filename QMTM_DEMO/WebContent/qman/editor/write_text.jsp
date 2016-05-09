<%
//******************************************************************************
//   프로그램 : write_text.jsp
//   모 듈 명 : 개별문제 등록
//   설    명 : 
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-08-20
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>    

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*, java.util.*, qmtm.*, qmtm.qman.editor.*, qmtm.qman.*, qmtm.admin.etc.EnvUtil" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	try
	{
		String q = "";
		String ex1 = "";
		String ex2 = "";
		String ex3 = "";
		String ex4 = "";
		String ex5 = "";
		String explain = "";
		String hint = "";
		String reftitle = "";
		String refbody = "";
		String id_ref = request.getParameter("id_ref");

		String userid = (String)session.getAttribute("userid");

		// 카테고리 정보
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
		
		q = ComLib.toStrHtml2(request.getParameter("q")); 
		
		ex1 = request.getParameter("ex1"); 
		ex2 = request.getParameter("ex2");
		ex3 = request.getParameter("ex3");
		ex4 = request.getParameter("ex4");
		ex5 = request.getParameter("ex5");
		explain = request.getParameter("explain");
		hint = request.getParameter("hint");
				
		// 문제 선택정보
		int qtype = QmTm.getIntChk(request.getParameter("qtype2"));
		int excount2 = QmTm.getIntChk(request.getParameter("excount2"));
		int cacount2 = QmTm.getIntChk(request.getParameter("cacount2"));
		
		String[] corrects = request.getParameterValues("corrects"); // 정답

		String arrCorrects = "";
		
		int seq[] = new int[cacount2];
		String box_size[] = new String[cacount2]; // 정답입력박스 크기
		String front_msg[] = new String[cacount2]; // 앞 메시지
		String back_msg[] = new String[cacount2]; // 뒷 메시지

		String ans_list[] = new String[cacount2]; // 단답형 답안 리스트
				
		if(qtype == 4) {
			for(int k=0; k<cacount2; k++) {
				
				ans_list[k] = QmTm.getNullChk(request.getParameter("ans_list2"+(k+1)));

				seq[k] = k+1;
				box_size[k] = QmTm.getNullChk(request.getParameter("ans_size"+(k+1)));
				front_msg[k] = QmTm.getNullChk(request.getParameter("front_msg"+(k+1)));
				back_msg[k] = QmTm.getNullChk(request.getParameter("back_msg"+(k+1)));

				arrCorrects += ans_list[k];
				if(k+1 != cacount2) {
					arrCorrects += "{|}";
				}				
			}
		} else {
			for(int k=0; k<cacount2; k++) {			
				arrCorrects += corrects[k];
				if(k+1 != cacount2) {
					arrCorrects += "{|}";
				}	
			}
		}
		
		// 단답형 정보
		String yn_single_line = request.getParameter("yn_single_line"); // 단답형 입력 박스 1줄에 표시 여부
		if(yn_single_line == null) {
			yn_single_line = "N";
		}

		String yn_caorder = request.getParameter("yn_caorder"); // 정답순서 있음 유무
		if(yn_caorder == null) {
			yn_caorder = "N";
		}
		String yn_case = request.getParameter("yn_case"); // 대소문자 구분 유무
		if(yn_case == null) {
			yn_case = "N";
		}
		String yn_blank = request.getParameter("yn_blank"); // 띄어쓰기 구분 유무 
		if(yn_blank == null) {
			yn_blank = "N";
		}
				
		// 문제정보
		double allotting = QmTm.getDblChk(request.getParameter("allotts")); // 배점
		//String id_qtype = request.getParameter("id_qtype"); // 문제유형
		int limittime1 = 1; // 분
		limittime1 = limittime1 * 60;
		int limittime2 = 0; // 초
		int limittime = limittime1 + limittime2;
		int excount = Integer.parseInt(request.getParameter("excount")); // 보기수
		int id_difficulty1 = Integer.parseInt(request.getParameter("id_difficulty1")); // 난이도
		int cacount = Integer.parseInt(request.getParameter("cacount")); // 정답수
		int id_q_use = Integer.parseInt(request.getParameter("id_q_use")); // 문제용도
		int make_cnt = QmTm.getIntChk(request.getParameter("make_cnt")); // 출제횟수
		int ex_rowcnt = QmTm.getIntChk(request.getParameter("ex_rowcnt")); // 1줄에 표시할 보기 수
		String q_chapter = QmTm.getNullChk(request.getParameter("q_chapter")); // 영역
		String find_kwd = QmTm.getNullChk(request.getParameter("find_kwd")); // 검색키워드		
		String q_media = QmTm.getNullChk(request.getParameter("q_media")); // 동영상
		String q_media_point = QmTm.getNullChk(request.getParameter("q_media_point")); // 동영상 포인트
		String q_sound = QmTm.getNullChk(request.getParameter("q_sound")); // 음성

		// 출처정보
		String src_book = QmTm.getNullChk(request.getParameter("src_book")); // 도서명
		String src_author = QmTm.getNullChk(request.getParameter("src_author")); // 저자명
		String src_page = QmTm.getNullChk(request.getParameter("src_page")); // 페이지
		String src_pub_year = QmTm.getNullChk(request.getParameter("src_pub_year")); // 출판연도
		String src_pub_comp = QmTm.getNullChk(request.getParameter("src_pub_comp")); // 출판사
		String src_misc = QmTm.getNullChk(request.getParameter("src_misc")); // 기타	
		
		// 지문 제목
		reftitle = QmTm.getNullChk(request.getParameter("ref_name"));
		
		if(reftitle.length() > 0) {
			QRefBean beans = new QRefBean();
			
			if(id_ref.equals("0")) { // 기존지문을 등록할 경우에는 지문 테이블에 등록하지 않는다.

				id_ref = CommonUtil.getMakeID("R");

				beans.setId_ref(id_ref);
				beans.setReftitle(reftitle);

				refbody = request.getParameter("refbody");

				StringBuffer buf = new StringBuffer(refbody);
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
					refbody3 = buf.substring(4000); // 최대 6000 자 저장
				}
				if (refbody1.length() > 0) {			    
					beans.setRefbody1(refbody1);
					beans.setRefbody2(refbody2);
					beans.setRefbody3(refbody3);
				}

				try {
					QUtil.insertRef(beans);
				} catch(Exception ex) {
					out.println(ComLib.getExceptionMsg(ex, "back"));
				
					if(true) return;
				}
			}

		} 
						
		if(qtype == 1) {
			ex1 = "O";
			ex2 = "X";
		}
		
		QBean bean = new QBean();

		bean.setId_subject(id_subject);
		bean.setId_chapter(id_chapter);
		bean.setId_chapter2(id_chapter2);
		bean.setId_chapter3(id_chapter3);
		bean.setId_chapter4(id_chapter4);
		bean.setId_ref(id_ref);
		bean.setId_qtype(qtype);
		bean.setExcount(excount);
		bean.setCacount(cacount);
		bean.setAllotting(allotting);
		bean.setLimittime(limittime);
		bean.setId_difficulty1(id_difficulty1);
		bean.setQ(q);
		bean.setEx1(ex1);
		bean.setEx2(ex2);
		bean.setEx3(ex3);
		bean.setEx4(ex4);
		bean.setEx5(ex5);
		bean.setCa(arrCorrects);
		bean.setYn_caorder(yn_caorder);
		bean.setYn_case(yn_case);
		bean.setYn_blank(yn_blank);
		bean.setExplain(ComLib.toStrHtml2(explain));
		bean.setHint(ComLib.toStrHtml2(hint));
		bean.setSrc_book(src_book);
		bean.setSrc_author(src_author);
		bean.setSrc_page(src_page);
		bean.setSrc_pub_comp(src_pub_comp);
		bean.setSrc_pub_year(src_pub_year);
		bean.setSrc_misc(src_misc);
		bean.setFind_kwd(find_kwd);
		bean.setUserid(userid);
		bean.setId_q_use(id_q_use);
		bean.setEx_rowcnt(ex_rowcnt);
		bean.setYn_single_line("Y");
				
		// 개별문제 등록
		try {
		    QUtil.insert_text(bean);

			// 단답형일경우...
			if(qtype == 4) {
				for(int k=0; k<cacount2; k++) {
				
					ans_list[k] = QmTm.getNullChk(request.getParameter("ans_list2"+(k+1)));

					seq[k] = k+1;
					box_size[k] = QmTm.getNullChk(request.getParameter("ans_size"+(k+1)));
					front_msg[k] = QmTm.getNullChk(request.getParameter("front_msg"+(k+1)));
					back_msg[k] = QmTm.getNullChk(request.getParameter("back_msg"+(k+1)));

					// 단답형 메시지 등록
					try {
						QUtil.insertMsg(seq[k], front_msg[k], back_msg[k], box_size[k]);
					} catch(Exception ex) {
						out.println(ComLib.getExceptionMsg(ex, "back"));
			
						if(true) return;
					}
				}
			}

	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));
			
			if(true) return;
	    }

		try {
			QUtil.makecntAdd();
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));
			
			if(true) return;
		}
	
	} catch(Exception e) 
	{
		//out.println(ComLib.getExceptionMsg(e, "back"));
			
		if(true) return;
	} 
%>

	<script language="javascript">
		alert("문항이 정상적으로 등록되었습니다.");
		window.opener.location.reload();
		window.close();
	</script>
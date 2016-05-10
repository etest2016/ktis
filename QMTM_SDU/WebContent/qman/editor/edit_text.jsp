<%
//******************************************************************************
//   프로그램 : edit_text.jsp
//   모 듈 명 : 개별문제 등록
//   설    명 : 
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2010-06-22
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.io.*, java.util.*, qmtm.*, qmtm.qman.editor.*, qmtm.common.*, qmtm.qman.*, qmtm.admin.etc.EnvUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	try
	{
		String id_q = "";		
		String reftitle = "";
		String refbody = "";
		String id_ref = "0";

		String userid = (String)session.getAttribute("userid");

		id_q = request.getParameter("id_qs");
		id_ref = request.getParameter("id_ref");

		// 카테고리 정보
		String id_subject = request.getParameter("id_subject");
		if (id_subject == null) { id_subject = "-1"; } else { id_subject = id_subject.trim(); }

		String id_chapter = request.getParameter("id_chapter");
		if (id_chapter == null) { id_chapter = "-1"; } else { id_chapter = id_chapter.trim(); }
		        
		String q = ComLib.toStrHtml2(request.getParameter("q")); 
		String ex1 = request.getParameter("ex1"); 
		String ex2 = request.getParameter("ex2");
		String ex3 = request.getParameter("ex3");
		String ex4 = request.getParameter("ex4");
		String ex5 = request.getParameter("ex5");
		String explain = request.getParameter("explain");
		String hint = request.getParameter("hint");

		// 문제 선택정보
		int qtype = QmTm.getIntChk(request.getParameter("qtype2"));
		int excount2 = QmTm.getIntChk(request.getParameter("excount2"));
		int cacount2 = QmTm.getIntChk(request.getParameter("cacount2"));

		String msg_yn = request.getParameter("msg_yn");
		
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
		String find_kwd = QmTm.getNullChk(request.getParameter("find_kwd")); // 검색키워드		

		// 출처정보
		String src_book = QmTm.getNullChk(request.getParameter("src_book")); // 도서명
		String src_author = QmTm.getNullChk(request.getParameter("src_author")); // 저자명
		String src_page = QmTm.getNullChk(request.getParameter("src_page")); // 페이지
		String src_pub_year = QmTm.getNullChk(request.getParameter("src_pub_year")); // 출판연도
		String src_pub_comp = QmTm.getNullChk(request.getParameter("src_pub_comp")); // 출판사
		String src_misc = QmTm.getNullChk(request.getParameter("src_misc")); // 기타

		String q_ks = QmTm.getNullChk(request.getParameter("q_ks")); // 대분류
		String q_to = QmTm.getNullChk(request.getParameter("q_to")); // 소분류

		String yn_ex_set = QmTm.getNullChk(request.getParameter("yn_ex_set")); // 선다형 문제 보기섞기 제어
		if (yn_ex_set == null || yn_ex_set.equals("")) { yn_ex_set = "N"; } else { yn_ex_set = yn_ex_set.trim(); }
		String yn_practice = QmTm.getNullChk(request.getParameter("yn_practice")); // 실기형 문제
		if (yn_practice == null || yn_practice.equals("")) { yn_practice = "N"; } else { yn_practice = yn_practice.trim(); }
			
		// 지문 제목
		reftitle = QmTm.getNullChk(request.getParameter("ref_name"));
		
		if(reftitle.length() > 0) {			
			QRefBean beans = new QRefBean();

			boolean chk = false;

			if(id_ref.equals("0")) {	
				// 지문 코드
				chk = true;
				id_ref = CommonUtil.getMakeID("R");
			}
			
			// 지문 코드			
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
				if(chk) {
					QUtil.insertRef(beans);
				} else {
					QUtil.updateRef(id_ref, beans);
				}
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));
			
				if(true) return;
			}
		} 
						
		if(qtype == 1) {
			ex1 = "O";
			ex2 = "X";
		}
		
		QBean bean = new QBean();
		
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
		bean.setExplain(explain);
		bean.setHint(hint);
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
		bean.setYn_single_line(yn_single_line);
		bean.setQ_ks(q_ks);
		bean.setQ_to(q_to);
		bean.setYn_ex_set(yn_ex_set);
		bean.setYn_practice(yn_practice);
				
		// 개별문제 등록
		try {
		    QUtil.update(id_q, bean);

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
						if(msg_yn.equals("Y")) {
							QUtil.updateMsg(id_q, seq[k], front_msg[k], back_msg[k], box_size[k]);
						} else {
							QUtil.insertMsg2(id_q, seq[k], front_msg[k], back_msg[k], box_size[k]);
						}
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

		StringBuffer bigos = new StringBuffer();

		bigos.append("문제유형 : ");
		if(qtype == 1) {	
			bigos.append("OX형");		
			bigos.append(", 정답 : ");
			bigos.append(arrCorrects);
		} else if(qtype == 2) {	
			bigos.append("선다형");
			bigos.append(", 보기갯수 : ");
			bigos.append(excount2);
			bigos.append(", 정답 : ");
			bigos.append(arrCorrects);
			bigos.append(", 문제출제시 보기섞기 금지 : ");
			bigos.append(yn_ex_set);
		} else if(qtype == 3) {	
			bigos.append("복수답안형");
			bigos.append(", 보기갯수 : ");
			bigos.append(excount2);
			bigos.append(", 정답갯수 : ");
			bigos.append(cacount2);
			bigos.append(", 정답 : ");
			bigos.append(arrCorrects);
			bigos.append(", 문제출제시 보기섞기 금지 : ");
			bigos.append(yn_ex_set);
		} else if(qtype == 4) {	
			bigos.append("단답형");
			bigos.append(", 정답갯수 : ");
			bigos.append(cacount2);
			bigos.append(", 정답 : ");
			bigos.append(arrCorrects);
		} else if(qtype == 5) {	
			if(yn_practice.equals("Y")) {
				bigos.append("실기형");
			} else {
				bigos.append("논술형");
			}
		}
		
		bigos.append(", 배점 : ");
		bigos.append(allotting);

		bigos.append(", 난이도 : ");
		if(id_difficulty1 == 0) {
			bigos.append("없음");
		} else if(id_difficulty1 == 1) {
			bigos.append("최상");
		} else if(id_difficulty1 == 2) {
			bigos.append("상");
		} else if(id_difficulty1 == 3) {
			bigos.append("중");
		} else if(id_difficulty1 == 4) {
			bigos.append("하");
		} else if(id_difficulty1 == 5) {
			bigos.append("최하");
		}
		
		bigos.append(", 검색키워드 : ");
		bigos.append(ComLib.nullChk2(find_kwd));
		
		bigos.append(", 대분류 : ");
		bigos.append(ComLib.nullChk2(q_ks));

		bigos.append(", 소분류 : ");
		bigos.append(ComLib.nullChk2(q_to));
		
		bigos.append(", 출처 : ");
		bigos.append(ComLib.nullChk2(src_pub_comp));

		bigos.append(", 비고 : ");
		bigos.append(ComLib.nullChk2(src_misc));
		
		bigos.append(", 비고 : 텍스트문제 ");

		// 로그정보 등록 시작
		WorkQLogBean logbean = new WorkQLogBean();

		logbean.setId_subject(id_subject);
		logbean.setId_chapter(id_chapter);
		logbean.setId_chapter2("-1");
		logbean.setId_chapter3("-1");
		logbean.setId_chapter4("-1");
		logbean.setUserid(userid);
		logbean.setGubun("문제수정");
		logbean.setId_q(id_q);
		logbean.setBigo(bigos.toString());

		try {
			WorkQLog.insert(logbean);
		} catch(Exception ex) {
			out.println(ex.getMessage());

			if(true) return;
		}
		// 로그정보 등록 종료
	
	} catch(Exception e) 
	{
		out.println(ComLib.getExceptionMsg(e, "back"));
			
		if(true) return;
	} 
%>

	<script language="javascript">
		alert("문제가 정상적으로 수정되었습니다.");
		window.opener.location.reload();
		window.close();
	</script>
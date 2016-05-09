<%
//******************************************************************************
//   프로그램 : edit.jsp
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
	
	// FTP 경로 변경
	try {
		ftp_path = EnvUtil.getFTP("qmtm");
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	
	try
	{
		String id_q = "";
		String q = "";
		String ex1 = "";
		String ex2 = "";
		String ex3 = "";
		String ex4 = "";
		String ex5 = "";
		String ex6 = "";
		String ex7 = "";
		String ex8 = "";
		String explain = "";
		String hint = "";
		String reftitle = "";
		String refbody = "";
		String id_ref = "0";

		String userid = (String)session.getAttribute("userid");

		id_q = request.getParameter("id_qs");
		id_ref = request.getParameter("id_ref");

		// 카테고리 정보
		String id_subject = request.getParameter("id_subject");
		if (id_subject == null) { id_subject = "-1"; } else { id_subject = id_subject.trim(); }
		
		File dir = new File(ftp_path+id_subject);

        try {
            if (!dir.exists()) {
                dir.mkdir();
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
		
		boolean bReaname = true; // 저장할 디렉터리에 파일이 존재할 경우 새로운 이름을 지정한다.
		String strSavePath = ftp_path+id_subject; // 실제 웹 서버에 저장되는 디렉터리를 지정한다.
		String strSaveUrl = web_path+id_subject; // 실제 웹 서버에 저장되는 디렉터리의 웹 URL 경로를 지정한다.
		String strMimeValue1 = QmTm.getNullChk(request.getParameter("mime_contents")); 
		String strMimeValue2 = QmTm.getNullChk(request.getParameter("mime_contents2")); 
		String strMimeValue3 = QmTm.getNullChk(request.getParameter("mime_contents3")); 
		String strMimeValue4 = QmTm.getNullChk(request.getParameter("mime_contents4"));
		String strMimeValue5 = QmTm.getNullChk(request.getParameter("mime_contents5")); 
		String strMimeValue6 = QmTm.getNullChk(request.getParameter("mime_contents6")); 
		String strMimeValue7 = QmTm.getNullChk(request.getParameter("mime_contents7")); 
		String strMimeValue8 = QmTm.getNullChk(request.getParameter("mime_contents8")); 
        String strMimeValue9 = QmTm.getNullChk(request.getParameter("mime_contents9"));
		String strMimeValue10 = QmTm.getNullChk(request.getParameter("mime_contents10"));
		String strMimeValue11 = QmTm.getNullChk(request.getParameter("mime_contents11"));
		String strMimeValue12 = QmTm.getNullChk(request.getParameter("mime_contents12"));

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
	
		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil 생성		
		util.setMimeValue(strMimeValue1); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util.setSavePath(strSavePath); // 저장 디렉터리 지정
		util.setSaveUrl(strSaveUrl); // URL 경로 지정

		util.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
						
		q = util.getDecodedHtml(false);

		q = q.replace("\"","");
	
		//외부개체가 포함되었을경우
		if(q.indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			q = q.replace("<?xml","<xml");
			q = q.replace("\"","");

			q = HtmlParser.html_parser(q, strSaveUrl);
		}

		q = q.replace("</HTML>","");
		q = q.replace("<PRE>","");
		q = q.replace("</PRE>","");
		q = q.replace("<P>","");
		q = q.replace("</P>","");
		q = q.replace("<!--StartFragment-->","");

		MimeUtil util2 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util2.setHtmlRange(Constant.HTML_INNER_BODY);
		util2.setMimeValue(strMimeValue2); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util2.setSavePath(strSavePath); // 저장 디렉터리 지정
		util2.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util2.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util2.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex1 = util2.getDecodedHtml(false);

		ex1 = ex1.replace("\"","");

		ex1 = ex1.replace("</HTML>","");
		ex1 = ex1.replace("<PRE>","");
		ex1 = ex1.replace("</PRE>","");
		ex1 = ex1.replace("<P>","");
		ex1 = ex1.replace("</P>","");
		ex1 = ex1.replace("<!--StartFragment-->","");

		//ex1 = ex1.replace("\n", "");
		//out.println(ex1);

		MimeUtil util3 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util3.setHtmlRange(Constant.HTML_INNER_BODY);
		util3.setMimeValue(strMimeValue3); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util3.setSavePath(strSavePath); // 저장 디렉터리 지정
		util3.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util3.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util3.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex2 = util3.getDecodedHtml(false);

		ex2 = ex2.replace("\"","");

		ex2 = ex2.replace("</HTML>","");
		ex2 = ex2.replace("<PRE>","");
		ex2 = ex2.replace("</PRE>","");
		ex2 = ex2.replace("<P>","");
		ex2 = ex2.replace("</P>","");
		ex2 = ex2.replace("<!--StartFragment-->","");

		//ex2 = ex2.replace("\n", "");
		//out.println(ex2);

		MimeUtil util4 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util4.setHtmlRange(Constant.HTML_INNER_BODY);
		util4.setMimeValue(strMimeValue4); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util4.setSavePath(strSavePath); // 저장 디렉터리 지정
		util4.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util4.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util4.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex3 = util4.getDecodedHtml(false);

		ex3 = ex3.replace("\"","");

		ex3 = ex3.replace("</HTML>","");
		ex3 = ex3.replace("<PRE>","");
		ex3 = ex3.replace("</PRE>","");
		ex3 = ex3.replace("<P>","");
		ex3 = ex3.replace("</P>","");
		ex3 = ex3.replace("<!--StartFragment-->","");

		//ex3 = ex3.replace("\n", "");
		//out.println(ex3);

		MimeUtil util5 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util5.setHtmlRange(Constant.HTML_INNER_BODY);
		util5.setMimeValue(strMimeValue5); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util5.setSavePath(strSavePath); // 저장 디렉터리 지정
		util5.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util5.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util5.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex4 = util5.getDecodedHtml(false);

		ex4 = ex4.replace("\"","");

		ex4 = ex4.replace("</HTML>","");
		ex4 = ex4.replace("<PRE>","");
		ex4 = ex4.replace("</PRE>","");
		ex4 = ex4.replace("<P>","");
		ex4 = ex4.replace("</P>","");
		ex4 = ex4.replace("<!--StartFragment-->","");
		
		//ex4 = ex4.replace("\n", "");
		//out.println(ex4);

		MimeUtil util6 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util6.setHtmlRange(Constant.HTML_INNER_BODY);
		util6.setMimeValue(strMimeValue6); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util6.setSavePath(strSavePath); // 저장 디렉터리 지정
		util6.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util6.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util6.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex5 = util6.getDecodedHtml(false);

		ex5 = ex5.replace("\"","");
		
		ex5 = ex5.replace("</HTML>","");
		ex5 = ex5.replace("<PRE>","");
		ex5 = ex5.replace("</PRE>","");
		ex5 = ex5.replace("<P>","");
		ex5 = ex5.replace("</P>","");
		ex5 = ex5.replace("<!--StartFragment-->","");

		//ex5 = ex5.replace("\n", "");
		//out.println(ex5);

		MimeUtil util7 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util7.setHtmlRange(Constant.HTML_INNER_BODY);
		util7.setMimeValue(strMimeValue7); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util7.setSavePath(strSavePath); // 저장 디렉터리 지정
		util7.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util7.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util7.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex6 = util7.getDecodedHtml(false);

		ex6 = ex6.replace("<P>","");
		ex6 = ex6.replace("</P>","");
		
		//ex6 = ex6.replace("\n", "");

		MimeUtil util8 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util8.setHtmlRange(Constant.HTML_INNER_BODY);
		util8.setMimeValue(strMimeValue8); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util8.setSavePath(strSavePath); // 저장 디렉터리 지정
		util8.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util8.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util8.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex7 = util8.getDecodedHtml(false);

		ex7 = ex7.replace("<P>","");
		ex7 = ex7.replace("</P>","");
		
		//ex7 = ex7.replace("\n", "");

		MimeUtil util9 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util9.setHtmlRange(Constant.HTML_INNER_BODY);
		util9.setMimeValue(strMimeValue9); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util9.setSavePath(strSavePath); // 저장 디렉터리 지정
		util9.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util9.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util9.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex8 = util9.getDecodedHtml(false);

		ex8 = ex8.replace("<P>","");
		ex8 = ex8.replace("</P>","");
		
		//ex8 = ex8.replace("\n", "");

		MimeUtil util10 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util10.setHtmlRange(Constant.HTML_INNER_BODY);
		util10.setMimeValue(strMimeValue10); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util10.setSavePath(strSavePath); // 저장 디렉터리 지정
		util10.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util10.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util10.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		explain = util10.getDecodedHtml(false);

		explain = explain.replace("\"","");

		explain = explain.replace("<P>","");
		explain = explain.replace("</P>","");
		
		//explain = explain.replace("\n", "");

		MimeUtil util11 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util11.setHtmlRange(Constant.HTML_INNER_BODY);
		util11.setMimeValue(strMimeValue11); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util11.setSavePath(strSavePath); // 저장 디렉터리 지정
		util11.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util11.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util11.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		hint = util11.getDecodedHtml(false);

		hint = hint.replace("\"","");

		hint= hint.replace("<P>","");
		hint= hint.replace("</P>","");

		//hint = hint.replace("\n", "");

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

			// 지문 내용
			MimeUtil util12 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
			util12.setHtmlRange(Constant.HTML_INNER_BODY);
			util12.setMimeValue(strMimeValue12); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
			util12.setSavePath(strSavePath); // 저장 디렉터리 지정
			util12.setSaveUrl(strSaveUrl); // URL 경로 지정
		
			util12.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
			util12.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
			refbody = util12.getDecodedHtml(false);

			refbody= refbody.replace("<P>","");
			refbody= refbody.replace("</P>","");

			//refbody = refbody.replace("\n", "");

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
		bean.setQ(ComLib.toStrHtml2(q));
		bean.setEx1(ComLib.toStrHtml2(ex1));
		bean.setEx2(ComLib.toStrHtml2(ex2));
		bean.setEx3(ComLib.toStrHtml2(ex3));
		bean.setEx4(ComLib.toStrHtml2(ex4));
		bean.setEx5(ComLib.toStrHtml2(ex5));
		bean.setEx6(ComLib.toStrHtml2(ex6));
		bean.setEx7(ex7);
		bean.setEx8(ex8);

		arrCorrects = arrCorrects.replaceAll("&","&amp;");
		arrCorrects = arrCorrects.replaceAll("<","&lt;");
		arrCorrects = arrCorrects.replaceAll(">","&gt;");

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
		bean.setYn_single_line(yn_single_line);
		bean.setQ_chapter(q_chapter);
		//bean.setQ_gubun(q_gubun);
		bean.setQ_media(q_media);
		bean.setQ_media_point(q_media_point);
		bean.setQ_sound(q_sound);
				
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
	
	} catch(Exception e) 
	{
		out.println(ComLib.getExceptionMsg(e, "back"));
			
		if(true) return;
	} 
%>

	<script language="javascript">
		alert("문항이 정상적으로 수정되었습니다.");
		window.opener.location.reload();
		window.close();
	</script>
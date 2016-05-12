<%
//******************************************************************************
//   프로그램 : write.jsp
//   모 듈 명 : 개별문제 멀티미디어 등록
//   설    명 : 개별문제 멀티미디어 등록
//   테 이 블 : r_difficulty, r_q_use, q_standard_a, q_standard_b
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.QuseUtil, qmtm.admin.etc.QuseBean, qmtm.tman.exam.RdifficultUtil, 
//              qmtm.tman.exam.RdifficultBean, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil 
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>    

<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.io.*, java.util.*, com.tagfree.util.*, org.w3c.tidy.*, org.w3c.dom.*, qmtm.common.*, qmtm.*, qmtm.qman.editor.*, qmtm.qman.*, qmtm.admin.etc.EnvUtil, qmtm.admin.etc.EnvUtilBean, org.apache.commons.net.ftp.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	EnvUtilBean evbean = null;
	
	try {
		evbean = EnvUtil.getSetInfo();
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
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
		boolean result = false;
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
		
		// 출처정보
		String src_book = QmTm.getNullChk(request.getParameter("src_book")); // 도서명
		String src_author = QmTm.getNullChk(request.getParameter("src_author")); // 저자명
		String src_page = QmTm.getNullChk(request.getParameter("src_page")); // 페이지
		String src_pub_year = QmTm.getNullChk(request.getParameter("src_pub_year")); // 출판연도
		String src_pub_comp = QmTm.getNullChk(request.getParameter("src_pub_comp")); // 출판사
		String src_misc = QmTm.getNullChk(request.getParameter("src_misc")); // 기타

		String yn_ex_set = QmTm.getNullChk(request.getParameter("yn_ex_set")); // 선다형 문제 보기섞기 제어
		if (yn_ex_set == null || yn_ex_set.equals("")) { yn_ex_set = "N"; } else { yn_ex_set = yn_ex_set.trim(); }
		String yn_practice = QmTm.getNullChk(request.getParameter("yn_practice")); // 실기형 문제
		if (yn_practice == null || yn_practice.equals("")) { yn_practice = "N"; } else { yn_practice = yn_practice.trim(); }
	
		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil 생성		
		util.setMimeValue(strMimeValue1); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util.setSavePath(strSavePath); // 저장 디렉터리 지정
		util.setSaveUrl(strSaveUrl); // URL 경로 지정

		util.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
						
		q = util.getDecodedHtml(false);
		
		//******************* FTP 연결시작 *********************
		int port = Integer.parseInt(ftp_port);
						
		ftpClient = new FTPClient();
							
		ftpClient.setControlEncoding("euc-kr");		
		ftpClient.connect(ftp_url,port);
							
		int reply = ftpClient.getReplyCode();

		if(!FTPReply.isPositiveCompletion(reply)) {
			ftpClient.disconnect();
			out.println("FTP server에 접속이 되지 않습니다.");
			if(true) return;
		}
									
		ftpClient.setSoTimeout(10000);
		ftpClient.login(ftp_username, ftp_pwd);

		// default FTP.ASCII_FILE_TYPE 
		ftpClient.setFileType(FTP.BINARY_FILE_TYPE); //FTP.ASCII_FILE_TYPE, FTP.EBCDIC_FILE_TYPE, FTP.IMAGE_FILE_TYPE , FTP.LOCAL_FILE_TYPE 
		// default FTP.STREAM_TRANSFER_MODE 
		ftpClient.setFileTransferMode(FTP.STREAM_TRANSFER_MODE); //FTP.BLOCK_TRANSFER_MODE, FTP.COMPRESSED_TRANSFER_MODE
						
		ftpClient.makeDirectory(id_subject);				
		//******************* FTP 연결종료 *********************
				
		Enumeration e = util.getDecodedFileList(); // 디코딩되어 저장된 파일 이름 리스트
		while (e.hasMoreElements()) 
		{
			String s = (String)e.nextElement();
											
			String downPath = strSavePath+"/"+s;
			String upPath = id_subject+"/"+s;
			
			File put_file = new File(downPath);
					
			InputStream inputStream = new FileInputStream(put_file);
			result = ftpClient.storeFile(upPath, inputStream);
							
			inputStream.close();
			
			if (result) {
			} else {
				out.println("파일 업로드에 실패하였습니다.");
				ftpClient.logout();	
				ftpClient.disconnect();
				if(true) return;
			}
		}
		
		//******************* FTP 업로드 종료 **********************

		q = q.replace("<BR>","&ltBR&gt");
				
		//외부개체가 포함되었을경우
		if(q.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
						
			q = q.replace("<?xml","<xml");

			q = HtmlParser.html_parser(q, strSaveUrl);
			
		}		

		q = q.replace("&ltBR&gt","<BR>");

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
		
		//******************* FTP 업로드 시작 *********************
		
		Enumeration e1 = util2.getDecodedFileList(); // 디코딩되어 저장된 파일 이름 리스트
		while (e1.hasMoreElements()) 
		{
			String s1 = (String)e1.nextElement();
														
			String downPath1 = strSavePath+"/"+s1;
			String upPath1 = id_subject+"/"+s1;
			File put_file1 = new File(downPath1);
											
			InputStream inputStream1 = new FileInputStream(put_file1);
			result = ftpClient.storeFile(upPath1, inputStream1);
													
			inputStream1.close();

			if (result) {
			} else {
				out.println("1.파일 업로드에 실패하였습니다.");
				ftpClient.logout();	
				ftpClient.disconnect();
				if(true) return;
			}
		}
								
		//******************* FTP 업로드 종료 **********************

		//외부개체가 포함되었을경우
		if(ex1.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			
			ex1 = ex1.replace("<BR>","&ltBR&gt");
			ex1 = ex1.replace("<?xml","<xml");

			ex1 = HtmlParser.html_parser(ex1, strSaveUrl);

			ex1 = ex1.replace("&ltBR&gt","<BR>");
		}		

		ex1 = ex1.replace("</HTML>","");
		ex1 = ex1.replace("<PRE>","");
		ex1 = ex1.replace("</PRE>","");
		ex1 = ex1.replace("<P>","");
		ex1 = ex1.replace("</P>","");
		ex1 = ex1.replace("<!--StartFragment-->","");

		MimeUtil util3 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util3.setHtmlRange(Constant.HTML_INNER_BODY);
		util3.setMimeValue(strMimeValue3); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util3.setSavePath(strSavePath); // 저장 디렉터리 지정
		util3.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util3.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util3.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex2 = util3.getDecodedHtml(false);
		
		//******************* FTP 업로드 시작 *********************
		
		Enumeration e2 = util3.getDecodedFileList(); // 디코딩되어 저장된 파일 이름 리스트
		while (e2.hasMoreElements()) 
		{
			String s2 = (String)e2.nextElement();
										
			String downPath2 = strSavePath+"/"+s2;
			String upPath2 = id_subject+"/"+s2;
			File put_file2 = new File(downPath2);
							
			InputStream inputStream2 = new FileInputStream(put_file2);
			result = ftpClient.storeFile(upPath2, inputStream2);
									
			inputStream2.close();

			if (result) {
			} else {
				out.println("2.파일 업로드에 실패하였습니다.");
				ftpClient.logout();	
				ftpClient.disconnect();
				if(true) return;
			}
		}
				
		//******************* FTP 업로드 종료 **********************

		//외부개체가 포함되었을경우
		if(ex2.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			
			ex2 = ex2.replace("<BR>","&ltBR&gt");
			ex2 = ex2.replace("<?xml","<xml");

			ex2 = HtmlParser.html_parser(ex2, strSaveUrl);

			ex2 = ex2.replace("&ltBR&gt","<BR>");
		}		

		ex2 = ex2.replace("</HTML>","");
		ex2 = ex2.replace("<PRE>","");
		ex2 = ex2.replace("</PRE>","");
		ex2 = ex2.replace("<P>","");
		ex2 = ex2.replace("</P>","");
		ex2 = ex2.replace("<!--StartFragment-->","");

		MimeUtil util4 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util4.setHtmlRange(Constant.HTML_INNER_BODY);
		util4.setMimeValue(strMimeValue4); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util4.setSavePath(strSavePath); // 저장 디렉터리 지정
		util4.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util4.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util4.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex3 = util4.getDecodedHtml(false);
		
		//******************* FTP 업로드 시작 *********************
		
		Enumeration e3 = util4.getDecodedFileList(); // 디코딩되어 저장된 파일 이름 리스트
		while (e3.hasMoreElements()) 
		{
			String s3 = (String)e3.nextElement();
												
			String downPath3 = strSavePath+"/"+s3;
			String upPath3 = id_subject+"/"+s3;
			File put_file3 = new File(downPath3);
									
			InputStream inputStream3 = new FileInputStream(put_file3);
			result = ftpClient.storeFile(upPath3, inputStream3);
											
			inputStream3.close();

			if (result) {
			} else {
				out.println("3.파일 업로드에 실패하였습니다.");
				ftpClient.logout();	
				ftpClient.disconnect();
				if(true) return;
			}
		}
						
		//******************* FTP 업로드 종료 **********************

		//외부개체가 포함되었을경우
		if(ex3.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			
			ex3 = ex3.replace("<BR>","&ltBR&gt");
			ex3 = ex3.replace("<?xml","<xml");

			ex3 = HtmlParser.html_parser(ex3, strSaveUrl);

			ex3 = ex3.replace("&ltBR&gt","<BR>");
		}		

		ex3 = ex3.replace("</HTML>","");
		ex3 = ex3.replace("<PRE>","");
		ex3 = ex3.replace("</PRE>","");
		ex3 = ex3.replace("<P>","");
		ex3 = ex3.replace("</P>","");
		ex3 = ex3.replace("<!--StartFragment-->","");

		MimeUtil util5 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util5.setHtmlRange(Constant.HTML_INNER_BODY);
		util5.setMimeValue(strMimeValue5); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util5.setSavePath(strSavePath); // 저장 디렉터리 지정
		util5.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util5.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util5.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex4 = util5.getDecodedHtml(false);
		
		//******************* FTP 업로드 시작 *********************		
		Enumeration e4 = util5.getDecodedFileList(); // 디코딩되어 저장된 파일 이름 리스트
		while (e4.hasMoreElements()) 
		{
			String s4 = (String)e4.nextElement();
														
			String downPath4 = strSavePath+"/"+s4;
			String upPath4 = id_subject+"/"+s4;
			File put_file4 = new File(downPath4);
											
			InputStream inputStream4 = new FileInputStream(put_file4);
			result = ftpClient.storeFile(upPath4, inputStream4);
													
			inputStream4.close();

			if (result) {
			} else {
				out.println("4.파일 업로드에 실패하였습니다.");
				ftpClient.logout();	
				ftpClient.disconnect();
				if(true) return;
			}
		}
								
		//******************* FTP 업로드 종료 **********************

		//외부개체가 포함되었을경우
		if(ex4.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			
			ex4 = ex4.replace("<BR>","&ltBR&gt");
			ex4 = ex4.replace("<?xml","<xml");

			ex4 = HtmlParser.html_parser(ex4, strSaveUrl);

			ex4 = ex4.replace("&ltBR&gt","<BR>");
		}		
		
		ex4 = ex4.replace("</HTML>","");
		ex4 = ex4.replace("<PRE>","");
		ex4 = ex4.replace("</PRE>","");
		ex4 = ex4.replace("<P>","");
		ex4 = ex4.replace("</P>","");
		ex4 = ex4.replace("<!--StartFragment-->","");

		MimeUtil util6 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util6.setHtmlRange(Constant.HTML_INNER_BODY);
		util6.setMimeValue(strMimeValue6); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util6.setSavePath(strSavePath); // 저장 디렉터리 지정
		util6.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util6.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util6.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 

		ex5 = util6.getDecodedHtml(false);
		
		//******************* FTP 업로드 시작 *********************
		
		Enumeration e5 = util6.getDecodedFileList(); // 디코딩되어 저장된 파일 이름 리스트
		while (e5.hasMoreElements()) 
		{
			String s5 = (String)e5.nextElement();
														
			String downPath5 = strSavePath+"/"+s5;
			String upPath5 = id_subject+"/"+s5;
			File put_file5 = new File(downPath5);
											
			InputStream inputStream5 = new FileInputStream(put_file5);
			result = ftpClient.storeFile(upPath5, inputStream5);
													
			inputStream5.close();

			if (result) {
			} else {
				out.println("5.파일 업로드에 실패하였습니다.");
				ftpClient.logout();	
				ftpClient.disconnect();
				if(true) return;
			}
		}
								
		//******************* FTP 업로드 종료 **********************

		//외부개체가 포함되었을경우
		if(ex5.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			
			ex5 = ex5.replace("<BR>","&ltBR&gt");
			ex5 = ex5.replace("<?xml","<xml");

			ex5 = HtmlParser.html_parser(ex5, strSaveUrl);

			ex5 = ex5.replace("&ltBR&gt","<BR>");
		}		
		
		ex5 = ex5.replace("</HTML>","");
		ex5 = ex5.replace("<PRE>","");
		ex5 = ex5.replace("</PRE>","");
		ex5 = ex5.replace("<P>","");
		ex5 = ex5.replace("</P>","");
		ex5 = ex5.replace("<!--StartFragment-->","");
		
		MimeUtil util10 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util10.setHtmlRange(Constant.HTML_INNER_BODY);
		util10.setMimeValue(strMimeValue10); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util10.setSavePath(strSavePath); // 저장 디렉터리 지정
		util10.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util10.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util10.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 

		explain = util10.getDecodedHtml(false);
		
		//******************* FTP 업로드 시작 *********************
		
		Enumeration e6 = util10.getDecodedFileList(); // 디코딩되어 저장된 파일 이름 리스트
		while (e6.hasMoreElements()) 
		{
			String s6 = (String)e6.nextElement();
														
			String downPath6 = strSavePath+"/"+s6;
			String upPath6 =id_subject+"/"+s6;
			File put_file6 = new File(downPath6);
											
			InputStream inputStream6 = new FileInputStream(put_file6);
			result = ftpClient.storeFile(upPath6, inputStream6);
													
			inputStream6.close();

			if (result) {
			} else {
				out.println("6.파일 업로드에 실패하였습니다.");
				ftpClient.logout();	
				ftpClient.disconnect();
				if(true) return;
			}
		}
		
		ftpClient.logout();
		//******************* FTP 업로드 종료 **********************

		//외부개체가 포함되었을경우
		if(explain.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			
			explain = explain.replace("<BR>","&ltBR&gt");
			explain = explain.replace("<?xml","<xml");

			explain = HtmlParser.html_parser(explain, strSaveUrl);

			explain = explain.replace("&ltBR&gt","<BR>");
		}	
		
		explain = explain.replace("</HTML>","");
		explain = explain.replace("<PRE>","");
		explain = explain.replace("</PRE>","");
		explain = explain.replace("<P>","");
		explain = explain.replace("</P>","");
		explain = explain.replace("<!--StartFragment-->","");

		MimeUtil util11 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util11.setHtmlRange(Constant.HTML_INNER_BODY);
		util11.setMimeValue(strMimeValue11); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util11.setSavePath(strSavePath); // 저장 디렉터리 지정
		util11.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util11.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util11.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 

		hint = util11.getDecodedHtml(false);

		//외부개체가 포함되었을경우
		if(hint.replace("\"","").indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			
			hint = hint.replace("<BR>","&ltBR&gt");
			hint = hint.replace("<?xml","<xml");

			hint = HtmlParser.html_parser(hint, strSaveUrl);

			hint = hint.replace("&ltBR&gt","<BR>");
		}
		
		hint = hint.replace("</HTML>","");
		hint = hint.replace("<PRE>","");
		hint = hint.replace("</PRE>","");
		hint = hint.replace("<P>","");
		hint = hint.replace("</P>","");
		hint = hint.replace("<!--StartFragment-->","");

		// 지문 제목
		reftitle = QmTm.getNullChk(request.getParameter("ref_name"));
		
		if(reftitle.length() > 0) {
			QRefBean beans = new QRefBean();
			
			// 지문 코드
			if(id_ref.equals("0")) {
				id_ref = CommonUtil.getMakeID("R");
			}

			beans.setId_ref(id_ref);

			if(id_ref.equals("0")) { // 기존지문을 등록할 경우에는 지문 테이블에 등록하지 않는다.

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

				refbody = refbody.replace("</HTML>","");
				refbody = refbody.replace("<PRE>","");
				refbody = refbody.replace("</PRE>","");
				refbody= refbody.replace("<P>","");
				refbody= refbody.replace("</P>","");

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
		bean.setQ(ComLib.toStrHtml2(q));
		bean.setEx1(ComLib.toStrHtml2(ex1));
		bean.setEx2(ComLib.toStrHtml2(ex2));
		bean.setEx3(ComLib.toStrHtml2(ex3));
		bean.setEx4(ComLib.toStrHtml2(ex4));
		bean.setEx5(ComLib.toStrHtml2(ex5));
		bean.setEx6(ex6);
		bean.setEx7(ex7);
		bean.setEx8(ex8);
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
						
		// 개별문제 등록
		try {
		    QUtil.insert(bean);

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
		} else if(qtype == 3) {	
			bigos.append("복수답안형");
			bigos.append(", 보기갯수 : ");
			bigos.append(excount2);
			bigos.append(", 정답갯수 : ");
			bigos.append(cacount2);
			bigos.append(", 정답 : ");
			bigos.append(arrCorrects);			
		} else if(qtype == 4) {	
			bigos.append("단답형");
			bigos.append(", 정답갯수 : ");
			bigos.append(cacount2);
			bigos.append(", 정답 : ");
			bigos.append(arrCorrects);
		} else if(qtype == 5) {	
			bigos.append("논술형");			
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
						
		bigos.append(", 출처 : ");
		bigos.append(ComLib.nullChk2(src_pub_comp));

		bigos.append(", 비고 : ");
		bigos.append(ComLib.nullChk2(src_misc));
				
		// 로그정보 등록 시작
		WorkQLogBean logbean = new WorkQLogBean();

		logbean.setId_subject(id_subject);
		logbean.setId_chapter(id_chapter);
		logbean.setId_chapter2(id_chapter2);
		logbean.setId_chapter3(id_chapter3);
		logbean.setId_chapter4(id_chapter4);
		logbean.setUserid(userid);
		logbean.setGubun("문제개별등록");
		logbean.setId_q("");
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
	} finally {
		if (ftpClient != null && ftpClient.isConnected()) {
			try {
				ftpClient.disconnect();
			} catch (Exception ex) {				
			}
		}
	}
%>

	<script language="javascript">
		alert("문제가 정상적으로 등록되었습니다.");
		window.opener.location.reload();
		window.close();
	</script>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*,java.util.*,com.tagfree.util.*,org.w3c.tidy.*,org.w3c.dom.*" %>
<%
	try
	{
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
		String refbody = "";
		
		boolean bReaname = true; // 저장할 디렉터리에 파일이 존재할 경우 새로운 이름을 지정한다.
		String strSavePath = "D:/qmtm_web/admin/ROOT/files"; // 실제 웹 서버에 저장되는 디렉터리를 지정한다.
		String strSaveUrl = "http://qmtm:2008/files"; // 실제 웹 서버에 저장되는 디렉터리의 웹 URL 경로를 지정한다.
		String strMimeValue1 = request.getParameter("mime_contents"); // Active Designer에서 작성된 본문의 MIME 값을 가져온다.
		String strMimeValue2 = request.getParameter("mime_contents2"); 
		String strMimeValue3 = request.getParameter("mime_contents3"); 
		String strMimeValue4 = request.getParameter("mime_contents4");
		String strMimeValue5 = request.getParameter("mime_contents5"); 
		String strMimeValue6 = request.getParameter("mime_contents6"); 
		String strMimeValue7 = request.getParameter("mime_contents7"); 
		String strMimeValue8 = request.getParameter("mime_contents8"); 
		String strMimeValue9 = request.getParameter("mime_contents9");
		String strMimeValue10 = request.getParameter("mime_contents10");
		String strMimeValue11 = request.getParameter("mime_contents11");
		String strMimeValue12 = request.getParameter("mime_contents12");
		
		// 문제정보
		String allotts = request.getParameter("allotts"); // 배점
		String limittime = request.getParameter("limittime"); // 분
		String limittime2 = request.getParameter("limittime2"); // 초
		String corrects = request.getParameter("corrects"); // 정답

		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil 생성		
		util.setMimeValue(strMimeValue1); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util.setSavePath(strSavePath); // 저장 디렉터리 지정
		util.setSaveUrl(strSaveUrl); // URL 경로 지정

		util.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
						
		q = util.getDecodedHtml(false);
		out.println(q); // 디코딩된 HTML을 가져옴.
						
		MimeUtil util2 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util2.setHtmlRange(Constant.HTML_INNER_BODY);
		util2.setMimeValue(strMimeValue2); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util2.setSavePath(strSavePath); // 저장 디렉터리 지정
		util2.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util2.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util2.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex1 = util2.getDecodedHtml(false);
		out.println(ex1);

		MimeUtil util3 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util3.setHtmlRange(Constant.HTML_INNER_BODY);
		util3.setMimeValue(strMimeValue3); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util3.setSavePath(strSavePath); // 저장 디렉터리 지정
		util3.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util3.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util3.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex2 = util3.getDecodedHtml(false);
		out.println(ex2);

		MimeUtil util4 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util4.setHtmlRange(Constant.HTML_INNER_BODY);
		util4.setMimeValue(strMimeValue4); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util4.setSavePath(strSavePath); // 저장 디렉터리 지정
		util4.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util4.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util4.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex3 = util4.getDecodedHtml(false);
		out.println(ex3);

		MimeUtil util5 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util5.setHtmlRange(Constant.HTML_INNER_BODY);
		util5.setMimeValue(strMimeValue5); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util5.setSavePath(strSavePath); // 저장 디렉터리 지정
		util5.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util5.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util5.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex4 = util5.getDecodedHtml(false);
		out.println(ex4);

		MimeUtil util6 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util6.setHtmlRange(Constant.HTML_INNER_BODY);
		util6.setMimeValue(strMimeValue6); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util6.setSavePath(strSavePath); // 저장 디렉터리 지정
		util6.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util6.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util6.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex5 = util6.getDecodedHtml(false);
		out.println(ex5);

		MimeUtil util7 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util7.setHtmlRange(Constant.HTML_INNER_BODY);
		util7.setMimeValue(strMimeValue7); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util7.setSavePath(strSavePath); // 저장 디렉터리 지정
		util7.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util7.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util7.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex6 = util7.getDecodedHtml(false);
		out.println(ex6);

		MimeUtil util8 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util8.setHtmlRange(Constant.HTML_INNER_BODY);
		util8.setMimeValue(strMimeValue8); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util8.setSavePath(strSavePath); // 저장 디렉터리 지정
		util8.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util8.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util8.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex7 = util8.getDecodedHtml(false);
		out.println(ex7);

		MimeUtil util9 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util9.setHtmlRange(Constant.HTML_INNER_BODY);
		util9.setMimeValue(strMimeValue9); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util9.setSavePath(strSavePath); // 저장 디렉터리 지정
		util9.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util9.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util9.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		ex8 = util9.getDecodedHtml(false);
		out.println(ex8);

		MimeUtil util10 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util10.setHtmlRange(Constant.HTML_INNER_BODY);
		util10.setMimeValue(strMimeValue10); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util10.setSavePath(strSavePath); // 저장 디렉터리 지정
		util10.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util10.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util10.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		explain = util10.getDecodedHtml(false);
		out.println(explain);

		MimeUtil util11 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util11.setHtmlRange(Constant.HTML_INNER_BODY);
		util11.setMimeValue(strMimeValue11); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util11.setSavePath(strSavePath); // 저장 디렉터리 지정
		util11.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util11.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util11.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		hint = util11.getDecodedHtml(false);
		out.println(hint);

		MimeUtil util12 = new MimeUtil(); // com.tagfree.util.MimeUtil 생성
		util12.setHtmlRange(Constant.HTML_INNER_BODY);
		util12.setMimeValue(strMimeValue12); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util12.setSavePath(strSavePath); // 저장 디렉터리 지정
		util12.setSaveUrl(strSaveUrl); // URL 경로 지정
		
		util12.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util12.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
				
		refbody = util12.getDecodedHtml(false);
		out.println(refbody);
	} 
	catch(Exception e) 
	{
		e.printStackTrace();
	} 
%>
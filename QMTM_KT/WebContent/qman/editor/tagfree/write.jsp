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
		
		boolean bReaname = true; // ������ ���͸��� ������ ������ ��� ���ο� �̸��� �����Ѵ�.
		String strSavePath = "D:/qmtm_web/admin/ROOT/files"; // ���� �� ������ ����Ǵ� ���͸��� �����Ѵ�.
		String strSaveUrl = "http://qmtm:2008/files"; // ���� �� ������ ����Ǵ� ���͸��� �� URL ��θ� �����Ѵ�.
		String strMimeValue1 = request.getParameter("mime_contents"); // Active Designer���� �ۼ��� ������ MIME ���� �����´�.
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
		
		// ��������
		String allotts = request.getParameter("allotts"); // ����
		String limittime = request.getParameter("limittime"); // ��
		String limittime2 = request.getParameter("limittime2"); // ��
		String corrects = request.getParameter("corrects"); // ����

		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil ����		
		util.setMimeValue(strMimeValue1); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util.setSavePath(strSavePath); // ���� ���͸� ����
		util.setSaveUrl(strSaveUrl); // URL ��� ����

		util.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
						
		q = util.getDecodedHtml(false);
		out.println(q); // ���ڵ��� HTML�� ������.
						
		MimeUtil util2 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util2.setHtmlRange(Constant.HTML_INNER_BODY);
		util2.setMimeValue(strMimeValue2); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util2.setSavePath(strSavePath); // ���� ���͸� ����
		util2.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util2.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util2.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex1 = util2.getDecodedHtml(false);
		out.println(ex1);

		MimeUtil util3 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util3.setHtmlRange(Constant.HTML_INNER_BODY);
		util3.setMimeValue(strMimeValue3); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util3.setSavePath(strSavePath); // ���� ���͸� ����
		util3.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util3.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util3.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex2 = util3.getDecodedHtml(false);
		out.println(ex2);

		MimeUtil util4 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util4.setHtmlRange(Constant.HTML_INNER_BODY);
		util4.setMimeValue(strMimeValue4); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util4.setSavePath(strSavePath); // ���� ���͸� ����
		util4.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util4.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util4.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex3 = util4.getDecodedHtml(false);
		out.println(ex3);

		MimeUtil util5 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util5.setHtmlRange(Constant.HTML_INNER_BODY);
		util5.setMimeValue(strMimeValue5); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util5.setSavePath(strSavePath); // ���� ���͸� ����
		util5.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util5.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util5.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex4 = util5.getDecodedHtml(false);
		out.println(ex4);

		MimeUtil util6 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util6.setHtmlRange(Constant.HTML_INNER_BODY);
		util6.setMimeValue(strMimeValue6); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util6.setSavePath(strSavePath); // ���� ���͸� ����
		util6.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util6.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util6.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex5 = util6.getDecodedHtml(false);
		out.println(ex5);

		MimeUtil util7 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util7.setHtmlRange(Constant.HTML_INNER_BODY);
		util7.setMimeValue(strMimeValue7); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util7.setSavePath(strSavePath); // ���� ���͸� ����
		util7.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util7.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util7.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex6 = util7.getDecodedHtml(false);
		out.println(ex6);

		MimeUtil util8 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util8.setHtmlRange(Constant.HTML_INNER_BODY);
		util8.setMimeValue(strMimeValue8); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util8.setSavePath(strSavePath); // ���� ���͸� ����
		util8.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util8.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util8.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex7 = util8.getDecodedHtml(false);
		out.println(ex7);

		MimeUtil util9 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util9.setHtmlRange(Constant.HTML_INNER_BODY);
		util9.setMimeValue(strMimeValue9); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util9.setSavePath(strSavePath); // ���� ���͸� ����
		util9.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util9.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util9.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex8 = util9.getDecodedHtml(false);
		out.println(ex8);

		MimeUtil util10 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util10.setHtmlRange(Constant.HTML_INNER_BODY);
		util10.setMimeValue(strMimeValue10); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util10.setSavePath(strSavePath); // ���� ���͸� ����
		util10.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util10.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util10.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		explain = util10.getDecodedHtml(false);
		out.println(explain);

		MimeUtil util11 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util11.setHtmlRange(Constant.HTML_INNER_BODY);
		util11.setMimeValue(strMimeValue11); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util11.setSavePath(strSavePath); // ���� ���͸� ����
		util11.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util11.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util11.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		hint = util11.getDecodedHtml(false);
		out.println(hint);

		MimeUtil util12 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util12.setHtmlRange(Constant.HTML_INNER_BODY);
		util12.setMimeValue(strMimeValue12); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util12.setSavePath(strSavePath); // ���� ���͸� ����
		util12.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util12.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util12.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		refbody = util12.getDecodedHtml(false);
		out.println(refbody);
	} 
	catch(Exception e) 
	{
		e.printStackTrace();
	} 
%>
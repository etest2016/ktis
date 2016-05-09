<%
//******************************************************************************
//   ���α׷� : edit.jsp
//   �� �� �� : �������� ���
//   ��    �� : 
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2010-06-22
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
	
	// FTP ��� ����
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

		// ī�װ� ����
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
		
		boolean bReaname = true; // ������ ���͸��� ������ ������ ��� ���ο� �̸��� �����Ѵ�.
		String strSavePath = ftp_path+id_subject; // ���� �� ������ ����Ǵ� ���͸��� �����Ѵ�.
		String strSaveUrl = web_path+id_subject; // ���� �� ������ ����Ǵ� ���͸��� �� URL ��θ� �����Ѵ�.
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

		// ���� ��������
		int qtype = QmTm.getIntChk(request.getParameter("qtype2"));
		int excount2 = QmTm.getIntChk(request.getParameter("excount2"));
		int cacount2 = QmTm.getIntChk(request.getParameter("cacount2"));

		String msg_yn = request.getParameter("msg_yn");
		
		String[] corrects = request.getParameterValues("corrects"); // ����

		String arrCorrects = "";

		int seq[] = new int[cacount2];
		String box_size[] = new String[cacount2]; // �����Է¹ڽ� ũ��
		String front_msg[] = new String[cacount2]; // �� �޽���
		String back_msg[] = new String[cacount2]; // �� �޽���

		String ans_list[] = new String[cacount2]; // �ܴ��� ��� ����Ʈ

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
		
		// �ܴ��� ����
		String yn_single_line = request.getParameter("yn_single_line"); // �ܴ��� �Է� �ڽ� 1�ٿ� ǥ�� ����
		if(yn_single_line == null) {
			yn_single_line = "N";
		}

		String yn_caorder = request.getParameter("yn_caorder"); // ������� ���� ����
		if(yn_caorder == null) {
			yn_caorder = "N";
		}
		String yn_case = request.getParameter("yn_case"); // ��ҹ��� ���� ����
		if(yn_case == null) {
			yn_case = "N";
		}
		String yn_blank = request.getParameter("yn_blank"); // ���� ���� ���� 
		if(yn_blank == null) {
			yn_blank = "N";
		}
				
		// ��������
		double allotting = QmTm.getDblChk(request.getParameter("allotts")); // ����
		//String id_qtype = request.getParameter("id_qtype"); // ��������
		int limittime1 = 1; // ��
		limittime1 = limittime1 * 60;
		int limittime2 = 0; // ��
		int limittime = limittime1 + limittime2;
		int excount = Integer.parseInt(request.getParameter("excount")); // �����
		int id_difficulty1 = Integer.parseInt(request.getParameter("id_difficulty1")); // ���̵�
		int cacount = Integer.parseInt(request.getParameter("cacount")); // �����
		int id_q_use = Integer.parseInt(request.getParameter("id_q_use")); // �����뵵
		int make_cnt = QmTm.getIntChk(request.getParameter("make_cnt")); // ����Ƚ��
		int ex_rowcnt = QmTm.getIntChk(request.getParameter("ex_rowcnt")); // 1�ٿ� ǥ���� ���� ��
		String q_chapter = QmTm.getNullChk(request.getParameter("q_chapter")); // ����
		String find_kwd = QmTm.getNullChk(request.getParameter("find_kwd")); // �˻�Ű����		
		String q_media = QmTm.getNullChk(request.getParameter("q_media")); // ������
		String q_media_point = QmTm.getNullChk(request.getParameter("q_media_point")); // ������ ����Ʈ
		String q_sound = QmTm.getNullChk(request.getParameter("q_sound")); // ����

		// ��ó����
		String src_book = QmTm.getNullChk(request.getParameter("src_book")); // ������
		String src_author = QmTm.getNullChk(request.getParameter("src_author")); // ���ڸ�
		String src_page = QmTm.getNullChk(request.getParameter("src_page")); // ������
		String src_pub_year = QmTm.getNullChk(request.getParameter("src_pub_year")); // ���ǿ���
		String src_pub_comp = QmTm.getNullChk(request.getParameter("src_pub_comp")); // ���ǻ�
		String src_misc = QmTm.getNullChk(request.getParameter("src_misc")); // ��Ÿ
	
		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil ����		
		util.setMimeValue(strMimeValue1); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util.setSavePath(strSavePath); // ���� ���͸� ����
		util.setSaveUrl(strSaveUrl); // URL ��� ����

		util.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
						
		q = util.getDecodedHtml(false);

		q = q.replace("\"","");
	
		//�ܺΰ�ü�� ���ԵǾ������
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

		MimeUtil util2 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util2.setHtmlRange(Constant.HTML_INNER_BODY);
		util2.setMimeValue(strMimeValue2); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util2.setSavePath(strSavePath); // ���� ���͸� ����
		util2.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util2.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util2.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
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

		MimeUtil util3 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util3.setHtmlRange(Constant.HTML_INNER_BODY);
		util3.setMimeValue(strMimeValue3); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util3.setSavePath(strSavePath); // ���� ���͸� ����
		util3.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util3.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util3.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
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

		MimeUtil util4 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util4.setHtmlRange(Constant.HTML_INNER_BODY);
		util4.setMimeValue(strMimeValue4); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util4.setSavePath(strSavePath); // ���� ���͸� ����
		util4.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util4.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util4.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
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

		MimeUtil util5 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util5.setHtmlRange(Constant.HTML_INNER_BODY);
		util5.setMimeValue(strMimeValue5); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util5.setSavePath(strSavePath); // ���� ���͸� ����
		util5.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util5.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util5.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
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

		MimeUtil util6 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util6.setHtmlRange(Constant.HTML_INNER_BODY);
		util6.setMimeValue(strMimeValue6); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util6.setSavePath(strSavePath); // ���� ���͸� ����
		util6.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util6.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util6.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
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

		MimeUtil util7 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util7.setHtmlRange(Constant.HTML_INNER_BODY);
		util7.setMimeValue(strMimeValue7); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util7.setSavePath(strSavePath); // ���� ���͸� ����
		util7.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util7.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util7.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex6 = util7.getDecodedHtml(false);

		ex6 = ex6.replace("<P>","");
		ex6 = ex6.replace("</P>","");
		
		//ex6 = ex6.replace("\n", "");

		MimeUtil util8 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util8.setHtmlRange(Constant.HTML_INNER_BODY);
		util8.setMimeValue(strMimeValue8); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util8.setSavePath(strSavePath); // ���� ���͸� ����
		util8.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util8.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util8.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex7 = util8.getDecodedHtml(false);

		ex7 = ex7.replace("<P>","");
		ex7 = ex7.replace("</P>","");
		
		//ex7 = ex7.replace("\n", "");

		MimeUtil util9 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util9.setHtmlRange(Constant.HTML_INNER_BODY);
		util9.setMimeValue(strMimeValue9); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util9.setSavePath(strSavePath); // ���� ���͸� ����
		util9.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util9.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util9.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		ex8 = util9.getDecodedHtml(false);

		ex8 = ex8.replace("<P>","");
		ex8 = ex8.replace("</P>","");
		
		//ex8 = ex8.replace("\n", "");

		MimeUtil util10 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util10.setHtmlRange(Constant.HTML_INNER_BODY);
		util10.setMimeValue(strMimeValue10); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util10.setSavePath(strSavePath); // ���� ���͸� ����
		util10.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util10.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util10.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		explain = util10.getDecodedHtml(false);

		explain = explain.replace("\"","");

		explain = explain.replace("<P>","");
		explain = explain.replace("</P>","");
		
		//explain = explain.replace("\n", "");

		MimeUtil util11 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
		util11.setHtmlRange(Constant.HTML_INNER_BODY);
		util11.setMimeValue(strMimeValue11); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util11.setSavePath(strSavePath); // ���� ���͸� ����
		util11.setSaveUrl(strSaveUrl); // URL ��� ����
		
		util11.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util11.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
		hint = util11.getDecodedHtml(false);

		hint = hint.replace("\"","");

		hint= hint.replace("<P>","");
		hint= hint.replace("</P>","");

		//hint = hint.replace("\n", "");

		// ���� ����
		reftitle = QmTm.getNullChk(request.getParameter("ref_name"));
		
		if(reftitle.length() > 0) {			
			QRefBean beans = new QRefBean();

			boolean chk = false;

			if(id_ref.equals("0")) {	
				// ���� �ڵ�
				chk = true;
				id_ref = CommonUtil.getMakeID("R");
			}
			
			// ���� �ڵ�			
			beans.setId_ref(id_ref);
			beans.setReftitle(reftitle);

			// ���� ����
			MimeUtil util12 = new MimeUtil(); // com.tagfree.util.MimeUtil ����
			util12.setHtmlRange(Constant.HTML_INNER_BODY);
			util12.setMimeValue(strMimeValue12); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
			util12.setSavePath(strSavePath); // ���� ���͸� ����
			util12.setSaveUrl(strSaveUrl); // URL ��� ����
		
			util12.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
			util12.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
				
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
			    refbody3 = buf.substring(4000); // �ִ� 6000 �� ����
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
				
		// �������� ���
		try {
		    QUtil.update(id_q, bean);

			// �ܴ����ϰ��...
			if(qtype == 4) {
				for(int k=0; k<cacount2; k++) {
				
					ans_list[k] = QmTm.getNullChk(request.getParameter("ans_list2"+(k+1)));

					seq[k] = k+1;
					box_size[k] = QmTm.getNullChk(request.getParameter("ans_size"+(k+1)));
					front_msg[k] = QmTm.getNullChk(request.getParameter("front_msg"+(k+1)));
					back_msg[k] = QmTm.getNullChk(request.getParameter("back_msg"+(k+1)));

					// �ܴ��� �޽��� ���
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
		alert("������ ���������� �����Ǿ����ϴ�.");
		window.opener.location.reload();
		window.close();
	</script>
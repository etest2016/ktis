<%
//******************************************************************************
//   ���α׷� : save_ref.jsp
//   �� �� �� : ��������
//   ��    �� : ��������
//   �� �� �� : 
//   �ڹ����� : qmtm.qman.editor.QUtil
//   �� �� �� : 2008-08-26
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*, java.util.*, com.tagfree.util.*, org.w3c.tidy.*, org.w3c.dom.*, qmtm.*, qmtm.qman.editor.*, qmtm.qman.*" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_subject = request.getParameter("id_subject"); // �����ڵ�
	//String id_subject = "aaaa"; // �����ڵ�
	//String reftitle = request.getParameter("ref_name"); // ��������
	String reftitle = "111111111111111"; // ��������
	//String ref_body = request.getParameter("ref_body");
	

	String id_ref = CommonUtil.getMakeID("R");

	//out.println(id_ref);
	
	try
	{
		File dir = new File("D:/qmtm_web/admin/ROOT/files/"+id_subject);

        try {
            if (!dir.exists()) {
                dir.mkdir();
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
		
		boolean bReaname = true; // ������ ���͸��� ������ ������ ��� ���ο� �̸��� �����Ѵ�.
		String strSavePath = "D:/qmtm_web/admin/ROOT/files/"+id_subject; // ���� �� ������ ����Ǵ� ���͸��� �����Ѵ�.
		String strSaveUrl = "http://qmtm:2008/files/"+id_subject; // ���� �� ������ ����Ǵ� ���͸��� �� URL ��θ� �����Ѵ�.
		//String ref_body = request.getParameter("ref_body"); // ��������
		String ref_body = "2222222222222222222222222222222222222222222222222222222222";
						
		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil ����		
		util.setHtmlRange(Constant.HTML_INNER_BODY);
		util.setMimeValue(ref_body); // �ۼ��� ���� + ���Ե� ���� ������ MIME �� ����
		util.setSavePath(strSavePath); // ���� ���͸� ����
		util.setSaveUrl(strSaveUrl); // URL ��� ����

		util.setRename(true); // ������ ���� �ÿ� ���ο� �̸��� ������ �������� ����
		
		util.processDecoding(); // MIME ���� ���ڵ� -> �� �� ���Ե� ������ ��� �� ������ ����ȴ�. 
						
		ref_body = util.getDecodedHtml(false);

		out.println(ref_body);

		//�ܺΰ�ü�� ���ԵǾ������
		if(ref_body.indexOf("<?xml:namespace prefix = v ns = urn:schemas-microsoft-com:vml />") != -1) {
			ref_body = ref_body.replace("<?xml","<xml");
			ref_body = ref_body.replace("\"","");

			ref_body = HtmlParser.html_parser(ref_body, strSaveUrl);
		}

		//out.println(ref_name);
		
		ref_body = ref_body.trim();

		out.println(ref_body);

		

	} catch(Exception e) 
	{ 
		e.printStackTrace();
	} 
%>
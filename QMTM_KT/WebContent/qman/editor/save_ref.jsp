<%
//******************************************************************************
//   프로그램 : save_ref.jsp
//   모 듈 명 : 지문저장
//   설    명 : 지문저장
//   테 이 블 : 
//   자바파일 : qmtm.qman.editor.QUtil
//   작 성 일 : 2008-08-26
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*, java.util.*, com.tagfree.util.*, org.w3c.tidy.*, org.w3c.dom.*, qmtm.*, qmtm.qman.editor.*, qmtm.qman.*" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_subject = request.getParameter("id_subject"); // 과목코드
	//String id_subject = "aaaa"; // 과목코드
	//String reftitle = request.getParameter("ref_name"); // 지문제목
	String reftitle = "111111111111111"; // 지문제목
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
		
		boolean bReaname = true; // 저장할 디렉터리에 파일이 존재할 경우 새로운 이름을 지정한다.
		String strSavePath = "D:/qmtm_web/admin/ROOT/files/"+id_subject; // 실제 웹 서버에 저장되는 디렉터리를 지정한다.
		String strSaveUrl = "http://qmtm:2008/files/"+id_subject; // 실제 웹 서버에 저장되는 디렉터리의 웹 URL 경로를 지정한다.
		//String ref_body = request.getParameter("ref_body"); // 지문내용
		String ref_body = "2222222222222222222222222222222222222222222222222222222222";
						
		MimeUtil util = new MimeUtil(); // com.tagfree.util.MimeUtil 생성		
		util.setHtmlRange(Constant.HTML_INNER_BODY);
		util.setMimeValue(ref_body); // 작성된 본문 + 포함된 이진 파일의 MIME 값 지정
		util.setSavePath(strSavePath); // 저장 디렉터리 지정
		util.setSaveUrl(strSaveUrl); // URL 경로 지정

		util.setRename(true); // 파일을 저장 시에 새로운 이름을 생성할 것인지를 설정
		
		util.processDecoding(); // MIME 값의 디코딩 -> 이 때 포함된 파일은 모두 웹 서버에 저장된다. 
						
		ref_body = util.getDecodedHtml(false);

		out.println(ref_body);

		//외부개체가 포함되었을경우
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
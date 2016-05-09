<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ page import ="java.io.*"%>
<%@ page import ="org.apache.poi.hwpf.usermodel.*"%>
<%@ page import ="org.apache.poi.hwpf.*"%>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	HWPFDocument doc = new HWPFDocument(new FileInputStream("D:\\qmtm_web\\files\\qmtm일반상식.doc"));

	Range r = doc.getRange();

	for(int x = 0; x < r.numSections(); x++) {
		Section s = r.getSection(x);
		for(int y=0; y < s.numParagraphs(); y++) {
			Paragraph p = s.getParagraph(y);
			for(int z=0; z<p.numCharacterRuns(); z++) {
				CharacterRun run = p.getCharacterRun(z);
				String text = run.text();
				out.println(text.replace("","").replace("",""));				
				out.println("<BR>");
				break;
			}
		}
	}
%>
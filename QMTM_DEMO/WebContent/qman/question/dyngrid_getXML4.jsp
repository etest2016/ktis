<%@ page contentType="text/xml; charset=EUC-KR" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "qmtm.DBPool, qmtm.ComLib, qmtm.QmTmException, qmtm.qman.question.QListGrid4, qmtm.qman.question.QListGridBean" %>

<?xml version="1.0" encoding="EUC-KR"?>
<% 	
	String id_subject = request.getParameter("id_subject");
	String id_chapter = request.getParameter("id_chapter");
	String id_chapter2 = request.getParameter("id_chapter2");
	String id_chapter3 = request.getParameter("id_chapter3");
	String id_chapter4 = request.getParameter("id_chapter4");
	
	// define variables from incoming values
    String posStart = ""; // 시작지점
    if (request.getParameter("posStart") != null){
        posStart = request.getParameter("posStart");
    }else{
        posStart = "0";
    }   

    String count = "1000"; // 가져올 갯수
    
    String totalCount = "";
    
	totalCount = "";
	if (posStart.equals("0")){
	        
		try {
			totalCount = String.valueOf(QListGrid4.getCnt(id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	} else {
	   	totalCount = "";
	}
        
    // 데이타 가져오기
	QListGridBean[] rst = null;

	try {
		rst = QListGrid4.getUBeans(id_subject, id_chapter, id_chapter2, id_chapter3, id_chapter4, Integer.parseInt(posStart), Integer.parseInt(count));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

    if(rst == null) {
		out.println("<rows total_count='" + totalCount + "' pos='" + posStart + "'>");

	} else {

     	out.println("<rows total_count='" + totalCount + "' pos='" + posStart + "'>");
		// output data in XML format  
	    for(int i=0; i<rst.length; i++) 
		{
			String qtypes = rst[i].getQtype();

			out.println("<row id=\"" + rst[i].getRownum() + "\">");
			out.println("<cell>" + rst[i].getId_q() + "</cell>");
			out.println("<cell>" + qtypes + "</cell>");
			out.println("<cell>" + ComLib.removeAndDel(ComLib.htmlDel(rst[i].getQ())) + "</cell>");
			out.println("<cell>" + ComLib.nullChk2(rst[i].getCa()) + "</cell>");
			out.println("<cell>" + rst[i].getRegdate() + "</cell>");
			out.println("</row>");
		}
		
	}
%>
</rows>

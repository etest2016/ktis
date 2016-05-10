<%@ page contentType="text/xml; charset=EUC-KR" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.apache.commons.lang3.StringEscapeUtils,qmtm.DBPool, qmtm.ComLib, qmtm.QmTmException, qmtm.tman.exam.QchangeUtil, qmtm.tman.exam.QchangeBean" %>

<?xml version="1.0" encoding="EUC-KR"?>
<% 	
    String id_exam = "E131022163851BR";//request.getParameter("id_exam");
	String id_subject = "S10050131021141533JM";//request.getParameter("id_subject");
	String id_chapter = "U10050131021141631IX";//request.getParameter("id_chapter");

	String id_q = "1043";//request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }

	String id_qtype = "2";//request.getParameter("id_qtype");
	if (id_qtype == null) { id_qtype = ""; } else { id_qtype = id_qtype.trim(); }
	
	// define variables from incoming values
    String posStart = ""; // 시작지점
    if (request.getParameter("posStart") != null){
        posStart = request.getParameter("posStart");
    }else{
        posStart = "0";
    }   

    String count = "100"; // 가져올 갯수
    
    String totalCount = "";
    
	totalCount = "";
	if (posStart.equals("0")){
	        
		try {
			totalCount = String.valueOf(QchangeUtil.getCnt(id_exam, id_subject, id_chapter, id_q, id_qtype));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	} else {
	   	totalCount = "";
	}
        
    // 데이타 가져오기
	QchangeBean[] rst = null;

	try {
		rst = QchangeUtil.getBeans(id_exam, id_subject, id_chapter, id_q, id_qtype, Integer.parseInt(posStart), Integer.parseInt(count));
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
			out.println("<row id=\"" + StringEscapeUtils.escapeXml(rst[i].getRownum()) + "\">");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getId_q()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getQtype()) + "</cell>");			
			out.println("<cell>" + StringEscapeUtils.escapeXml(StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(rst[i].getQ())))) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getEx1()))) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getEx2()))) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getEx3()))) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getEx4()))) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getEx5()))) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(ComLib.nullChk2(rst[i].getCa())) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(ComLib.nullChk2(rst[i].getCorrect_pct())) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getCnt()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getExcount()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getCacount()) + "</cell>");			
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getDifficulty()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getRegdate()) + "</cell>");
			out.println("</row>");
		}
		
	}
%>
</rows>

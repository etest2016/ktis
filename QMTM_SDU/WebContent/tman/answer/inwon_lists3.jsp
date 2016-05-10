<%
//******************************************************************************
//   프로그램 : inwon_lists3.jsp
//   모 듈 명 : 응시자 리스트
//   설    명 : 응시자 리스트
//   테 이 블 : exam_ans, qt_userid
//   자바파일 : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   작 성 일 : 2008-05-20
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.apache.commons.lang3.StringEscapeUtils, qmtm.DBPool, qmtm.ComLib, qmtm.QmTmException, qmtm.tman.answer.*" %>
<%@ include file = "/common/login_chk.jsp" %>

<?xml version="1.0" encoding="EUC-KR"?>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "X";

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
			totalCount = String.valueOf(AnsInwonListGrid.getCnt2(id_exam));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	} else {
	   	totalCount = "";
	}

	AnsInwonListGridBean[] rst = null;
	
	// 완료자/미완료자 가지고오기
	try {
	    rst = AnsInwonListGrid.getBeans2(id_exam, Integer.parseInt(posStart), Integer.parseInt(count));
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
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getUserid()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getName()) + "</cell>");
			out.println("</row>");			
		}
		
	}
%>
</rows>
<%
//******************************************************************************
//   ���α׷� : inwon_lists2.jsp
//   �� �� �� : ������ ����Ʈ
//   ��    �� : ������ ����Ʈ
//   �� �� �� : exam_ans, qt_userid
//   �ڹ����� : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   �� �� �� : 2008-05-20
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.apache.commons.lang3.StringEscapeUtils, qmtm.DBPool, qmtm.ComLib, qmtm.QmTmException, qmtm.tman.answer.*" %>

<?xml version="1.0" encoding="EUC-KR"?>
<%
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "N";

	// define variables from incoming values
    String posStart = ""; // ��������
    if (request.getParameter("posStart") != null){
        posStart = request.getParameter("posStart");
    }else{
        posStart = "0";
    }   

    String count = "1000"; // ������ ����
    
    String totalCount = "";
    
	totalCount = "";
	if (posStart.equals("0")){
	        
		try {
			totalCount = String.valueOf(AnsInwonListGrid.getCnt(id_exam, bigos));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	} else {
	   	totalCount = "";
	}	
	
	AnsInwonListGridBean[] rst = null;
	
	// �Ϸ���/�̿Ϸ��� ���������
	try {
	    rst = AnsInwonListGrid.getBeans(id_exam, bigos, Integer.parseInt(posStart), Integer.parseInt(count));
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
			String score_bak = "";
			if(rst[i].getScore_bak() > -1.0) {
				score_bak = String.valueOf(rst[i].getScore_bak());				
			} else {
				score_bak = "";
			}

			String score_log = "";
			if(rst[i].getScore_log().equals("-1")) {
				score_log = "";
			} else {
				score_log = rst[i].getScore_log();
			}
			
			String pass_yn = "";
			
			if(rst[i].getScore() >= rst[i].getSuccess_score()) {
				pass_yn = "Y";
			} else {
				pass_yn = "N";
			}
						
			out.println("<row id=\"" + StringEscapeUtils.escapeXml(rst[i].getRownum()) + "\">");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getUserid()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getName()) + "</cell>");
			out.println("<cell>" + rst[i].getNr_set() + "</cell>");			
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getStart_time()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getEnd_time()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(ComLib.nullChk(rst[i].getUser_ip())) + "</cell>");
			out.println("<cell>" + rst[i].getScore() + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(score_bak) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(score_log) + "</cell>");
			if(rst[i].getYn_success_score().equals("Y")) {
				out.println("<cell>" + rst[i].getSuccess_score() + "</cell>");
				out.println("<cell>" + StringEscapeUtils.escapeXml(pass_yn) + "</cell>");
			} else {
				out.println("<cell></cell>");
				out.println("<cell></cell>");
			}
			
			out.println("</row>");
		}		
	}
%>
</rows>

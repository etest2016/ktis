<%
//******************************************************************************
//   ���α׷� : inwon_lists4.jsp
//   �� �� �� : ������ ����Ʈ
//   ��    �� : ������ ����Ʈ
//   �� �� �� : bak_exam_ans, qt_userid
//   �ڹ����� : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   �� �� �� : 2008-05-20
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*, java.io.FileWriter, java.io.File" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "D";

	AnsInwonListBean[] rst = null;
	
	// ��Ȼ����� ���������

    try {
	    rst = AnsInwonList.getBeans3(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

int qcounts = 0;

	StringBuffer strXML = new StringBuffer();

	strXML.append("<?xml version='1.0' encoding='euc-kr'?>");
	strXML.append(DBPool.NL);
	strXML.append("<rows>");
	strXML.append(DBPool.NL);
	
	String fileName = "inwon_lists4.xml";

	if(rst == null) {
		qcounts = 0;
		
	} else {
		qcounts = rst.length;
		
		for(int i=0; i<qcounts; i++) {

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
			
			strXML.append("<row id='"+rst[i].getUserid()+"'>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getUserid()+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getName()+"</cell>");
			//strXML.append("<cell>"+rst[i].getName()+"^javascript:selects('"+rst[i].getUserid()+"');^_self</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getNr_set()+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getStart_time()+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getEnd_time()+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+ComLib.nullChk(rst[i].getUser_ip())+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getScore()+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+score_bak+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+score_log+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("</row>");
			strXML.append(DBPool.NL);	
		}
		
	}

	strXML.append("</rows>");

	String fullPathFileName = DBPool.XML_PATH + "/" + fileName;

	try {
         FileWriter output = new FileWriter(fullPathFileName, false);
         output.write(strXML.toString(), 0, strXML.toString().length());
         output.flush();
         output.close();
    } catch (Exception ex) {
         out.println("XML ���� �����߿� ���ͳ� ������°� ���� �ʽ��ϴ�. [XmlList.saveXML()]");
    } 	
%>

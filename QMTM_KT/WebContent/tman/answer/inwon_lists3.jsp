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

	String bigos = "X";

	AnsInwonListBean[] rst = null;
	
	// 미응시자 가지고오기
    try {
	    rst = AnsInwonList.getBeans2(id_exam);
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
	
	String fileName = "inwon_lists3.xml";

	if(rst == null) {
		qcounts = 0;
		
	} else {
		qcounts = rst.length;	

		for(int i=0; i<qcounts; i++) {
			
			strXML.append("<row id='"+rst[i].getUserid()+"'>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getUserid()+"</cell>");
			strXML.append(DBPool.NL);
			strXML.append("<cell>"+rst[i].getName()+"</cell>");
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
         out.println("XML 파일 생성중에 인터넷 연결상태가 좋지 않습니다. [XmlList.saveXML()]");
    } 	
%>
<%=qcounts%>
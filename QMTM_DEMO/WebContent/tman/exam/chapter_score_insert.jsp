<%
//******************************************************************************
//   ���α׷� : q_allotting.jsp
//   �� �� �� : ���� ���� ��� ������
//   ��    �� : ���� ���� ��� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-04-30
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }	
	
	if (id_exam.length() == 0 || id_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

	String score = request.getParameter("score");
	if (score == null) { score = "0"; } else { score = score.trim(); }	

	try {
	    ChapterScore.delete(id_exam, id_chapter, Double.parseDouble(score));
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }	
%>

<Script language="JavaScript">
	alert("�䱸���� ������� ��ϵǾ����ϴ�.");
	opener.location.reload();
	window.close();
</Script>
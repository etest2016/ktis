<%
//******************************************************************************
//   ���α׷� : chapter_update.jsp
//   �� �� �� : ����° �ܿ� ����
//   ��    �� : �������� ����° �ܿ����� �����ϱ�
//   �� �� �� : q_chapter3
//   �ڹ����� : qmtm.admin.qman.Chapter3QmanUtil, qmtm.admin.qman.Chapter3QmanBean
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>   

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject"); 
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String id_chapter1 = request.getParameter("id_chapter1"); 
	if (id_chapter1 == null) { id_chapter1 = ""; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2"); 
	if (id_chapter2 == null) { id_chapter2 = ""; } else { id_chapter2 = id_chapter2.trim(); }
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_subject.length() == 0 || id_chapter1.length() == 0 || id_chapter2.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String chapter = request.getParameter("chapter");
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order"));
	
	Chapter3QmanBean bean = new Chapter3QmanBean();
	
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);
	
	// �ܿ����� ����
    try {
	    Chapter3QmanUtil.update(bean, id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload(); 
	alert("�ܿ��� ���������� �����Ǿ����ϴ�.");	 
	window.close();
</script>
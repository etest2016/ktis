<%
//******************************************************************************
//   ���α׷� : chapter_update.jsp
//   �� �� �� : �ܿ� ����
//   ��    �� : �������� �ܿ����� �����ϱ�
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.admin.qman.ChapterQmanUtil, qmtm.admin.qman.ChapterQmanBean
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

    String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }

	String id_q_chapter = request.getParameter("id_q_chapter"); // �����ڵ�
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String chapter = request.getParameter("chapter");
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order"));
	
	ChapterQmanBean bean = new ChapterQmanBean();
	
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);
	
	// �ܿ����� ����
    try {
	    ChapterQmanUtil.update(bean, id_q_chapter);
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
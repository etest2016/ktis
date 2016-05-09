<%
//******************************************************************************
//   ���α׷� : chapter_insert_ok.jsp
//   �� �� �� : �ܿ� ���
//   ��    �� : �������� �ܿ� ����ϱ�
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil
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
		
	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));
	
		if(true) return ; 
	}

	String chapter = request.getParameter("chapter");
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order"));

	String id_q_chapter = CommonUtil.getMakeID("U1");

	ChapterQmanBean bean = new ChapterQmanBean();

	bean.setId_q_subject(id_q_subject);
	bean.setId_q_chapter(id_q_chapter);
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);

    // �ܿ����

	try {
	   ChapterQmanUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<script language="javascript">
	opener.parent.frames['fraLeft'].location.reload(); 
	alert("�ܿ��� ���������� ��ϵǾ����ϴ�.");
	location.href="chapter_insert.jsp?id_q_subject=<%=id_q_subject%>";
</script>

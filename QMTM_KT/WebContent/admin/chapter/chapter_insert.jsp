<%
//******************************************************************************
//   ���α׷� : chapter_insert.jsp
//   �� �� �� : �ܿ� ���
//   ��    �� : �ش� ���� �Ʒ� �ܿ� ����ϱ�
//   �� �� �� : c_chapter
//   �ڹ����� : qmtm.admin.chapter.ChapterUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.chapter.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // �����ڵ�
	String chapter = request.getParameter("chapter"); // �ܿ���
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order")); // �ܿ�����
	
    String id_chapter = CommonUtil.getMakeID("U1");

	SubjectBean bean = new SubjectBean();

	bean.setId_subject(id_node);
	bean.setId_chapter(id_chapter);
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);
	
	// �ܿ����� ���
    try {
	    ChapterUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("�ܿ��� ���������� ��ϵǾ����ϴ�.");
	window.opener.location.reload();
	window.close();
</script>
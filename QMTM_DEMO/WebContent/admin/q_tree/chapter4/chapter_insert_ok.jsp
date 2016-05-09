<%
//******************************************************************************
//   ���α׷� : chapter_insert_ok.jsp
//   �� �� �� : �׹�° �ܿ� ���
//   ��    �� : �������� �׹�° �ܿ� ����ϱ�
//   �� �� �� : q_chapter4
//   �ڹ����� : qmtm.admin.qman.Chapter4QmanBean, qmtm.admin.qman.Chapter4QmanUtil
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

    String id_q_chapter3 = request.getParameter("id_q_chapter");
	if (id_q_chapter3 == null) { id_q_chapter3= ""; } else { id_q_chapter3 = id_q_chapter3.trim(); }

	if (id_q_chapter3.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String chapter = request.getParameter("chapter");
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order"));

	// �ܿ����� ���������
	Chapter3QmanBean rst = null;

    try {
	    rst = Chapter3QmanUtil.getBean(id_q_chapter3);
    } catch(Exception ex) { 
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	String id_q_chapter4 = CommonUtil.getMakeID("U4");

	Chapter4QmanBean bean = new Chapter4QmanBean();

	bean.setId_q_subject(rst.getId_q_subject());
	bean.setId_q_chapter(rst.getId_q_chapter());
	bean.setId_q_chapter2(rst.getId_q_chapter2());
	bean.setId_q_chapter3(id_q_chapter3);
	bean.setId_q_chapter4(id_q_chapter4);
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);

    // �ܿ����
	try {
	    Chapter4QmanUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload(); 
	alert("�ܿ��� ���������� ��ϵǾ����ϴ�.");	
	location.href="chapter_insert.jsp?id_q_chapter=<%=id_q_chapter3%>";
</script>
<%
//******************************************************************************
//   ���α׷� : chapter_delete.jsp
//   �� �� �� : �׹�° �ܿ� ����
//   ��    �� : �������� �׹�° �ܿ� �����ϱ�
//   �� �� �� : q_chapter4
//   �ڹ����� : qmtm.admin.qman.Chapter4QmanUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String id_subject = request.getParameter("id_subject"); 
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String id_chapter1 = request.getParameter("id_chapter1"); 
	if (id_chapter1 == null) { id_chapter1 = ""; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2"); 
	if (id_chapter2 == null) { id_chapter2 = ""; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("id_chapter3"); 
	if (id_chapter3 == null) { id_chapter3 = ""; } else { id_chapter3 = id_chapter3.trim(); }
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_subject.length() == 0 || id_chapter1.length() == 0 || id_chapter2.length() == 0 || id_chapter3.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = request.getParameter("bigos");
	if (bigos == null) { bigos = "N"; } else { bigos = bigos.trim(); }

	// �ش�ܿ� �������� ���� üũ
	boolean down_QYN = false;

	try {
	    down_QYN = Chapter4QmanUtil.getDownQCnt(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	
	if(down_QYN) {

		// �ܿ����� ����
		try {
			Chapter4QmanUtil.delete(id_q_chapter);
		} catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
%>

	<script language="javascript">		
		opener.parent.frames['fraLeft'].location.reload(); 
		alert("�ܿ��� ���������� �����Ǿ����ϴ�.");
		<% if(bigos.equals("N")) { %>
			opener.parent.frames['fraMain'].location.href="../../../qman/question/q_list3.jsp?id_q_subject=<%=id_chapter2%>&id_q_chapter=<%=id_chapter3%>"; 
		<% } else { %>
			opener.parent.frames['fraMain'].location.href="../chapter3/chapter_list.jsp?id_q_chapter=<%=id_chapter3%>";
		<% } %>		
		window.close();
	</script>

<% } else { %>

	<script language="javascript">
		alert("�ش� �ܿ��� ������ �־ ������ �� �����ϴ�. \n\n������ ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
		window.close();
	</script>

<% } %>
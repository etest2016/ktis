<%
//******************************************************************************
//   ���α׷� : chapter_delete.jsp
//   �� �� �� : �ι�° �ܿ� ����
//   ��    �� : �������� �ι�° �ܿ� �����ϱ�
//   �� �� �� : q_chapter2
//   �ڹ����� : qmtm.admin.qman.Chapter2QmanUtil
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
	
	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }
		
	if (id_subject.length() == 0 || id_q_subject.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String bigos = request.getParameter("bigos");
	if (bigos == null) { bigos = "N"; } else { bigos = bigos.trim(); }

    // �����ܿ� ���� üũ
	boolean down_YN = false;

	try {
	    down_YN = Chapter2QmanUtil.getDownCnt(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	// �ش�ܿ� �������� ���� üũ
	boolean down_QYN = false;

	try {
	    down_QYN = Chapter2QmanUtil.getDownQCnt(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
	
	if(down_YN && down_QYN) {
	
		// �ܿ����� ����
		try {
			Chapter2QmanUtil.delete(id_q_chapter);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
	    }
%>

	<script language="javascript">		
		opener.parent.frames['fraLeft'].location.reload(); 
		alert("�ܿ��� ���������� �����Ǿ����ϴ�.");
		<% if(bigos.equals("N")) { %>
			opener.parent.frames['fraMain'].location.href="../../../qman/question/q_list1.jsp?id_q_subject=<%=id_subject%>&id_q_chapter=<%=id_q_subject%>"; 
		<% } else { %>
			opener.parent.frames['fraMain'].location.href="../chapter/chapter_list.jsp?id_q_chapter=<%=id_q_subject%>";
		<% } %>		
		window.close();
	</script>

<%
	} else if((!down_YN) && down_QYN) { 
%>
	<script language="javascript">
		alert("������ �ܿ��� �־ ������ �� �����ϴ�. \n\n���� �ܿ��� ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
		window.close();
	</script>
<%
	} else if(down_YN && (!down_QYN)) {
%>
	<script language="javascript">
		alert("�ش� �ܿ��� ������ �־ ������ �� �����ϴ�. \n\n������ ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
		window.close();
	</script>
<%
	} else if((!down_YN) && (!down_QYN)) { 
%>
	<script language="javascript">
		alert("�ش� �ܿ��� ���� �� ���� �ܿ��� �־ ������ �� �����ϴ�. \n\n���� ����, ���� �ܿ� ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
		window.close();
	</script>
<%
	} 
%>
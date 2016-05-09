<%
//******************************************************************************
//   ���α׷� : course_insert_ok.jsp
//   �� �� �� : ���� ���
//   ��    �� : ������� ���� ����ϱ�   
//   �� �� �� : c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.TmanTree
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.TmanTree, java.util.Date, java.util.Calendar" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String course = request.getParameter("course");
	if (course == null) { course = ""; } else { course = course.trim(); }
    
	if (id_category.length() == 0 || course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);

	String years = String.valueOf(year);

	String id_course = CommonUtil.getMakeID("C1");

    // �������
	try {
	    TmanTree.insert(id_course, course, years, id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("���������� ��ϵǾ����ϴ�.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.reload(); 
	location.href="course_insert.jsp?id_category=<%=id_category%>";
</script>
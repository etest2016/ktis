<%
//******************************************************************************
//   ���α׷� : subject_insert_ok.jsp
//   �� �� �� : ���� ���
//   ��    �� : �������� ���� ����ϱ�
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.admin.course.CourseUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*, java.util.Date, java.util.Calendar " %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String q_subject = request.getParameter("q_subject");
	if (q_subject == null) { q_subject= ""; } else { q_subject = q_subject.trim(); }

	if (q_subject.length() == 0 || id_category.length() == 0 || id_course.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);

	String years = String.valueOf(year);
 	
	String id_q_subject = CommonUtil.getMakeID("S1");

    // �������
	try {
	    QmanTree.insert(id_category, id_q_subject, q_subject, years, id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("������ ���������� ��ϵǾ����ϴ�.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.reload(); 
	location.href="subject_insert.jsp?id_category=<%=id_category%>&id_course=<%=id_course%>";
</script>
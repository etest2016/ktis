<%
//******************************************************************************
//   ���α׷� : subject_delete.jsp
//   �� �� �� : ���� ����
//   ��    �� : ������� ���� �����ϱ�
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course"); // ���� ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // ���� ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigo = request.getParameter("bigo"); 

    // �������� ���� üũ 
	boolean down_YN = false;

	try {
	    down_YN = SubjectTmanUtil.getDownCnt2(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	if(down_YN) {
	
		// �������� ����
		try {
			SubjectTmanUtil.delete(id_course, id_subject);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
%>

<script language="javascript">	
	opener.parent.fraLeft.location.reload(); 	
	alert("������ ���������� �����Ǿ����ϴ�.");		
	opener.parent.fraMain.location.href="../course/course_list.jsp?id_course=<%=id_course%>"; 
	opener.parent.fraLeft.oc('<%=id_course%>',0,'C1');
	window.close();
</script>

<%
	} else {
%>
<script language="javascript">
	alert("������ ������ �־ ������ �� �����ϴ�. \n\n���� ������ ���� �� ������ �ֽñ� �ٶ��ϴ�.");	
	window.close();
</script>
<%
	}
%>
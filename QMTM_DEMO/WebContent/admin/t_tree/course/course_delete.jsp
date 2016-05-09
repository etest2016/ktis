<%
//******************************************************************************
//   ���α׷� : course_delete.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���������ϱ�
//   �� �� �� : c_course
//   �ڹ����� : qmtm.admin.TmanTree, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2008-03-31
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.TmanTree, qmtm.admin.tman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// �������� ���� üũ
	boolean down_YN = false;

	try {
	    down_YN = SubjectTmanUtil.getDownCnt(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	if(down_YN) {	

    // �������� ����	
	try {
	    TmanTree.delete(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("������ ���������� �����Ǿ����ϴ�.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.href="../../q_tree/f_main.jsp"; 
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
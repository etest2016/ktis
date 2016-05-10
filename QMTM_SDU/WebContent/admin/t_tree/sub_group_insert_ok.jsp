<%
//******************************************************************************
//   ���α׷� : sub_group_insert_ok.jsp
//   �� �� �� : ����׷� ���
//   ��    �� : ����׷� ��� ������
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.admin.TmanTree
//   �� �� �� : 2008-04-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String[] subjects = request.getParameterValues("subjects");

	String subject_name = "";

	String id_subject = "";

    if(subjects != null) {
		for(int i = 0; i < subjects.length; i++) {

			subject_name = request.getParameter("names"+subjects[i]);

			id_subject = CommonUtil.getMakeID("S1"); // �����ڵ� ���ϱ�

			// ����׷� ���
			try {
				TmanTree.group_insert(id_course, id_subject, subjects[i], subject_name);
		    } catch(Exception ex) {		    	
			    out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		}
	}
%>

<script language="javascript">	
	opener.parent.fraLeft.location.reload();
	alert("������ ���������� ��ϵǾ����ϴ�.");
	opener.parent.fraLeft.oc('<%=id_course%>',0,'C1');
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>
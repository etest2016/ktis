<%
//******************************************************************************
//   ���α׷� : create.jsp
//   �� �� �� : �� Ʈ���� �б�
//   ��    �� : �� Ʈ�� Ŭ������ �� �ش� �������� �б�
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // Ʈ�� ID
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	

    String id_parentnode = request.getParameter("node_rid"); // Ʈ�� �θ� ID
	if (id_parentnode == null) { id_parentnode = ""; } else { id_parentnode = id_parentnode.trim(); }	

	String node_gubun = request.getParameter("node_gubun"); // Ʈ�� ���� (���� : C1, ���� : S1)
	if (node_gubun == null) { node_gubun = ""; } else { node_gubun = node_gubun.trim(); }	

	if (id_node.length() == 0 || id_parentnode.length() == 0 || node_gubun.length() == 0) { 
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}	
%>    

<!-- �ش� Ʈ�� �������� �̵� -->
<script language="javascript">
	var node_gubun = "<%=node_gubun%>";

    if(node_gubun == "C1") {
		location.href = "course/course_list.jsp?id_course=<%=id_node%>";
	} else if(node_gubun == "S1") {
		location.href = "subject/subject_list.jsp?id_course=<%=id_parentnode%>&id_subject=<%=id_node%>";
	} 
</script>
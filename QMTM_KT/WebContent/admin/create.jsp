<%
//******************************************************************************
//   ���α׷� : create.jsp
//   �� �� �� : �� Ʈ���� �б�
//   ��    �� : �� Ʈ�� Ŭ������ �� �ش� �������� �б�
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-03-31
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

	String node_gubun = request.getParameter("node_gubun"); // Ʈ�� ���� (���� : C1, ���� : S1, �ܿ�1 : U1, �ܿ�2 : U2, �ܿ�3 : U3)
	if (node_gubun == null) { node_gubun = ""; } else { node_gubun = node_gubun.trim(); }	

	if (id_node.length() == 0 || id_parentnode.length() == 0 || node_gubun.length() == 0) { 
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%	
	}	
%>    

<!-- �ش� Ʈ�� �������� �̵� -->
<script language="javascript">
	var node_gubun = "<%=node_gubun%>";

	if(node_gubun == "C1") {
		location.href = "course/course_mgr.jsp?id_node=<%=id_node%>";
	} else if(node_gubun == "S1") {
		location.href = "subject/subject_mgr.jsp?id_node=<%=id_node%>&id_parentnode=<%=id_parentnode%>";
	} else if(node_gubun == "U1") {
		location.href = "chapter/chapter_mgr.jsp?id_node=<%=id_node%>&id_parentnode=<%=id_parentnode%>";
	} else if(node_gubun == "U2") {
		location.href = "chapter/chapter_mgr2.jsp?id_node=<%=id_node%>&id_parentnode=<%=id_parentnode%>";
	} else if(node_gubun == "U3") {
		location.href = "chapter/chapter_mgr3.jsp?id_node=<%=id_node%>&id_parentnode=<%=id_parentnode%>";
	}
</script>
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
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // Ʈ�� ID
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	

    String id_parentnode = request.getParameter("node_rid"); // Ʈ�� �θ� ID
	if (id_parentnode == null) { id_parentnode = ""; } else { id_parentnode = id_parentnode.trim(); }	

	String node_gubun = request.getParameter("node_gubun"); // Ʈ�� ���� (���� : C1, ���� : E1)
	if (node_gubun == null) { node_gubun = ""; } else { node_gubun = node_gubun.trim(); }	

	if (id_node.length() == 0 || id_parentnode.length() == 0 || node_gubun.length() == 0) { 
%>
	<script type="text/javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%	
	}	
%>    

<!-- �ش� Ʈ�� �������� �̵� -->
<script type="text/javascript">
	var node_gubun = "<%=node_gubun%>";

	if(node_gubun == "C1") {
		//location.href = "course_list.jsp?id_course=<%=id_node%>";
		location.href = "jucha_quiz_list.jsp?id_course=<%=id_node%>";	
	} else if(node_gubun == "E1") {
		location.href = "exam/exam_list.jsp?id_exam=<%=id_node%>";
	}
</script>
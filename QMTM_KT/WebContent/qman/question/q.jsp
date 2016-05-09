<%
//******************************************************************************
//   프로그램 : q.jsp
//   모 듈 명 : 
//   설    명 : 
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-04-15
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // 트리 ID
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	

    String id_parentnode = request.getParameter("node_rid"); // 트리 부모 ID
	if (id_parentnode == null) { id_parentnode = ""; } else { id_parentnode = id_parentnode.trim(); }	

	String node_gubun = request.getParameter("node_gubun"); // 트리 구분 (과목 : S1, 단원1 : U1, 단원2 : U2, 단원3 : U3, 단원4 : U4)
	if (node_gubun == null) { node_gubun = ""; } else { node_gubun = node_gubun.trim(); }	

	if (id_node.length() == 0 || id_parentnode.length() == 0 || node_gubun.length() == 0) { 
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}	
%>    

<!-- 해당 트리 페이지로 이동 -->
<script language="javascript">
	var node_gubun = "<%=node_gubun%>";

    if(node_gubun == "S1") {
		location.href = "q_s_list.jsp?id_q_subject=<%=id_node%>&id_q_chapter=0";
	} else if(node_gubun == "U1") { 
		location.href = "q_list1.jsp?id_q_chapter=<%=id_node%>&id_q_subject=<%=id_parentnode%>";
	} else if(node_gubun == "U2") { 
		location.href = "q_list2.jsp?id_q_chapter=<%=id_node%>&id_q_subject=<%=id_parentnode%>";
	} else if(node_gubun == "U3") { 
		location.href = "q_list3.jsp?id_q_chapter=<%=id_node%>&id_q_subject=<%=id_parentnode%>";
	} else if(node_gubun == "U4") { 
		location.href = "q_list4.jsp?id_q_chapter=<%=id_node%>&id_q_subject=<%=id_parentnode%>";
	}
</script>
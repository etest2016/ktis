<%
//******************************************************************************
//   프로그램 : create.jsp
//   모 듈 명 : 각 트리별 분기
//   설    명 : 각 트리 클릭했을 때 해당 페이지로 분기
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
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

	String node_gubun = request.getParameter("node_gubun"); // 트리 구분 (과정 : C1, 과목 : S1, 단원1 : U1, 단원2 : U2, 단원3 : U3)
	if (node_gubun == null) { node_gubun = ""; } else { node_gubun = node_gubun.trim(); }	

	if (id_node.length() == 0 || id_parentnode.length() == 0 || node_gubun.length() == 0) { 
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}	
%>    

<!-- 해당 트리 페이지로 이동 -->
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
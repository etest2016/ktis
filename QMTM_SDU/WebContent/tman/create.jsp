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
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // 트리 ID
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	

    String id_parentnode = request.getParameter("node_rid"); // 트리 부모 ID
	if (id_parentnode == null) { id_parentnode = ""; } else { id_parentnode = id_parentnode.trim(); }	

	String node_gubun = request.getParameter("node_gubun"); // 트리 구분 (과정 : C1, 시험 : E1)
	if (node_gubun == null) { node_gubun = ""; } else { node_gubun = node_gubun.trim(); }	

	if (id_node.length() == 0 || id_parentnode.length() == 0 || node_gubun.length() == 0) { 
%>
	<script type="text/javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}	
%>    

<!-- 해당 트리 페이지로 이동 -->
<script type="text/javascript">
	var node_gubun = "<%=node_gubun%>";

	if(node_gubun == "C1") {
		//location.href = "course_list.jsp?id_course=<%=id_node%>";
		location.href = "jucha_quiz_list.jsp?id_course=<%=id_node%>";	
	} else if(node_gubun == "E1") {
		location.href = "exam/exam_list.jsp?id_exam=<%=id_node%>";
	}
</script>

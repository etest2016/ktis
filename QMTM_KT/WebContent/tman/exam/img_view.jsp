<%
//******************************************************************************
//   프로그램 : img_view.jsp
//   모 듈 명 : 시험지 이미지 보기
//   설    명 : 시험지 이미지 보기 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-04-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String img_view = request.getParameter("paper_img");
	if (img_view == null) { img_view = ""; } else { img_view = img_view.trim(); }

	if (img_view.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}
%>

<img src="../paper_img/qmtm_paper<%=img_view%>.jpg">
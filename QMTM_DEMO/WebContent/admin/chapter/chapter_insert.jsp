<%
//******************************************************************************
//   프로그램 : chapter_insert.jsp
//   모 듈 명 : 단원 등록
//   설    명 : 해당 과목 아래 단원 등록하기
//   테 이 블 : c_chapter
//   자바파일 : qmtm.admin.chapter.ChapterUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.chapter.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // 과목코드
	String chapter = request.getParameter("chapter"); // 단원명
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order")); // 단원순서
	
    String id_chapter = CommonUtil.getMakeID("U1");

	SubjectBean bean = new SubjectBean();

	bean.setId_subject(id_node);
	bean.setId_chapter(id_chapter);
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);
	
	// 단원정보 등록
    try {
	    ChapterUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	alert("단원이 정상적으로 등록되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
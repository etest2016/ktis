<%
//******************************************************************************
//   프로그램 : chapter_update.jsp
//   모 듈 명 : 단원 수정
//   설    명 : 문제은행 단원정보 수정하기
//   테 이 블 : q_chapter
//   자바파일 : qmtm.admin.qman.ChapterQmanUtil, qmtm.admin.qman.ChapterQmanBean
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>   

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }

	String id_q_chapter = request.getParameter("id_q_chapter"); // 과정코드
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String chapter = request.getParameter("chapter");
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order"));
	
	ChapterQmanBean bean = new ChapterQmanBean();
	
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);
	
	// 단원정보 수정
    try {
	    ChapterQmanUtil.update(bean, id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>
<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload(); 
	alert("단원이 정상적으로 수정되었습니다.");
	window.close();
</script>
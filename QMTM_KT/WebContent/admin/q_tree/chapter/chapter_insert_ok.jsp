<%
//******************************************************************************
//   프로그램 : chapter_insert_ok.jsp
//   모 듈 명 : 단원 등록
//   설    명 : 문제은행 단원 등록하기
//   테 이 블 : q_chapter
//   자바파일 : qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil
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
		
	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));
	
		if(true) return ; 
	}

	String chapter = request.getParameter("chapter");
	int chapter_order = Integer.parseInt(request.getParameter("chapter_order"));

	String id_q_chapter = CommonUtil.getMakeID("U1");

	ChapterQmanBean bean = new ChapterQmanBean();

	bean.setId_q_subject(id_q_subject);
	bean.setId_q_chapter(id_q_chapter);
	bean.setChapter(chapter);
	bean.setChapter_order(chapter_order);

    // 단원등록

	try {
	   ChapterQmanUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<script language="javascript">
	opener.parent.frames['fraLeft'].location.reload(); 
	alert("단원이 정상적으로 등록되었습니다.");
	location.href="chapter_insert.jsp?id_q_subject=<%=id_q_subject%>";
</script>

<%
//******************************************************************************
//   프로그램 : paper_guide_update.jsp
//   모 듈 명 : 영역안내문 수정
//   설    명 : 영역안내문 수정하기
//   테 이 블 : exam_paper_guide
//   자바파일 : qmtm.tman.paper.ExamPaperGuide
//   작 성 일 : 2008-05-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	int nr_qs = Integer.parseInt(request.getParameter("nr_qs"));
	int nr_q = Integer.parseInt(request.getParameter("nr_q"));
	String guide_msg = request.getParameter("guide_msg");

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		window.close();
	</script>
<%	
	}

	ExamPaperGuideBean bean = new ExamPaperGuideBean();

	bean.setNr_q(nr_q);
	bean.setGuide_msg(guide_msg);

	// 영역안내문 정보 수정
    try {
	    ExamPaperGuide.update(bean, id_exam, nr_qs);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	window.opener.location.reload();
	window.close();	
</script>
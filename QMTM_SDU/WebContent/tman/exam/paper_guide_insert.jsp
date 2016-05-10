<%
//******************************************************************************
//   프로그램 : paper_guide_insert.jsp
//   모 듈 명 : 영역안내문 저장
//   설    명 : 영역안내문 저장하기
//   테 이 블 : exam_paper_guide
//   자바파일 : qmtm.tman.paper.ExamPaperGuide, qmtm.tman.paper.ExamPaperGuideBean
//   작 성 일 : 2008-05-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

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

	bean.setId_exam(id_exam);
	bean.setNr_q(nr_q);
	bean.setGuide_msg(guide_msg);

	// 영역안내문 정보 등록
    try {
	    ExamPaperGuide.insert(bean);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<script language="javascript">
	window.opener.location.reload();
	window.close();	
</script>
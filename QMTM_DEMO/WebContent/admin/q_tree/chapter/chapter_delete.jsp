<%
//******************************************************************************
//   프로그램 : chapter_delete.jsp
//   모 듈 명 : 단원 삭제
//   설    명 : 문제은행 단원 삭제하기
//   테 이 블 : q_chapter
//   자바파일 : qmtm.admin.qman.ChapterQmanUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("euc-kr");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }
	
	if (id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = request.getParameter("bigos");
	if (bigos == null) { bigos = "N"; } else { bigos = bigos.trim(); }

    // 하위단원 유무 체크
	boolean down_YN = false;

	try {
	    down_YN = ChapterQmanUtil.getDownCnt(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	// 해당단원 문제포함 체크
	boolean down_QYN = false;

	try {
	    down_QYN = ChapterQmanUtil.getDownQCnt(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	if(down_YN && down_QYN) {
	
		// 단원정보 삭제
		try {
			ChapterQmanUtil.delete(id_q_chapter);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
	    }
%>

<script language="javascript">	
	opener.parent.frames['fraLeft'].location.reload(); 
	alert("단원이 정상적으로 삭제되었습니다.");
	<% if(bigos.equals("N")) { %>
	opener.parent.frames['fraMain'].location.href="../../../qman/question/q_s_list.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>"; 
	<% } else { %>
	opener.parent.frames['fraMain'].location.href="../subject/subject_list.jsp?id_q_subject=<%=id_q_subject%>";
    <% } %>
	window.close();
</script>

<%
	} else if((!down_YN) && down_QYN) { 
%>
<script language="javascript">
	alert("하위에 단원이 있어서 삭제할 수 없습니다. \n\n하위 단원을 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
	} else if(down_YN && (!down_QYN)) {
%>
<script language="javascript">
	alert("해당 단원에 문항이 있어서 삭제할 수 없습니다. \n\n문항을 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
	} else if((!down_YN) && (!down_QYN)) { 
%>
<script language="javascript">
	alert("해당 단원에 문항 및 하위 단원이 있어서 삭제할 수 없습니다. \n\n문항 삭제, 하위 단원 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
	} 
%>
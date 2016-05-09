<%
//******************************************************************************
//   프로그램 : chapter_delete.jsp
//   모 듈 명 : 세번째 단원 삭제
//   설    명 : 문제은행 세번째 단원 삭제하기
//   테 이 블 : q_chapter3
//   자바파일 : qmtm.admin.qman.Chapter3QmanUtil
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

	String id_subject = request.getParameter("id_subject"); 
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String id_chapter1 = request.getParameter("id_chapter1"); 
	if (id_chapter1 == null) { id_chapter1 = ""; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2"); 
	if (id_chapter2 == null) { id_chapter2 = ""; } else { id_chapter2 = id_chapter2.trim(); }
	
	String id_q_chapter = request.getParameter("id_q_chapter"); // 단원 ID
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_subject.length() == 0 || id_chapter1.length() == 0 || id_chapter2.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

	String bigos = request.getParameter("bigos");
	if (bigos == null) { bigos = "N"; } else { bigos = bigos.trim(); }

    // 하위단원 유무 체크
	boolean down_YN = false;

	try {
	    down_YN = Chapter3QmanUtil.getDownCnt(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	// 해당단원 문제포함 유무 체크
	boolean down_QYN = false;

	try {
	    down_QYN = Chapter3QmanUtil.getDownQCnt(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
	if(down_YN && down_QYN) {
	
		// 단원정보 삭제
		try {
			Chapter3QmanUtil.delete(id_q_chapter);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
	    }
%>

	<script language="javascript">		
		opener.parent.frames['fraLeft'].location.reload(); 
		alert("단원이 정상적으로 삭제되었습니다.");
		<% if(bigos.equals("N")) { %>
			opener.parent.frames['fraMain'].location.href="../../../qman/question/q_list2.jsp?id_q_subject=<%=id_chapter1%>&id_q_chapter=<%=id_chapter2%>"; 
		<% } else { %>
			opener.parent.frames['fraMain'].location.href="../chapter2/chapter_list.jsp?id_q_chapter=<%=id_chapter2%>";
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
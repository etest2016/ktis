<%
//******************************************************************************
//   프로그램 : course_delete.jsp
//   모 듈 명 : 과정 삭제
//   설    명 : 과정삭제하기
//   테 이 블 : c_course
//   자바파일 : qmtm.admin.TmanTree, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.TmanTree, qmtm.admin.tman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// 하위과목 유무 체크
	boolean down_YN = false;

	try {
	    down_YN = SubjectTmanUtil.getDownCnt(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	if(down_YN) {	

    // 과정정보 삭제	
	try {
	    TmanTree.delete(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("과정이 정상적으로 삭제되었습니다.");
	opener.parent.frames['fraLeft'].location.reload(); 
	opener.parent.frames['fraMain'].location.href="../../q_tree/f_main.jsp"; 
	window.close();
</script>

<%
	} else {
%>
<script language="javascript">
	alert("하위에 과목이 있어서 삭제할 수 없습니다. \n\n하위 과목을 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
	}
%>
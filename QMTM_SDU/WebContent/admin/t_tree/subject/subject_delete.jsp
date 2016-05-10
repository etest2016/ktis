<%
//******************************************************************************
//   프로그램 : subject_delete.jsp
//   모 듈 명 : 과목 삭제
//   설    명 : 시험관리 과목 삭제하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course"); // 과정 ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // 과목 ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigo = request.getParameter("bigo"); 

    // 하위시험 유무 체크 
	boolean down_YN = false;

	try {
	    down_YN = SubjectTmanUtil.getDownCnt2(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	if(down_YN) {
	
		// 과목정보 삭제
		try {
			SubjectTmanUtil.delete(id_course, id_subject);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
%>

<script language="javascript">	
	opener.parent.fraLeft.location.reload(); 	
	alert("과목이 정상적으로 삭제되었습니다.");		
	opener.parent.fraMain.location.href="../course/course_list.jsp?id_course=<%=id_course%>"; 
	opener.parent.fraLeft.oc('<%=id_course%>',0,'C1');
	window.close();
</script>

<%
	} else {
%>
<script language="javascript">
	alert("하위에 시험이 있어서 삭제할 수 없습니다. \n\n하위 시험을 삭제 후 진행해 주시기 바랍니다.");	
	window.close();
</script>
<%
	}
%>
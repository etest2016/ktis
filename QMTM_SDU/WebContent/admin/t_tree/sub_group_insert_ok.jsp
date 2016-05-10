<%
//******************************************************************************
//   프로그램 : sub_group_insert_ok.jsp
//   모 듈 명 : 과목그룹 등록
//   설    명 : 과목그룹 등록 페이지
//   테 이 블 : c_subject
//   자바파일 : qmtm.admin.TmanTree
//   작 성 일 : 2008-04-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String[] subjects = request.getParameterValues("subjects");

	String subject_name = "";

	String id_subject = "";

    if(subjects != null) {
		for(int i = 0; i < subjects.length; i++) {

			subject_name = request.getParameter("names"+subjects[i]);

			id_subject = CommonUtil.getMakeID("S1"); // 과목코드 구하기

			// 과목그룹 등록
			try {
				TmanTree.group_insert(id_course, id_subject, subjects[i], subject_name);
		    } catch(Exception ex) {		    	
			    out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
		}
	}
%>

<script language="javascript">	
	opener.parent.fraLeft.location.reload();
	alert("과목이 정상적으로 등록되었습니다.");
	opener.parent.fraLeft.oc('<%=id_course%>',0,'C1');
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>
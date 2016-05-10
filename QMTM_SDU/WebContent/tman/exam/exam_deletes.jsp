<%
//******************************************************************************
//   프로그램 : exam_deletes.jsp
//   모 듈 명 : 시험 삭제
//   설    명 : 시험 삭제
//   테 이 블 : exam_m, exam_paper2
//   자바파일 : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   작 성 일 : 2008-06-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	if (id_course.length() == 0 || id_subject.length() ==0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

    // 과목 아래 시험정보 가지고오기
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getBeans(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }	
%>

<HTML>
 <HEAD>
  <TITLE> 시험 삭제 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function exam_deletes() {

		var str = confirm("체크한 시험에 대해서 일괄삭제 작업을 진행하시겠습니까?");

		if(str == true) {
			document.form1.submit();
		}
    }

 </script>

 </HEAD>

 <BODY id="tman">

    <form name="form1" method="post" action="exam_deletes_ok.jsp">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="main">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><td colspan="5"><input type="button" value="시험일괄삭제" onClick="exam_deletes();"></td></tr>
			<tr id="tr">
				<td>선택</td>
				<td>시험제목</td>
				<td>시험가능여부</td>
				<td>시험시작일</td>
				<td>시험종료일</td>
			</tr>
	<%
		if(rst == null) {
	%>
			<tr>
				<td class="blank" colspan="5" align="center">시험이 없습니다.</td>
			</tr>
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {
	%>
			<tr id="td" align="center">
				<td><input type="checkbox" name="id_exams" value="<%=rst[i].getId_exam()%>"></td>
				<td>&nbsp;<%=rst[i].getTitle()%></td>
				<td><%=rst[i].getYn_enable()%></td>
				<td><%=rst[i].getExam_start1()%></td>
				<td><%=rst[i].getExam_end1()%></td>
			</tr>
	<%
			}
		}
	%>
		</table>

	</div>
	<jsp:include page="../copyright.jsp"/>

 </BODY>
</HTML>
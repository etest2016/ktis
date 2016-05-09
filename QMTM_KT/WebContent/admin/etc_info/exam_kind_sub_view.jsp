<%
//******************************************************************************
//   프로그램 : exam_kind_sub_view.jsp
//   모 듈 명 : 시험구분확인
//   설    명 : 시험구분확인 팝업 페이지
//   테 이 블 : r_exam_kind_sub
//   자바파일 : qmtm.admin.etc.ExamKindSubBean, qmtm.admin.etc.ExamKindSubUtil
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam_kind_sub = request.getParameter("id_exam_kind_sub");
	if (id_exam_kind_sub == null) { id_exam_kind_sub= ""; } else { id_exam_kind_sub = id_exam_kind_sub.trim(); }

	if (id_exam_kind_sub.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	ExamKindSubBean rst = null;

    try {
	    rst = ExamKindSubUtil.getBean(id_exam_kind_sub);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="exam_kind_sub_edit.jsp?id_exam_kind_sub=<%=id_exam_kind_sub%>";
	}
	
	//--  삭제체크
    function deletes()  {
       var st = confirm("*주의* 시험구분를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "exam_kind_sub_delete.jsp?id_exam_kind_sub=<%=id_exam_kind_sub%>";
       }
    }
</script>
<html>
<head>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험구분확인<span> 시험그룹확인 및 시험명을 수정합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">그룹구분</td>
				<td width="200"><%=rst.getExam_kind()%></td>
			</tr>
			<tr>
				<td id="left">시험코드</td>
				<td><%=id_exam_kind_sub%></td>
			</tr>
			<tr>
				<td id="left">시험명</td>
				<td><%=rst.getExam_kind_sub()%></td>
			</tr>
	</table>
	</div>

	<div id="button">
	<a href="javascript:edits();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
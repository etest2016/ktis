<%
//******************************************************************************
//   프로그램 : std_grade_view.jsp
//   모 듈 명 : 학년코드확인
//   설    명 : 학년코드확인 팝업 페이지
//   테 이 블 : r_std_grade
//   자바파일 : qmtm.admin.etc.StdGradeBean, qmtm.admin.etc.StdGradeUtil
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

	String std_grade = request.getParameter("std_grade");
	if (std_grade == null) { std_grade= ""; } else { std_grade = std_grade.trim(); }

	if (std_grade.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	StdGradeBean rst = null;

    try {
	    rst = StdGradeUtil.getBean(std_grade);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="std_grade_edit.jsp?std_grade=<%=std_grade%>";
	}
	
	//--  삭제체크
    function deletes()  {
       var st = confirm("*주의* 학년코드를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "std_grade_delete.jsp?std_grade=<%=std_grade%>";
       }
    }
</script>
<html>
<head>
	<title>:: 학년코드 확인 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">학년코드 확인 <span> 학년코드 확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">학년코드</td>
				<td width="200"><%=std_grade%></td>
			</tr>
			<tr>
				<td id="left">학년명</td>
				<td><%=rst.getGrade_nm()%></td>
			</tr>
			<tr>
				<td id="left">등록일자</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
<!--<input type="button" onClick="edits()" value="수정하기">--><a href="javascript:edits();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onClick="deletes()"  value="삭제하기">--><a href="javascript:deletes();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="창닫기">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</center>
</div>

	</form>

</BODY>
</HTML>
<%
//******************************************************************************
//   프로그램 : class_list.jsp
//   모 듈 명 : 분류명 설정
//   설    명 : 분류명 설정 페이지
//   테 이 블 : qt_settings
//   자바파일 : qmtm.admin.env.ClassBean,
//              qmtm.admin.env.ClassUtil 
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.env.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR"); 
   
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 </HEAD>

 <BODY id="admin">

	<div id="main">

		<div id="mainTop">
			<div class="title">분류명 설정<span></span></div>
			<div class="location">ADMIN > 환경설정 > <span>분류명 설정</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableB" style="width: 600px;">
			<tr>
				<td id="left" width="120"><li>회사명</td>
				<td><input type="text" class="input" name="company_name" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>대분류명</td>
				<td><input type="text" class="input" name="lb_code_a" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>중분류명</td>
				<td><input type="text" class="input" name="lb_code_b" value="" size="30"></td>
			</tr>  
			<tr>
				<td id="left"><li>소분류명1</td>
				<td><input type="text" class="input" name="lb_code_c" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>소분류명2</td>
				<td><input type="text" class="input" name="lb_code_d" value="" size="30"></td>
			</tr>
			<tr>
				<td id="left"><li>소분류명3</td>
				<td><input type="text" class="input" name="lb_code_e" value="" size="30"></td>
			</tr>
		</table>
		
		<div class="button"><img src="../../images/bt5_edit.gif"></div>

	</div>
	<jsp:include page="../../copyright.jsp"/>
		
 </BODY>
</HTML>
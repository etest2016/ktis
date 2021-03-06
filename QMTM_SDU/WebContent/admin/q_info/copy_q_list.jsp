<%
//******************************************************************************
//   프로그램 : exam_ing_list.jsp
//   모 듈 명 : 시험진행 관리 페이지
//   설    명 : 시험진행 관리 페이지
//   테 이 블 : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   작 성 일 : 2008-06-23
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
	
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
	
</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_ing_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">문제복사관리</div>
			<div class="location">퀴즈문제관리 ><span> 문제복사관리</span></div>
		</div>


		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="10">
					<select name="">
						<option value="">2016년1학기</option>
					</select>&nbsp;
					<select name="">
						<option value="">과목전체</option>
						<option value="">aaaaaaaaaaaaaaaaaaaaaaa</option>
					</select>&nbsp;	
							
					<input type="button" value="검색하기" class="form4">
				</td>				
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">				
				<td bgcolor="#D8D8D8">년도/학기</td>
				<td bgcolor="#D8D8D8">과목코드</td>
				<td bgcolor="#D8D8D8">과목명</td>
				<td bgcolor="#D8D8D8">등록단원</td>							
				<td bgcolor="#D8D8D8">등록문항</td>
				<td bgcolor="#D8D8D8">중복문항</td>
				<td bgcolor="#D8D8D8">오류문항</td>
				<td bgcolor="#D8D8D8">문제복사</td>											
			</tr>

			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>				
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td><input type="button" value="문제복사" class="form"></td>									
			</tr>

		</table>
		
	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
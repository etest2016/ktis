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
			<div class="title">응시모니터링 <span>응시모니터링현황을 확인할 수 있습니다.</span></div>
			<div class="location">퀴즈평가관리 ><span> 응시모니터링</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="7">
					<select name="">
						<option value="">2016년1학기</option>
					</select>&nbsp;
					<select name="">
						<option value="">과목전체</option>
						<option value="">aaaaaaaaaaaaaaaaaaaaaaa</option>
					</select>&nbsp;					
					<select name="">
						<option value="">전체</option>
					</select>&nbsp;					
					<input type="text" class="input" size="20">&nbsp;&nbsp;<input type="button" value="검색하기" class="form4">
				</td>	
				<td colspan="6" align="right"><input type="button" value="선택과목일괄채점" class="form">&nbsp;&nbsp;<input type="button" value="선택과목수동채점" class="form"></td>			
			</tr>
			<tr id="bt3">
				<td colspan="13" align="right">
					<strong>선택된 응시자 처리</strong> <input type="button" value="이벤트로그" class="form6">&nbsp;&nbsp;<input type="button" value="답안로그" class="form6">&nbsp;&nbsp;<input type="button" value="개인시간연장처리" class="form6">&nbsp;&nbsp;<input type="button" value="재응시처리" class="form6">&nbsp;&nbsp;<input type="button" value="운영일지작성" class="form6">&nbsp;&nbsp;<input type="button" value="강제제출처리" class="form6">
				</td>				
			</tr>
			
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">				
				<td bgcolor="#D8D8D8">과목명</td>
				<td bgcolor="#D8D8D8">평가명</td>
				<td bgcolor="#D8D8D8">학번</td>
				<td bgcolor="#D8D8D8">성명</td>
				<td bgcolor="#D8D8D8">시험지번호</td>
				<td bgcolor="#D8D8D8">입장시간</td>
				<td bgcolor="#D8D8D8">답안제출시간</td>
				<td bgcolor="#D8D8D8">점수</td>
				<td bgcolor="#D8D8D8">응시시간</td>
				<td bgcolor="#D8D8D8">초과시간</td>
				<td bgcolor="#D8D8D8">장애여부</td>
				<td bgcolor="#D8D8D8">접속IP</td>
				<td bgcolor="#D8D8D8">자동제출</td>				
			</tr>

			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">				
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		</table>
		
	</div>

	
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
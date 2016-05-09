<%
//******************************************************************************
//   프로그램 : q_search_list.jsp
//   모 듈 명 : 문제 검색 결과
//   설    명 : 조건을 주어 문제 검색 결과를 보여준다.
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-04-16
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 2008-07-02
//   수 정 자 : 이테스트 석준호
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

	<table border="0" width="95%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF" height="30">
			<td align="left">* 검색된 문제</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td>
				<table border="0" width="100%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
					<tr bgcolor="#DDDDDD" height="30" align="center">
						<td>문제코드</td>
						<td>문제유형</td>
						<td>문제</td>
					</tr>
					<tr bgcolor="#FFFFFF" height="25">
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

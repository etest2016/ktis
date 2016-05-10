<%
//******************************************************************************
//   프로그램 : admin_list.jsp
//   모 듈 명 : 전체 관리자 리스트
//   설    명 : 전체 관리자 리스트 페이지
//   테 이 블 : qt_adminid
//   자바파일 : qmtm.ComLib, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil 
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");	

	String rst = "";
%>

<HTML>
 <HEAD>
  <TITLE> 관리기능설정 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup('admin_quiz_edit.jsp','edit','width=650, height=880, scrollbars=no, top='+(screen.height-880)/2+', left='+(screen.width-650)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">관리기능설정<span>: 퀴즈운영에 대한 관리기능을 설정합니다.</span></div>
			<div class="location">ADMIN > 설정관리 > <span>관리기능설정</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="8" align="right"><input type="button" value="관리기능설정하기" class="form5" onClick="insert();"></td></tr>
			<tr id="tr">				
				<td>성적공개기간</td>
				<td>문제유효기간</td>
				<td>응시방식</td>
				<td>재입장횟수</td>
				<td>부정행위의심알림횟수</td>
				<td>종료전알림시간</td>
				<td>종료후재입장추가시간</td>
				<td>논술답안자동저장시간</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="8">등록되어진 관리기능이 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length(); i++) {					   
			%>
			<tr id="td" align="center">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<%
				   }
				}
			%>
		</table>

	</div>

	<jsp:include page="../../copyright.jsp"/>

		
 </BODY>
</HTML>
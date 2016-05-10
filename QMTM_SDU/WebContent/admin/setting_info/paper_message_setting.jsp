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

	String rst = null;
%>

<HTML>
 <HEAD>
  <TITLE> 응시메시지설정 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup('paper_message_edit.jsp','edit','width=800, height=550, scrollbars=no, top='+(screen.height-550)/2+', left='+(screen.width-800)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">응시메시지설정<span>: 퀴즈응시에 대한 메시지를 설정합니다.</span></div>
			<div class="location">ADMIN > 설정관리 > <span>응시메시지설정</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="8" align="right"><input type="button" value="응시메시지설정하기" class="form5" onClick="insert();"></td></tr>
			<tr id="tr">				
				<td>NO</td>
				<td>메시지구분</td>
				<td>메시지내용</td>				
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="3">등록되어진 메시지 내용이 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length(); i++) {					   
			%>
			<tr id="td" align="center">
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
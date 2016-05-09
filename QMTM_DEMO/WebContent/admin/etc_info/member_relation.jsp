<%
//******************************************************************************
//   프로그램 : member_relation.jsp
//   모 듈 명 : 정보연동 관리
//   설    명 : 정보연동 관리 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2013-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");   
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">
	function stuImport() {
		var str = "";

		var str = confirm("학생 정보 연동을 시작합니다.\n\n연동할 데이타가 많을경우에는 시간이 많이 소요될 수 있습니다.");
	
		if(str) {
			window.open("stu_import.jsp","simport","top=0, left=0, width=1, height=1, scrollbars=no");
		}
    }

	function profImport() {
		
		var str = "";

		var str = confirm("선생님 정보 연동을 시작합니다.\n\n연동할 데이타가 많을경우에는 시간이 많이 소요될 수 있습니다.");
	
		if(str) {
			window.open("prof_import.jsp","simport","top=0, left=0, width=1, height=1, scrollbars=no");
		}
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">정보연동 관리</div>
			<div class="location">ADMIN > 기타정보관리 > <span>정보연동관리</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<TD colspan="2">&nbsp;</TD>
		</TR>
		<tr id="td" align="center">
			<td><img src="../../images/stu_import.gif" onClick="stuImport();"></td>
			<td><img src="../../images/prof_import.gif" onClick="profImport();"></td>
		</tr>
	</table>
	</div>

	<jsp:include page="../../copyright.jsp"/>
		
		
 </BODY>
</HTML>
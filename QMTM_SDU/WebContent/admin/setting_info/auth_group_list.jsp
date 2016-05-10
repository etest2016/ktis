<%
//******************************************************************************
//   프로그램 : auth_group_list_excel.jsp
//   모 듈 명 : 권한그룹설정 페이지
//   설    명 : 권한그룹설정 관리 페이지
//   테 이 블 : 
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   작 성 일 : 2016-04-25
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
	
	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }
	
	String rsts = "";
	
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<script type="text/javascript" src="../../js/jquery.js"></script>
    <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
 
	<script type="text/javaScript">
		
		function auth_group_write() {
			$.posterPopup("auth_group_write.jsp","gWrite","width=650, height=450, scrollbars=no");
		}

		function group_subject_write() {
			
		}

		function group_member_write() {
	
		}
	
	</script>

</head>

<BODY id="tman">
	
	<form name="form1" method="post" action="auth_group_list.jsp">
	
	<div id="main">

		<div id="mainTop">
			<div class="title">권한그룹 관리 <span>등록된 그룹에 대해서 권한을 관리할 수 있습니다.</span></div>
			<div class="location">설정관리 ><span> 권한그룹설정</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="12">
					<select name="field">
					<option value="id_group" <% if(field.equals("id_group")) { %> selected <% } %>>그룹코드</option>
					<option value="groupname" <% if(field.equals("groupname")) { %> selected <% } %>>그룹명</option>
					</select>&nbsp;&nbsp;
					<input type="text" class="input" name="str" size="25" value="<%=str%>" onClick="document.form1.str.value == ''">&nbsp;&nbsp;<a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
				<td colspan="2" align="right"><input type="button" value="권한그룹등록" class="form" onClick="auth_group_write();"></td>
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">그룹코드</td>
				<td bgcolor="#D8D8D8">그룹명</td>
				<td bgcolor="#D8D8D8">문제관리권한</td>
				<td bgcolor="#D8D8D8">퀴즈관리권한</td>
				<td bgcolor="#D8D8D8">문제편집</td>
				<td bgcolor="#D8D8D8">문제삭제</td>
				<td bgcolor="#D8D8D8">퀴즈편집</td>
				<td bgcolor="#D8D8D8">퀴즈삭제</td>
				<td bgcolor="#D8D8D8">답안지관리</td>
				<td bgcolor="#D8D8D8">채점관리</td>
				<td bgcolor="#D8D8D8">성적통계</td>
				<td bgcolor="#D8D8D8">재응시권한</td>
				<td bgcolor="#D8D8D8">담당과목등록</td>
				<td bgcolor="#D8D8D8">그룹원등록</td>
			</tr>
<% if(rsts == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="14">등록된 권한그룹이 없습니다.</td>
			</tr>
<% 
	} else { 		
		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td>123</td>
				<td>테스트그룹</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td><input type="button" value="과목등록" class="form6" onClick="group_subject_write();"></td>
				<td><input type="button" value="교직원등록" class="form6" onClick="group_member_write();"></td>
			</tr>
<%	
	}
%>
		</table>
		
	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
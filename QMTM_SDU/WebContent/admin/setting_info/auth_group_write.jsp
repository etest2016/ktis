<%
//******************************************************************************
//   프로그램 : admin_edit.jsp
//   모 듈 명 : 관리자 수정
//   설    명 : 관리자 수정 팝업 페이지
//   테 이 블 : qt_adminid
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil" %>
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
<HTML>
<HEAD>
<TITLE> 권한그룹 등록 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script type="text/javascript">

		function Send() {
			
		}

	</script>
	
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="auth_group_insert.jsp">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">권한그룹 등록 <span>권한그룹을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td width="100" id="left">그룹코드</td>
				<td width="350"><input type="text" name="" class="input" size="10"></td>
			</tr>
			<tr>
				<td id="left">그룹명</td>
				<td><input type="text" name="" class="input" size="40"></td>
			</tr>
			<tr>
				<td id="left">화면권한</td>
				<td><input type="checkbox" name="" value="Y"> 문제관리권한&nbsp;&nbsp;<input type="checkbox" name="" value="Y"> 퀴즈관리권한</td>
			</tr>
			<tr>
				<td id="left">문제관리권한</td>
				<td><input type="checkbox" name="" value="Y"> 문제편집권한&nbsp;&nbsp;<input type="checkbox" name="" value="Y"> 문제삭제권한</td>
			</tr>
			<tr>
				<td id="left">퀴즈관리권한</td>
				<td><input type="checkbox" name="" value="Y"> 퀴즈편집권한&nbsp;&nbsp;<input type="checkbox" name="" value="Y"> 퀴즈삭제권한</td>
			</tr>	
			<tr>
				<td id="left">기타권한</td>
				<td><table border=0>
				<tr>
					<td><input type="checkbox" name="" value="Y"> 답안지권한</td><td><input type="checkbox" name="" value="Y"> 재응시권한</td>
				</tr>
				<tr>
					<td><input type="checkbox" name="" value="Y"> 채점권한</td><td><input type="checkbox" name="" value="Y"> 성적통계권한</td>
				</tr>
				</table></td>
			</tr>	
		</table>
	</div>

	<div id="button">
		<input type="button" value="등록하기" class="form" onClick="Send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>
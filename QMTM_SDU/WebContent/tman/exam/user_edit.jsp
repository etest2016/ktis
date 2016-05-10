<%
//******************************************************************************
//   프로그램 : user_info.jsp
//   모 듈 명 : 응시자 정보
//   설    명 : 응시자 정보
//   테 이 블 : qt_userid
//   자바파일 : qmtm.tman.UserInfo, qmtm.tman.UserInfoBean
//   작 성 일 : 2008-06-02
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	UserInfoBean users = null;
	
	try {
		users = UserInfo.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));
		
		if(true) return;
	}
%>

<html>
<head>
	<title> :: 응시자 정보 수정 :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="javascript">
		function edits() {
			var frm = document.form1;
			
			if(frm.password.value == "") {
				alert("비밀번호를 입력하세요.");
				frm.password.focus();
				return;
			} else if(frm.name.value == "") {
				alert("성명을 입력하세요.");
				frm.name.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td id="left"></td>
				<Td id="mid"><div class="title">응시자 정보 <span>선택응시자의 정보를 수정합니다</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<form name="form1" action="user_update.jsp" method="post">
	<input type="hidden" name="userid" value="<%=userid%>">
	<div id="contents">
		
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<tr>
				<td id="left" width="80"><li>아이디</td>
				<td>&nbsp;<%=userid%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>비밀번호</td>
				<td>&nbsp;<input type="text" name="password" class="input" size="15" value="<%=users.getPassword()%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>성명</td>
				<td>&nbsp;<input type="text" name="name" class="input" size="15" value="<%=users.getName()%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>이메일</td>
				<td>&nbsp;<input type="text" name="email" class="input" size="50" value="<%=ComLib.nullChk(users.getEmail())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>주소1</td>
				<td>&nbsp;<input type="text" name="home_addr1" class="input" size="50" value="<%=ComLib.nullChk(users.getHome_addr1())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>나머지주소</td>
				<td>&nbsp;<input type="text" name="home_addr2" class="input" size="50" value="<%=ComLib.nullChk(users.getHome_addr2())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>집전화</td>
				<td>&nbsp;<input type="text" name="home_phone" class="input" size="15" value="<%=ComLib.nullChk(users.getHome_phone())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>핸드폰</td>
				<td>&nbsp;<input type="text" name="mobile_phone" class="input" size="15" value="<%=ComLib.nullChk(users.getMobile_phone())%>">&nbsp;</td>
			</tr>						
			<tr>
				<td id="left"><li>소속1</td>
				<td>&nbsp;<input type="text" name="sosok1" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok1())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>소속2</td>
				<td>&nbsp;<input type="text" name="sosok2" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok2())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>소속3</td>
				<td>&nbsp;<input type="text" name="sosok3" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok3())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>소속4</td>
				<td>&nbsp;<input type="text" name="sosok4" class="input" size="50" value="<%=ComLib.nullChk(users.getSosok4())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>직위</td>
				<td>&nbsp;<input type="text" name="jikwi" class="input" size="20" value="<%=ComLib.nullChk(users.getJikwi())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>직무</td>
				<td>&nbsp;<input type="text" name="jikmu" class="input" size="50" value="<%=ComLib.nullChk(users.getJikmu())%>">&nbsp;</td>
			</tr>
			<tr>
				<td id="left"><li>회사</td>
				<td>&nbsp;<input type="text" name="company" class="input" size="50" value="<%=ComLib.nullChk(users.getCompany())%>">&nbsp;</td>
			</tr>
		</table>
	</div>
	<div id="button">

		<img src="../../images/bt5_edit_yj1.gif" onclick="edits();" style="cursor: pointer;"> <img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: pointer;">
	</div>
	</form>
</body>

</html>

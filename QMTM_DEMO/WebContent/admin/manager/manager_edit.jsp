<%
//******************************************************************************
//   프로그램 : manager_edit.jsp
//   모 듈 명 : 담당자 수정
//   설    명 : 담당자 수정 팝업 페이지
//   테 이 블 : qt_workerid
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, 
//             qmtm.admin.manager.ManagerUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// 담당자 가지고오기
	ManagerBean rst = null;

	try {
		rst = ManagerUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String password = rst.getPassword();
	
%>
<HTML>
<HEAD>
<TITLE> 담당자 수정 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Send() {
			var frm = document.frmdata;
			
			if(frm.password.value == "") {
				alert("비밀번호를 입력하세요");
				frm.password.focus();
				return false;
			} else if(frm.name.value == "") {
				alert("성명을 입력하세요");
				frm.name.focus();
				return false;
			} else {
				frm.submit();
			}
		}

	</script>
	
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="manager_update.jsp">
<input type="hidden" name="userid" value="<%=userid%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">담당자 정보수정 <span>담당자 정보수정 및 사용유무 수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">아이디</td>
				<td width="300"><%=userid%></td>
			</tr>
			<tr>
				<td id="left">비밀번호</td>
				<td><input type="password" class="input" name="password" size="20" value="<%=password%>"></td>
			</tr>
			<tr>
				<td id="left">성명</td>
				<td><input type="text" class="input" name="name" size="20"  value="<%=rst.getName()%>"></td>
			</tr>
			<tr>
				<td id="left">담당자 소속</td>
				<td><textarea name="rmk" cols="35" rows="3"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">사용유무</td>
				<td><input type="radio" name="yn_valid" value="Y" <% if(rst.getYn_valid().equals("Y")) { %> checked <% } %>> 사용가능&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <% if(rst.getYn_valid().equals("N")) { %> checked <% } %>> 사용불가능</td>
			</tr>
	</table>
	</div>

<div id="button">
<img src="../../images/bt5_edit_yj1.gif" onClick="Send();">&nbsp;&nbsp;<!--input type="button" onclick="window.close()" value="창닫기"--><a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
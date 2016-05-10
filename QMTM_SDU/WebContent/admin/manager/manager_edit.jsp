<%
//******************************************************************************
//   프로그램 : manager_edit.jsp
//   모 듈 명 : 담당자 수정
//   설    명 : 담당자 수정 팝업 페이지
//   테 이 블 : qt_workerid
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, 
//              qmtm.admin.manager.ManagerUtil
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// 담당자 가지고오기
	ManagerBean rst = null;

	try {
		rst = ManagerUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>
<HTML>
<HEAD>
<TITLE> 담당자 수정 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Send() {
			var frm = document.frmdata;
			
			if(frm.name.value == "") {
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
				<td id="left" width="100">아이디</td>
				<td width="300"><%=userid%></td>
			</tr>
			<!--<tr>
				<td id="left">비밀번호</td>
				<td><input type="password" name="password" size="21" value=""></td>
			</tr>-->
			<tr>
				<td id="left">성명</td>
				<td><input type="text" name="name" size="20"  value="<%=rst.getName()%>" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">휴대폰</td>
				<td><input type="text" name="hp" size="20" value="<%=ComLib.nullChk(rst.getHp())%>"></td>
			</tr>
			<tr>
				<td id="left">이메일</td>
				<td><input type="text" name="email" size="30"  value="<%=ComLib.nullChk(rst.getEmail())%>" style="ime-mode:inactive;"></td>
			</tr>			
			<tr>
				<td id="left">담당자 소속</td>
				<td><textarea name="rmk" cols="35" rows="3" style="ime-mode:active;"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">계정사용유무</td>
				<td><input type="radio" name="yn_valid" value="Y" <% if(rst.getYn_valid().equals("Y")) { %> checked <% } %>> 사용&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <% if(rst.getYn_valid().equals("N")) { %> checked <% } %>> 미사용</td>
			</tr>
	</table>
	</div>

	<div id="button">
		<input type="button" value="수정하기" class="form" onClick="Send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>
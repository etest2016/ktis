<%
//******************************************************************************
//   프로그램 : admin_view.jsp
//   모 듈 명 : 관리자 확인
//   설    명 : 관리자 확인 팝업 페이지
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
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil" %>
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

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// 관리자 가지고오기
	AdminBean rst = null;

	try {
		rst = AdminUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
		
	String yn_use = rst.getYn_valid();

	if(yn_use.equalsIgnoreCase("Y")) {
	   yn_use = "사용";
	} else {
	   yn_use = "미사용";
	}

%>

<script language="javascript">
	function edits() {
		location.href="admin_edit.jsp?userid=<%=userid%>";
	}
	
	//--  삭제체크
    function dels()  {
       var st = confirm("*주의* 관리자를 정말 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "admin_delete.jsp?userid=<%=userid%>";
       }
    }
</script>
<HTML>
<HEAD>
<TITLE> 관리자 확인 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">관리자 정보확인 <span>관리자 정보확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">아이디</td>
				<td width="300"><%=userid%></td>
			<tr>
				<td id="left">비밀번호</td>
				<td>********</td>
			</tr>
			<tr>
				<td id="left">성명</td>
				<td><%=rst.getName()%></td>
			</tr>
			<tr>
				<td id="left">휴대폰</td>
				<td><%=ComLib.nullChk2(rst.getHp())%></td>
			</tr>
			<tr>
				<td id="left">이메일</td>
				<td><%=ComLib.nullChk2(rst.getEmail())%></td>
			</tr>			
			<tr>
				<td id="left">관리자 소속</td>
				<td><textarea name="rmk" cols="35" rows="3"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">계정사용유무</td>
				<td><%=yn_use%></td>
			</tr>
	</table>
	</div>

	<div id="button">
		<input type="button" value="수정하기" class="form" onClick="edits();"><!--&nbsp;&nbsp;<input type="button" value="삭제하기" class="form" onClick="dels();">-->&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
	</div>

</BODY>
</HTML>
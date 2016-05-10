<%
//******************************************************************************
//   프로그램 : manager_view.jsp
//   모 듈 명 : 담당자 확인
//   설    명 : 담당자 확인 팝업 페이지
//   테 이 블 : qt_workerid
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, 
//             qmtm.admin.manager.ManagerUtil
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
		
	String yn_use = rst.getYn_valid();

	if(yn_use.equalsIgnoreCase("Y")) {
	   yn_use = "사용";
	} else {
	   yn_use = "미사용";
	}
	
	String password = rst.getPassword();
	
%>

<script language="javascript">
	function edits() {
		location.href="manager_edit.jsp?userid=<%=userid%>";
	}
	
	//--  삭제체크
    function deletes()  {
       var st = confirm("*주의* 담당자를 삭제하시겠습니까? \n\n 담당자를 삭제하시면 담당자 등록 관련 정보도 함께 삭제됩니다." );
       if (st == true) {
           document.location = "manager_delete.jsp?userid=<%=userid%>";
       }
    }
</script>
<HTML>
<HEAD>
<TITLE> 담당자 확인 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">담당자 정보확인 <span>담당자 정보확인 및 수정,삭제</span></div></td>
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

			<!--<tr>
				<td id="left">비밀번호</td>
				<td>********</td>
			</tr>-->
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
				<td id="left">담당자 소속</td>
				<td><textarea name="rmk" cols="35" rows="3"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">계정사용유무</td>
				<td><%=yn_use%></td>
			</tr>
	</table>
	</div>

<div id="button">
	<input type="button" value="수정하기" class="form" onClick="edits();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

</BODY>
</HTML>
<%
//******************************************************************************
//   프로그램 : module_insert.jsp
//   모 듈 명 : 모듈등록
//   설    명 : 모듈등록 팝업 페이지
//   테 이 블 : q_chapter
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.ModuleUtil
//   작 성 일 : 2013-02-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.ModuleUtil " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
		
	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (userid.length() == 0 || id_subject.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	// 정렬순서
	int order_cnt = 0;

	try {
		order_cnt = ModuleUtil.getOrderCnt(id_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

%> 

<HTML>
 <HEAD>
  <TITLE> :: 신규단원 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_module.value == "") {
				alert("단원명을 입력하세요");
				frm.q_module.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>

 </HEAD>

 <BODY id="popup2">
	
	<form name="frmdata" method="post" action="module_insert_ok.jsp">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">신규단원 등록 <span>새 단원을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td width="30%" id="left">단원명</td>
				<td width="70%"><input type="text" class="input" name="q_module" size="25" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">정렬순서</td>
				<td><select name="module_order">
			<% for(int i = 1; i <= 15; i++) { %>	
				<option value="<%=i%>" <%if(order_cnt == i) {%>selected<% } %>><%=i%></option>
			<% } %></td>
			</tr>
		</table>
		
	</div>

	<div id="button">
		<input type="button" value="등록하기" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
	</div>

	</form>

 </BODY>
</HTML>
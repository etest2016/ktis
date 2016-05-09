<%
//******************************************************************************
//   프로그램 : chapter_insert.jsp
//   모 듈 명 : 두번째 단원등록
//   설    명 : 두번재 단원등록 팝업 페이지
//   테 이 블 : q_chapter2
//   자바파일 : qmtm.admin.qman.Chapter2QmanBean, qmtm.admin.qman.Chapter2QmanUtil
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

	int chapter_order = 0;

	// 단원순서 가지고오기
	try {
		chapter_order = 1 + Chapter3QmanUtil.getCnt(id_q_chapter);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>
<HTML>
<HEAD>
<TITLE> :: 신규단원3 등록 :: </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.chapter.value == "") {
				alert("단원명을 입력하세요");
				frm.chapter.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>
	
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="chapter_insert_ok.jsp">
<input type="hidden" name="id_q_chapter" value="<%=id_q_chapter%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">신규단원3 등록 <span>새 단원3을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">단원명</td>
				<td><input type="text" class="input" name="chapter" size="30"></td>
			</tr>
			<tr>
				<td id="left">정렬순서</td>
				<td><select name="chapter_order">
		<% for(int i = 1; i <= 10; i++) { %>	
			<option value="<%=i%>" <%if(chapter_order == i) {%>selected<% } %>><%=i%></option>
		<% } %>
				</td>
			</tr>
	</table>
	</div>

<div id="button">
<img src="../../../images/bt_chapter_ins_yj1.gif" onClick="send();" style="cursor:hand">&nbsp;
<img src="../../../images/bt5_exit_yj1_11.gif" border="0" align="adsmiddle" onClick="window.close();" style="cursor:hand">
</div>	
	
	</form>

</body>
</HTML>
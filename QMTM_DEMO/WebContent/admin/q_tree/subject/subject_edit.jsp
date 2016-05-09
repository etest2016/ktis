<%
//******************************************************************************
//   프로그램 : subject_edit.jsp
//   모 듈 명 : 과목수정
//   설    명 : 문제은행 과목수정 페이지
//   테 이 블 : q_subject
//   자바파일 : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil " %>

<%
	response.setDateHeader("Expires", 0);   
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject= ""; } else { id_q_subject = id_q_subject.trim(); }

	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));
	
		if(true) return ;
	}
	
	// 과목정보 가지고오기
	QmanTreeBean rst = null;

    try {
	    rst = QmanTree.getBean(id_q_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }
%>
<HTML>
<HEAD>
<TITLE> 과목정보 수정 </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">

	<script language="JavaScript">

		function send() {
			var frm = document.form1;
			
			if(frm.q_subject.value == "") {
				alert("과목명을 입력하세요");
				frm.q_subject.focus();
				return false;
			} else {
				document.form1.submit();
			}
		}

	</script>
</HEAD>


<BODY id="popup2">

	<form name="form1" method="post" action="subject_update.jsp">
	<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과목정보 수정 <span>과목명 및 공개유무 수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<!--table border="0" cellpadding ="0" cellspacing="0" id="tablea">
			<tr id="tr">
				<td>과목명</td>
				<td>공개유무</td>
			</tr>
			<tr id="td" align="center" height="50">
				<td><input type="text" class="input" name="q_subject" value="<%=rst.getQ_subject()%>"></td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> 비공개</td>
			</tr>
		</table-->

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td id="left">과목명</td>
				<td><input type="text" class="input" name="q_subject" value="<%=rst.getQ_subject()%>" size="30"></td>
			</tr>
			<tr>
				<td id="left">공개유무</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> 비공개</td>
			</tr>
		</table>
	</div>


	<div id="button">
		<img src="../../../images/bt5_edit_yj1.gif" border="0" onClick="send();" onfocus="this.blur();" style="cursor:hand">&nbsp;
		<img onclick="window.close();" src="../../../images/bt5_exit_yj1.gif" onfocus="this.blur();" style="cursor:hand">
	</div>

	</form>

</BODY>
</HTML>
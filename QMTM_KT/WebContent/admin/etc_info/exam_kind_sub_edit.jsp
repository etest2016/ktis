<%
//******************************************************************************
//   프로그램 : exam_kind_sub_edit.jsp
//   모 듈 명 : 시험구분수정
//   설    명 : 시험구분수정 팝업 페이지
//   테 이 블 : r_exam_kind_sub
//   자바파일 : qmtm.admin.etc.ExamKindSubBean, qmtm.admin.etc.ExamKindSubUtil
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam_kind_sub = request.getParameter("id_exam_kind_sub");
	if (id_exam_kind_sub == null) { id_exam_kind_sub= ""; } else { id_exam_kind_sub = id_exam_kind_sub.trim(); }

	if (id_exam_kind_sub.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	// 그룹구분목록 가지고오기
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
	
	ExamKindSubBean rst2 = null;

    try {
	    rst2 = ExamKindSubUtil.getBean(id_exam_kind_sub);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }
%>

<html>
<head>
	<title>:: 시험구분 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.exam_kind_sub.value == "") {
				alert("시험구분을 입력하세요");
				frm.exam_kind_sub.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="exam_kind_sub_update.jsp">
<input type="hidden" name="id_exam_kind_sub" value="<%=id_exam_kind_sub%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험구분코드수정<span> 시험구분을 수정합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">그룹구분선택</td>
				<td width="200"><select name="id_exam_kind">
				<% if(rst == null) { %>
				<option value="">그룹구분 없음</option>
				<% 
					} else { 
						for(int i=0; i<rst.length; i++) {
				%>
			<option value="<%=rst[i].getId_exam_kind()%>" <%if(rst[i].getId_exam_kind().equals(String.valueOf(rst2.getId_exam_kind()))) { %> selected <%}%>><%=rst[i].getExam_kind()%></option>
			<% 
						}
					} 
				%>
				</select>
				</td>
			</tr>
			<tr>
				<td id="left">시험코드</td>
				<td bgcolor="#FFFFFF"><%=id_exam_kind_sub%></td>
			</tr>
			<tr>
				<td id="left">시험명</td>
				<td bgcolor="#FFFFFF"><input type="text" class="input" name="exam_kind_sub" size="30" value="<%=rst2.getExam_kind_sub()%>"></td>
			</tr>
	</table>
</div>

<div id="button">
<img src="../../../images/bt5_edit_yj1.gif" border="0" onClick="send();">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
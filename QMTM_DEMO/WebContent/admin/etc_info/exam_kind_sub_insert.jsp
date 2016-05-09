<%
//******************************************************************************
//   프로그램 : exam_kind_sub_insert.jsp
//   모 듈 명 : 시험구분등록
//   설    명 : 시험구분등록 팝업 페이지
//   테 이 블 : r_exam_kind_sub
//   자바파일 : qmtm.admin.etc.StdLevelBean, qmtm.admin.etc.StdLevelUtil
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

	// 그룹구분목록 가지고오기
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>
<html>
<head>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">
	function Send() {

		var frm = document.frmdata;

		if(frm.id_exam_kind_sub.value == 0) {
			alert("시험코드를 입력하세요");
			return;
		} else if(frm.exam_kind_sub.value == 0) {
			alert("시험명을 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="exam_kind_sub_insert_ok.jsp">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험구분코드등록<span> 시험구분을 등록합니다.</span></div></td>
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
				<option value="<%=rst[i].getId_exam_kind()%>"><%=rst[i].getExam_kind()%></option>

				<% 
						}
					} 
				%>
				</select>
				</td>
			</tr>
			<tr>
				<td id="left">시험코드</td>
				<td width="200"><input type="text" class="input" name="id_exam_kind_sub" size="10"></td>
			</tr>
			<tr>
				<td id="left">시험명</td>
				<td><input type="text" class="input" name="exam_kind_sub" size="25"></td>
			</tr>
	</table>
</div>

<div id="button">
<img src="../../../images/bt5_make_yj1_1.gif" onclick="Send();">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
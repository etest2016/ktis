<%
//******************************************************************************
//   프로그램 : paper_preview.jsp
//   모 듈 명 : 시험지 미리보기 옵션 설정
//   설    명 : 시험지 미리보기 옵션 설정
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-05-16
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }
	
	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		window.close();
	</script>
<%	
	}
%>
<HEAD>
<TITLE> :: 시험지 미리보기 - 옵션 설정:: </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

	<form name="frmdata" method="post" action="paper_preview_res.jsp">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="nr_set" value="<%=nr_set%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험지 미리보기 옵션설정 <span></span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="25%" align="center">표시항목<br>선택</td>
				<td>

					<input type="checkbox" name="ref" checked disabled> 지문
					<input type="checkbox" name="q" checked disabled> 문제
					<input type="checkbox" name="ex" checked disabled> 보기

					<hr>

					<input type="checkbox" name="answer" value="Y">정답&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="explain" value="Y">해설&nbsp;&nbsp;
					<input type="checkbox" name="hint" value="Y">힌트<br>

					<input type="checkbox" name="diff" value="Y">난이도&nbsp;
					<input type="checkbox" name="allott" value="Y">배점&nbsp;&nbsp;
					<input type="checkbox" name="id_q" value="Y">문제코드


				</td>
			</tr>
		</table>
	</div>

	<div id="button">
		<input type="image" value="시험지 미리보기" name="submit" src="../../images/bt_paper_preview_yj1.gif">&nbsp;
		<input type="image" value="취소" onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

	</form>

</BODY>
</HTML>
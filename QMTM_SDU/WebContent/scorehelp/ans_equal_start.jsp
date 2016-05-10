<%
//******************************************************************************
//   프로그램 : ans_equal_start.asp
//   모 듈 명 : 모사답안 비교 대상 문제
//   설    명 : 모사답안 비교 대상 문제
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 
//   작 성 자 : 
//   수 정 일 : 2009-01-21
//   수 정 자 : 이테스트 강진아
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");

%>
<%
	Score_AnsEqualBean rst = null;

	try {
		rst = Score_AnsEqual.getBean(id_exam, id_q);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
	
%>

<html>
<head>
<title>모사 답안 실행결과</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>
<BODY Style="margin:0px;">

	<!-- 타이틀 디자인 -->
	<div style="width: 100%; height: 70px; background-image: url(../images/bg_mark_top.gif); text-align: right;"><img src="../images/bt_re.gif" onclick="javascript:parent.window.location.reload();" style="cursor: pointer;"><img src="../images/bt_out.gif" style="cursor: pointer;" onclick="javascript:parent.window.close()"></div>

	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center" style="padding-left: 30px; padding-right: 30px;">
				<div class="title">논술형 문제 정보</div>
				
				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="TableD">
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>문제번호</B></td>  
						<td bgcolor="#FFFFFF"><%=rst.getId_q()%>&nbsp;</td>
						<td width="15%" align="center" id="left"><B>배점</B></td> 
						<td bgcolor="#FFFFFF"><%=rst.getAllotting()%>점</td>	
					</tr>
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>문제</B></td>  
						<td height="30" bgcolor="#FFFFFF" colspan="3"><%=rst.getQ()%>&nbsp;</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>

</BODY>
</HTML>
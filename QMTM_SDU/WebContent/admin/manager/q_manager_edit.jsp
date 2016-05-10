<%
//******************************************************************************
//   프로그램 : q_manager_edit.jsp
//   모 듈 명 : 담당자 담당과정 수정
//   설    명 : 담당자 담당과정 수정 팝업 페이지
//   테 이 블 : q_worker_subj, q_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil
//   작 성 일 : 2010-06-10
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil " %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (userid.length() == 0 || id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// 담당자 과정 가지고오기
	ManagerTBean rst = null;

	try {
		rst = ManagerTUtil.getBean(userid, id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

%>	

<HTML>
<HEAD>
	<TITLE> :: 과정권한 수정 :: </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<HEAD>

<BODY ID="popup2">

	<form name="frmdata" method="post" action="q_manager_update.jsp">
	<input type="hidden" name="userid" value="<%=userid%>">
	<input type="hidden" name="id_course" value="<%=id_course%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과정권한 수정 <span>선택 과정의 권한 수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">

		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableD" width="100%">

			<tr>
				<td id="left">과정명&nbsp;</td>
				<td><%=rst.getCourse()%></td>
			</tr>
			<tr>
				<td id="left">문제편집권한&nbsp;</td>
				<td><input type="checkbox" name="q_edit" value="Y" <% if(rst.getPt_q_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">문제삭제권한&nbsp;</td>
				<td><input type="checkbox" name="q_del" value="Y" <% if(rst.getPt_q_delete().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">시험편집권한&nbsp;</td>
				<td><input type="checkbox" name="exam_edit" value="Y" <% if(rst.getPt_exam_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">시험삭제권한&nbsp;</td>
				<td><input type="checkbox" name="exam_del" value="Y" <% if(rst.getPt_exam_delete().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">답안지관리권한&nbsp;</td>
				<td><input type="checkbox" name="answer_edit" value="Y" <% if(rst.getPt_answer_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">채점관리권한&nbsp;</td>
				<td><input type="checkbox" name="score_edit" value="Y" <% if(rst.getPt_score_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">통계관리권한&nbsp;</td>
				<td><input type="checkbox" name="static_edit" value="Y" <% if(rst.getPt_static_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
		</table>
	</div>

	<div id="button">
		<input type="image" value="수정하기" name="submit" src="../../images/bt5_edit_yj1.gif">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif">
	</div>

	

	</form>

</BODY>
</HTML>
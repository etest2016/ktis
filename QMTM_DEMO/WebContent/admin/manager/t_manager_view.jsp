<%
//******************************************************************************
//   프로그램 : t_manager_view.jsp
//   모 듈 명 : 담당자 담당과정 확인
//   설    명 : 담당자 담당과정 확인 팝업 페이지
//   테 이 블 : t_worker_subj, c_course
//   자바파일 : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil
//   작 성 일 : 2010-06-10
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil" %>

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
	<TITLE> :: [TMan] 과정정보 조회 :: </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<script language="javascript">
		function edits() {
			location.href="t_manager_edit.jsp?userid=<%=userid%>&id_course=<%=id_course%>";
		}
		
		//--  삭제체크
		function deletes()  {
		   var st = confirm("*주의* 담당과정을 삭제하시겠습니까?" );
		   if (st == true) {
			   document.location = "t_manager_delete.jsp?userid=<%=userid%>&id_course=<%=id_course%>";
		   }
		}
	</script>
</HEAD>

<BODY ID="popup2">

	<form name="frmdata" method="post" action="t_manager_insert_ok.jsp">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">[TMan] 과정정보 조회 <span>담당 과정정보 조회 및 수정, 삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<table cellpadding="0" cellspacing="0" border="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="110">과정명&nbsp;</td>
				<td><%=rst.getCourse()%></td>
			</tr>
			<tr>
				<td id="left">시험편집권한&nbsp;</td>
				<td><%=rst.getPt_exam_edit()%></td>
			</tr>
			<tr>
				<td id="left">시험삭제권한&nbsp;</td>
				<td><%=rst.getPt_exam_delete()%></td>
			</tr>
			<tr>
				<td id="left">답안지관리권한&nbsp;</td>
				<td><%=rst.getPt_answer_edit()%></td>
			</tr>
			<tr>
				<td id="left">채점관리권한&nbsp;</td>
				<td><%=rst.getPt_score_edit()%></td>
			</tr>
			<tr>
				<td id="left">통계관리권한&nbsp;</td>
				<td><%=rst.getPt_static_edit()%></td>
			</tr>
			<tr>
				<td id="left">등록일자&nbsp;</td>
				<td><%=rst.getRegdate()%></td>
			</tr>	
		</table>
	</div>

	<div id="button">
		<a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
	</div>


	

	</form>

</BODY>
</HTML>
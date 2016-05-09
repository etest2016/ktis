<%
//******************************************************************************
//   프로그램 : t_manager_insert.jsp
//   모 듈 명 : 담당자 과정등록
//   설    명 : 담당자 과정등록 팝업 페이지
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

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    // 담당자 담당과목 목록 가지고오기
	ManagerTBean[] rst = null;

	try {
		rst = ManagerTUtil.getAddBeans(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD>
  <TITLE> :: 담당과정 추가 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="JavaScript">
	function checks() {
		var frm = document.form1;
		var cnt = 0;

		if (frm.courses.length == undefined) { //한개일때 체크
			if(frm.courses.checked==true ) {
			   cnt = cnt + 1;
			} 
		}else{

			for(i=0;i<frm.courses.length;i++) {
				if(frm.courses[i].checked) {
					cnt = cnt + 1;
				}
			}
		}
			
		if(cnt == 0) {
			alert("과정을 선택하세요.!!!");
			return;
		}

		frm.submit();
    }	
 </script>

 </HEAD>

 <BODY id="popup2">
	
	<form name="form1" method="post" action="t_manager_insert_ok.jsp">
	<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">담당과정 추가 <span>선택 담당자에게 권한을 부여할 과정 및 권한 설정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	
	<div id="contents" style="text-align: center;">
		
		<TABLE width="960" cellpadding="3" cellspacing="0" border="0" id="tableA">
			<tr id="tr4">
				<td width="9%" height="40" align="center" bgcolor="#DBDBDB">선택</td>
				<td>과정코드</td>
				<td>과정명</td>
				<td width="50">시험편집권한</td>
				<td width="50">시험삭제권한</td>
				<td width="40">답안지관리</td>
				<td width="35">채점관리</td>
				<td width="35">통계관리</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="8">추가하실 과정이 없습니다.</td>
			</tr>
			
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>

			<tr id="td" align="center">
				<td><input type="checkbox" name="courses" value="<%=rst[i].getId_course()%>"></td>
				<td><%=rst[i].getId_course()%></td>
				<td><%=rst[i].getCourse()%></td>
				<td><input type="checkbox" name="exam_edit<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="exam_del<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="answer_edit<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="score_edit<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="static_edit<%=rst[i].getId_course()%>" value="Y"></td>
			</tr>
			<%
				   }
				}
			%>
		</table>

	</div>

	<div id="button">
		<% if(rst != null) { %><!--<input type="button" value="과정추가하기" onClick="checks();">--><a href="javascript:checks();"><img src="../../images/bt_t_insertyj_1.gif"></a><% } %>&nbsp;&nbsp;<!--<input type="button" value="창닫기" onClick="window.close();">--><a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a>
	</div>			
	
 </BODY>
</HTML>
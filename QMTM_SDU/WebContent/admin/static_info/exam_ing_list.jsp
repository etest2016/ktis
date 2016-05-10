<%
//******************************************************************************
//   프로그램 : exam_ing_list.jsp
//   모 듈 명 : 시험진행 관리 페이지
//   설    명 : 시험진행 관리 페이지
//   테 이 블 : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   작 성 일 : 2008-06-23
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
	<script language="JavaScript">
		function send() {
			var frm = document.form1;
			
			if(frm.exam_start.value == "") {
				alert("검색일자를 입력하세요");
				frm.exam_start.focus();
				return;
			} else if(frm.exam_end.value == "") {
				alert("검색일자를 입력하세요");
				frm.exam_end.focus();
				return;
			} else {
				frm.submit();
			}
		}
	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_ing_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">시험 진행 관리 <span>검색할 시험일자를 입력하면 현재 진행중인 시험목록을 확인할 수 있습니다.</span></div>
			<div class="location">시험관리 ><span> 시험진행 관리</span></div>
		</div>


		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="6">
					<input type="text" class="input" name="exam_start" size="12" readonly onClick="MiniCal(document.all.exam_start)" value="<%=exam_start%>"> ~ <input type="text" class="input" name="exam_end" size="12" readonly onClick="MiniCal(document.all.exam_end)" value="<%=exam_end%>">&nbsp;&nbsp;<!--<input type="button" value="확인하기" onClick="send();">--><a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
				<td colspan="2" align="right"><a href="exam_schedule.jsp">[달력으로 보기]</a></td>
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">시험명</td>
				<td bgcolor="#D8D8D8">시험시작일</td>
				<td bgcolor="#D8D8D8">시험종료일</td>
				<td bgcolor="#D8D8D8">대상인원</td>
				<td bgcolor="#D8D8D8">응시인원</td>
				<td bgcolor="#D8D8D8">미응시인원</td>
				<td bgcolor="#D8D8D8">답안완료인원</td>
				<td bgcolor="#D8D8D8">답안미완료인원</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="8">검색일자를 입력하세요..</td>
			</tr>
<% 
	} else { 
		
		IngInwonBean inwons = null;
		
		for(int i=0; i<rst.length; i++) {
			
			try {
				inwons = IngInwon.getInwons(rst[i].getId_exam(), rst[i].getId_auth_type());
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

			    if(true) return;
			}
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td><%=rst[i].getTitle()%></td>
				<td><%=rst[i].getExam_start()%></td>
				<td><%=rst[i].getExam_end()%></td>
				<td><%=inwons.getTot_inwon()%> 명</td>
				<td><%=inwons.getAns_y_inwon() + inwons.getAns_n_inwon()%> 명</td>
				<td><%=inwons.getTot_inwon() - (inwons.getAns_y_inwon() + inwons.getAns_n_inwon())%> 명</td>
				<td><%=inwons.getAns_y_inwon()%> 명</td>
				<td><%=inwons.getAns_n_inwon()%> 명</td>
			</tr>
<%
		}
	}
%>
		</table>
		
	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
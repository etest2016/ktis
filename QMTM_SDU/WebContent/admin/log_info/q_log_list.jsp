<%
//******************************************************************************
//   프로그램 : q_log_list.jsp
//   모 듈 명 : 문제로그관리 페이지
//   설    명 : 문제로그관리 페이지
//   테 이 블 : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, java.util.Date, java.util.Calendar
//   작 성 일 : 2013-01-29
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, java.util.Date, java.util.Calendar" %>
<%@ include file = "../../common/paging.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String exam_start = request.getParameter("exam_start");
	if (exam_start == null) { exam_start = ""; } else { exam_start = exam_start.trim(); }

	String gubun = request.getParameter("gubun");
	if (gubun == null) { gubun = ""; } else { gubun = gubun.trim(); }

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }

	if(gubun.length() == 0) {
		gubun = "";
	}

	if(field.length() == 0) {
		field = "";
	}

	String tmp_page = request.getParameter("page");
	if (tmp_page == null) { tmp_page= ""; } else { tmp_page = tmp_page.trim(); }

	String url = "q_log_list.jsp";	

	String add_tag = "&gubun="+gubun+"&exam_start="+exam_start+"&field="+field+"&str="+str;
    	
	int total_page = 0; // 총 페이지
    int total_count = 0; // 총 레코드 수
	int current_page = 0; // 현재 페이지
	int page_scale = 150; // 한 화면에 보여지는 게시물 수
	int remain = 0; // 페이지 계산을 위해 나머지값 계산.
	int start_rnum = 0; // 현재 페이지 게시물 시작번호
	int end_rnum = 0; // 현재 페이지 게시물 끝번호

	if(tmp_page.length() == 0) {
		current_page = 1;
	} else {
		current_page = Integer.parseInt(tmp_page);
	}
	
	WorkQLogBean[] rst = null;

	if(exam_start.length() > 0) {

		try {
			total_count = WorkQLog.getCounts(gubun, exam_start, field, str);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		remain = total_count % page_scale;
		
		if(remain == 0) {
			total_page = total_count / page_scale;
		} else {
			total_page = total_count / page_scale + 1;
		}

		int lists = (current_page - 1) * page_scale;
		
		try {
			rst = WorkQLog.getBeans(page_scale, lists, gubun, exam_start, field, str);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));		    

		    if(true) return;
		}
	} 
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	
	<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
		$(function() {
			$.datepicker.setDefaults($.datepicker.regional['ko']);
			$( ".date_picker" ).datepicker();
		});
	</script>
 
	<script language="JavaScript">
		function send() {
			var frm = document.form1;
			
			if(frm.exam_start.value == "") {
				alert("검색일자를 입력하세요");
				frm.exam_start.focus();
				return;
			} else {
				frm.submit();
			}
		}
		
	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="q_log_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">퀴즈문제출제로그관리 <span>검색할 일자를 입력하면 문제관련로그를 확인할 수 있습니다.</span></div>
			<div class="location">ADMIN ><span> 퀴즈출제현황및로그관리 > 퀴즈문제출제로그관리</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="9">
					<b>로그구분선택</b> : <Select name="gubun">
					<option value="" <%if(gubun.equals("")) { %>selected<% } %>>전체</option>	
					<option value="과목등록" <%if(gubun.equals("과목등록")) { %>selected<% } %>>과목등록</option>
					<option value="과목수정" <%if(gubun.equals("과목수정")) { %>selected<% } %>>과목수정</option>
					<option value="과목삭제" <%if(gubun.equals("과목삭제")) { %>selected<% } %>>과목삭제</option>
					<option value="단원등록" <%if(gubun.equals("단원등록")) { %>selected<% } %>>단원등록</option>
					<option value="단원수정" <%if(gubun.equals("단원수정")) { %>selected<% } %>>단원수정</option>
					<option value="단원삭제" <%if(gubun.equals("단원삭제")) { %>selected<% } %>>단원삭제</option>

					<option value="대분류등록" <%if(gubun.equals("대분류등록")) { %>selected<% } %>>대분류등록</option>
					<option value="대분류수정" <%if(gubun.equals("대분류수정")) { %>selected<% } %>>대분류수정</option>
					<option value="대분류삭제" <%if(gubun.equals("대분류삭제")) { %>selected<% } %>>대분류삭제</option>
					<option value="소분류등록" <%if(gubun.equals("소분류등록")) { %>selected<% } %>>소분류등록</option>
					<option value="소분류수정" <%if(gubun.equals("소분류수정")) { %>selected<% } %>>소분류수정</option>
					<option value="소분류삭제" <%if(gubun.equals("소분류삭제")) { %>selected<% } %>>소분류삭제</option>

					<option value="문제일괄등록" <%if(gubun.equals("문제일괄등록")) { %>selected<% } %>>문제일괄등록</option>
					<option value="문제개별등록" <%if(gubun.equals("문제개별등록")) { %>selected<% } %>>문제개별등록</option>
					<option value="문제수정" <%if(gubun.equals("문제수정")) { %>selected<% } %>>문제수정</option>
					<option value="문제삭제" <%if(gubun.equals("문제삭제")) { %>selected<% } %>>문제삭제</option>
					<option value="문제복사" <%if(gubun.equals("문제복사")) { %>selected<% } %>>문제복사</option>
					<option value="문제이동" <%if(gubun.equals("문제이동")) { %>selected<% } %>>문제이동</option>
					<option value="오류문제처리" <%if(gubun.equals("오류문제처리")) { %>selected<% } %>>오류문제처리</option>					
				</select>&nbsp;&nbsp;
					<b>검색일자</b> : <input type="text" class="input date_picker" name="exam_start" size="12" readonly>&nbsp;&nbsp;
					<b>검색조건</b> : <select name="field">
				<option value="" <%if(field.equals("")) { %>selected<% } %>>전체</option>
				<option value="a.q_subject" <%if(field.equals("a.q_subject")) { %>selected<% } %>>과목명</option>
				<option value="c.name" <%if(field.equals("c.name")) { %>selected<% } %>>담당자명</option>
				</select>&nbsp;&nbsp;
				<input type="text" class="input" name="str" size="20" value="<%=str%>">&nbsp;&nbsp;<a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>			
				</td>				
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">NO</td>
				<td bgcolor="#D8D8D8">과목명</td>
				<td bgcolor="#D8D8D8">단원명</td>
				<td bgcolor="#D8D8D8">교수자ID</td>
				<td bgcolor="#D8D8D8">성명</td>
				<td bgcolor="#D8D8D8">구분</td>
				<td bgcolor="#D8D8D8">상세내용</td>
				<td bgcolor="#D8D8D8">등록일</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="8">검색조건을 입력하세요..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {	
			int list_num = total_count - (current_page - 1) * page_scale - i;

			String chapter_name = "";

			try {
				chapter_name = WorkQLog.getChapter(rst[i].getId_chapter());
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));		    

			    if(true) return;
			}
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td><%=list_num%></td>
				<td><%=rst[i].getSubject()%></td>
				<td><%=chapter_name%></td>
				<td><%if(rst[i].getUserid() == null) { %>관리자<% } else { %><%=rst[i].getUserid()%><% } %></td>
				<td><%=rst[i].getName()%></td>
				<td><%=rst[i].getGubun()%></td>
				<td><textarea cols="45" rows="5" readonly><%=rst[i].getBigo()%></textarea></td>
				<td><%=rst[i].getRegdate()%></td>
			</tr>
<%
		}
	}
%>
		</table>
		
		<P>

		<table border="0" width="100%">
			<tr>
				<td align="center"><%= PageNumber(current_page, total_page, url, add_tag) %></td>
			</tr>
		</table>
		
	</form>

	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</html>
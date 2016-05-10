<%
//******************************************************************************
//   프로그램 : exam_log_list.jsp
//   모 듈 명 : 시험진행 관리 페이지
//   설    명 : 시험진행 관리 페이지
//   테 이 블 : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.common.WorkExamLog, qmtm.common.WorkExamLogBean, java.util.Date, java.util.Calendar
//   작 성 일 : 2013-01-29
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.common.WorkExamLog, qmtm.common.WorkExamLogBean, java.util.Date, java.util.Calendar" %>
<%@ include file = "../../common/paging.jsp" %> 
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

	String url = "exam_log_list.jsp";	

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
	
	WorkExamLogBean[] rst = null;

	if(exam_start.length() > 0) {

		try {
			total_count = WorkExamLog.getCounts(gubun, exam_start, field, str);
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
			rst = WorkExamLog.getBeans(page_scale, lists, gubun, exam_start, field, str);
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
	<form name="form1" method="post" action="exam_log_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">퀴즈평가로그관리 <span>검색할 일자를 입력하면 퀴즈관련로그를 확인할 수 있습니다.</span></div>
			<div class="location">ADMIN ><span> 퀴즈출제현황및로그관리 > 퀴즈평가로그관리</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="10">
					<b>로그구분선택</b> : <Select name="gubun">
					<option value="" <%if(gubun.equals("")) { %>selected<% } %>>전체</option>					
					<option value="시험설정" <%if(gubun.equals("시험설정")) { %>selected<% } %>>퀴즈설정</option>
					<option value="시험수정" <%if(gubun.equals("시험수정")) { %>selected<% } %>>퀴즈수정</option>
					<option value="시험삭제" <%if(gubun.equals("시험삭제")) { %>selected<% } %>>퀴즈삭제</option>
					<option value="대상자등록" <%if(gubun.equals("대상자등록")) { %>selected<% } %>>대상자등록</option>
					<option value="대상자삭제" <%if(gubun.equals("대상자삭제")) { %>selected<% } %>>대상자삭제</option>
					<option value="시험일괄복사" <%if(gubun.equals("시험일괄복사")) { %>selected<% } %>>시험일괄복사</option>
					<option value="시험지만들기" <%if(gubun.equals("시험지만들기")) { %>selected<% } %>>시험지만들기</option>
					<option value="문제교체" <%if(gubun.equals("문제교체")) { %>selected<% } %>>문제교체</option>
					<option value="시험지삭제" <%if(gubun.equals("시험지삭제")) { %>selected<% } %>>시험지삭제</option>
					<option value="답안지추가" <%if(gubun.equals("답안지추가")) { %>selected<% } %>>답안지추가</option>
					<option value="답안지편집" <%if(gubun.equals("답안지편집")) { %>selected<% } %>>답안지편집</option>
					<option value="답안지삭제" <%if(gubun.equals("답안지삭제")) { %>selected<% } %>>답안지삭제</option>
					<option value="응시상태변경" <%if(gubun.equals("응시상태변경")) { %>selected<% } %>>응시상태변경</option>
					<option value="답안지복구" <%if(gubun.equals("답안지복구")) { %>selected<% } %>>답안지복구</option>
					<option value="DB에서답안지삭제" <%if(gubun.equals("DB에서답안지삭제")) { %>selected<% } %>>DB에서답안지삭제</option>
					<option value="모든응시자채점" <%if(gubun.equals("모든응시자채점")) { %>selected<% } %>>모든응시자채점</option>
					<option value="선택응시자채점" <%if(gubun.equals("선택응시자채점")) { %>selected<% } %>>선택응시자채점</option>
					<option value="득점가감처리" <%if(gubun.equals("득점가감처리")) { %>selected<% } %>>득점가감처리</option>
					<option value="단답형채점" <%if(gubun.equals("단답형채점")) { %>selected<% } %>>단답형채점</option>
					<option value="서술형채점" <%if(gubun.equals("서술형채점")) { %>selected<% } %>>서술형채점</option>
					<option value="실기형채점" <%if(gubun.equals("실기형채점")) { %>selected<% } %>>실기형채점</option>					
					<option value="개인시간변경" <%if(gubun.equals("개인시간변경")) { %>selected<% } %>>개인시간변경</option>
					<option value="제한시간일괄연장" <%if(gubun.equals("제한시간일괄연장")) { %>selected<% } %>>제한시간일괄연장</option>
					<option value="제한시간연장" <%if(gubun.equals("제한시간연장")) { %>selected<% } %>>제한시간연장</option>
					<option value="성적통계" <%if(gubun.equals("성적통계")) { %>selected<% } %>>성적통계</option>					
				</select>&nbsp;&nbsp;
				<b>검색일자</b> : <input type="text" class="input date_picker" name="exam_start" size="12" readonly>&nbsp;&nbsp;
				<b>검색조건</b> : <select name="field">
				<option value="" <%if(field.equals("")) { %>selected<% } %>>전체</option>
				<option value="a.course" <%if(field.equals("a.course")) { %>selected<% } %>>과목명</option>
				<option value="b.title" <%if(field.equals("b.title")) { %>selected<% } %>>시험명</option>
				<option value="d.name" <%if(field.equals("d.name")) { %>selected<% } %>>담당자명</option>
				</select>&nbsp;&nbsp;
				<input type="text" class="input" name="str" size="20">&nbsp;&nbsp;<a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>			
				</td>				
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">NO</td>
				<td bgcolor="#D8D8D8">과목코드</td>
				<td bgcolor="#D8D8D8">과목명</td>
				<td bgcolor="#D8D8D8">주차</td>
				<td bgcolor="#D8D8D8">퀴즈명</td>
				<td bgcolor="#D8D8D8">교수자ID</td>
				<td bgcolor="#D8D8D8">성명</td>
				<td bgcolor="#D8D8D8">구분</td>
				<td bgcolor="#D8D8D8">상세내용</td>
				<td bgcolor="#D8D8D8">등록일</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="10">검색조건을 입력하세요..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {	
			int list_num = total_count - (current_page - 1) * page_scale - i;
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td><%=list_num%></td>
				<td><%=rst[i].getCourse()%></td>
				<td><%=rst[i].getTitle()%></td>
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
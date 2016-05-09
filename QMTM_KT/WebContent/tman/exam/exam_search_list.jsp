<%
//******************************************************************************
//   프로그램 : exam_search_list.jsp
//   모 듈 명 : 시험검색 관리 페이지
//   설    명 : 시험검색 관리 페이지
//   테 이 블 : exam_m
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList
//   작 성 일 : 2010-06-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }

	// 검색된 시험정보 가지고오기
	ExamListBean[] rst = null;

	if(field.length() > 0 && str.length() > 0) {

		try {
			if(userid.equals("qmtm")) {
				rst = ExamList.getAdmSearchBeans(field, str, userid);
			} else {
				rst = ExamList.getSearchBeans(field, str, userid);
			}
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
	}
%>

<html>
<head>
	<title></title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
	<script language="JavaScript">
		function send() {
			var frm = document.form1;
			
			if(frm.str.value == "") {
				alert("검색내용을 입력하세요");
				frm.str.focus();
				return;
			} else {
				frm.submit();
			}
		}

		function edits(id_exam) {
			window.open("exam_edit.jsp?id_exam="+id_exam,"edit","width=850, height=650, scrollbars=yes, top=0, left=0");
	    }
	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_search_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">시험 검색 <span>검색할 항목을 선택 후 검색내용을 입력하세요.</span></div>
			<div class="location">시험관리 > <span> 시험 검색</span></div>	
		</div>

		<TABLE cellpadding="0" cellspacing="0" border="0" width="100%" id="tablea">
			<tr id="bt3">
				<td colspan="9">
					<select name="field">
					<option value="a.title" <% if(field.equals("a.title")) { %> selected <% } %>>시험명</option>
					<option value="c.name" <% if(field.equals("c.name")) { %> selected <% } %>>출제자 성명</option>
					<option value="a.userid" <% if(field.equals("a.userid")) { %> selected <% } %>>출제자 아이디</option>
					</select>&nbsp;&nbsp;
					
					<input type="text" class="input" name="str" size="15" value="<%=str%>" onClick="document.form1.str.value == ''">&nbsp;&nbsp;<!--<input type="button" value="확인하기" onClick="send();">--><a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
			</tr>
		
			<tr id="tr">
				<td>과정명</td>
				<td>시험제목</td>
				<td>시험가능여부</td>
				<td>시험기간</td>
				<td>성적조회기간</td>
				<td>출제자</td>
			</tr>
	<%
		if(rst == null) {
	%>
			<tr>
				<td class="blank" colspan="6">검색한 시험목록이 없습니다.</td>
			</tr>
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {

	%>
			<tr id="td" align="center">
			    <td align="left">&nbsp;<%=rst[i].getCourse()%></td>
				<td align="left">&nbsp;<a href="exam_list.jsp?id_exam=<%=rst[i].getId_exam()%>"><%=rst[i].getTitle()%></a></td>
				<td><%=rst[i].getYn_enable()%></td>
				<td><%=rst[i].getExam_start1()%>~<br><%=rst[i].getExam_end1()%></td>
				<td><%=rst[i].getStat_start()%>~<br><%=rst[i].getStat_end()%></td>
				<td><%=rst[i].getName()%></td>
			</tr>
	<%
			}
		}
	%>
		</table>

	</div>
	<jsp:include page="../../copyright.jsp"/>
	
 </BODY>
</HTML>
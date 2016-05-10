<%
//******************************************************************************
//   프로그램 : subject_insert.jsp
//   모 듈 명 : 강좌등록
//   설    명 : 시험관리 강좌등록 팝업 페이지
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2013-02-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanUtil, java.sql.Timestamp, java.util.Calendar" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	Calendar cal = Calendar.getInstance();
	String years = String.valueOf(cal.get(Calendar.YEAR));
	int month = cal.get(Calendar.MONTH);

	String months = String.valueOf(month+1);

	if(String.valueOf(months).length() == 1) {
		months = "0"+months;
	}

	// 정렬순서
	int order_cnt = 0;

	try {
		order_cnt = SubjectTmanUtil.getOrderCnt(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: 시험 강좌 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <Script language="JavaScript">
  	function send() {
  		if(document.frmdata.subject.value == "") {
  			alert("강좌명을 등록하세요.");
  			document.frmdata.subject.focus();
  			return;
  		} else {
  			document.frmdata.submit();
  		}  		
  	}
  </Script>
  
 </HEAD>

 <BODY id="popup2">

<form name="frmdata" method="post" action="subject_insert_ok.jsp">
<input type="hidden" name="id_course" value="<%=id_course%>">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험 강좌 등록 <span>신규 강좌를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td width="90" id="left">강좌명</td>
				<td width="200"><input type="text" class="input" name="subject" size="30" style="ime-mode:active;">&nbsp;</td>
			</tr>
			<tr>
			<td id="left">정렬순서</td>
				<td><select name="subject_order">
				<% for(int i = 1; i <= 15; i++) { %>	
					<option value="<%=i%>" <%if(order_cnt == i) {%>selected<% } %>><%=i%></option>
				<% } %></td>
			</tr>
			<tr>
				<td id="left">교육시작일</td>
				<td><select name="open_year">
				<%
					String open_year = "";
					for(int i = 2008; i<=2025; i++) { 
						open_year = String.valueOf(i);
				%>
					<option value="<%=i%>" <% if(open_year.equals(years)) { %>selected<% } %>><%=i%></option>
				<%}%>
				</select>&nbsp;/&nbsp;<Select name="open_month">
				<%
					for(int i = 1; i<=12; i++) { 
						String open_month = "";
						if(String.valueOf(i).length() == 1) {
							open_month = "0"+String.valueOf(i);
						} else {
							open_month = String.valueOf(i);
						}
				%>
					<option value="<%=open_month%>" <% if(open_month.equals(months)) { %>selected<% } %>><%=open_month%></option>
				<%}%>
				</td>
			</tr>
		</table>
		
	</div>

	<div id="button">
		<input type="button" value="등록하기" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">		
	</div>

	</form>

 </BODY>
</HTML>
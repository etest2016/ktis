<%
//******************************************************************************
//   프로그램 : subject_edit.jsp
//   모 듈 명 : 강좌수정
//   설    명 : 시험관리 강좌수정 페이지
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2013-02-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // 과정 ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // 과목 ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// 강좌정보 가지고오기
	SubjectTmanBean rst = null;

    try {
	    rst = SubjectTmanUtil.getBean(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<HTML>
<HEAD>
<TITLE> 강좌정보 수정 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
  	function checks() {
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

<form name="frmdata" method="post" action="subject_update.jsp">
<input type="hidden" name="id_course" value="<%=id_course%>">
<input type="hidden" name="id_subject" value="<%=id_subject%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">강좌정보 수정 <span>강좌명 및 공개유무 수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td width="60" id="left">강좌명</td>
				<td width="220"><input type="text" class="input" size="30" name="subject" value="<%=rst.getSubject()%>"></td>
			</tr>
			<tr>
				<td id="left">교육시작일</td>
				<td><select name="open_year">
				<%
					String open_year = "";
					for(int i = 2008; i<=2025; i++) { 
						open_year = String.valueOf(i);
				%>
					<option value="<%=open_year%>" <% if(open_year.equals(rst.getOpen_year())) { %>selected<% } %>><%=open_year%></option>
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
					<option value="<%=open_month%>" <% if(open_month.equals(rst.getOpen_month())) { %>selected<% } %>><%=open_month%></option>
				<%}%>
				</td>
			</tr>
			<tr>
			<td id="left">정렬순서</td>
				<td><select name="subject_order">
				<% for(int i = 1; i <= 15; i++) { %>	
					<option value="<%=i%>" <%if(rst.getSubject_order() == i) {%>selected<% } %>><%=i%></option>
				<% } %></td>
			</tr>
			<tr>
				<td id="left">공개유무</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> 비공개</td>
			</tr>
		</table>
	</div>

	<div id="button">
    <img src="../../images/bt5_edit_yj1.gif" onClick="checks();" style="cursor:pointer">&nbsp;&nbsp;<img border="0" src="../../images/bt5_exit_yj1.gif" style="cursor:pointer" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>
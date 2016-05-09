<%
//******************************************************************************
//   프로그램 : subject_edit.jsp
//   모 듈 명 : 과목수정
//   설    명 : 시험관리 과목수정 페이지
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // 과정 ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // 과목 ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// 과목정보 가지고오기
	SubjectTmanBean rst = null;

    try {
	    rst = SubjectTmanUtil.getBean(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<HTML>
<HEAD>
<TITLE> 단원정보 수정 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
  	function checks() {
  		if(document.frmdata.subject.value == "") {
  			alert("단원명을 등록하세요.");
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
				<Td id="mid"><div class="title">단원정보 수정 <span>단원명 및 공개유무 수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">단원명</td>
				<td><input type="text" class="input" size="30" name="subject" value="<%=rst.getSubject()%>"></td>
			</tr>
			<tr>
				<td id="left">공개유무</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> 비공개</td>
			</tr>
		</table>
	</div>

	<div id="button">
    <img src="../../images/bt5_edit_yj1.gif" onClick="checks();" style="cursor:hand">&nbsp;&nbsp;<img border="0" src="../../images/bt5_exit_yj1.gif" style="cursor:hand" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>
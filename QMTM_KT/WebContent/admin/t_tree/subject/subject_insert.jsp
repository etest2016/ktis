<%
//******************************************************************************
//   프로그램 : subject_insert.jsp
//   모 듈 명 : 과목등록
//   설    명 : 시험관리 과목등록 팝업 페이지
//   테 이 블 : 
//   자바파일 : qmtm.ComLib
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: 신규과목 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
  
  <Script language="JavaScript">
  	function checks() {
  		if(document.frmdata.subject.value == "") {
  			alert("과목명을 등록하세요.");
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
				<Td id="mid"><div class="title">신규과목 등록 <span>새 과목을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<table style="border: 2px solid #ddd;">
			<tr height="50">
				<td>&nbsp;&nbsp;&nbsp;과목명</td>
				<td><input type="text" class="input" name="subject" size="25">&nbsp;</td>
				<td><img src="../../../images/bt5_sjinsert_yj2.gif" onClick="checks();" style="cursor:hand">&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</table>
	</div>

	<div id="button">
		<input type="image" value="취소" onclick="window.close();" src="../../../images/bt5_exit_yj1.gif">
	</div>

	</form>

 </BODY>
</HTML>
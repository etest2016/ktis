<%
//******************************************************************************
//   프로그램 : course_insert.jsp
//   모 듈 명 : 과정등록
//   설    명 : 과정등록 팝업 페이지   
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2010-06-09
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

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

%>

<HTML>
 <HEAD>
  <TITLE> :: 신규과정 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="javascript">
  	function sends() {
  		if(document.frmdata.course.value.replace(/\s/g, "")=="") {
  			alert("과정명을 입력하세요.");
  			document.frmdata.course.focus();
  			return;
  		} else {
  			document.frmdata.submit();
  		}    
  	}
  </script>
  
 </HEAD>

 <BODY id="popup2">

<form name="frmdata" method="post" action="course_insert_ok.jsp">
<input type="hidden" name="id_category" value="<%=id_category%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">신규과정 등록 <span>새 과정을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<table style="border: 2px solid #ddd;">
			<tr height="50">
				<td>&nbsp;&nbsp;&nbsp;과정명</td>
				<td><input type="text" class="input" name="course" size="20">&nbsp;</td>
				<td><img onclick="sends()" src="../../images/bt5_sjinsert_yj2_1.gif" border="0" style=cursor:hand;>&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</table>
		</div>

	
	<div id="button">
		<img onclick="window.close();" src="../../images/bt5_exit_yj1.gif" style="cursor:hand">
	</div>

	</form>

 </BODY>
</HTML>
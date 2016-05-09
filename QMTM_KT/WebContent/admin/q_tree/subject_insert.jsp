<%
//******************************************************************************
//   프로그램 : subject_insert.jsp
//   모 듈 명 : 과목등록
//   설    명 : 과목등록 팝업 페이지
//   테 이 블 : q_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil
//   작 성 일 : 2010-06-07
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (userid.length() == 0 || id_category.length() == 0 || id_course.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	// 그룹구분목록 가지고오기
	GroupKindBean[] rst = null;

	try {
		rst = GroupKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%> 

<HTML>
 <HEAD>
  <TITLE> :: 신규과목 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_subject.value == "") {
				alert("과목명을 입력하세요");
				frm.q_subject.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>

 </HEAD>

 <BODY id="popup2">
	
	<form name="frmdata" method="post" action="subject_insert_ok.jsp">
	<input type="hidden" name="id_category" value="<%=id_category%>">
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

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td width="30%" id="left">과목명</td>
				<td width="60%"><input type="text" class="input" name="q_subject" size="25"></td>
			</tr>
		</table>
		
	</div>

	<div id="button">
		<img src="../../images/bt5_sjinsert_yj2.gif" border="0" onClick="send();" style="cursor:hand">&nbsp;&nbsp;<img onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();" style="cursor:hand">
	</div>

	</form>

 </BODY>
</HTML>
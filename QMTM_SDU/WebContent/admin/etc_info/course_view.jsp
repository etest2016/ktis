<%
//******************************************************************************
//   프로그램 : course_view.jsp
//   모 듈 명 : 과정확인
//   설    명 : 과정확인 팝업 페이지
//   테 이 블 : c_course
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean
//   작 성 일 : 2013-02-06
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory = ""; } else { id_midcategory = id_midcategory.trim(); }

	if (id_course.length() == 0 || id_midcategory.length() == 0 || id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	CourseKindBean rst = null; 

	try {
		rst = CourseKindUtil.getBean(id_midcategory, id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	String yn_valid = "";
	if(rst.getYn_valid().equals("Y")) {
		yn_valid = "공개";
	} else {
		yn_valid = "비공개";
	}
%>

<script language="javascript">
	
	function edits() {
		location.href = "course_edit.jsp?id_category=<%=id_category%>&id_midcategory=<%=id_midcategory%>&id_course=<%=id_course%>";
	}

	function dels() {
		location.href = "course_delete.jsp?id_course=<%=id_course%>";
	}

</script>

<HTML>
<HEAD>
<TITLE> 과정정보 확인 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과정정보 확인 <span>과정확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">대영역명</td>
				<td width="220"><%=rst.getCategory()%></td>
			</tr>
			<tr>
				<td id="left">소영역명</td>
				<td width="220"><%=rst.getMidcategory()%></td>
			</tr>
			<tr>
				<td id="left">과정명</td>
				<td width="220"><%=rst.getCourse()%></td>
			</tr>
			<tr>
				<td id="left">정렬순서</td>
				<td width="220"><%=rst.getOrders()%></td>
			</tr>
			<tr>
				<td id="left">공개여부</td>
				<td><%=yn_valid%></td>
			</tr>
			<tr>
				<td id="left">등록일자</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
	</div>

<div id="button">
	<input type="button" value="수정하기" class="form" onClick="edits();">&nbsp;&nbsp;<input type="button" value="삭제하기" class="form" onClick="dels();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
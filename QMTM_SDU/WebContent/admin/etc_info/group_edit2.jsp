<%
//******************************************************************************
//   프로그램 : group_edit2.jsp
//   모 듈 명 : 소영역구분 수정
//   설    명 : 소영역구분 수정 페이지
//   테 이 블 : c_midcateogry
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, 
//              qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory= ""; } else { id_midcategory = id_midcategory.trim(); }

	if (id_midcategory.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	

	MidCategoryBean rst = null;

    try {
	    rst = MidCategoryUtil.getBean(id_midcategory);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	// 대영역목록 가지고오기
	CategoryBean[] rst2 = null;

	try {
		rst2 = CategoryUtil.getParentCategory();
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 대영역 수정 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.midcategory.value == "") {
				alert("소대영역명을 입력하세요");
				frm.midcategory.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="group_update2.jsp">
<input type="hidden" name="id_midcategory" value="<%=id_midcategory%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대영역수정 <span> 대영역 정보수정</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
		<tr>
			<td id="left">대영역선택</td>
			<td width="200">
			<select name="id_category">
			<% if(rst2 == null) { %>
				<option value=""></option>
			<% 
				} else { 
					for(int i = 0; i < rst2.length; i++) {
			%>
				<option value="<%=rst2[i].getId_category()%>" <% if(rst.getId_category().equals(rst2[i].getId_category())) { %>selected<% } %>><%=rst2[i].getCategory()%></option>
			<% 
					}
				} 
			%>
			</select>
			</td>
		</tr>
		<tr>
			<td id="left">소영역코드</td>
			<td width="200"><%=id_midcategory%></td>
		</tr>
		<tr>
			<td id="left">소영역명</td>
			<td><input type="text" class="input" name="midcategory" size="25" value="<%=rst.getMidcategory()%>" style="ime-mode:active;"></td>
		</tr>
		<tr>
			<td id="left">정렬순서</td>
			<td><select name="orders">
			<% for(int i = 1; i <= 15; i++) { %>	
				<option value="<%=i%>" <% if(rst.getOrders() == i) { %>selected<% } %>><%=i%></option>
			<% } %>
			</td>
		</tr>
		<tr>
			<td id="left">공개여부</td>
			<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) {%>checked<%}%>> 공개&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N"<%if(rst.getYn_valid().equals("N")) {%>checked<%}%>> 비공개</td>
		</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="수정하기" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
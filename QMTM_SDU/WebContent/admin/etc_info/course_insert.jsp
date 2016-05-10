<%
//******************************************************************************
//   프로그램 : course_insert
//   모 듈 명 : 과정 등록
//   설    명 : 과정 등록 페이지
//   테 이 블 : 
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, 
//              qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil,
//              qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil 
//   작 성 일 : 2013-01-21
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

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 대영역목록 가지고오기
	CategoryBean[] rst = null;

	// 대영역코드 정보 가져오기
	try {
		rst = CategoryUtil.getParentCategory();
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: 과정 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("대영역을 선택하세요");				
				return;
			} else if(frm.id_midcategory.value == "") {
				alert("소영역을 선택하세요");				
				return;
			} else if(frm.course.value == "") {
				alert("과정명을 입력하세요");
				frm.course.focus();
				return;
			} else if(frm.orders.value == "") {
				alert("정렬순서를 선택하세요");				
				return;
			} else {
				frm.submit();
			}
		}

		var category1;

		// 소영역 기준코드정보 가지고오기
		function get_category_list(strs) {			

			category1 = new ActiveXObject("Microsoft.XMLHTTP");
			category1.onreadystatechange = get_category_list_callback;
			category1.open("GET", "midcategory.jsp?id_category="+strs+"&id_midcategory=''", true);
			category1.send();
		}

		function get_category_list_callback() {

			if(category1.readyState == 4) {
				if(category1.status == 200) {
					if(typeof(document.all.div_category) == "object") {
						document.all.div_category.innerHTML = category1.responseText;
					}
				}
			}
		}

		var order1;

		// 과정 정렬순서 가지고오기
		function get_order_list(strs) {
			
			order1 = new ActiveXObject("Microsoft.XMLHTTP");
			order1.onreadystatechange = get_order_list_callback;
			order1.open("GET", "orderCnt.jsp?id_midcategory="+strs, true);
			order1.send();
		}

		function get_order_list_callback() {
			if(order1.readyState == 4) {
				if(order1.status == 200) {
					if(typeof(document.all.div_order) == "object") {
						document.all.div_order.innerHTML = order1.responseText;
					}
				}
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="course_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과정 등록 <span> 과정코드를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
		<tr>
			<td id="left">대영역선택</td>
			<td width="200">
			<select name="id_category" style="width:200" onChange="get_category_list(this.value);">
			<% if(rst == null) { %>
				<option value=""></option>
			<% 
				} else { 
			%>
				<option value="">대영역을 선택하세요</option>
			<%
					for(int i = 0; i < rst.length; i++) {
			%>
				<option value="<%=rst[i].getId_category()%>"><%=rst[i].getCategory()%></option>
			<% 
					}
				} 
			%>
			</select>
			</td>
		</tr>
		<tr>
			<td id="left">소영역선택</td>
			<td width="200">
			<div  style="float: left;" id="div_category"><select name="id_midcategory" style="width:200" onChange="get_order_list(this.value);">
				<option value="">소영역을 선택하세요</option>
			</select></div>
			</td>
		</tr>			
		<tr>
			<td id="left">과정명</td>
			<td><input type="text" class="input" name="course" size="32" style="ime-mode:active;"></td>
		</tr>
		<tr>
			<td id="left">정렬순서</td>
			<td>
			<div  style="float: left;" id="div_order"><select name="orders">
				<option value="">선택</option>
			</select></div>
			</td>
		</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="등록하기" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
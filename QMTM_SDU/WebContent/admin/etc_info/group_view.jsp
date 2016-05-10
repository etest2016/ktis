<%
//******************************************************************************
//   프로그램 : group_view.jsp
//   모 듈 명 : 대영역구분 확인
//   설    명 : 대영역구분 확인 페이지
//   테 이 블 : c_cateogry
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil
//   작 성 일 : 2010-06-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	CategoryBean rst = null;

    try {
	    rst = CategoryUtil.getBean(id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="group_edit.jsp?id_category=<%=id_category%>";
	}
	
	//--  삭제체크
    function deletes()  {
       var st = confirm("*주의* 대영역을 삭제하시겠습니까?" );
       if (st == true) {
           document.location = "group_delete.jsp?id_category=<%=id_category%>";
       }
    }
</script>
<html>
<head>
	<title>:: 대영역 확인 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대영역 확인 <span> 대영역 확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">대영역코드</td>
				<td width="200"><%=id_category%></td>
			</tr>
			<tr>
				<td id="left">대영역명</td>
				<td><%=rst.getCategory()%></td>
			</tr>
			<tr>
				<td id="left">공개여부</td>
				<td><%if(rst.getYn_valid().equals("Y")) {%>공개<%} else {%>비공개<%}%></td>
			</tr>
			<tr>
				<td id="left">등록일자</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="수정하기" class="form" onClick="edits();">&nbsp;&nbsp;<input type="button" value="삭제하기" class="form" onClick="deletes();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
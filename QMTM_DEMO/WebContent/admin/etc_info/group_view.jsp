<%
//******************************************************************************
//   프로그램 : exam_kind_view.jsp
//   모 듈 명 : 그룹구분확인
//   설    명 : 그룹구분확인 팝업 페이지
//   테 이 블 : r_exam_kind
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil
//   작 성 일 : 2010-06-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	GroupKindBean rst = null;

    try {
	    rst = GroupKindUtil.getBean(id_category);
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
       var st = confirm("*주의* 분야를 삭제하시겠습니까?" );
       if (st == true) {
           document.location = "group_delete.jsp?id_category=<%=id_category%>";
       }
    }
</script>
<html>
<head>
	<title>:: 분야그룹 확인 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">분야그룹 확인 <span> 분야그룹 확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">분야코드</td>
				<td width="200"><%=id_category%></td>
			</tr>
			<tr>
				<td id="left">분야명</td>
				<td><%=rst.getCategory()%></td>
			</tr>
			<tr>
				<td id="left">등록일자</td>
				<td><%=rst.getRegdate()%></textarea></td>
			</tr>
	</table>
</div>

<div id="button">
<a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
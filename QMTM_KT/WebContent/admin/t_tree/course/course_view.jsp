<%
//******************************************************************************
//   프로그램 : course_view.jsp
//   모 듈 명 : 과정확인
//   설    명 : 과정확인 팝업 페이지
//   테 이 블 : c_course
//   자바파일 : qmtm.admin.TmanTreeBean, qmtm.admin.TmanTree
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if (id_course.length() == 0 || id_category.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	
	// 과정정보 가지고오기
	TmanTreeBean rst = null;

    try {
	    rst = TmanTree.getBean(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	String yn_valid = "";
	if(rst.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "공개";
	} else {
		yn_valid = "비공개";
	}
%>

<script language="javascript">
	function sub_edit() {
		location.href="course_edit.jsp?id_category=<%=id_category%>&id_course=<%=id_course%>";
	}
	
	//--  과정 삭제체크
    function sub_delete()  {
       var st = confirm("*주의* 과정정보를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "course_delete.jsp?id_course=<%=id_course%>";
       }
    }
</script>

<HTML>
<HEAD>
<TITLE> 과정정보 확인 </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">
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
				<td id="left">과정명</td>
				<td width="200"><%=rst.getCourse()%></td>
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
<!--<input type="button" value="수정하기" onClick="sub_edit();">--><a href="javascript:sub_edit();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="삭제하기" onClick="sub_delete();">--><a href="javascript:sub_delete();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="창닫기" onClick="window.close();">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
<%
//******************************************************************************
//   프로그램 : q_standarda_view.jsp
//   모 듈 명 : 대분류구분 확인
//   설    명 : 대분류구분 확인 페이지
//   테 이 블 : q_standard_a
//   자바파일 : qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_standarda = request.getParameter("id_standarda");
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	if (id_standarda.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	QstandardABean rst = null;

    try {
	    rst = QstandardAUtil.getBean(id_standarda);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="group_edit.jsp?id_standarda=<%=id_standarda%>";
	}
	
	//--  삭제체크
    function deletes()  {
       var st = confirm("*주의* 대영역을 삭제하시겠습니까?" );
       if (st == true) {
           document.location = "group_delete.jsp?id_standarda=<%=id_standarda%>";
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
				<td width="200"><%=id_standarda%></td>
			</tr>
			<tr>
				<td id="left">대영역명</td>
				<td><%=rst.getStandarda()%></td>
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
<a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
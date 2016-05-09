<%
//******************************************************************************
//   프로그램 : q_use_view.jsp
//   모 듈 명 : 문제용도확인
//   설    명 : 문제용도확인 팝업 페이지
//   테 이 블 : r_q_use
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   작 성 일 : 2010-06-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_use = request.getParameter("id_q_use");
	if (id_q_use == null) { id_q_use= ""; } else { id_q_use = id_q_use.trim(); }

	if (id_q_use.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	QuseBean rst = null;

    try {
	    rst = QuseUtil.getBean(id_q_use);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="q_use_edit.jsp?id_q_use=<%=id_q_use%>";
	}
	
	//--  삭제체크
    function deletes()  {
       var st = confirm("*주의* 문제용도를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "q_use_delete.jsp?id_q_use=<%=id_q_use%>";
       }
    }
</script>
<html>
<head>
	<title>:: 문제용도 확인 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제용도 확인 <span> 문제용도 정보확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">코드</td>
				<td width="200"><%=id_q_use%></td>
			</tr>
			<tr>
				<td id="left">문제용도</td>
				<td><%=rst.getQ_use()%></td>
			</tr>
			<tr>
				<td id="left">설명</td>
				<td><textarea name="rmk" rows="3" cols="25" readonly><%=ComLib.nullChk(rst.getRmk())%></textarea></td>
			</tr>
	</table>
	</div>

<div id="button">
<a href="javascript:edits();" onfocus="this.blur();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();" onfocus="this.blur();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();" onfocus="this.blur();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
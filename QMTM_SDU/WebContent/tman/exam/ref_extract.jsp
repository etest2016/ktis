<%
//******************************************************************************
//   프로그램 : ref_extract.jsp
//   모 듈 명 : 문제 지문추출 등록 페이지
//   설    명 : 문제 지문추출 문제수, 배점 등록 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-07-24
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	int orders = Integer.parseInt(request.getParameter("orders"));
	int refCnt = Integer.parseInt(request.getParameter("refCnt")); // 지문에 포함된 문제수
	int refGroupCnt = Integer.parseInt(request.getParameter("refGroupCnt")); // 지문 그룹수
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt")); // 지문문제 Index
	int orderCnt2 = Integer.parseInt(request.getParameter("orderCnt2")); // 일반문제 Index

	int q_counts = Integer.parseInt(request.getParameter("q_counts"));
	double allots = Double.parseDouble(request.getParameter("allots"));

%>

<html>
<head>
	<title>문제 추출</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">
	function extract_send() {
		var firstWin = window.opener; 
		var frm = document.extract_form;

		var refCnt = <%=refCnt%>;
		var refGroupCnt = <%=refGroupCnt%>;
		var q_counts = <%=q_counts%>;
		var allots = <%=allots%>;
		var orderCnt = <%=orderCnt%>;
		var orderCnt2 = <%=orderCnt2%>;
		var orders = <%=orders%>;

		var all_qcnt = 0;
		var all_score = 0;

		if(frm.refCnt.value == "") {
			alert("추출할 지문 그룹수를 입력하세요.");
			frm.refCnt.focus();
			return;
		}
		
		for(var i=0; i<orderCnt; i++) {
			if(i != orders) {
				all_qcnt = all_qcnt + (Number(eval("firstWin.document.form1.ref_qs"+i+".value")) * Number(eval("firstWin.document.form1.qs"+i+".value")));
				all_score = all_score + (Number(eval("firstWin.document.form1.ref_score"+i+".value")) * (Number(eval("firstWin.document.form1.ref_qs"+i+".value")) * Number(eval("firstWin.document.form1.qs"+i+".value"))));
			}
		}

		for(var j=0; j<orderCnt2; j++) {
			all_qcnt = all_qcnt + Number(eval("firstWin.document.form1.ch_qs"+j+".value"));
			all_score = all_score + (Number(eval("firstWin.document.form1.ch_score"+j+".value")) * Number(eval("firstWin.document.form1.ch_qs"+j+".value")));
		}

		all_qcnt = all_qcnt + (Number(frm.refCnt.value) * refCnt);
		all_score = all_score + ((Number(frm.refCnt.value) * refCnt) * Number(frm.refAllott.value));

		if(Number(frm.refCnt.value) > refGroupCnt) {
			alert("추출가능한 지문 그룹수보다 큰 그룹수를 입력하셨습니다. \n\n추출가능한 지문 그룹수를 확인하시고 다시 입력해주세요.");
			return;
		}

		if(frm.refAllott.value == "") {
			alert("문제별 배점을 입력하세요.");
			frm.refAllott.focus();
			return;
		}
		
		if(all_qcnt > q_counts) {
			alert("현재 입력한 총 문제수는 " +all_qcnt+"문제 입니다.\n\n 해당시험에 출제문제수는 " +q_counts+"문제여야 합니다.");
			frm.refCnt.value = "";
			return;
		}

		if(all_score > allots) {
			alert("현재 입력한 총 배점은 " +all_score+"점 입니다.\n\n해당시험에 배점은 " +allots+"점이어야 합니다.");
			frm.refAllott.value = "";
			return;
		}
		
		firstWin.document.form1.ref_qs<%=orders%>.value = frm.refCnt.value;
		firstWin.document.form1.ref_score<%=orders%>.value = frm.refAllott.value;
		firstWin.document.form1.qcnts4.value = all_qcnt;
		firstWin.document.form1.qcnts5.value = all_score;

		window.close(this);
	}
</script>
</head>

<BODY id="tman">
	<form name="extract_form">
	<table border=0 width="320" height="150" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" valign="middle">
		<tr bgcolor="#FFFFFF" height="40">
			<td align="right" width="70%" valign="middle" bgcolor="#DBDBDB">추출할 지문그룹 수&nbsp;(지문 그룹수 : <b><%=refGroupCnt%></b>)&nbsp;</td>
			<td align="left">&nbsp;&nbsp;<input type="text" class="input" name="refCnt" size="4"> 그룹</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="40">
			<td align="right" width="70%" valign="middle" bgcolor="#DBDBDB">문제별 배점&nbsp;(추출문제별 배점)&nbsp;</td>
			<td align="left">&nbsp;&nbsp;<input type="text" class="input" name="refAllott" size="4"> 점</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="40">
			<td align="center" valign="middle" colspan="2"><input type="button" value="확인하기" onClick="extract_send()">&nbsp;&nbsp;<input type="button" value="취소하기" onclick="window.close();"></td>
		</tr>
	</table>
	</form>

</body>

</html>

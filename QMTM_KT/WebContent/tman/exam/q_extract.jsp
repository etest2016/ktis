<%
//******************************************************************************
//   프로그램 : q_extract.jsp
//   모 듈 명 : 문제 추출 등록 페이지
//   설    명 : 문제 추출 문항수, 배점 등록 페이지
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

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	int orders = Integer.parseInt(request.getParameter("orders"));
	int qCnt = Integer.parseInt(request.getParameter("qCnt"));
	int orderCnt = Integer.parseInt(request.getParameter("orderCnt"));
	int orderCnt2 = Integer.parseInt(request.getParameter("orderCnt2"));

	int q_counts = Integer.parseInt(request.getParameter("q_counts"));
	double allots = Double.parseDouble(request.getParameter("allots"));
%>

<html>
<head>
	<title>문제 추출</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">
	function extract_send() {
		var firstWin = window.opener; 
		var frm = document.extract_form;

		var qCnt = <%=qCnt%>;
		var q_counts = <%=q_counts%>;
		var allots = <%=allots%>;
		var orderCnt = <%=orderCnt%>;
		var orderCnt2 = <%=orderCnt2%>;
		var orders = <%=orders%>;

		var all_qcnt = 0;
		var all_score = 0;

		if(frm.qCnt.value == "") {
			alert("추출할 문항수를 입력하세요.");
			frm.qCnt.focus();
			return;
		}
		
		for(var i=0; i<orderCnt; i++) {
			if(i != orders) {
				all_qcnt = all_qcnt + Number(eval("firstWin.document.form1.ch_qs"+i+".value"));
				all_score = all_score + (Number(eval("firstWin.document.form1.ch_score"+i+".value")) * Number(eval("firstWin.document.form1.ch_qs"+i+".value")));
			}
		}

		for(var j=0; j<orderCnt2; j++) {
			all_qcnt = all_qcnt + (Number(eval("firstWin.document.form1.ref_qs"+j+".value")) * Number(eval("firstWin.document.form1.qs"+j+".value")));
			all_score = all_score + (Number(eval("firstWin.document.form1.ref_score"+j+".value")) * (Number(eval("firstWin.document.form1.ref_qs"+j+".value")) * Number(eval("firstWin.document.form1.qs"+j+".value"))));
		}

		all_qcnt = all_qcnt + Number(frm.qCnt.value);
		all_score = all_score + (Number(frm.qCnt.value) * Number(frm.qAllott.value));

		if(Number(frm.qCnt.value) > qCnt) {
			alert("추출가능한 문항수보다 큰 문항수를 입력하셨습니다. \n\n추출가능한 문항수를 확인하시고 다시 입력해주세요.");
			return;
		}

		if(frm.qAllott.value == "") {
			alert("배점을 입력하세요.");
			frm.qAllott.focus();
			return;
		}
		
		if(all_qcnt > q_counts) {
			alert("현재 입력한 총 문항수는 " +all_qcnt+"문항 입니다.\n\n 해당시험에 출제문항수는 " +q_counts+"문항이어야 합니다.");
			frm.qCnt.value = "";
			return;
		}

		if(all_score > allots) {
			alert("현재 입력한 총 배점은 " +all_score+"점 입니다.\n\n해당시험에 배점은 " +allots+"점이어야 합니다.");
			frm.qAllott.value = "";
			return;
		}
		
		firstWin.document.form1.ch_qs<%=orders%>.value = frm.qCnt.value;
		firstWin.document.form1.ch_score<%=orders%>.value = frm.qAllott.value;
		firstWin.document.form1.qcnts4.value = all_qcnt;
		firstWin.document.form1.qcnts5.value = all_score;

		window.close(this);
	}
</script>
</head>

<BODY id="popup2">
	<form name="extract_form">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문항 추출 </div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
 
	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td width="65%" id="left">추출 문항수&nbsp;(총 문항수 : <b><%=qCnt%></b>)&nbsp;</td>
				<td >&nbsp;&nbsp;<input type="text" class="input" name="qCnt" size="4"> 문항</td>
			</tr>
			<tr>
				<td width="65%" id="left">배점&nbsp;(추출문항별 배점)&nbsp;</td>
				<td>&nbsp;&nbsp;<input type="text" class="input" name="qAllott" size="4"> 점</td>
			</tr>
		</table>
	<div>

	<div id="button">
		<img src="../../images/bt_exam_list_yj1.gif" onfocus="this.blur();" onClick="extract_send();" style="cursor:hand">&nbsp;
		<img onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();" style="cursor:hand">
	</div>
		
	</form>
	
</body>

</html>

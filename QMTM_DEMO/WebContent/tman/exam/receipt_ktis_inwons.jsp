<%
//******************************************************************************
//   프로그램 : receipt_inwons.jsp
//   모 듈 명 : 접수인원
//   설    명 : 접수인원 페이지
//   테 이 블 : exam_receipt, qt_userid
//   자바파일 : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//              qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//              qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//              qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   작 성 일 : 2008-06-23
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*, java.util.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	String pvalue = request.getParameter("pvalue");
	String groups = request.getParameter("groups");
	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	GroupUserBean[] rst = null;
	
	if (pvalue != null) {
		try {
			rst = GroupUser.getBeans(pvalue, "name");
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));
	
		    if(true) return;
		}
	}

	int search_inwon = 0;
	
	if(rst == null) {
		search_inwon = 0;
	} else {
		search_inwon = rst.length;
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: 조직 대상자 검색 :: </TITLE>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">

	 function Sends() {
		if(document.form1.pvalue.value == "") {
			alert("검색할 조직명이나 조직코드를 입력해 주십시오.");
			return;
		} 

		document.form1.submit();
	 }
  
	function check_enable() {
		var frmx = document.form1;
		
		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = true;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = true;
			 }
		 }
	 }

	 function check_disable() {
		var frmx = document.form1;
		
		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = false;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = false;
			 }
		}
	 }

	 function q_delete() {
		
		var frmx = document.form1;
		
		var selectId = "";
		var k = 0;

		if(frmx.userid.length == undefined) {
			 if(frmx.userid.checked == true) {
				 selectId = selectId + frmx.userid.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 if (frmx.userid[i].checked == true) {
					selectId = selectId + frmx.userid[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
		    alert("삭제할 대상자를 선택해주세요.");
		 } else {
		    var st = confirm("이미 시험에 응시한 대상자는 삭제되지 않습니다.\n\n선택한 대상자를 삭제하시겠습니까?" );

			if (st == true) {
				location.href="receipt_inwons_delete.jsp?id_exam=<%=id_exam%>&inwons="+selectId.substring(0,selectId.length-1);			
		  	}
	     }
	}

  </Script>
   
</HEAD>

<BODY id="popup2">

	<form name="form1" method="post" action="receipt_ktis_inwons.jsp">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">조직 대상자 검색<span>조직정보를 검색하여 대상자를 등록 합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="100"><li>조직검색</td>
				<td>
					<select name="groups">
						<option value="id">조직명</option>
						<option value="name">조직코드</option>
					</select>
					&nbsp;&nbsp;
					<input type="text" name="pvalue" size="40">
					<input type="button" value="검색" onClick="Sends();" class="form5"></td>
			</tr>	
		</table>
		</div>
	</div>	

	<div id="contents">
		
		<table border="0" width="100%" style="margin-bottom: 0px;">
			<tr>
				<Td height="5"></td>
			</tr>
			<tr>
				<td align="left"><input type="button" value="전체선택" class="form3" onClick="check_enable();">&nbsp;&nbsp;<input type="button" value="전체해제" class="form3"  onClick="check_disable();">&nbsp;&nbsp;&nbsp;<input type="button" value="선택대상자등록" onclick="q_delete();" class="form"></td>
				<td align="right">검색된 인원은 총 <b><font color="red"><%=search_inwon%></font></b> 명 입니다.</td>
			</tr>
		</table>
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">선택</td>
				<td width="6%">NO</td>
				<td width="14%">아이디</td>
				<td width="15%">성명</td>
				<td width="30%">조직코드</td>
				<td width="30%">조직명</td>
			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:360px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="7">검색된 대상자가 없습니다.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
				%>
				<tr id="td" align="center">
					<td width="5%"><input type="checkbox" name="userid" value="<%=rst[i].getSabun()%>"></td>
					<td width="6%">&nbsp;<%=i+1%></td>
					<td width="14%"><%=rst[i].getSabun()%></td>					
					<td width="15%"><%=rst[i].getUser_name()%></td>
					<td width="30%"><%=rst[i].getDept_id()%></td>
					<td width="30%"><%=rst[i].getDept_name()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		</div>

	</div>

	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
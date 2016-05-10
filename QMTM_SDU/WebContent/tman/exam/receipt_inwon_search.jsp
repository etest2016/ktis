<%
//******************************************************************************
//   프로그램 : receipt_inwon_search.jsp
//   모 듈 명 : 대상자 검색
//   설    명 : 대상자 검색 페이지
//   테 이 블 : exam_receipt, qt_userid
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean
//   작 성 일 : 2013-02-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }

	ReceiptBean[] rst = null;
	
	if(!str.equals("")) {
		if(!str.equals("")) {
			str = ComLib.htmlDel(str);
			str = str.toLowerCase().replaceAll("script","");
			str = str.toLowerCase().replaceAll("union","");
			str = str.toLowerCase().replaceAll("select","");
			str = str.toLowerCase().replaceAll("update","");
			str = str.toLowerCase().replaceAll("delete","");
			str = str.toLowerCase().replaceAll("insert","");
			str = str.toLowerCase().replaceAll("drop","");
			str = str.toLowerCase().replaceAll("'","");
			str = str.toLowerCase().replaceAll(";","");
			str = str.toLowerCase().replaceAll("--","");
			str = str.toLowerCase().replaceAll("||","");		
		}
		
		try {
			rst = ReceiptUtil.getSearch(id_exam, field, str);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		int receipt_inwon = 0;
		
		if(rst == null) {
			receipt_inwon = 0;
		} else {
			receipt_inwon = rst.length;
		}
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: 대상자 검색 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
	function Sends() {
		if(document.form1.file.value == "") {
			alert("대상자 등록할 파일을 선택해주세요.");
			return;
		} 

		var str = confirm("해당 시험에 대상자를 등록합니다.\n\n등록할 대상자가 많을경우 시간이 오래걸릴수 있습니다.\n\n대상자를 등록하시겠습니까?");

		if(str) {
			document.forms1.submit();
		}
    }
	
	function check_enable() {
		var frmx = document.forms1;

		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = true;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = true;
			 }
		 }
	 }

	 function check_disable() {
		var frmx = document.forms1;
		
		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = false;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = false;
			 }
		}
	 }

	 function member_reg() {
		
		var frmx = document.forms1;
		
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
		    alert("추가할 대상자를 선택해주세요.");			
		 } else {
		    document.forms1.inwons.value = selectId.substring(0,selectId.length-1);				
			document.forms1.action = 'receipt_member_reg.jsp';
			document.forms1.method = 'post';
			document.forms1.submit();		  	
	     }
	}
	 
  </Script>
   
</HEAD>

<BODY id="popup2">

	<form name="forms1" method="post">
		<input type="hidden" name="id_exam" value="<%=id_exam%>">
		<input type="hidden" name="inwons">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대상자 검색등록<span>검색되어진 대상자를 일괄 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="150"><li>대상자 검색</td>
				<td colspan="3"><select name="field">
				<option value="name">성명</option>
				<option value="userid">아이디</option>
				</select>&nbsp;<input type="text" name="str" size="15" class="input">
				&nbsp;<input type="submit" value="검색하기" class="form"></td>				
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
				<td align="left"><input type="button" value="전체선택" class="form2" onClick="check_enable();">&nbsp;&nbsp;<input type="button" value="전체제거" class="form2" onClick="check_disable();">&nbsp;&nbsp;&nbsp;<input type="button" value="대상자등록" class="form6" onClick="member_reg();"></td>
				<td align="right"></td>
			</tr>
		</table>
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">선택</td>
				<td width="5%">NO</td>
				<td width="15%">아이디</td>
				<td width="15%">성명</td>
				<td width="25%">소속1</td>
				<td width="25%">소속2</td>
				<td width="10%">직급</td>				
			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:360px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="7">등록된 대상자가 없습니다.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
				%>
				<tr id="td" align="center">					
					<td width="5%"><input type="checkbox" name="userid" value="<%=rst[i].getUserid()%>"></td>
					<td width="5%">&nbsp;<%=i+1%></td>
					<td width="15%"><a href="javascript:" onClick="receipt_edit('<%=rst[i].getUserid()%>');"><%=rst[i].getUserid()%></a></td>					
					<td width="15%"><%=rst[i].getName()%></td>
					<td width="25%"><%=rst[i].getSosok1()%></td>
					<td width="25%"><%=rst[i].getSosok2()%></td>
					<td width="10%"><%=rst[i].getLevel()%></td>					
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
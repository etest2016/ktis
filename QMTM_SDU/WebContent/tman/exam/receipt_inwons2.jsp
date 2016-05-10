<%
//******************************************************************************
//   프로그램 : receipt_inwons2.jsp
//   모 듈 명 : 대상자인원
//   설    명 : 대상자인원 페이지
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

	String id_course = request.getParameter("id_course");	
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }	
	
	String course_year = request.getParameter("course_year");	
	if (course_year == null) { course_year= ""; } else { course_year = course_year.trim(); }	
	
	String course_no = request.getParameter("course_no");	
	if (course_no == null) { course_no = ""; } else { course_no = course_no.trim(); }	

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }
	
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

	ReceiptBean[] rst = null;

	try {
		rst = ReceiptUtil.getBeans2(id_exam, field, str);
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
%>

<HTML>
 <HEAD>
  <TITLE> :: 과정 대상자 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <Script language="JavaScript">
	
	function receipt_import() {
		window.open("receipt_import.jsp?id_exam=<%=id_exam%>&id_course=<%=id_course%>&id_subject=<%=id_subject%>&course_year=<%=course_year%>&course_no=<%=course_no%>", "imports", "width=1, height=1");
	}
  
  	function check_enable() {
		var frmx = document.form2;

		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = true;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = true;
			 }
		 }
	 }

	 function check_disable() {
		var frmx = document.form2;
		
		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = false;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = false;
			 }
		}
	 }

	 function receipt_delete() {
		
		var frmx = document.form2;
		
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
				document.forms1.inwons.value = selectId.substring(0,selectId.length-1);				
				document.forms1.action = 'receipt_inwons_delete.jsp';
				document.forms1.method = 'post';
				document.forms1.submit();				
		  	}
	     }
	}
	
	function inwon_list() {
		location.href = "receipt_inwons2.jsp?id_exam=<%=id_exam%>";
	}
	
  </Script>
   
</HEAD>

<BODY id="popup2">

	<form name="forms1">
		<input type="hidden" name="id_exam" value="<%=id_exam%>">
		<input type="hidden" name="id_course" value="<%=id_course%>">
		<input type="hidden" name="id_subject" value="<%=id_subject%>">
		<input type="hidden" name="inwons">
	</form>
		
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">과정 대상자 등록</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	
	<div id="contents"> 
		
		<table border="0" width="100%" style="margin-bottom: 0px;">
			<tr>
				<Td height="5"></td>
			</tr>
			<tr>
				<form name="form2" method="post">
				<input type="hidden" name="id_exam" value="<%=id_exam%>">
				<!-- <td align="left"><input type="button" value="전체선택" class="form2" onClick="check_enable();">&nbsp;&nbsp;<input type="button" value="전체제거" class="form2" onClick="check_disable();">&nbsp;&nbsp;<input type="button" value="대상자삭제" class="form5" onClick="receipt_delete();"></td>-->
				<td align="left">대상자 검색 <select name="field">
				<option value="a.name">성명</option>
				<option value="a.userid">아이디</option>
				</select>&nbsp;<input type="text" name="str" size="15" class="input">
				&nbsp;<input type="submit" value="검색하기" class="form"><%if(!str.equals("")) {%>&nbsp;<input type="button" value="전체대상자보기" class="form6" onClick="inwon_list();"><% } %></td>
				<!-- <td align="right"><input type="button" value="대상자 가져오기" onClick="receipt_import();" class="form5"></td>-->	
				</form>			
			</tr>
			<tr>
				<Td height="5"></td>
			</tr>			
		</table>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">NO</td>
				<td width="12%">아이디</td>
				<td width="12%">성명</td>
				<td width="20%">소속1</td>
				<td width="20%">소속2</td>
				<td width="10%">직급</td>
				<td>등록일자</td>
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
					
					<td width="5%">&nbsp;<%=i+1%></td>
					<td width="12%"><%=rst[i].getUserid()%></td>					
					<td width="12%"><%=rst[i].getName()%></td>
					<td width="20%">&nbsp;<%=rst[i].getSosok1()%></td>
					<td width="20%">&nbsp;<%=rst[i].getSosok2()%></td>
					<td width="10%">&nbsp;<%=rst[i].getLevel()%></td>
					<td>&nbsp;<%=rst[i].getRegdate()%></td>					
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
	
 </BODY>
</HTML>
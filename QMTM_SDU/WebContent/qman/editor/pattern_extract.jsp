<%
//******************************************************************************
//   프로그램 : pattern_extract.jsp
//   모 듈 명 : 패턴 추출 등록 페이지
//   설    명 : 패턴 추출 문제수, 배점 등록 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2009-11-30
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String a = request.getParameter("a");
	String b = request.getParameter("b");
	String c = request.getParameter("c");
	String d = request.getParameter("d");
	String e = request.getParameter("e");
	String f = request.getParameter("f");

	String pattern_gubun = "";

	if(a.equals("q")) {
		pattern_gubun = "문제";
	} else if(a.equals("e")) {
		pattern_gubun = "보기";
	} else if(a.equals("c")) {
		pattern_gubun = "정답";
	} else if(a.equals("p")) {
		pattern_gubun = "해설";
	} else if(a.equals("h")) {
		pattern_gubun = "힌트";
	} else if(a.equals("d")) {
		pattern_gubun = "난이도";
	} 

%>

<html>
<title>패턴 편집</title>
<head>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<script language="JavaScript">

function sends(bigos) {
	
	var firstWin = window.opener; 
	var frm = document.extract_form;

	if(bigos == "q") {		
		firstWin.document.writeForm.q1.value = frm.q1.value;
		firstWin.document.writeForm.q2.value = frm.q2.value;
		firstWin.document.writeForm.q3.value = frm.q3.value;
		firstWin.document.writeForm.q4.value = frm.q4.value;
		firstWin.document.writeForm.q5.value = frm.q5.value;
	} else if(bigos == "e") {
		firstWin.document.writeForm.e1.value = frm.e1.value;
		firstWin.document.writeForm.e2.value = frm.e2.value;
		firstWin.document.writeForm.e3.value = frm.e3.value;
		firstWin.document.writeForm.e4.value = frm.e4.value;
		firstWin.document.writeForm.e5.value = frm.q5.value;
	} else if(bigos == "c") {
		firstWin.document.writeForm.c1.value = frm.c1.value;
		firstWin.document.writeForm.c2.value = frm.c2.value;
		firstWin.document.writeForm.c3.value = frm.c3.value;
		firstWin.document.writeForm.c4.value = frm.c4.value;
		firstWin.document.writeForm.c5.value = frm.q5.value;
	} else if(bigos == "p") {
		firstWin.document.writeForm.p1.value = frm.p1.value;
		firstWin.document.writeForm.p2.value = frm.p2.value;
		firstWin.document.writeForm.p3.value = frm.p3.value;
		firstWin.document.writeForm.p4.value = frm.p4.value;
		firstWin.document.writeForm.p5.value = frm.q5.value;
	} else if(bigos == "h") {
		firstWin.document.writeForm.h1.value = frm.h1.value;
		firstWin.document.writeForm.h2.value = frm.h2.value;
		firstWin.document.writeForm.h3.value = frm.h3.value;
		firstWin.document.writeForm.h4.value = frm.h4.value;
		firstWin.document.writeForm.h5.value = frm.q5.value;
	} else if(bigos == "d") {
		firstWin.document.writeForm.d1.value = frm.d1.value;
		firstWin.document.writeForm.d2.value = frm.d2.value;
		firstWin.document.writeForm.d3.value = frm.d3.value;
		firstWin.document.writeForm.d4.value = frm.d4.value;
		firstWin.document.writeForm.d5.value = frm.q5.value;
	}

	self.close();
}

function displays(bigos, values) {
	
	var frm = document.extract_form;
	var str = "";

	if(bigos == "q") {
		if(frm.q2.value != "" && frm.q3.value != "") {
			str = frm.q1.value + frm.q2.value + "1" + frm.q4.value + "," + frm.q1.value + frm.q2.value + "2" + frm.q4.value + ",";
			str += frm.q1.value + frm.q2.value + "3" + frm.q4.value + "," + frm.q1.value + frm.q2.value + "4" + frm.q4.value + ","; 
			str += frm.q1.value + frm.q2.value + "5" + frm.q4.value + ",";			
		} else if(frm.q2.value == "" && frm.q3.value != "") {
			str = frm.q1.value + frm.q2.value + "1" + frm.q4.value + "," + frm.q1.value + frm.q2.value + "2" + frm.q4.value + ",";
			str += frm.q1.value + frm.q2.value + "3" + frm.q4.value + "," + frm.q1.value + frm.q2.value + "4" + frm.q4.value + ","; 
			str += frm.q1.value + frm.q2.value + "5" + frm.q4.value + ",";
		} else {
			str = frm.q1.value + frm.q2.value + frm.q3.value + frm.q4.value;
		}

		frm.q5.value = str;

	} else if(bigos == "e") {

		if((frm.e2.value != "" || frm.e2.value == "") && frm.e3.value != "") {
			str = frm.e1.value + frm.e2.value + frm.e3.value.substring(0,1) + frm.e4.value + ",";
			str += frm.e1.value + frm.e2.value + frm.e3.value.substring(1,2) + frm.e4.value + ",";
			str += frm.e1.value + frm.e2.value + frm.e3.value.substring(2,3) + frm.e4.value + ","; 
			str += frm.e1.value + frm.e2.value + frm.e3.value.substring(3,4) + frm.e4.value + ","; 
			str += frm.e1.value + frm.e2.value + frm.e3.value.substring(4,5) + frm.e4.value + ",";
		} else {
			str = frm.e1.value + frm.e2.value + frm.e3.value + frm.e4.value;
		}
		
		frm.q5.value = str;

	} else if(bigos == "c") {

		frm.q5.value = frm.c1.value + frm.c2.value + frm.c4.value;

	} else if(bigos == "p") {

		frm.q5.value = frm.p1.value + frm.p2.value + frm.p4.value;

	} else if(bigos == "h") {

		frm.q5.value = frm.h1.value + frm.h2.value + frm.h4.value;

	} else if(bigos == "d") {

		frm.q5.value = frm.d1.value + frm.d2.value + frm.d4.value;

	}
}

</script>

</head>

<BODY id="popup2">

	<form name="extract_form">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">패턴유형 <span><b>: <%=pattern_gubun%></b></span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
 
	<div id="contents">
	
	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">					
		<% if(a.equals("q")) { %>
		<tr>
			<td width="400">
			<select name="q1" onChange="displays('q');">
				<option value="" <%if(b.equals("")) { %>selected<% } %>></option>
				<option value="(" <%if(b.equals("(")) { %>selected<% } %>>(</option>
				<option value="{" <%if(b.equals("{")) { %>selected<% } %>>{</option>
				<option value="[" <%if(b.equals("[")) { %>selected<% } %>>[</option>
			</select>&nbsp;
			<select name="q2" onChange="displays('q');">
				<option value="문제" <%if(c.equals("문제")) { %>selected<% } %>>문제</option>
				<option value="문" <%if(c.equals("문")) { %>selected<% } %>>문</option>
			</select>&nbsp;
			<select name="q3" onChange="displays('q');">
				<option value="[0-9]" <%if(d.equals("[0-9]")) { %>selected<% } %>>[0-9]</option>
			</select>&nbsp;
			<select name="q4" onChange="displays('q');">
				<option value="" <%if(e.equals("")) { %>selected<% } %>></option>
				<option value="." <%if(e.equals(".")) { %>selected<% } %>>.</option>
				<option value=")" <%if(e.equals(")")) { %>selected<% } %>>)</option>
				<option value="}" <%if(e.equals("}")) { %>selected<% } %>>}</option>
				<option value="]" <%if(e.equals("]")) { %>selected<% } %>>]</option>
			</select>&nbsp;
			</td>
		</tr>
		<% } else if(a.equals("e")) { %>
		<tr>
			<td>
			<select name="e1" onChange="displays('e');">
				<option value="" <%if(b.equals("")) { %>selected<% } %>></option>
				<option value="(" <%if(b.equals("(")) { %>selected<% } %>>(</option>
				<option value="{" <%if(b.equals("{")) { %>selected<% } %>>{</option>
				<option value="[" <%if(b.equals("[")) { %>selected<% } %>>[</option>
			</select>&nbsp;
			<select name="e2" onChange="displays('e');">
				<option value="" <%if(c.equals("")) { %>selected<% } %>></option>
				<option value="보기" <%if(c.equals("보기")) { %>selected<% } %>>보기</option>
			</select>&nbsp;
			<select name="e3" onChange="displays('e');">
				<option value="①②③④⑤" <%if(d.equals("①②③④⑤")) { %>selected<% } %>>①②③④⑤</option>
				<option value="12345" <%if(d.equals("12345")) { %>selected<% } %>>12345</option>
				<option value="㉠㉡㉢㉣㉤" <%if(d.equals("㉠㉡㉢㉣㉤")) { %>selected<% } %>>㉠㉡㉢㉣㉤</option>
				<option value="ㄱㄴㄷㄹㅁ" <%if(d.equals("ㄱㄴㄷㄹㅁ")) { %>selected<% } %>>ㄱㄴㄷㄹㅁ</option>
				<option value="㉮㉯㉰㉱㉲" <%if(d.equals("㉮㉯㉰㉱㉲")) { %>selected<% } %>>㉮㉯㉰㉱㉲</option>
				<option value="가나다라마" <%if(d.equals("가나다라마")) { %>selected<% } %>>가나다라마</option>
				<option value="ⓐⓑⓒⓓⓔ" <%if(d.equals("ⓐⓑⓒⓓⓔ")) { %>selected<% } %>>ⓐⓑⓒⓓⓔ</option>
				<option value="abcde" <%if(d.equals("abcde")) { %>selected<% } %>>abcde</option>
				<option value="ABCDE" <%if(d.equals("ABCDE")) { %>selected<% } %>>ABCDE</option>
				<option value="갑을병정무" <%if(d.equals("갑을병정무")) { %>selected<% } %>>갑을병정무</option>
			</select>&nbsp;
			<select name="e4" onChange="displays('e');">
				<option value="" <%if(e.equals("")) { %>selected<% } %>></option>
				<option value=")" <%if(e.equals(")")) { %>selected<% } %>>)</option>
				<option value="}" <%if(e.equals("}")) { %>selected<% } %>>}</option>
				<option value="]" <%if(e.equals("]")) { %>selected<% } %>>]</option>
			</select>&nbsp;
			</td>
		</tr>
		<% } else if(a.equals("c")) { %>
		<tr>
			<td>
			<select name="c1" onChange="displays('c');">
				<option value="" <%if(b.equals("")) { %>selected<% } %>></option>
				<option value="(" <%if(b.equals("(")) { %>selected<% } %>>(</option>
				<option value="{" <%if(b.equals("{")) { %>selected<% } %>>{</option>
				<option value="[" <%if(b.equals("[")) { %>selected<% } %>>[</option>
			</select>&nbsp;
			<select name="c2" onChange="displays('c');">
				<option value="정답" <%if(c.equals("정답")) { %>selected<% } %>>정답</option>
				<option value="해답" <%if(c.equals("해답")) { %>selected<% } %>>해답</option>
				<option value="답" <%if(c.equals("답")) { %>selected<% } %>>답</option>
			</select>&nbsp;
			<select name="c3" disabled>
			</select>&nbsp;
			<select name="c4" onChange="displays('c');">
				<option value="" <%if(e.equals("")) { %>selected<% } %>></option>
				<option value=")" <%if(e.equals(")")) { %>selected<% } %>>)</option>
				<option value="}" <%if(e.equals("}")) { %>selected<% } %>>}</option>
				<option value="]" <%if(e.equals("]")) { %>selected<% } %>>]</option>
			</select>&nbsp;
			</td>
		</tr>
		<% } else if(a.equals("p")) { %>
		<tr>
			<td>
			<select name="p1" onChange="displays('p');">
				<option value="" <%if(b.equals("")) { %>selected<% } %>></option>
				<option value="(" <%if(b.equals("(")) { %>selected<% } %>>(</option>
				<option value="{" <%if(b.equals("{")) { %>selected<% } %>>{</option>
				<option value="[" <%if(b.equals("[")) { %>selected<% } %>>[</option>
			</select>&nbsp;
			<select name="p2" onChange="displays('p');">
				<option value="해설" <%if(c.equals("해설")) { %>selected<% } %>>해설</option>
				<option value="정해" <%if(c.equals("정해")) { %>selected<% } %>>정해</option>
				<option value="설명" <%if(c.equals("설명")) { %>selected<% } %>>설명</option>
			</select>&nbsp;
			<select name="p3" disabled>
			</select>&nbsp;
			<select name="p4" onChange="displays('p');">
				<option value="" <%if(e.equals("")) { %>selected<% } %>></option>
				<option value=")" <%if(e.equals(")")) { %>selected<% } %>>)</option>
				<option value="}" <%if(e.equals("}")) { %>selected<% } %>>}</option>
				<option value="]" <%if(e.equals("]")) { %>selected<% } %>>]</option>
			</select>&nbsp;
			</td>
		</tr>
		<% } else if(a.equals("h")) { %>
		<tr>
			<td>
			<select name="h1" onChange="displays('h');">
				<option value="" <%if(b.equals("")) { %>selected<% } %>></option>
				<option value="(" <%if(b.equals("(")) { %>selected<% } %>>(</option>
				<option value="{" <%if(b.equals("{")) { %>selected<% } %>>{</option>
				<option value="[" <%if(b.equals("[")) { %>selected<% } %>>[</option>
			</select>&nbsp;
			<select name="h2" onChange="displays('h');">
				<option value="힌트" <%if(c.equals("힌트")) { %>selected<% } %>>힌트</option>
			</select>&nbsp;
			<select name="h3" disabled>
			</select>&nbsp;
			<select name="h4" onChange="displays('h');">
				<option value="" <%if(e.equals("")) { %>selected<% } %>></option>
				<option value=")" <%if(e.equals(")")) { %>selected<% } %>>)</option>
				<option value="}" <%if(e.equals("}")) { %>selected<% } %>>}</option>
				<option value="]" <%if(e.equals("]")) { %>selected<% } %>>]</option>
			</select>&nbsp;
			</td>
		</tr>
		<% } else if(a.equals("d")) { %>
		<tr>
			<td>
			<select name="d1" onChange="displays('d');">
				<option value="" <%if(b.equals("")) { %>selected<% } %>></option>
				<option value="(" <%if(b.equals("(")) { %>selected<% } %>>(</option>
				<option value="{" <%if(b.equals("{")) { %>selected<% } %>>{</option>
				<option value="[" <%if(b.equals("[")) { %>selected<% } %>>[</option>
			</select>&nbsp;
			<select name="d2" onChange="displays('d');">
				<option value="난이도" <%if(c.equals("난이도")) { %>selected<% } %>>난이도</option>
				<option value="중요도" <%if(c.equals("중요도")) { %>selected<% } %>>중요도</option>
			</select>&nbsp;
			<select name="d3" disabled>
			</select>&nbsp;
			<select name="d4" onChange="displays('d');">
				<option value="" <%if(e.equals("")) { %>selected<% } %>></option>
				<option value=")" <%if(e.equals(")")) { %>selected<% } %>>)</option>
				<option value="}" <%if(e.equals("}")) { %>selected<% } %>>}</option>
				<option value="]" <%if(e.equals("]")) { %>selected<% } %>>]</option>
			</select>&nbsp;
			</td>
		</tr>
		<% } %>
		<tr>
			<td height="5"></td>
		</tr>
		<tr>
			<td>적용 : <input type="text" name="q5" size="38" value="<%=f%>" class="input"></td>
		</tr>
	</table>
	
	<div>

	<div id="button">
		<img src="../../images/bt_paper_checks_yj1.gif" onfocus="this.blur();" onClick="sends('<%=a%>');">&nbsp;
		<img onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

</form>
</body>

</html>
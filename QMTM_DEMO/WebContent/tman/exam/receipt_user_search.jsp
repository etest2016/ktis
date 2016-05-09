<%
//******************************************************************************
//   프로그램 : manager_insert.jsp
//   모 듈 명 : 담당자 등록
//   설    명 : 담당자 등록 팝업 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2010-06-08
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

	String search_bigo = request.getParameter("search_bigo");
	if (search_bigo == null) { search_bigo = "1"; } else { search_bigo = search_bigo.trim(); }
		
	String field = "";
	String str = "";

	String jikmu = "";
	String jikwi = "";
	String str2 = "";

	if(search_bigo.equals("1")) {
		field = request.getParameter("Field");
		if (field == null) { field = ""; } else { field = field.trim(); }

		str = request.getParameter("Str");
		if (str == null) { str = ""; } else { str = str.trim(); }
	} else {
		jikmu = request.getParameter("jikmu");
		if (jikmu == null) { jikmu = ""; } else { jikmu = jikmu.trim(); } 

		jikwi = request.getParameter("jikwi");
		if (jikwi == null) { jikwi = ""; } else { jikwi = jikwi.trim(); } 
		
		str2 = request.getParameter("Str2");
		if (str2 == null) { str2 = ""; } else { str2 = str2.trim(); }
	}
	
	ReceiptBean[] rst = null;
	ReceiptBean[] jikwiRst = null;

	/*ReceiptBean[] jikmuRst = null;

	try {
		jikmuRst = ReceiptUtil.getJikmus();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}*/

	try {
		jikwiRst = ReceiptUtil.getJikwis();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
	
	if(search_bigo.equals("1")) {
	
		if(!str.equals("")) {
		
			try {
				rst = ReceiptUtil.getSearch(field, str);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}
		}

	} else {		
		
		if(!(jikmu.equals("") && jikwi.equals("") && str2.equals(""))) {
			
			try {
				rst = ReceiptUtil.getSearch2(jikmu, jikwi, str2);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));

				if(true) return;
			}

		}

	}

%>

<html>
<head>
	<title>:: 대상자 검색등록 :: </title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">

		function users() {
			var frm = document.frmdata;
			
			if(frm.Str.value == "") {
				alert("검색어를 입력하세요");
				frm.Str.focus();
				return false;
			} else {
				frm.submit();
			}
		}

		function users2() {
			var frm = document.frmdata;
					
			frm.submit();			
		}

		function check_enable() {
			var frmx = document.frmdata;
			
			if(frmx.userid.length == undefined) {
				 frmx.userid.checked = true;
			} else if(frmx.userid.length != undefined) {
				 for (i=0; i<=frmx.userid.length -1; i++) {
					 frmx.userid[i].checked = true;
				 }
			 }
		 }

		 function check_disable() {
			var frmx = document.frmdata;
			
			if(frmx.userid.length == undefined) {
				 frmx.userid.checked = false;
			} else if(frmx.userid.length != undefined) {
				 for (i=0; i<=frmx.userid.length -1; i++) {
					 frmx.userid[i].checked = false;
				 }
			}
		 }
		
		function send() {
		
			var frmx = document.frmdata;
			
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
				alert("등록할 대상자를 선택해주세요.");
			 } else {
				var st = confirm("선택한 대상자를 등록하시겠습니까?" );

				if (st == true) {
					document.frmdata.inwons.value = selectId.substring(0,selectId.length-1);
					document.frmdata.action = 'receipt_user_search_ok.jsp';
					document.frmdata.method = 'post';
					document.frmdata.submit();
					
					//location.href="receipt_user_search_ok.jsp?id_exam=<%=id_exam%>&inwons="+selectId.substring(0,selectId.length-1);			
				}
			 }
		}

		function search(bigo) {

			if(bigo == "1") {				
				document.all.search_set.style.display = "block";
				document.all.search_set2.style.display = "none";
			} else {
				document.all.search_set.style.display = "none";
				document.all.search_set2.style.display = "block";
			}
		}

		function inits() {
			search("<%=search_bigo%>");
		}

		function edits(userid) {
			window.open("user_edit.jsp?userid="+userid,"user_edit","width=550, height=650, scrollbars=no");
		}

	</script>
</head>

<BODY id="popup2" onLoad="inits();">

<form name="frmdata" method="post">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="inwons">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대상자 검색등록 <span>검색되어진 대상자를 일괄 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">			
			<tr>
				<td id="left" width="15%">검색 구분</td>
				<td> <input type="radio" name="search_bigo" value="1" onClick="search('1');" <%if(search_bigo.equals("1")) { %>checked<% } %>> 개별검색&nbsp;&nbsp;&nbsp;<input type="radio" name="search_bigo" onClick="search('2');" value="2" <%if(search_bigo.equals("2")) { %>checked<% } %>> 일괄검색</td>
			</tr>
			<tr>
				<td id="left" width="15%">대상자 검색</td>
				<td><div id="search_set" style="display:block"><select name="Field">
				<option value="name" <%if(field.equals("name")) { %>selected<% } %>>성명</option>
				<option value="userid" <%if(field.equals("userid")) { %>selected<% } %>>아이디</option>				
				</select>
				&nbsp;&nbsp;<input type="text" class="input" name="Str" size="15" value="<%=str%>">&nbsp;&nbsp;<input type="button" value="검색하기" class="form" onClick="users();">&nbsp;&nbsp;<input type="button" value="대상자등록" class="form4" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form4" onClick="window.close()"></div>
				<div id="search_set2" style="display:none"><select name="jikwi">
				<% if(jikwiRst == null) { %>
				<option value="">등록직위없음</option>
				<%
					} else {
				%>
				<option value="" <% if(jikwi.equals("")) { %>selected<% } %>>직위선택</option>
				<%
						for(int n=0; n<jikwiRst.length; n++) {
				%>
				<option value="<%=jikwiRst[n].getJikwi()%>" <% if(jikwi.equals(jikwiRst[n].getJikwi())) { %>selected<% } %>><%=jikwiRst[n].getJikwi()%></option>				
				<%
						}
					}
				%>				
				</select>
				&nbsp;&nbsp;직무검색 : <input type="text" class="input" name="jikmu" size="20" value="<%=jikmu%>">
				&nbsp;&nbsp;소속검색 : <input type="text" class="input" name="Str2" size="20" value="<%=str2%>">&nbsp;&nbsp;<input type="button" value="검색하기" class="form" onClick="users2();">&nbsp;&nbsp;<input type="button" value="대상자등록" class="form4" onClick="send();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form4" onClick="window.close()"></div>
				</td>
			</tr>		
		</table>

		<table border="0" width="100%" style="margin-bottom: 0px;">
			<tr>
				<Td height="5" colspan="2"></td>
			</tr>
			<tr>
				<td align="left"><img src="../../images/bt_q_list_yj1.gif" onClick="check_enable();">&nbsp;&nbsp;<img src="../../images/bt_q_list2_yj1.gif"  onClick="check_disable();"></td>
				<td align="right"><b>사번을 클릭하면 정보를 수정할 수 있습니다.</b></td>
			</tr>
		</table>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="4%">선택</td>
				<td width="4%">NO</td>
				<td width="10%">사번</td>
				<td width="10%">성명</td>
				<td width="15%">소속1</td>
				<td width="15%">소속2</td>
				<td width="15%">소속3</td>
				<td width="12%">직위</td>
				<td width="15%">직무</td>
			</tr>
		</table>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
			<% if(search_bigo.equals("1") && str.equals("")) { %>
			<tr id="td" align="center">
				<td colspan="9" class="blank">대상자를 검색하세요.</td>			
			</tr>
			<% 
				} else {
					if(rst == null) {
			%>
			<tr id="td" align="center">
				<td colspan="9" class="blank">검색되어진 대상자가 없습니다.</td>			
			</tr>
			<%
					} else {
						for(int i=0; i<rst.length; i++) {
			%>

			<tr id="td" align="center">				
				<td width="4%"><input type="checkbox" name="userid" class="form2" value="<%=rst[i].getUserid()%>"></td>
				<td width="4%"><%=i+1%></td>
				<td width="10%"><a href="javascript:edits('<%=rst[i].getUserid()%>');"><%=rst[i].getUserid()%></a></td>
				<td width="10%"><%=rst[i].getName()%></td>
				<td width="15%"><%=ComLib.nullChk(rst[i].getSosok2())%></td>
				<td width="15%"><%=ComLib.nullChk(rst[i].getSosok3())%></td>
				<td width="15%"><%=ComLib.nullChk(rst[i].getSosok4())%></td>
				<td width="12%"><%=ComLib.nullChk(rst[i].getJikwi())%></td>
				<td width="15%"><%=ComLib.nullChk(rst[i].getJikmu())%></td>
			</tr>
			<% 
						}
					}	
				}
			%>
		</table>

	</div>
	
	</form>

</BODY>
</HTML>
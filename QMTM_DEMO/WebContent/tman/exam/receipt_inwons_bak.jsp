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

<%@ include file="../../common/paging.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String tmp_page = request.getParameter("page");
	if (tmp_page == null) { tmp_page= ""; } else { tmp_page = tmp_page.trim(); }

	String url = "receipt_inwons.jsp";	

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }
	
	str = new String(str.getBytes("8859_1"),"euc-kr");

	String add_tag = "&id_exam="+id_exam+"&field="+field+"&str="+str;
    	
	int total_page = 0; // 총 페이지
    int total_count = 0; // 총 레코드 수
	int current_page = 0; // 현재 페이지
	int page_scale = 100; // 한 화면에 보여지는 게시물 수
	int remain = 0; // 페이지 계산을 위해 나머지값 계산.
	int start_rnum = 0; // 현재 페이지 게시물 시작번호
	int end_rnum = 0; // 현재 페이지 게시물 끝번호

	if(tmp_page.length() == 0) {
		current_page = 1;
	} else {
		current_page = Integer.parseInt(tmp_page);
	}
	
	try {
		total_count = ReceiptUtil.getCounts(id_exam, field, str);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	remain = total_count % page_scale;
	
	if(remain == 0) {
		total_page = total_count / page_scale;
	} else {
		total_page = total_count / page_scale + 1;
	}

    int lists = (current_page - 1) * page_scale;
	
	ReceiptBean[] rst = null;
	
	try {
		rst = ReceiptUtil.getBeans(id_exam, page_scale, lists, field, str);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: 대상자 등록 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
	function Sends() {
		if(document.form1.file.value == "") {
			alert("대상자 등록할 파일을 선택해주세요.");
			return;
		} 

		document.form1.submit();
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

	 function q_delete() {
		
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
		    alert("삭제할 대상자를 선택해주세요.");			
		 } else {
		    var st = confirm("이미 시험에 응시한 대상자는 삭제되지 않습니다.\n\n선택한 대상자를 삭제하시겠습니까?" );

			if (st == true) {																
				document.forms1.inwons.value = selectId.substring(0,selectId.length-1);
				document.forms1.action = 'receipt_inwons_delete.jsp';
				document.forms1.method = 'post';
				document.forms1.submit();
				
				//location.href="receipt_inwons_delete.jsp?id_exam=<%=id_exam%>&inwons="+selectId.substring(0,selectId.length-1);			
		  	}
	     }
	}

	function m_reg() {
		window.open("receipt_user_search.jsp?id_exam=<%=id_exam%>","m_reg","width=1000, height=550, scrollbars=yes, top=0, left=0");
	}

	function excel_down() {
		location.href = "receipt_inwons_excel.jsp?id_exam=<%=id_exam%>&field=<%=field%>&str=<%=str%>";
	}

	function lists() {
		location.href="receipt_inwons.jsp?id_exam=<%=id_exam%>";
	}
	
	function users() {
		var frm = document.frmdata;
			
		if(frm.str.value == "") {
			alert("검색어를 입력하세요");
			frm.str.focus();
			return false;
		} else {
			frm.submit();
		}
	}

  </Script>
   
</HEAD>

<BODY id="popup2">

	<form name="forms1" method="post">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="inwons">
	</form>
	
	<form name="form1" method="post" action="receipt_upload.jsp" enctype="multipart/form-data">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">대상자 등록<span>접수형 시험일경우 엑셀파일을 이용해서 대상자를 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="100"><li>엑셀파일</td>
				<td colspan="3"><input type="file" name="file" size="70" class="form2">&nbsp;&nbsp;<input type="button" value="대상자 등록" class="form5" onClick="Sends();"></td></form>
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
				<td align="left"><img src="../../images/bt_q_list_yj1.gif" onClick="check_enable();">&nbsp;&nbsp;<img src="../../images/bt_q_list2_yj1.gif"  onClick="check_disable();">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="선택대상자삭제" class="form2" onclick="q_delete();">&nbsp;&nbsp;<input type="button" value="대상자 검색등록" class="form2" onclick="m_reg();"></td>				
				<td align="right">검색된 대상자 총 <b><font color="red"><%=total_count%></font></b> 명 입니다.</td>
			</tr>
			<tr>
				<td align="right" colspan="2"><form name="frmdata" method="get"><input type="hidden" name="id_exam" value="<%=id_exam%>"><b>대상자 검색 : </b><select name="field">
				<option value="name" <%if(field.equals("name")) { %>selected<% } %>>성명</option>
				<option value="userid" <%if(field.equals("userid")) { %>selected<% } %>>아이디</option>
				<option value="company" <%if(field.equals("company")) { %>selected<% } %>>회사명</option>
				<option value="sosok1" <%if(field.equals("sosok1")) { %>selected<% } %>>소속명</option>
				</select>
				&nbsp;&nbsp;<input type="text" class="input" name="str" size="15" value="<%=str%>">&nbsp;&nbsp;<input type="button" value="검색하기" class="form" onClick="users();">&nbsp;<%if(!str.equals("")) { %><input type="button" value="전체리스트" class="form" onClick="lists();"><% } %>&nbsp;<input type="button" value="엑셀파일 다운로드" class="form" onClick="excel_down();"></td>
			</tr>
		</table>
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%" style="margin-bottom: 0px;">
			<tr id="tr">			
				<td width="4%">선택</td>
				<td width="5%">NO</td>
				<td width="9%">아이디</td>
				<td width="10%">비밀번호</td>
				<td width="10%">성명</td>
				<td width="11%">소속1</td>
				<td width="11%">소속2</td>
				<td width="11%">소속3</td>
				<td width="9%">직위</td>
				<td width="10%">직무</td>
				<td width="10%">등록일자</td>
			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:360px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="11">등록된 대상자가 없습니다.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
							int list_num = total_count - (current_page - 1) * page_scale - i;
				%>
				<tr id="td" align="center">
					<td width="4%"><input type="checkbox" name="userid" class="form2" value="<%=rst[i].getUserid()%>"></td>
					<td width="5%">&nbsp;<%=list_num%></td>
					<td width="9%"><%=rst[i].getUserid()%></td>
					<td width="10%">----</td>
					<td width="10%"><%=rst[i].getName()%></td>
					<td width="11%"><%=ComLib.nullChk(rst[i].getSosok2())%></td>
					<td width="11%"><%=ComLib.nullChk(rst[i].getSosok3())%></td>
					<td width="11%"><%=ComLib.nullChk(rst[i].getSosok4())%></td>
					<td width="9%"><%=ComLib.nullChk(rst[i].getJikwi())%></td>
					<td width="10%"><%=ComLib.nullChk(rst[i].getJikmu())%></td>
					<td width="10%"><%=rst[i].getRegdate()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		</div>

		<P>

		<table border="0" width="100%">
			<tr>
				<td align="center"><%= PageNumber(current_page, total_page, url, add_tag) %></td>
			</tr>
		</table>

	</div>

	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
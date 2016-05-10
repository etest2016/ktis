<%
//******************************************************************************
//   프로그램 : q_info_edit.jsp
//   모 듈 명 : 문제정보변경 페이지
//   설    명 : 문제정보변경 페이지
//   테 이 블 : q
//   자바파일 : qmtm.ComLib, qmtm.tman.exam.RdifficultBean, qmtm.tman.exam.RdifficultUtil, 
//              qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil, qmtm.qman.standard.QstandardABean, 
//              qmtm.qman.standard.QstandardAUtil 
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.RdifficultBean, qmtm.tman.exam.RdifficultUtil, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	
	
	String id_q_chapter = request.getParameter("id_chapter");
	if (id_q_chapter == null) { id_q_chapter = "-1"; } else { id_q_chapter = id_q_chapter.trim(); }	
	
	if (id_qs.length() == 0 || id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 난이도 정보 가지고오기
	RdifficultBean[] diff = null;

    try {
	    diff = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	// 문제용도1 가지고 오기
	QuseBean[] quse = null;

    try {
	    quse = QuseUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
%>

<html>
<head>
	<title> :: 문제정보 변경 :: </title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">

		function checks1() {
			var frm = document.form1;
			
			if(frm.q_allott.checked == true) {
				frm.q_allotts.disabled = false;
			} else {
				frm.q_allotts.value = "";
				frm.q_allotts.disabled = true;
			}
		}

		function checks2() {
			var frm = document.form1;
			
			if(frm.q_use.checked == true) {
				frm.q_uses.disabled = false;
			} else {
				frm.q_uses.value = "";
				frm.q_uses.disabled = true;
			}
		}
		
		function checks3() {
			var frm = document.form1;
			
			if(frm.q_diff.checked == true) {
				frm.q_diffs.disabled = false;
			} else {
				frm.q_diffs.value = "";
				frm.q_diffs.disabled = true;
			}
		}
		
		function checks4() {
			var frm = document.form1;
			
			if(frm.q_pub_comp.checked == true) {
				frm.q_pub_comps.disabled = false;
			} else {
				frm.q_pub_comps.value = "";
				frm.q_pub_comps.disabled = true;
			}
		}

		function checks5() {
			var frm = document.form1;
			
			if(frm.q_etc.checked == true) {
				frm.q_etcs.disabled = false;
			} else {
				frm.q_etcs.value = "";
				frm.q_etcs.disabled = true;
			}
		}
		
		function checks6() {
			var frm = document.form1;
			
			if(frm.q_kwd.checked == true) {
				frm.q_kwds.disabled = false;
			} else {
				frm.q_kwds.value = "";
				frm.q_kwds.disabled = true;
			}
		}		
		
	</script>

</head>

<BODY id="popup2">
	
	<form name="form1" method="post" action="q_info_update.jsp">

	<input type="hidden" name="id_qs" value="<%=id_qs%>">
	<input type="hidden" name="id_subject" value="<%=id_q_subject%>">
	<input type="hidden" name="id_chapter" value="<%=id_q_chapter%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">문제정보 변경 <span>문제정보를 변경합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_allott" onClick="checks1();">&nbsp;배점</td>
				<td><input type="text" class="input" name="q_allotts" size="41" disabled>
				</td>
			</tr>
			
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_use" onClick="checks2();">&nbsp;문제용도</td>
				<td><select name="q_uses" style="width:255px;" disabled>
				<option value=""></option>
				<% for(int i=0; i<quse.length; i++) { %>
					<option value="<%=quse[i].getId_q_use()%>"><%=quse[i].getQ_use()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_diff" onClick="checks3();">&nbsp;난이도</td>
				<td><select name="q_diffs" style="width:255px" disabled>
				<option value=""></option>
				<% for(int i=0; i<diff.length; i++) { %>
					<option value="<%=diff[i].getId_difficulty()%>"><%=diff[i].getDifficulty()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_pub_comp" onClick="checks4();">&nbsp;출처</td>
				<td><input type="text" class="input" name="q_pub_comps" size="41" disabled>
				</td>
			</tr>
			
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_etc" onClick="checks5();">&nbsp;비고</td>
				<td><input type="text" class="input" name="q_etcs" size="41" disabled>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_kwd" onClick="checks6();">&nbsp;검색 키워드</td>
				<td><input type="text" class="input" name="q_kwds" size="41" disabled>
				</td>
			</tr>
			
		</table>

	</div>
	<div id="button">
		<input type="image" value="문제정보변경" name="submit" src="../../images/bt_q_info_edit_yj1.gif" onfocus="this.blur();">&nbsp;&nbsp;<!--input type="button" value="창닫기" onClick="window.close();"--><a href="javascript:window.close();" onfocus="this.blur();"><img border="0" src="../../images/bt_q_search_closeyj1.gif" ></a>
	</div>

	
	

	</form>
</BODY>
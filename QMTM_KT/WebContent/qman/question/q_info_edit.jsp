<%
//******************************************************************************
//   ���α׷� : q_info_edit.jsp
//   �� �� �� : ������������ ������
//   ��    �� : ������������ ������
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.tman.exam.*
//   �� �� �� : 2008-07-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// ���̵� ���� ���������
	RdifficultBean[] diff = null;

    try {
	    diff = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	// �����뵵1 ������ ����
	QuseBean[] quse = null;

    try {
	    quse = QuseUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<html>
<head>
	<title> :: �������� ���� :: </title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

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
			
			if(frm.q_book.checked == true) {
				frm.q_books.disabled = false;
			} else {
				frm.q_books.value = "";
				frm.q_books.disabled = true;
			}
		}

		function checks5() {
			var frm = document.form1;
			
			if(frm.q_author.checked == true) {
				frm.q_authors.disabled = false;
			} else {
				frm.q_authors.value = "";
				frm.q_authors.disabled = true;
			}
		}

		function checks6() {
			var frm = document.form1;
			
			if(frm.q_page.checked == true) {
				frm.q_pages.disabled = false;
			} else {
				frm.q_pages.value = "";
				frm.q_pages.disabled = true;
			}
		}

		function checks7() {
			var frm = document.form1;
			
			if(frm.q_pub_comp.checked == true) {
				frm.q_pub_comps.disabled = false;
			} else {
				frm.q_pub_comps.value = "";
				frm.q_pub_comps.disabled = true;
			}
		}

		function checks8() {
			var frm = document.form1;
			
			if(frm.q_pub_year.checked == true) {
				frm.q_pub_years.disabled = false;
			} else {
				frm.q_pub_years.value = "";
				frm.q_pub_years.disabled = true;
			}
		}

		function checks9() {
			var frm = document.form1;
			
			if(frm.q_etc.checked == true) {
				frm.q_etcs.disabled = false;
			} else {
				frm.q_etcs.value = "";
				frm.q_etcs.disabled = true;
			}
		}
		
		function checks10() {
			var frm = document.form1;
			
			if(frm.q_kwd.checked == true) {
				frm.q_kwds.disabled = false;
			} else {
				frm.q_kwds.value = "";
				frm.q_kwds.disabled = true;
			}
		}

		function checks11() {
			var frm = document.form1;
			
			if(frm.q_use.checked == true) {
				frm.q_uses.disabled = false;
			} else {
				frm.q_uses.value = "";
				frm.q_uses.disabled = true;
			}
		}

		function checks12() {
			var frm = document.form1;
			
			if(frm.q_use2.checked == true) {
				frm.q_uses2.disabled = false;
			} else {
				frm.q_uses2.value = "";
				frm.q_uses2.disabled = true;
			}
		}
		
	</script>

</head>

<BODY id="popup2">
	
	<form name="form1" method="post" action="q_info_update.jsp">

	<input type="hidden" name="id_qs" value="<%=id_qs%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� ���� <span>���������� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_allott" onClick="checks1();">&nbsp;����</td>
				<td><input type="text" class="input" name="q_allotts" size="41" disabled>
				</td>
			</tr>

			
			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_diff" onClick="checks3();">&nbsp;���̵�</td>
				<td><select name="q_diffs" style="width:255px" disabled>
				<option value=""></option>
				<% for(int i=0; i<diff.length; i++) { %>
					<option value="<%=diff[i].getId_difficulty()%>"><%=diff[i].getDifficulty()%></option>
				<% } %>
				</select>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_book" onClick="checks4();">&nbsp;������ó-������</td>
				<td><input type="text" class="input" name="q_books" size="41" disabled>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_author" onClick="checks5();">&nbsp;������ó-���ڸ�</td>
				<td><input type="text" class="input" name="q_authors" size="41" disabled>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_page" onClick="checks6();">&nbsp;������ó-������</td>
				<td><input type="text" class="input" name="q_pages" size="41" disabled>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_pub_comp" onClick="checks7();">&nbsp;������ó-���ǻ�</td>
				<td><input type="text" class="input" name="q_pub_comps" size="41" disabled>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_pub_year" onClick="checks8();">&nbsp;������ó-���ǿ���</td>
				<td><Select name="q_pub_years" style="width:255px;" disabled>
				<option value=""></option>
				<% for(int i = 2010; i <= 2020; i++) { %>
					<option value="<%=i%>"><%=i%>��</option>
				<% } %>
				</Select>				
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_etc" onClick="checks9();">&nbsp;������ó-��Ÿ����</td>
				<td><input type="text" class="input" name="q_etcs" size="41" disabled>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_kwd" onClick="checks10();">&nbsp;�˻� Ű����</td>
				<td><input type="text" class="input" name="q_kwds" size="41" disabled>
				</td>
			</tr>

			<tr>
				<td id="left"><input type="checkbox" value="Y" name="q_use" onClick="checks11();">&nbsp;�����뵵1</td>
				<td><select name="q_uses" style="width:255px;" disabled>
				<option value=""></option>
				<% for(int i=0; i<quse.length; i++) { %>
					<option value="<%=quse[i].getId_q_use()%>"><%=quse[i].getQ_use()%></option>
				<% } %>
				</select>
				</td>
			</tr>

		</table>

	</div>
	<div id="button">
		<input type="image" value="������������" name="submit" src="../../images/bt_q_info_edit_yj1.gif" onfocus="this.blur();">&nbsp;&nbsp;<!--input type="button" value="â�ݱ�" onClick="window.close();"--><a href="javascript:window.close();" onfocus="this.blur();"><img border="0" src="../../images/bt_q_search_closeyj1.gif" ></a>
	</div>

	
	

	</form>
</BODY>
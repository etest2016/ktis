<%
//******************************************************************************
//   ���α׷� : q_search.jsp
//   �� �� �� : ���� �˻�
//   ��    �� : ������ �־� ������ �˻��Ѵ�.
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2008-04-16
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 2008-07-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%@ include file = "../common/calendar.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	// �������� ���� ���������
	RqtypeBean[] qtypes = null;

    try {
	    qtypes = RqtypeUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
	
	// ���̵� ���� ���������
	RdifficultBean[] diffs = null;

    try {
	    diffs = RdifficultUtil.getBeans();
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<html>
	<head>
	<title>���� �˻�</title>
	<link rel="StyleSheet" href="../css/style.css" type="text/css">
	<style>
		#q_view { }
		#q_view table { width: 500px; border: 10px solid red; }
	</style>
	<script type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
	<script language="JavaScript">
	
		function checks1() {
			var frm = document.form1;
			
			if(frm.qte.checked == true) {
				frm.qtype.disabled = false;
				frm.qte.value = "Y";
			} else {
				frm.qtype.disabled = true;
				frm.qte.value = "N";
			}
		}

		function checks2() {
			var frm = document.form1;
			
			if(frm.diff.checked == true) {
				frm.difficulty.disabled = false;
				frm.diff.value = "Y";
			} else {
				frm.difficulty.disabled = true;
				frm.diff.value = "N";
			}
		}

		function checks3() {
			var frm = document.form1;
			
			if(frm.cnts.checked == true) {
				frm.cnt1.disabled = false;
				frm.cnt2.disabled = false;
				frm.cnts.value = "Y";
			} else {
				frm.cnt1.disabled = true;
				frm.cnt2.disabled = true;
				frm.cnts.value = "N";
			}
		}

		/*function checks4() {
			var frm = document.form1;
			
			if(frm.managers.checked == true) {
				frm.manager1.disabled = false;
				frm.managers.value = "Y";
			} else {
				frm.manager1.disabled = true;
				frm.managers.value = "N";
			}
		}

		function checks5() {
			var frm = document.form1;
			
			if(frm.updates.checked == true) {
				frm.update1.disabled = false;
				frm.update2.disabled = false;
				frm.updates.value = "Y";
			} else {
				frm.update1.disabled = true;
				frm.update2.disabled = true;
				frm.updates.value = "N";
			}
		}*/

		function checks6() {
			var frm = document.form1;
			
			if(frm.id_qs.checked == true) {
				frm.id_qs1.disabled = false;
				frm.id_qs.value = "Y";
			} else {
				frm.id_qs1.disabled = true;
				frm.id_qs.value = "N";
			}
		}

		function checks7() {
			var frm = document.form1;
			
			if(frm.incorrects.checked == true) {
				
				frm.incorrects.value = "Y";

				frm.qte.checked = false;
				frm.qte.disabled = true;
				frm.qtype.disabled = true;
				
				frm.diff.checked = false;
				frm.diff.disabled = true;
				frm.difficulty.disabled = true;
				
				frm.cnts.checked = false;
				frm.cnts.disabled = true;
				frm.cnt1.disabled = true;
				frm.cnt2.disabled = true;

				frm.id_qs.checked = false;
				frm.id_qs.disabled = true;
				frm.id_qs1.disabled = true;

				frm.incorrect1.disabled = false;
			} else {

				frm.incorrects.value = "N";

				frm.qte.disabled = false;
				frm.diff.disabled = false;
				frm.cnts.disabled = false;				
				frm.id_qs.disabled = false;

				frm.incorrect1.disabled = true;
			}
		}

		function checks8() {
			var frm = document.form1;
			
			if(frm.qs0.checked == true) {
				frm.qs1.disabled = false;
				frm.qs0.value = "Y";
			} else {
				frm.qs1.disabled = true;
				frm.qs0.value = "N";
			}
		}

		function qs_search_list() {

			var frm = document.form1;

			var qte = "N";
			var qtype = "";
			if(frm.qte.checked == true) {
				qte = frm.qte.value;
				qtype = frm.qtype.value;
				if(frm.qtype.value == "") {
					alert("���������� �����ϼ���.");
					return;
				}
			}			

			var diff = "N";
			var difficulty = "";
			if(frm.diff.checked == true) {
				diff = "Y";
				difficulty = frm.difficulty.value;
				if(frm.difficulty.value == "") {
					alert("���̵��� �����ϼ���.");
					return;
				}
			} 
			
			var cnts = "N";
			var cnt1 = "";
			var cnt2 = "";
			if(frm.cnts.checked == true) {
				cnts = frm.cnts.value;
				cnt1 = frm.cnt1.value;
				cnt2 = frm.cnt2.value;
			}
			
			var id_qs = "N";
			var id_qs1 = "";
			if(frm.id_qs.checked == true) {
				id_qs = frm.id_qs.value;
				id_qs1 = frm.id_qs1.value;
			}

			var incorrects = "N";
			var incorrect1 = "";
			if(frm.incorrects.checked == true) {
				incorrects = frm.incorrects.value;
				incorrect1 = frm.incorrect1.value;
				if(frm.incorrect1.value == "") {
					alert("���������� �����ϼ���.");
					return;
				}
			}

			var qs0 = "N";
			var qs1 = "";
			if(frm.qs0.checked == true) {
				qs0 = frm.qs0.value;
				qs1 = frm.qs1.value;
			}

			qs = new ActiveXObject("Microsoft.XMLHTTP");
			qs.onreadystatechange = qs_search_list_callback;
			qs.open("POST", "q_search_res.jsp", true);
			qs.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=EUC-KR");
			qs.send("qte="+qte+"&qtype="+qtype+"&diff="+diff+"&difficulty="+difficulty+"&cnts="+cnts+"&cnt1="+cnt1+"&cnt2="+cnt2+"&id_qs="+id_qs+"&id_qs1="+id_qs1+"&incorrects="+incorrects+"&icorrect1="+incorrect1+"&qs0="+qs0+"&qs1="+qs1);
		}

		function qs_search_list_callback() {
			if(qs.readyState == 4) {
				if(qs.status == 200) {
					if(typeof(document.all.qs_search) == "object") {
						document.all.qs_search.innerHTML = qs.responseText;
					}
				}
		    }
		}

		function dbl_selects(id_q, id_subject) {
			$.posterPopup("editor/edit_form.jsp?id_q="+id_q+"&id_subject="+id_subject,"q_edit","width=1020, height=740, scrollbars=yes");
		}
	
	</script>
	</head>

	<BODY id="popup2">
	
	<form name="form1" method="post" action="q_search.jsp">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����˻�<span>�˻��� ���ϴ� ������ �˻� ������ �Է��Ͻʽÿ�</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left"><input type="checkbox" name="qte" onClick="checks1(this);" value="Y" >���� ����</td>
				<td><select name="qtype" style=width:200 disabled>
				<option value="">�������� ����</option>
				<% for(int i=0; i<qtypes.length; i++) { %>
				<option value="<%=qtypes[i].getId_qtype()%>"><%=qtypes[i].getQtype()%></option>
				<% } %>
				</select>
				</td>
				<td id="left"><input type="checkbox" name="diff" onClick="checks2();" value="Y" >���̵�</td>
				<td><select name="difficulty" style=width:200 disabled>
				<option value="">���̵� ����</option>
				<% for(int i=0; i<diffs.length; i++) { %>
				<option value="<%=diffs[i].getId_difficulty()%>"><%=diffs[i].getDifficulty()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" name="cnts" onClick="checks3();" value="Y" >����Ƚ��</td>
				<td><input type="text" class="input" name="cnt1" disabled size="5"> ȸ&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;<input type="text" class="input" name="cnt2" disabled size="5"> ȸ</td>
				<td id="left"><input type="checkbox" name="id_qs" onClick="checks6();" value="Y">���� �ڵ�</td>
				<td><input type="text" class="input" name="id_qs1" size="10" disabled></td>
			</tr>			
			<tr>
				<td id="left"><input type="checkbox" name="incorrects" value="Y" onClick="checks7();" >������ ���� ����</td>
				<td ><select name="incorrect1" style=width:200 disabled>
				<option value="">�����ϼ���</option>
				<option value="1">���� ����</option>
				<option value="2">��� ���� ó��</option>
				</select>
				</td>
				<td id="left"><input type="checkbox" name="qs0" onClick="checks8();" value="Y">������</td>
				<td><input type="text" class="input" name="qs1" size="35" disabled></td>
			</tr>
		</table>
				

		<div id="button">
		<!--input type="button" value="�˻��ϱ�" onClick="qs_search_list();"--><a href="javascript:qs_search_list();"><img src="../images/bt_get_user_search_yj1.gif" align="absmiddle"></a>&nbsp;&nbsp;&nbsp;<!--input type="button" value="�� ��" onClick="window.close();"--><a href="javascript:window.close();"><img src="../images/bt_q_search_closeyj1.gif" align="absmiddle"></a>
		</div>

		<BR>
		<!--table border="0" width="100%" cellpadding="0" cellspacing="1" bgcolor="#C2C9D9" id="tableA">
			<tr bgcolor="#FFFFFF" height="30" id="bt2">
				<td align="left">* �˻��� ����</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>
				<div id = "qs_search"></div>
				</td>
			</tr>
		</table-->

		<div id = "qs_search"></div>

	</form>
</body>
</html>
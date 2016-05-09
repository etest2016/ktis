<%
//******************************************************************************
//   ���α׷� : q_search1.jsp
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

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }	
	
	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }	

	if (id_subject.length() == 0 || id_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = request.getParameter("bigos");
	if (bigos == null) { bigos = ""; } else { bigos = bigos.trim(); }
	
	// ���� �˻�
	QSearchListBean[] rst = null;

	String qtes = "";
	String qtype = "";
	String diff = "";
	String difficultys = "";
	String cnts = "";
	String cnt1 = "";
	String cnt2 = "";
	String id_qs = "";
	String id_qs1 = "";
	String incorrects = "";
	String incorrect1 = "";
	String qs_chk = "";
	String qs = "";

	if(bigos.equals("Y")) {

		qtes = request.getParameter("qte");
		if (qtes == null) { qtes = ""; } else { qtes = qtes.trim(); }
		qtype = request.getParameter("qtype");
		if (qtype == null) { qtype = ""; } else { qtype = qtype.trim(); }

		diff = request.getParameter("diff");
		if (diff == null) { diff = ""; } else { diff = diff.trim(); }
		difficultys = request.getParameter("difficulty");
		if (difficultys == null) { difficultys = ""; } else { difficultys = difficultys.trim(); }

		cnts = request.getParameter("cnts");
		if (cnts == null) { cnts = ""; } else { cnts = cnts.trim(); }
		cnt1 = request.getParameter("cnt1");
		if (cnt1 == null) { cnt1 = ""; } else { cnt1 = cnt1.trim(); }
		cnt2 = request.getParameter("cnt2");
		if (cnt2 == null) { cnt2 = ""; } else { cnt2 = cnt2.trim(); }
		
		id_qs = request.getParameter("id_qs");
		if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
		id_qs1 = request.getParameter("id_qs1");
		if (id_qs1 == null) { id_qs1 = ""; } else { id_qs1 = id_qs1.trim(); }

		incorrects = request.getParameter("incorrects");
		if (incorrects == null) { incorrects = ""; } else { incorrects = incorrects.trim(); }
		incorrect1 = request.getParameter("incorrect1");
		if (incorrect1 == null) { incorrect1 = ""; } else { incorrect1 = incorrect1.trim(); }

		qs_chk = request.getParameter("qs_chk");
		if (qs_chk == null) { qs_chk = ""; } else { qs_chk = qs_chk.trim(); }
		
		qs = request.getParameter("qs");
		if (qs == null) { qs = ""; } else { qs = qs.trim(); }

		QSearchBean bean = new QSearchBean();

		bean.setQtes(qtes);
		bean.setQtypes(qtype);
		bean.setDiffs(diff);
		bean.setDifficultys(difficultys);
		bean.setCnts(cnts);
		bean.setCnt1(cnt1);
		bean.setCnt2(cnt2);
		bean.setId_qs(id_qs);
		bean.setId_qs1(id_qs1);
		bean.setIncorrects(incorrects);
		bean.setIncorrect1(incorrect1);
		bean.setQs(qs_chk);
		bean.setQs1(qs);
		
		try {
			rst = QSearch.getSearchBeans(bean, id_subject, id_chapter, userid);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
	}
	
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
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<style>
		#q_view { }
		#q_view table { width: 500px; border: 10px solid red; }
	</style>
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
		}*/

		function checks5() {
			var frm = document.form1;
			
			if(frm.qs_chk.checked == true) {
				frm.qs.disabled = false;
				frm.qs_chk.value = "Y";
			} else {
				frm.qs.disabled = true;
				frm.qs_chk.value = "N";
			}
		}

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

				frm.qs_chk.checked = false;
				frm.qs_chk.disabled = true;
				frm.qs_chk.disabled = true;

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

		function qs_search_list() {

			var frm = document.form1;

			var qte = "N";
			var qtype = "";

			if(frm.qte.checked == true) {
				qte = "Y";
				qtype = frm.qtype.value;
			} else {
				qte = "N";
				qtype = "";
			}
			
			var diff = "N";
			var difficulty = "";
			
			if(frm.diff.checked == true) {
				diff = "Y";
				difficulty = frm.difficulty.value;
			} else {
				diff = "N";
				difficulty = "";
			}
			
			var cnts = "N";
			var cnt1 = "";
			var cnt2 = "";
			
			if(frm.cnts.checked == true) {
				cnts = "Y";
				cnt1 = frm.cnt1.value;
				cnt2 = frm.cnt2.value;
			} else {
				cnts = "N";
				cnt1 = "";
				cnt2 = "";
			}
			
			var id_qs = "N";
			var id_qs1 = "";
			
			if(frm.id_qs.checked == true) {
				id_qs = "Y";
				id_qs1 = frm.id_qs1.value;
			} else {
				id_qs = "N";
				id_qs1 = "";
			}

			var incorrects = "N";
			var incorrect1 = "";

			if(frm.incorrects.checked == true) {
				incorrects = "Y";
				incorrect1 = frm.incorrect1.value;
			} else {
				incorrects = "N";
				incorrect1 = "";
			}
			
			var qs_chk = "N";
			var qs = "";

			if(frm.qs_chk.checked == true) {
				qs_chk = "Y";
				qs = frm.qs.value;
			} else {
				qs_chk = "N";
				qs = "";
			}
			
			frm.bigos.value = "Y";
							
			frm.submit();
		}

		function dbl_selects(id_q, id_subject) {
			window.open("../editor/edit_form.jsp?id_q="+id_q+"&id_subject="+id_subject,"q_edit","width=1020, height=740, scrollbars=yes");
		}
	
	</script>
	</head>

	<BODY id="popup2">
	
	<form name="form1" method="post" action="q_search1.jsp">
	<input type="hidden" name="bigos" >
	<input type="hidden" name="id_subject" value="<%=id_subject%>">
	<input type="hidden" name="id_chapter" value="<%=id_chapter%>">

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
				<td colspan="3"><select name="incorrect1" style=width:200 disabled>
				<option value="">�����ϼ���</option>
				<option value="1">���� ����</option>
				<option value="2">��� ���� ó��</option>
				</select>
				</td>
			</tr>
			<tr>
				<td id="left"><input type="checkbox" name="qs_chk" onClick="checks5();" value="Y" >������ �˻�</td>
				<td colspan="3"><input type="text" class="input" name="qs" disabled size="50"></td>				
			</tr>
		</table>
				

		<div id="button">
		<a href="javascript:qs_search_list();"><img src="../../images/bt_get_user_search_yj1.gif" align="absmiddle"></a>&nbsp;&nbsp;&nbsp;<a href="javascript:window.close();"><img src="../../images/bt_q_search_closeyj1.gif" align="absmiddle"></a>
		</div>

		<% if(bigos.equals("Y")) { %>
		<BR>
		
			<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr3">			
				<td width="90">�����ڵ�</td>
				<td width="90">��������</td>
				<td width="90">���̵�</td>
				<td width="90">����Ƚ��</td>
				<td>����</td>
			</tr>
			<% if(rst == null) { %>
			<tr bgcolor="#FFFFFF" height="40">
				<td colspan="5" align="center"  class="blank">�˻��Ǿ��� ������ �����ϴ�.</td>
			</tr>
			<%
				} else {
					for(int i=0; i<rst.length; i++) {
						
			%>

			<tr id="td">
				<td align="center"><%=rst[i].getId_qs()%></td>
				<td align="center"><%=rst[i].getQtypes()%></td>
				<td align="center"><%=rst[i].getDifficulty()%></td>			
				<td align="center"><%=rst[i].getMake_cnt()%></td>
				<td id="q_view"><a href="javascript:onClick=dbl_selects('<%=rst[i].getId_qs()%>', '<%=rst[i].getId_subject()%>');"><%=rst[i].getQs()%></a></td>
			</tr>
			<%
					}
				}
			%>
		</table>
		
		<% } %>
	</form>
</body>
</html>
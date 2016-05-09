<%
//******************************************************************************
//   ���α׷� : q_copy.jsp
//   �� �� �� : �������� ������
//   ��    �� : �������� ������
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.tman.exam.*
//   �� �� �� : 2008-07-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR"); 

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// �������� ���������
	ExamUtilBean[] rst = null;

    try {
	    if(userid.equals("qmtm")) {
		    rst = ExamUtil.getQBeans();
		} else {
			rst = ExamUtil.getQBeans(userid);
		}
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<html>
<head>
	<title> :: ���� ���� :: </title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">

		var cpt1;
		var cpt2;
		var cpt3;
		var cpt4;

		// �ܿ� 1 ���� ���������
		function get_cpt1_list(cpts1) {

			var frm = document.form1;

			frm.cpt1.checked = false;
			frm.cpt2.checked = false;
			frm.cpt3.checked = false;
			frm.cpt4.checked = false;

			frm.chapter2.disabled = true;
			frm.chapter2.value = "";
			frm.chapter3.disabled = true;
			frm.chapter3.value = "";
			frm.chapter4.disabled = true;
			frm.chapter4.value = "";

			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
			} else {
				frm.chapter1.disabled = true;
			}

			cpt1 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt1.onreadystatechange = get_cpt1_list_callback;
			cpt1.open("GET", "cpt1.jsp?cpt1="+cpts1, true);
			cpt1.send();
		}

		function get_cpt1_list_callback() {

			if(cpt1.readyState == 4) {
				if(cpt1.status == 200) {
					if(typeof(document.all.div_cpt1) == "object") {
						document.all.div_cpt1.innerHTML = cpt1.responseText;
					}
				}
			}
		}

		// �ܿ� 2 ���� ���������
		function get_cpt2_list(cpts2) {

			var frm = document.form1;

			frm.cpt2.checked = false;
			frm.cpt3.checked = false;
			frm.cpt4.checked = false;

			frm.chapter3.disabled = true;
			frm.chapter3.value = "";
			frm.chapter4.disabled = true;
			frm.chapter4.value = "";

			cpt2 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt2.onreadystatechange = get_cpt2_list_callback;
			cpt2.open("GET", "cpt2.jsp?cpt2="+cpts2, true);
			cpt2.send();
		}

		function get_cpt2_list_callback() {			
			if(cpt2.readyState == 4) {
				if(cpt2.status == 200) {
					if(typeof(document.all.div_cpt2) == "object") {
						document.all.div_cpt2.innerHTML = cpt2.responseText;
					}
				}
			}
		}
		
		// �ܿ� 3 ���� ���������
		function get_cpt3_list(cpts3) {
			
			var frm = document.form1;
			frm.cpt3.checked = false;
			frm.cpt4.checked = false;

			frm.chapter4.disabled = true;
			frm.chapter4.value = "";
			
			cpt3 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt3.onreadystatechange = get_cpt3_list_callback;
			cpt3.open("GET", "cpt3.jsp?cpt3="+cpts3, true);
			cpt3.send();
		}

		function get_cpt3_list_callback() {			
			if(cpt3.readyState == 4) {
				if(cpt3.status == 200) {
					if(typeof(document.all.div_cpt3) == "object") {
						document.all.div_cpt3.innerHTML = cpt3.responseText;
					}
				}
			}
		}

		// �ܿ� 4 ���� ���������
		function get_cpt4_list(cpts4) {
			
			var frm = document.form1;
			frm.cpt4.checked = false;
			
			cpt4 = new ActiveXObject("Microsoft.XMLHTTP");
			cpt4.onreadystatechange = get_cpt4_list_callback;
			cpt4.open("GET", "cpt4.jsp?cpt4="+cpts4, true);
			cpt4.send();
		}

		function get_cpt4_list_callback() {
			if(cpt4.readyState == 4) {
				if(cpt4.status == 200) {
					if(typeof(document.all.div_cpt4) == "object") {
						document.all.div_cpt4.innerHTML = cpt4.responseText;
					}
				}
			}
		}

		// �ܿ� 1
		function checks2() {
			var frm = document.form1;
			
			if(frm.cpt1.checked == true) {
				frm.chapter1.disabled = false;
			} else {
				frm.chapter1.disabled = true;
			}
		}

		// �ܿ� 2
		function checks3() {
			var frm = document.form1;
			
			if(frm.cpt2.checked == true) {
				frm.chapter2.disabled = false;
			} else {
				frm.chapter2.disabled = true;
			}
		}

		// �ܿ� 3
		function checks4() {
			var frm = document.form1;
			
			if(frm.cpt3.checked == true) {
				frm.chapter3.disabled = false;
			} else {
				frm.chapter3.disabled = true;
			}
		}

		// �ܿ� 4
		function checks5() {
			var frm = document.form1;
			
			if(frm.cpt4.checked == true) {
				frm.chapter4.disabled = false;
			} else {
				frm.chapter4.disabled = true;
			}
		}

	</script>

</head>

<BODY id="popup2">

	<form name="form1" method="post" action="q_copy_ok.jsp">
	<input type="hidden" name="id_qs" value="<%=id_qs%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ���� <span>������ �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="120" align="center">������&nbsp;&nbsp;</td>
				<td>
					<select name="subjects" style="width:300" onChange="get_cpt1_list(this.value);">
						<option value="">������ �����ϼ���</option>
						<% for(int i=0; i<rst.length; i++) { %>
							<option value="<%=rst[i].getId_q_subject()%>"><%=rst[i].getQ_subject()%></option>
						<% } %>
					</select>
				</td>
			</tr>

			<tr>
				<td id="left" align="center"><input type="checkbox" value="Y" name="cpt1" onClick="checks2();">&nbsp;&nbsp;�ܿ� 1&nbsp;&nbsp;</td>
				<td>
					<div id="div_cpt1">
						<select name="chapter1" style="width:300" disabled onChange="get_cpt2_list(this.value);">
							<option value=""></option>
						</select>
					</div>
				</td>
			</tr>

			<tr>
				<td id="left" align="center"><input type="checkbox" value="Y" name="cpt2" onClick="checks3();">&nbsp;&nbsp;�ܿ� 2&nbsp;&nbsp;</td>
				<td>
					<div id="div_cpt2">
						<select name="chapter2" style="width:300" disabled onChange="get_cpt3_list(this.value);">
							<option value=""></option>
						</select>
					</div>
				</td>
			</tr>

			<tr>
				<td id="left" align="center"><input type="checkbox" value="Y" name="cpt3" onClick="checks4();">&nbsp;&nbsp;�ܿ� 3&nbsp;&nbsp;</td>
				<td>
					<div id="div_cpt3">
						<select name="chapter3" style="width:300" disabled onChange="get_cpt4_list(this.value);">
							<option value=""></option>
						</select>
					</div>
				</td>
			</tr>

			<tr>
				<td id="left" align="center"><input type="checkbox" value="Y" name="cpt4" onClick="checks5();">&nbsp;&nbsp;�ܿ� 4&nbsp;&nbsp;</td>
				<td>
					<div id="div_cpt4">
						<select name="chapter4" style="width:300" disabled>
							<option value=""></option>
						</select>
					</div>
				</td>
			</tr>
			
		</table>

	</div>
	<div id="button">
		<input type="image" value="��������" name="submit" src="../../images/bt_q_copy_yj1.gif">&nbsp;&nbsp;<!--input type="button" value="����ϱ�" onClick="window.close();"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif">
	</div>


	</form>
</BODY>
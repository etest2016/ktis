<%
//******************************************************************************
//   ���α׷� : q_move.jsp
//   �� �� �� : �����̵� ������
//   ��    �� : �����̵� ������
//   �� �� �� : q_subject, t_worker_subj
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String usergrade = (String)session.getAttribute("usergrade");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }	
	
	if (id_qs.length() == 0 || userid.length() == 0 || id_qs.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	ExamUtilBean[] rst = null;

    try {
	    if(userid.equals("qmtm") || usergrade.equals("M")) {
		    rst = ExamUtil.getCourseList(id_category);
		} else {
			rst = ExamUtil.getCourseList(id_category, userid);
		}
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<html>
<head>
	<title> :: ���� �̵� :: </title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">

		var subj1;
		var cpt1;

		// ���� ���� ���������
		function get_subj1_list(subjs1) {
			
			var frm = document.form1;

			frm.subj.checked = false;
			
			if(frm.subj.checked == true) {
				frm.id_subject.disabled = false;
			} else {
				frm.id_subject.disabled = true;
			}

			subj1 = new ActiveXObject("Microsoft.XMLHTTP");
			subj1.onreadystatechange = get_subj1_list_callback;
			subj1.open("GET", "subj.jsp?subj="+subjs1, true);
			subj1.send();
		}

		function get_subj1_list_callback() {

			if(subj1.readyState == 4) {
				if(subj1.status == 200) {
					if(typeof(document.all.div_subj1) == "object") {
						document.all.div_subj1.innerHTML = subj1.responseText;
					}
				}
			}
		}

		// �ܿ� 1 ���� ���������
		function get_cpt1_list(cpts1) {

			var frm = document.form1;

			frm.cpt1.checked = false;
			
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

		function checks() {
			var frm = document.form1;
			
			if(frm.subj.checked == true) {
				frm.id_subject.disabled = false;
			} else {
				frm.id_subject.disabled = true;
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

		function Send() {
			var frm = document.form1;
			
			if(frm.subj.checked == false) {
				alert("������ üũ�ϼ���.");
				return;
			} else if(frm.id_subject.value == "") {
				alert("�����̵� �� ������ �����ϼ���.");
				return;
			} else if(frm.cpt1.checked == false) {
				alert("�ܿ��� üũ�ϼ���.");
				return;
			} else if(frm.chapter1.value == "") {
				alert("�����̵� �� �ܿ��� �����ϼ���.");
				return;
			} else { 
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">
	
	<form name="form1" method="post" action="q_move_ok.jsp">
	<input type="hidden" name="id_qs" value="<%=id_qs%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� �̵� <span>���� ��θ� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		

		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td id="left" width="120" align="center">��������&nbsp;&nbsp;</td>
				<td>
					<select name="id_course" style="width:300" onChange="get_subj1_list(this.value);">
						<option value="">������ �����ϼ���</option>
						<% for(int i=0; i<rst.length; i++) { %>
							<option value="<%=rst[i].getId_course()%>"><%=rst[i].getCourse()%></option>
						<% } %>
					</select>
				</td>
			</tr>
			
			<tr>
				<td id="left" width="120" align="center"><input type="checkbox" value="Y" name="subj" onClick="checks();">&nbsp;&nbsp;������&nbsp;&nbsp;</td>
				<td>
					<div id="div_subj1">
						<select name="id_subject" style="width:300" disabled>
							<option value=""></option>
						</select>
					</div>
				</td>
			</tr>

			<tr>
				<td id="left" align="center"><input type="checkbox" value="Y" name="cpt1" onClick="checks2();">&nbsp;&nbsp;�ܿ�����&nbsp;&nbsp;</td>
				<td><div id="div_cpt1"><select name="chapter1" style="width:300" disabled >
					<option value=""></option>
				</select>
				</div>
				</td>
			</tr>
			
		</table>


	</div>
	<div id="button">

		<a href="javascript:Send();"><img src="../../images/bt_q_move_yj1.gif"></a>&nbsp;&nbsp;&nbsp;<!--input type="button" value="����ϱ�" onClick="window.close();"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif"></a>

	</div>


	</form>

</body>
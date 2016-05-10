<%
//******************************************************************************
//   ���α׷� : course_insert
//   �� �� �� : ���� ���
//   ��    �� : ���� ��� ������
//   �� �� �� : 
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, 
//              qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil,
//              qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil 
//   �� �� �� : 2013-01-21
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// �뿵����� ���������
	CategoryBean[] rst = null;

	// �뿵���ڵ� ���� ��������
	try {
		rst = CategoryUtil.getParentCategory();
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: ���� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("�뿵���� �����ϼ���");				
				return;
			} else if(frm.id_midcategory.value == "") {
				alert("�ҿ����� �����ϼ���");				
				return;
			} else if(frm.course.value == "") {
				alert("�������� �Է��ϼ���");
				frm.course.focus();
				return;
			} else if(frm.orders.value == "") {
				alert("���ļ����� �����ϼ���");				
				return;
			} else {
				frm.submit();
			}
		}

		var category1;

		// �ҿ��� �����ڵ����� ���������
		function get_category_list(strs) {			

			category1 = new ActiveXObject("Microsoft.XMLHTTP");
			category1.onreadystatechange = get_category_list_callback;
			category1.open("GET", "midcategory.jsp?id_category="+strs+"&id_midcategory=''", true);
			category1.send();
		}

		function get_category_list_callback() {

			if(category1.readyState == 4) {
				if(category1.status == 200) {
					if(typeof(document.all.div_category) == "object") {
						document.all.div_category.innerHTML = category1.responseText;
					}
				}
			}
		}

		var order1;

		// ���� ���ļ��� ���������
		function get_order_list(strs) {
			
			order1 = new ActiveXObject("Microsoft.XMLHTTP");
			order1.onreadystatechange = get_order_list_callback;
			order1.open("GET", "orderCnt.jsp?id_midcategory="+strs, true);
			order1.send();
		}

		function get_order_list_callback() {
			if(order1.readyState == 4) {
				if(order1.status == 200) {
					if(typeof(document.all.div_order) == "object") {
						document.all.div_order.innerHTML = order1.responseText;
					}
				}
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="course_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ��� <span> �����ڵ带 ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
		<tr>
			<td id="left">�뿵������</td>
			<td width="200">
			<select name="id_category" style="width:200" onChange="get_category_list(this.value);">
			<% if(rst == null) { %>
				<option value=""></option>
			<% 
				} else { 
			%>
				<option value="">�뿵���� �����ϼ���</option>
			<%
					for(int i = 0; i < rst.length; i++) {
			%>
				<option value="<%=rst[i].getId_category()%>"><%=rst[i].getCategory()%></option>
			<% 
					}
				} 
			%>
			</select>
			</td>
		</tr>
		<tr>
			<td id="left">�ҿ�������</td>
			<td width="200">
			<div  style="float: left;" id="div_category"><select name="id_midcategory" style="width:200" onChange="get_order_list(this.value);">
				<option value="">�ҿ����� �����ϼ���</option>
			</select></div>
			</td>
		</tr>			
		<tr>
			<td id="left">������</td>
			<td><input type="text" class="input" name="course" size="32" style="ime-mode:active;"></td>
		</tr>
		<tr>
			<td id="left">���ļ���</td>
			<td>
			<div  style="float: left;" id="div_order"><select name="orders">
				<option value="">����</option>
			</select></div>
			</td>
		</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="����ϱ�" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
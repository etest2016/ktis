<%
//******************************************************************************
//   ���α׷� : group_edit2.jsp
//   �� �� �� : �ҿ������� ����
//   ��    �� : �ҿ������� ���� ������
//   �� �� �� : c_midcateogry
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, 
//              qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
//   �� �� �� : 2013-01-28
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

	String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory= ""; } else { id_midcategory = id_midcategory.trim(); }

	if (id_midcategory.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	

	MidCategoryBean rst = null;

    try {
	    rst = MidCategoryUtil.getBean(id_midcategory);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	// �뿵����� ���������
	CategoryBean[] rst2 = null;

	try {
		rst2 = CategoryUtil.getParentCategory();
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<html>
<head>
	<title>:: �뿵�� ���� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.midcategory.value == "") {
				alert("�Ҵ뿵������ �Է��ϼ���");
				frm.midcategory.focus();
				return false;			
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="popup2">

<form name="frmdata" method="post" action="group_update2.jsp">
<input type="hidden" name="id_midcategory" value="<%=id_midcategory%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�뿵������ <span> �뿵�� ��������</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
		<tr>
			<td id="left">�뿵������</td>
			<td width="200">
			<select name="id_category">
			<% if(rst2 == null) { %>
				<option value=""></option>
			<% 
				} else { 
					for(int i = 0; i < rst2.length; i++) {
			%>
				<option value="<%=rst2[i].getId_category()%>" <% if(rst.getId_category().equals(rst2[i].getId_category())) { %>selected<% } %>><%=rst2[i].getCategory()%></option>
			<% 
					}
				} 
			%>
			</select>
			</td>
		</tr>
		<tr>
			<td id="left">�ҿ����ڵ�</td>
			<td width="200"><%=id_midcategory%></td>
		</tr>
		<tr>
			<td id="left">�ҿ�����</td>
			<td><input type="text" class="input" name="midcategory" size="25" value="<%=rst.getMidcategory()%>" style="ime-mode:active;"></td>
		</tr>
		<tr>
			<td id="left">���ļ���</td>
			<td><select name="orders">
			<% for(int i = 1; i <= 15; i++) { %>	
				<option value="<%=i%>" <% if(rst.getOrders() == i) { %>selected<% } %>><%=i%></option>
			<% } %>
			</td>
		</tr>
		<tr>
			<td id="left">��������</td>
			<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) {%>checked<%}%>> ����&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N"<%if(rst.getYn_valid().equals("N")) {%>checked<%}%>> �����</td>
		</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="�����ϱ�" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
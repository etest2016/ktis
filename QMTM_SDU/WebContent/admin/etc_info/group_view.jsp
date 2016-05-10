<%
//******************************************************************************
//   ���α׷� : group_view.jsp
//   �� �� �� : �뿵������ Ȯ��
//   ��    �� : �뿵������ Ȯ�� ������
//   �� �� �� : c_cateogry
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	CategoryBean rst = null;

    try {
	    rst = CategoryUtil.getBean(id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="group_edit.jsp?id_category=<%=id_category%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* �뿵���� �����Ͻðڽ��ϱ�?" );
       if (st == true) {
           document.location = "group_delete.jsp?id_category=<%=id_category%>";
       }
    }
</script>
<html>
<head>
	<title>:: �뿵�� Ȯ�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�뿵�� Ȯ�� <span> �뿵�� Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�뿵���ڵ�</td>
				<td width="200"><%=id_category%></td>
			</tr>
			<tr>
				<td id="left">�뿵����</td>
				<td><%=rst.getCategory()%></td>
			</tr>
			<tr>
				<td id="left">��������</td>
				<td><%if(rst.getYn_valid().equals("Y")) {%>����<%} else {%>�����<%}%></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="�����ϱ�" class="form" onClick="edits();">&nbsp;&nbsp;<input type="button" value="�����ϱ�" class="form" onClick="deletes();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
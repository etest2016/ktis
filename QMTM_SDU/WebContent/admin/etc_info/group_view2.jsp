<%
//******************************************************************************
//   ���α׷� : group_view2.jsp
//   �� �� �� : �ҿ������� Ȯ��
//   ��    �� : �ҿ������� Ȯ�� ������
//   �� �� �� : c_midcateogry
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil" %>
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

	if(!chk_usergrade.equals("S")) {
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
%>

<script language="javascript">
	function edits() {
		location.href="group_edit2.jsp?id_midcategory=<%=id_midcategory%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* �ҿ����� �����Ͻðڽ��ϱ�?" );
       if (st == true) {
           document.location = "group_delete2.jsp?id_midcategory=<%=id_midcategory%>";
       }
    }
</script>
<html>
<head>
	<title>:: �ҿ��� Ȯ�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ҿ��� Ȯ�� <span> �ҿ��� Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�뿵����</td>
				<td width="200"><%=rst.getCategory()%></td>
			</tr>
			<tr>
				<td id="left">�ҿ����ڵ�</td>
				<td><%=id_midcategory%></td>
			</tr>
			<tr>
				<td id="left">�ҿ�����</td>
				<td><%=rst.getMidcategory()%></td>
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
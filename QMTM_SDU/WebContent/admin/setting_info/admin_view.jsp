<%
//******************************************************************************
//   ���α׷� : admin_view.jsp
//   �� �� �� : ������ Ȯ��
//   ��    �� : ������ Ȯ�� �˾� ������
//   �� �� �� : qt_adminid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	// ������ ���������
	AdminBean rst = null;

	try {
		rst = AdminUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
		
	String yn_use = rst.getYn_valid();

	if(yn_use.equalsIgnoreCase("Y")) {
	   yn_use = "���";
	} else {
	   yn_use = "�̻��";
	}

%>

<script language="javascript">
	function edits() {
		location.href="admin_edit.jsp?userid=<%=userid%>";
	}
	
	//--  ����üũ
    function dels()  {
       var st = confirm("*����* �����ڸ� ���� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "admin_delete.jsp?userid=<%=userid%>";
       }
    }
</script>
<HTML>
<HEAD>
<TITLE> ������ Ȯ�� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ ����Ȯ�� <span>������ ����Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">���̵�</td>
				<td width="300"><%=userid%></td>
			<tr>
				<td id="left">��й�ȣ</td>
				<td>********</td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><%=rst.getName()%></td>
			</tr>
			<tr>
				<td id="left">�޴���</td>
				<td><%=ComLib.nullChk2(rst.getHp())%></td>
			</tr>
			<tr>
				<td id="left">�̸���</td>
				<td><%=ComLib.nullChk2(rst.getEmail())%></td>
			</tr>			
			<tr>
				<td id="left">������ �Ҽ�</td>
				<td><textarea name="rmk" cols="35" rows="3"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">�����������</td>
				<td><%=yn_use%></td>
			</tr>
	</table>
	</div>

	<div id="button">
		<input type="button" value="�����ϱ�" class="form" onClick="edits();"><!--&nbsp;&nbsp;<input type="button" value="�����ϱ�" class="form" onClick="dels();">-->&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

</BODY>
</HTML>
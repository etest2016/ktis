<%
//******************************************************************************
//   ���α׷� : manager_view.jsp
//   �� �� �� : ����� Ȯ��
//   ��    �� : ����� Ȯ�� �˾� ������
//   �� �� �� : qt_workerid
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, 
//             qmtm.admin.manager.ManagerUtil
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// ����� ���������
	ManagerBean rst = null;

	try {
		rst = ManagerUtil.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String yn_use = rst.getYn_valid();

	if(yn_use.equalsIgnoreCase("Y")) {
	   yn_use = "����";
	} else {
	   yn_use = "�Ұ���";
	}

	String password = rst.getPassword();
	
%>

<script language="javascript">
	function edits() {
		location.href="manager_edit.jsp?userid=<%=userid%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* ����ڸ� �����Ͻðڽ��ϱ�? \n\n ����ڸ� �����Ͻø� ����� ��� ���� ������ �Բ� �����˴ϴ�." );
       if (st == true) {
           document.location = "manager_delete.jsp?userid=<%=userid%>";
       }
    }
</script>
<HTML>
<HEAD>
<TITLE> ����� Ȯ�� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="manager_insert_ok.jsp">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">����� ����Ȯ�� <span>����� ����Ȯ�� �� ����,����</span></div></td>
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
				<td><%=password%></td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><%=rst.getName()%></td>
			</tr>
			<tr>
				<td id="left">����� �Ҽ�</td>
				<td><textarea name="rmk" cols="35" rows="3"><%=rst.getContent1()%></textarea></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><%=yn_use%></td>
			</tr>
	</table>
	</div>

<div id="button">
<a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
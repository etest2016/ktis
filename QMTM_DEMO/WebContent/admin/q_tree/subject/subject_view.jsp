<%
//******************************************************************************
//   ���α׷� : subject_view.jsp
//   �� �� �� : ����Ȯ��
//   ��    �� : �������� ����Ȯ�� �˾� ������
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);       
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject= ""; } else { id_q_subject = id_q_subject.trim(); }

	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));
	
		if(true) return ;
	}
	
	// �������� ���������
	QmanTreeBean rst = null;

    try {
	    rst = QmanTree.getBean(id_q_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
    }

	String yn_valid = "";
	if(rst.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "����";
	} else {
		yn_valid = "�����";
	}
%>
<html>
<head>
<title></title>
<script language="javascript">
	function sub_edit() {
		location.href="subject_edit.jsp?id_q_subject=<%=id_q_subject%>";
	}
	
	//--  ���� ����üũ
    function sub_delete()  {
       var st = confirm("*����* ���������� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "subject_delete.jsp?id_q_subject=<%=id_q_subject%>";
       }
    }
</script>

</head>

<BODY id="admin">
<table border="0" width="300" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" style="width: 100%; margin-bottom: 20px; margin-top: 30px; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<tr height="30" style="height: 30px; text-align: center; background-image: url(../../../images/tableyj_top2.gif); background-repeat: repeat-x; font-size: 10pt;">
		<td colspan="2" width="30%" align="center">����Ȯ��</td>
	</tr>

	<tr height="30">
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d;">�����&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #a9da6d;">&nbsp;&nbsp;<%=rst.getQ_subject()%></td>
	</tr>
	<tr height="30">
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d;">��������&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #a9da6d;">&nbsp;&nbsp;<%=yn_valid%></td>
	</tr>
	<tr height="30">
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d;">�������&nbsp;</td>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #a9da6d;">&nbsp;&nbsp;<%=rst.getRegdate()%></td>
	</tr>
</table>

<p>
<center>
<!--<input type="button" value="�����ϱ�" onClick="sub_edit();">--><a href="javascript:sub_edit();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="�����ϱ�" onClick="sub_delete();">--><a href="javascript:sub_delete();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>
</center>

</body>
</html>
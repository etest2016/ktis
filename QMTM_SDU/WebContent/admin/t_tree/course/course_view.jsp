<%
//******************************************************************************
//   ���α׷� : course_view.jsp
//   �� �� �� : ����Ȯ��
//   ��    �� : ����Ȯ�� �˾� ������
//   �� �� �� : c_course
//   �ڹ����� : qmtm.admin.TmanTreeBean, qmtm.admin.TmanTree
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if (id_course.length() == 0 || id_category.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	
	// �������� ���������
	TmanTreeBean rst = null;

    try {
	    rst = TmanTree.getBean(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	String yn_valid = "";
	if(rst.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "����";
	} else {
		yn_valid = "�����";
	}
%>

<script language="javascript">
	function sub_edit() {
		location.href="course_edit.jsp?id_category=<%=id_category%>&id_course=<%=id_course%>";
	}
	
	//--  ���� ����üũ
    function sub_delete()  {
       var st = confirm("*����* ���������� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "course_delete.jsp?id_course=<%=id_course%>";
       }
    }
</script>

<HTML>
<HEAD>
<TITLE> �������� Ȯ�� </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� Ȯ�� <span>����Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">������</td>
				<td width="200"><%=rst.getCourse()%></td>
			</tr>
			<tr>
				<td id="left">��������</td>
				<td><%=yn_valid%></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
	</div>

<div id="button">
<!--<input type="button" value="�����ϱ�" onClick="sub_edit();">--><a href="javascript:sub_edit();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="�����ϱ�" onClick="sub_delete();">--><a href="javascript:sub_delete();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="â�ݱ�" onClick="window.close();">--><a href="javascript:window.close();"><img border="0" src="../../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
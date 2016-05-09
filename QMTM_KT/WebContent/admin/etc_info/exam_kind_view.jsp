<%
//******************************************************************************
//   ���α׷� : exam_kind_view.jsp
//   �� �� �� : �׷챸��Ȯ��
//   ��    �� : �׷챸��Ȯ�� �˾� ������
//   �� �� �� : r_exam_kind
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil
//   �� �� �� : 2010-06-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam_kind = request.getParameter("id_exam_kind");
	if (id_exam_kind == null) { id_exam_kind= ""; } else { id_exam_kind = id_exam_kind.trim(); }

	if (id_exam_kind.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	ExamKindBean rst = null;

    try {
	    rst = ExamKindUtil.getBean(id_exam_kind);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	function edits() {
		location.href="exam_kind_edit.jsp?id_exam_kind=<%=id_exam_kind%>";
	}
	
	//--  ����üũ
    function deletes()  {
       var st = confirm("*����* �׷챸�и� �����Ͻðڽ��ϱ�? " );
       if (st == true) {
           document.location = "exam_kind_delete.jsp?id_exam_kind=<%=id_exam_kind%>";
       }
    }
</script>
<html>
<head>
	<title>:: �׷챸�� Ȯ�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�׷챸�� Ȯ�� <span> �׷챸�� Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ڵ�</td>
				<td width="200"><%=id_exam_kind%></td>
			</tr>
			<tr>
				<td id="left">�׷챸��</td>
				<td><%=rst.getExam_kind()%></td>
			</tr>
			<tr>
				<td id="left">����</td>
				<td><textarea name="rmk" rows="3" cols="25" readonly><%=ComLib.nullChk(rst.getRmk())%></textarea></td>
			</tr>
	</table>
</div>

<div id="button">
<!--<input type="button" onClick="edits()" value="�����ϱ�">--><a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onClick="deletes()"  value="�����ϱ�">--><a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<!--<input type="button" onclick="window.close()" value="â�ݱ�">--><a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
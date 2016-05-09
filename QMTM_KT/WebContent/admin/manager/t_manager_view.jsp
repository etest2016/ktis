<%
//******************************************************************************
//   ���α׷� : t_manager_view.jsp
//   �� �� �� : ����� ������ Ȯ��
//   ��    �� : ����� ������ Ȯ�� �˾� ������
//   �� �� �� : t_worker_subj, c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil
//   �� �� �� : 2010-06-10
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	if (userid.length() == 0 || id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// ����� ���� ���������
	ManagerTBean rst = null;

	try {
		rst = ManagerTUtil.getBean(userid, id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>
<HTML>
<HEAD>
	<TITLE> :: [TMan] �������� ��ȸ :: </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<script language="javascript">
		function edits() {
			location.href="t_manager_edit.jsp?userid=<%=userid%>&id_course=<%=id_course%>";
		}
		
		//--  ����üũ
		function deletes()  {
		   var st = confirm("*����* �������� �����Ͻðڽ��ϱ�?" );
		   if (st == true) {
			   document.location = "t_manager_delete.jsp?userid=<%=userid%>&id_course=<%=id_course%>";
		   }
		}
	</script>
</HEAD>

<BODY ID="popup2">

	<form name="frmdata" method="post" action="t_manager_insert_ok.jsp">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">[TMan] �������� ��ȸ <span>��� �������� ��ȸ �� ����, ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<table cellpadding="0" cellspacing="0" border="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="110">������&nbsp;</td>
				<td><%=rst.getCourse()%></td>
			</tr>
			<tr>
				<td id="left">������������&nbsp;</td>
				<td><%=rst.getPt_exam_edit()%></td>
			</tr>
			<tr>
				<td id="left">�����������&nbsp;</td>
				<td><%=rst.getPt_exam_delete()%></td>
			</tr>
			<tr>
				<td id="left">�������������&nbsp;</td>
				<td><%=rst.getPt_answer_edit()%></td>
			</tr>
			<tr>
				<td id="left">ä����������&nbsp;</td>
				<td><%=rst.getPt_score_edit()%></td>
			</tr>
			<tr>
				<td id="left">����������&nbsp;</td>
				<td><%=rst.getPt_static_edit()%></td>
			</tr>
			<tr>
				<td id="left">�������&nbsp;</td>
				<td><%=rst.getRegdate()%></td>
			</tr>	
		</table>
	</div>

	<div id="button">
		<a href="javascript:edits();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:deletes();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
	</div>


	

	</form>

</BODY>
</HTML>
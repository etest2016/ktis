<%
//******************************************************************************
//   ���α׷� : q_manager_edit.jsp
//   �� �� �� : ����� ������ ����
//   ��    �� : ����� ������ ���� �˾� ������
//   �� �� �� : q_worker_subj, q_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil
//   �� �� �� : 2010-06-10
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil " %>
<%@ include file = "/common/admin_chk.jsp" %>

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
	<TITLE> :: �������� ���� :: </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<HEAD>

<BODY ID="popup2">

	<form name="frmdata" method="post" action="q_manager_update.jsp">
	<input type="hidden" name="userid" value="<%=userid%>">
	<input type="hidden" name="id_course" value="<%=id_course%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� ���� <span>���� ������ ���� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">

		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableD" width="100%">

			<tr>
				<td id="left">������&nbsp;</td>
				<td><%=rst.getCourse()%></td>
			</tr>
			<tr>
				<td id="left">������������&nbsp;</td>
				<td><input type="checkbox" name="q_edit" value="Y" <% if(rst.getPt_q_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">������������&nbsp;</td>
				<td><input type="checkbox" name="q_del" value="Y" <% if(rst.getPt_q_delete().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">������������&nbsp;</td>
				<td><input type="checkbox" name="exam_edit" value="Y" <% if(rst.getPt_exam_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">�����������&nbsp;</td>
				<td><input type="checkbox" name="exam_del" value="Y" <% if(rst.getPt_exam_delete().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">�������������&nbsp;</td>
				<td><input type="checkbox" name="answer_edit" value="Y" <% if(rst.getPt_answer_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">ä����������&nbsp;</td>
				<td><input type="checkbox" name="score_edit" value="Y" <% if(rst.getPt_score_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
			<tr>
				<td id="left">����������&nbsp;</td>
				<td><input type="checkbox" name="static_edit" value="Y" <% if(rst.getPt_static_edit().equals("Y")) { %> checked <% } %>></td>
			</tr>
		</table>
	</div>

	<div id="button">
		<input type="image" value="�����ϱ�" name="submit" src="../../images/bt5_edit_yj1.gif">&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif">
	</div>

	

	</form>

</BODY>
</HTML>
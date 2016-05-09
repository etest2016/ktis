<%
//******************************************************************************
//   ���α׷� : t_manager_insert.jsp
//   �� �� �� : ����� �������
//   ��    �� : ����� ������� �˾� ������
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

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    // ����� ������ ��� ���������
	ManagerTBean[] rst = null;

	try {
		rst = ManagerTUtil.getAddBeans(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD>
  <TITLE> :: ������ �߰� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="JavaScript">
	function checks() {
		var frm = document.form1;
		var cnt = 0;

		if (frm.courses.length == undefined) { //�Ѱ��϶� üũ
			if(frm.courses.checked==true ) {
			   cnt = cnt + 1;
			} 
		}else{

			for(i=0;i<frm.courses.length;i++) {
				if(frm.courses[i].checked) {
					cnt = cnt + 1;
				}
			}
		}
			
		if(cnt == 0) {
			alert("������ �����ϼ���.!!!");
			return;
		}

		frm.submit();
    }	
 </script>

 </HEAD>

 <BODY id="popup2">
	
	<form name="form1" method="post" action="t_manager_insert_ok.jsp">
	<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ �߰� <span>���� ����ڿ��� ������ �ο��� ���� �� ���� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	
	<div id="contents" style="text-align: center;">
		
		<TABLE width="960" cellpadding="3" cellspacing="0" border="0" id="tableA">
			<tr id="tr4">
				<td width="9%" height="40" align="center" bgcolor="#DBDBDB">����</td>
				<td>�����ڵ�</td>
				<td>������</td>
				<td width="50">������������</td>
				<td width="50">�����������</td>
				<td width="40">���������</td>
				<td width="35">ä������</td>
				<td width="35">������</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="8">�߰��Ͻ� ������ �����ϴ�.</td>
			</tr>
			
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>

			<tr id="td" align="center">
				<td><input type="checkbox" name="courses" value="<%=rst[i].getId_course()%>"></td>
				<td><%=rst[i].getId_course()%></td>
				<td><%=rst[i].getCourse()%></td>
				<td><input type="checkbox" name="exam_edit<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="exam_del<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="answer_edit<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="score_edit<%=rst[i].getId_course()%>" value="Y"></td>
				<td><input type="checkbox" name="static_edit<%=rst[i].getId_course()%>" value="Y"></td>
			</tr>
			<%
				   }
				}
			%>
		</table>

	</div>

	<div id="button">
		<% if(rst != null) { %><!--<input type="button" value="�����߰��ϱ�" onClick="checks();">--><a href="javascript:checks();"><img src="../../images/bt_t_insertyj_1.gif"></a><% } %>&nbsp;&nbsp;<!--<input type="button" value="â�ݱ�" onClick="window.close();">--><a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a>
	</div>			
	
 </BODY>
</HTML>
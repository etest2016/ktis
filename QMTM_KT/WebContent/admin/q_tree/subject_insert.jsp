<%
//******************************************************************************
//   ���α׷� : subject_insert.jsp
//   �� �� �� : ������
//   ��    �� : ������ �˾� ������
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil
//   �� �� �� : 2010-06-07
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (userid.length() == 0 || id_category.length() == 0 || id_course.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	// �׷챸�и�� ���������
	GroupKindBean[] rst = null;

	try {
		rst = GroupKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%> 

<HTML>
 <HEAD>
  <TITLE> :: �ű԰��� ��� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_subject.value == "") {
				alert("������� �Է��ϼ���");
				frm.q_subject.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>

 </HEAD>

 <BODY id="popup2">
	
	<form name="frmdata" method="post" action="subject_insert_ok.jsp">
	<input type="hidden" name="id_category" value="<%=id_category%>">
	<input type="hidden" name="id_course" value="<%=id_course%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ű԰��� ��� <span>�� ������ ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td width="30%" id="left">�����</td>
				<td width="60%"><input type="text" class="input" name="q_subject" size="25"></td>
			</tr>
		</table>
		
	</div>

	<div id="button">
		<img src="../../images/bt5_sjinsert_yj2.gif" border="0" onClick="send();" style="cursor:hand">&nbsp;&nbsp;<img onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();" style="cursor:hand">
	</div>

	</form>

 </BODY>
</HTML>
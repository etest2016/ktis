<%
//******************************************************************************
//   ���α׷� : subject_insert.jsp
//   �� �� �� : ������
//   ��    �� : ������ �˾� ������
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.SubjectUtil
//   �� �� �� : 2013-02-05
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.SubjectUtil " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
		
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (userid.length() == 0 || id_course.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	// ���ļ���
	int order_cnt = 0;

	try {
		order_cnt = SubjectUtil.getOrderCnt(id_course);
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
				<td width="70%"><input type="text" class="input" name="q_subject" size="25" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">���ļ���</td>
				<td><select name="subject_order">
			<% for(int i = 1; i <= 15; i++) { %>	
				<option value="<%=i%>" <%if(order_cnt == i) {%>selected<% } %>><%=i%></option>
			<% } %></td>
			</tr>
		</table>
		
	</div>

	<div id="button">
		<input type="button" value="����ϱ�" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

	</form>

 </BODY>
</HTML>
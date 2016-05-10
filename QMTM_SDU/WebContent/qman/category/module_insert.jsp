<%
//******************************************************************************
//   ���α׷� : module_insert.jsp
//   �� �� �� : �����
//   ��    �� : ����� �˾� ������
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.ModuleUtil
//   �� �� �� : 2013-02-05
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.ModuleUtil " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
		
	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (userid.length() == 0 || id_subject.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	// ���ļ���
	int order_cnt = 0;

	try {
		order_cnt = ModuleUtil.getOrderCnt(id_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

%> 

<HTML>
 <HEAD>
  <TITLE> :: �űԴܿ� ��� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.q_module.value == "") {
				alert("�ܿ����� �Է��ϼ���");
				frm.q_module.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>

 </HEAD>

 <BODY id="popup2">
	
	<form name="frmdata" method="post" action="module_insert_ok.jsp">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�űԴܿ� ��� <span>�� �ܿ��� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			
			<tr>
				<td width="30%" id="left">�ܿ���</td>
				<td width="70%"><input type="text" class="input" name="q_module" size="25" style="ime-mode:active;"></td>
			</tr>
			<tr>
				<td id="left">���ļ���</td>
				<td><select name="module_order">
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
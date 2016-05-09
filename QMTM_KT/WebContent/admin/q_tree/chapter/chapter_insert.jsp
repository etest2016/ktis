<%
//******************************************************************************
//   ���α׷� : chapter_insert.jsp
//   �� �� �� : �ܿ����
//   ��    �� : �ܿ���� �˾� ������
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil              
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }
		
	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
		
	int chapter_order = 0;

	// �ܿ����� ���������
	try {
		chapter_order = 1 + ChapterQmanUtil.getCnt(id_q_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>


<HTML>
<HEAD>
<TITLE> :: �űԴܿ�1 ��� :: </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">

<script language="JavaScript">

		function send() {
			var frm = document.frmdata;
			
			if(frm.chapter.value == "") {
				alert("�ܿ����� �Է��ϼ���");
				frm.chapter.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>
	
</HEAD>


<BODY id="popup2">

	<form name="frmdata" method="post" action="chapter_insert_ok.jsp">
	<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�űԴܿ�1 ��� <span>�� �ܿ�1�� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
 
	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ܿ���</td>
				<td width="230"><input type="text" class="input" name="chapter" size="30"></td>
			</tr>
			<tr>
				<td id="left">���ļ���</td>
				<td><select name="chapter_order">
			<% for(int i = 1; i <= 10; i++) { %>	
				<option value="<%=i%>" <%if(chapter_order == i) {%>selected<% } %>><%=i%></option>
			<% } %></td>
			</tr>
		</table>
	<div>

	<div id="button">
		<img src="../../../images/bt_chapter_ins_yj1.gif" onfocus="this.blur();" onClick="send();" style="cursor:hand">&nbsp;
		<img onclick="window.close();" src="../../../images/bt5_exit_yj1.gif" onfocus="this.blur();" style="cursor:hand">
	</div>
		
	</form>

</body>
</HTML>
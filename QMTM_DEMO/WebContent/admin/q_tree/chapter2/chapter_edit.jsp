<%
//******************************************************************************
//   ���α׷� : chapter_edit.jsp
//   �� �� �� : �ι�° �ܿ�����
//   ��    �� : �������� �ι�° �ܿ����� ������
//   �� �� �� : q_chapter2
//   �ڹ����� : qmtm.admin.qman.Chapter2QmanUtil, qmtm.admin.qman.Chapter2QmanBean
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

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_subject.length() == 0 || id_q_subject.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
	
	// �ܿ����� ���������
	Chapter2QmanBean rst = null;

    try {
	    rst = Chapter2QmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>
<TITLE> �ܿ����� ���� </TITLE>
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

<form name="frmdata" method="post" action="chapter_update.jsp">
<input type="hidden" name="id_subject" value="<%=id_subject%>">
<input type="hidden" name="id_q_subject" value="<%=id_q_subject%>">
<input type="hidden" name="id_q_chapter" value="<%=id_q_chapter%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ܿ�����<span>�ܿ��� �� ���ļ��� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ܿ���&nbsp;</td>
				<td width="230">&nbsp;&nbsp;<input type="text" class="input" name="chapter" value="<%=rst.getChapter()%>" size="30"></td>
			</tr>
			<tr>
				<td id="left">���ļ���&nbsp;</td>
				<td>&nbsp;&nbsp;<select name="chapter_order">
		<% for(int i = 1; i <= 10; i++) { %>	
			<option value="<%=i%>" <%if(rst.getChapter_order() == i) {%>selected<% } %>><%=i%></option>
		<% } %>
				</td>
			</tr>
			<tr>
				<td id="left">�������&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rst.getRegdate()%></td>
			</tr>
	</table>
	</div>

<div id="button">
<img src="../../../images/bt5_edit_yj1.gif" onClick="send();" style="cursor:hand">&nbsp;&nbsp;<img border="0" src="../../../images/bt5_exit_yj1.gif" border="0" align="adsmiddle" style="cursor:hand" onClick="window.close();">
</div>

</form>

</BODY>
</HTML>
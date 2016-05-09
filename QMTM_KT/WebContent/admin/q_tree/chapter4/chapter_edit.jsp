<%
//******************************************************************************
//   ���α׷� : chapter_edit.jsp
//   �� �� �� : �׹�° �ܿ�����
//   ��    �� : �������� �׹�° �ܿ����� ������
//   �� �� �� : q_chapter4
//   �ڹ����� : qmtm.admin.qman.Chapter4QmanUtil, qmtm.admin.qman.Chapter4QmanBean
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

	String id_chapter1 = request.getParameter("id_chapter1"); 
	if (id_chapter1 == null) { id_chapter1 = ""; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2"); 
	if (id_chapter2 == null) { id_chapter2 = ""; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("id_chapter3"); 
	if (id_chapter3 == null) { id_chapter3 = ""; } else { id_chapter3 = id_chapter3.trim(); }
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_subject.length() == 0 || id_chapter1.length() == 0 || id_chapter2.length() == 0 || id_chapter3.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// �ܿ����� ���������
	// �ܿ����� ���������
	Chapter4QmanBean rst = null;

    try {
	    rst = Chapter4QmanUtil.getBean(id_q_chapter);
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
<input type="hidden" name="id_chapter1" value="<%=id_chapter1%>">
<input type="hidden" name="id_chapter2" value="<%=id_chapter2%>">
<input type="hidden" name="id_chapter3" value="<%=id_chapter3%>">
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
				<td>&nbsp;&nbsp;<input type="text" class="input" name="chapter" value="<%=rst.getChapter()%>" size="30"></td>
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
<img src="../../../images/bt5_edit_yj1.gif" onClick="send();" style="cursor:hand">&nbsp;&nbsp;<img border="0" src="../../../images/bt5_exit_yj1.gif" style="cursor:hand" onClick="window.close();">
</div>

</form>

</BODY>
</HTML>
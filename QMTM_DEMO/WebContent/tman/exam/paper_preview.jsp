<%
//******************************************************************************
//   ���α׷� : paper_preview.jsp
//   �� �� �� : ������ �̸����� �ɼ� ����
//   ��    �� : ������ �̸����� �ɼ� ����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-05-16
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }
	
	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}
%>
<HEAD>
<TITLE> :: ������ �̸����� - �ɼ� ����:: </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

	<form name="frmdata" method="post" action="paper_preview_res.jsp">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="nr_set" value="<%=nr_set%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ �̸����� �ɼǼ��� <span></span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="25%" align="center">ǥ���׸�<br>����</td>
				<td>

					<input type="checkbox" name="ref" checked disabled> ����
					<input type="checkbox" name="q" checked disabled> ����
					<input type="checkbox" name="ex" checked disabled> ����

					<hr>

					<input type="checkbox" name="answer" value="Y">����&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="explain" value="Y">�ؼ�&nbsp;&nbsp;
					<input type="checkbox" name="hint" value="Y">��Ʈ<br>

					<input type="checkbox" name="diff" value="Y">���̵�&nbsp;
					<input type="checkbox" name="allott" value="Y">����&nbsp;&nbsp;
					<input type="checkbox" name="id_q" value="Y">�����ڵ�


				</td>
			</tr>
		</table>
	</div>

	<div id="button">
		<input type="image" value="������ �̸�����" name="submit" src="../../images/bt_paper_preview_yj1.gif">&nbsp;
		<input type="image" value="���" onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

	</form>

</BODY>
</HTML>
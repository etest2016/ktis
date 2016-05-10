<%
//******************************************************************************
//   ���α׷� : paper_guide_view.jsp
//   �� �� �� : �����ȳ��� Ȯ��
//   ��    �� : �����ȳ��� Ȯ��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.paper.ExamPaperGuide
//   �� �� �� : 2008-05-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	int nr_q = Integer.parseInt(request.getParameter("nr_q"));

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	// �ش� ���迡 �����ȳ����� ������ �´�.

	ExamPaperGuideBean rst = null;

	try {
		rst = ExamPaperGuide.getBean(id_exam, nr_q);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="JavaScript">

	function guide_del() {
		var st = confirm("*����* �����ȳ����� �����Ͻðڽ��ϱ�?" );
        if (st == true) {
			document.location = "paper_guide_delete.jsp?id_exam=<%=id_exam%>&nr_q=<%=nr_q%>";
        }
	}

	function guide_edit() {
		document.location = "paper_guide_edit.jsp?id_exam=<%=id_exam%>&nr_q=<%=nr_q%>";
	}

</script>
<HEAD>
<TITLE> �����ȳ��� Ȯ�� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����ȳ��� Ȯ�� <span>�����ȳ��� Ȯ�ι� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�����ȳ��� ���۹�ȣ</td>
				<td>&nbsp;&nbsp;<%=nr_q%></td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="guide_msg" cols="40" rows="5" readonly><%=rst.getGuide_msg()%></textarea></td>
			</tr>
		</table>
		</div>

	<div id="button">
		<!--<input type="button" value="�����ϱ�" onClick="guide_edit();">--><a href="javascript:guide_edit();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="�����ϱ�" onClick="guide_del();">--><a href="javascript:guide_del();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;
		<input type="image" value="���" onclick="window.close();" src="../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

	</form>

</BODY>
</HTML>
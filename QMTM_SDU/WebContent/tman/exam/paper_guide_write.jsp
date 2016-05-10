<%
//******************************************************************************
//   ���α׷� : paper_guide_write.jsp
//   �� �� �� : �����ȳ��� ���
//   ��    �� : �����ȳ��� ���
//   �� �� �� : 
//   �ڹ����� : 
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

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	// �ش� ���迡 ������ �ִ��ȣ�� ������´�.
	
	int q_cnts = 0;

	try {
		q_cnts = ExamPaperGuide.getPaperQcnt(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="JavaScript" type="text/javascript">
    <!--
    
	function checks() {
		if(document.frmdata.guide_msg.value == "") {
			alert("���ù� ������ �Է��ϼ���.");
			return false;
		} else {
			document.frmdata.submit();
		}
	}

	//-->

</script>
<HEAD>
<TITLE> �����ȳ��� ��� </TITLE>
 <link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="paper_guide_insert.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����ȳ��� ��� <span>�����ȳ��� ������ ���</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	
	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�����ȳ������۹�ȣ</td>
				<td><select name="nr_q">
					<% for(int i=0; i<q_cnts; i++) { %>
					<option value="<%=i+1%>">&nbsp;&nbsp;&nbsp;# <%=i+1%>&nbsp;&nbsp;&nbsp;</option>
					<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="guide_msg" cols="40" rows="5"></textarea></td>
			</tr>
		</table>
	</div>

	<div id="button">
		<a href="javascript:checks();"><img border="0" src="../../../images/bt_paper_checks_yj1.gif"></a>&nbsp;
		<input type="image" value="���" onclick="window.close();" src="../../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

	</form>

</BODY>
</HTML>
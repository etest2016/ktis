<%
//******************************************************************************
//   ���α׷� : paper_guide_edit.jsp
//   �� �� �� : �����ȳ��� ���
//   ��    �� : �����ȳ��� ���
//   �� �� �� : exam_paper_guide
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

	// �ش� ���迡 ������ �ִ��ȣ�� ������´�.
	
	int q_cnts = 0;

	try {
		q_cnts = ExamPaperGuide.getPaperQcnt(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
	
	// �ش� ���迡 �����ȳ����� �����Ѵ�.

	ExamPaperGuideBean rst = null;

	try {
		rst = ExamPaperGuide.getBean(id_exam, nr_q);
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
<TITLE> �����ȳ��� ���� </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
 <link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="paper_guide_update.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="nr_qs" value="<%=nr_q%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����ȳ��� ���� <span>�����ȳ��� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="48%">�����ȳ������۹�ȣ</td>
				<td>&nbsp;&nbsp;<select name="nr_q">
					<% for(int i=0; i<q_cnts; i++) { %>
					<option value="<%=i+1%>" <% if(nr_q == (i+1)) { %> selected <% } %>>&nbsp;&nbsp;&nbsp;# <%=i+1%>&nbsp;&nbsp;&nbsp;</option>
					<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="guide_msg" cols="40" rows="5"><%=rst.getGuide_msg()%></textarea></td>
			</tr>
		</table>
	</div>

	<div id="button">
	<!--<input type="button" value="�����ϱ�" onClick="checks();">--><a href="javascript:checks();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;
		<input type="image" value="���" onclick="window.close();" src="../../../images/bt5_exit_yj1.gif" onfocus="this.blur();">
	</div>

	</form>

</BODY>
</HTML>
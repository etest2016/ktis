<%
//******************************************************************************
//   ���α׷� : web_preview.jsp
//   �� �� �� : ������ �������� �̸�����
//   ��    �� : ������ �������� �̸�����
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.exam.ExamList
//   �� �� �� : 2010-06-18
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;	
	}

	String title = "";

	try {
		title = ExamList.getExamTitle(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
<HEAD>
<TITLE> :: ������ �̸����� :: </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">
<!--

	function frameofTest()
	{
		window.open("../../user/paper/fraTest.jsp?id_exam=<%= id_exam %>&userid=tman@@2008", "test_exampaper", "fullscreen=yes, scrollbars=yes");
	}

//-->
</script>


<HEAD>

<BODY id="popup2">   

   <div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� �̸����� <span>�������� �̸� Ȯ���մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table id="tableD" cellpadding="0" border="0" cellspacing="0">
			<tr>
				<td id="left" width="65"><li>�����</td>
				<td><%=title%></td>
			</tr>
			<tr>
				<td id="left">&nbsp;</td>
				<td>
					<input type="text" class="input" name="userid" value="tman@@2008" readonly size="14"><br>
					<div class="point_s" style="margin-top: 5px;">* �ش� ���̵�� ������ �������� �̸� Ȯ���� �� ������, ��� �����Ŀ��� �ݺ��ؼ� ���迡 ������ �� �ֽ��ϴ�.</div>
				</td>
			</tr>
		</table>		

	</div>

	<div id="button">
		<a href="javascript:frameofTest();" onfocus="this.blur();"><img src="../../images/bt_paper_preview_yj1.gif"></a>&nbsp;&nbsp;<img src="../../images/bt5_exit_yj1_11.gif" onclick="window.close();" style="cursor: hand;">
	</div>


 </BODY>
</HTML>

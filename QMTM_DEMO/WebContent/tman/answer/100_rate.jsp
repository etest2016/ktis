<%
//******************************************************************************
//   ���α׷� : 100_rate.jsp
//   �� �� �� : 100�� ���� ���� ȯ������
//   ��    �� : 100�� ���� ���� ȯ������
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   �� �� �� : 2009-02-26
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	double allottings = 0;
	String score100_yn = "";
	String rate100_yn = "";

	ExamCreateBean rst = null;
	
	try {
	    rst = ExamUtil.getInfos(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

	if(rst == null) {
		allottings = 0;
		score100_yn = "";
	} else {
		allottings = rst.getAllotting();
		score100_yn = rst.getScore100_yn();
		rate100_yn = rst.getRate100_yn();
	}

%>

<HTML>
 <HEAD>
  <TITLE> 100�� ���� ���������� ó�� </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="JavaScript">
		function Send()
		{
			var str;

			str = confirm("100�� ������ ������ ȯ���Ͻðڽ��ϱ�? \n\n������ 100���������� ȯ���߰ų�, \n100�� ������ ������ ȯ��������쿡�� �ʱ�ȭ���Ŀ� �����Ͻñ� �ٶ��ϴ�.\n\n�����Ͻ÷��� Ȯ���ϱ⸦ Ŭ���ϼ���.");
			if(str == true) {
				document.form1.submit();			
			}
		}

		function score_reset() 
		{
			var str;

			str = confirm("������ 100�� �������� ȯ���� ������ �ʱ�ȭ�Ͻðڽ��ϱ�\n\n�����Ͻ÷��� Ȯ���ϱ⸦ Ŭ���ϼ���.");
			if(str == true) {
				location.href="100_score_reset.jsp?id_exam=<%=id_exam%>&allott=<%=allottings%>";
			}				
		}

		function rate_reset() 
		{
			var str;

			str = confirm("������ 100�� ������ ȯ���� ������ �ʱ�ȭ�Ͻðڽ��ϱ�\n\n�����Ͻ÷��� Ȯ���ϱ⸦ Ŭ���ϼ���.");
			if(str == true) {
				location.href="100_rate_reset.jsp?id_exam=<%=id_exam%>&allott=<%=allottings%>";
			}				
		}
	</script>
	</head>

<BODY style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;" id="tman">
<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>


<center>
<form name="form1" method="post" action="100_rate_ok.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="allott" value="<%=allottings%>">

<table width="95%" border="0" cellpadding="1" cellspacing="1" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
	
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3">* �ش� ���迡 �����Ǿ��� ������ <%=allottings%> �Դϴ�.</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3"></td>
	</tr>
	<tr bgcolor="#FFFFFF" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">
		<td colspan="3"><font color="red"><b>100�� ���� ȯ������ ����</b></font>&nbsp;&nbsp;&nbsp;<%if(rate100_yn.equals("Y")) { %><a href="javascript:alert('������ 100�� ���������� ������ �ϼ̽��ϴ�.\n\n�ٽ� �����Ͻ÷��� �ϴܿ� �������� �����Ͻ� �Ŀ� �������ֽñ� �ٶ��ϴ�.');"><% } else { %><a href="javascript:Send();"><% } %><img border="0" src="../../images/bt3_action.gif" align="absmiddle"></a>
		</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td height="5" colspan="3"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="50">
		<td colspan="3" valign="middle" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"> �����ϱ⸦ Ŭ���Ͻø� �ش� ���迡 ������ ������ 100�� ���������� ȯ���մϴ�.<br><br>ex)������ 4���̰� ������������ 2���ϰ�쿡�� 100�� ���� ���������� ȯ���ϸ� 50���� �˴ϴ�.</td>
	</tr>
</table>
<br>
<table width="95%" border="0" cellpadding="1" cellspacing="1" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<tr bgcolor="#FFFFFF" height="50">
		<td colspan="3" valign="middle" style="background-color: #FCFCFC; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"> ������ 100�� ������ ȯ���� �����ϼ��� ��� �Ʒ� [Ŭ���ϱ�] �� ���ؼ� ������ �������� ���� �� �Ŀ� �������ֽñ� �ٶ��ϴ�.</td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="40">
		<td> <font color="red"><b>100�� ���� ȯ������ �������� ����</b></font>&nbsp;&nbsp;&nbsp;<%if(rate100_yn.equals("Y")) { %><a href="javascript:rate_reset();"><% } else { %><a href="javascript:alert('100�� ���� ȯ�������� ������ �Ͻ��Ŀ� �̿��Ͻ� �� �ֽ��ϴ�.');"><% } %>[Ŭ���ϱ�]</a></td>
	</tr>
</table>
</TD>
			<TD></TD>
		</TR>
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>
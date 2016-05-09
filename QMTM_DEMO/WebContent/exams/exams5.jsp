<%
//******************************************************************************
//   ���α׷� : 
//   �� �� �� : �������� �Ű�
//   ��    �� : 
//   �� �� �� : 
//   �ڹ����� : qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil              
//   �� �� �� : 2008-12-05
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.*, qmtm.qman.question.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    // �ű� ��� ���� ��������
	QListBean[] rst = null; 

	try {
		rst = QListUtil.getNewQ(userid);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<HTML>
<HEAD>
<TITLE> :: ������ ���� :: </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">
</HEAD>


<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ <span>������ �������� ������ �������� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" width="100%">
			<tr>
				<td width="200">Ʈ��</td>
				<td>
					::������ ���� ��ġ<br>
					<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
						<TR>
							<TD id="left">������ġ</TD>
							<TD><INPUT TYPE="text" NAME=""></TD>
						</TR>
						<TR>
							<TD id="left">������</TD>
							<TD>&nbsp;</TD>
						</TR>
						<TR>
							<TD id="left">������</TD>
							<TD>&nbsp;</TD>
						</TR>
					</TABLE>
					<br>
					�� �����Ǵ� �������� ������ ��ġ�� ������ "������ ������" ī�װ������� ���� �� [Ȯ��] ��ư�� Ŭ�� �Ͻʽÿ�.
				</td>
			</tr>
		</table>

		<div id="button">
		<input type="image" value="Ȯ��" name="submit" src="../images/bt5_submit.gif" onfocus="this.blur();">&nbsp;
		<input type="image" value="���" onclick="window.close();" src="../images/bt5_cancle.gif" onfocus="this.blur();">
		</div>

</body>
</HTML>
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

	String userid = CommonUtil.get_Cookie(request, "userid");
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
<TITLE> :: �������� �Ű� :: </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">
</HEAD>


<BODY id="popup2">

	<form name="frmdata" method="post" action="exams2_ok.jsp">
	<input type="hidden" name="id_q_subject" value="">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� �Ű� <span>�ش� ���׿� ���� ���������� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="15%">�����ڵ�</td>
				<!--�����ڵ� �Է�-->
				<td width="35%">&nbsp;</td>
				<td id="left" width="15%">��������</td>
				<td>
					<SELECT NAME="">
						<OPTION VALUE="" SELECTED>��������
						<OPTION VALUE="">
					</SELECT>
				</td>
			</tr>
			<tr>
				<td id="left">�Ű���</td>
				<td>&nbsp;</td>
				<td id="left">�Ű���</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td id="left">�Ű���</td>
				<td colspan="3">
					<textarea style="width: 100%; height: 200px;"></textarea>
				</td>
			</tr>
		</table>
	<div>
	<br>
	<span class="point_s">�� �Ű� �� ���� ������ ���� ������ �Է� �� [Ȯ��] ��ư�� Ŭ�� �Ͻʽÿ�.<br>
	&nbsp;&nbsp;(����) �ѹ� �Ű��� ���������� ������ �� �����Ƿ� ��Ȯ�ϰ� �Է��� �ֽñ� �ٶ��ϴ�.</span>


	<div id="button">
		<input type="image" value="Ȯ��" name="submit" src="../images/bt5_submit.gif" onfocus="this.blur();">&nbsp;
		<input type="image" value="���" onclick="window.close();" src="../images/bt5_cancle.gif" onfocus="this.blur();">
	</div>
	
	
	</form>

</body>
</HTML>
<%
//******************************************************************************
//   ���α׷� : q_delete.jsp
//   �� �� �� : ���� ����
//   ��    �� : �������� ���� ������ ���Ͽ� ���� ����
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2008-04-21
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 2008-07-07 
//   �� �� �� : ���׽�Ʈ ����ȣ
//	 �������� : �������� ���� ���� ����(�������� ���� ���׿� ���ؼ�)
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>  
<%@ page import="qmtm.*, qmtm.qman.question.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%
	}

	String[] arrId_qs = id_qs.split(",");

	QListBean[] rst = null;

	try {
		rst = QListUtil.getQHistory(id_qs);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	StringBuffer del_NQ = new StringBuffer();

	StringBuffer del_YQ = new StringBuffer();

	String res = "";
	String res2 = "";

	String del_ABC = "A";

	if(rst == null) {
		res2 = id_qs;
		res = "";
		del_ABC = "A";
	} else {
		for(int j=0; j<rst.length; j++) {
			del_NQ.append(rst[j].getId_q());
			del_NQ.append(",");
		}

		res = del_NQ.toString().substring(0, del_NQ.toString().length()-1);

		for(int k=0; k<arrId_qs.length; k++) {
			if(res.indexOf(arrId_qs[k]) < 0) {
				del_YQ.append(arrId_qs[k]);
				del_YQ.append(",");
			}
		}

		if(del_YQ.toString().length() ==0) {
			del_ABC = "B";
		} else {
			del_ABC = "C";
			res2 = del_YQ.toString().substring(0, del_YQ.toString().length()-1);
		}
	}
%>

<html>
	<head>
	<title>���� �����ϱ�</title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	</head>

	<BODY style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;" id="qman">
	
	<form name="form1" method="post" action="q_delete_ok.jsp">
	<input type="hidden" name="id_qs" value="<%=res2%>">
	<center>
	<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>
		<% if(del_ABC.equals("A")) { %>
			<table border="0" width="100%" cellpadding ="0" cellspacing="2" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
				<tr height="40" bgcolor="#DBDBDB">
					<td colspan="2" width="27%" style="background-color: #FCFCFC; text-align: left;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;���� ���õ� ������ �����Ͻðڽ��ϱ�? ������ ������ ������ �� �����ϴ�.</td>
				</tr>
				<tr height="50" bgcolor="#DBDBDB">
					<td align="left" width="27%" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">���� �����ڵ�</td>
					<td align="left" bgcolor="#FFFFFF" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"><textarea cols="60" rows="5" readonly><%=res2%></textarea></td>
				</tr>
				<tr height="30">
					<td colspan="2" width="17%" rowspan="14" bgcolor="#FFFFFF" valign="top" align="center"><br><input type="image" value="�����ϱ�" name="submit" src="../../images/bt_q_delete_yj1.gif">&nbsp;&nbsp;&nbsp;<!--input type="button" value="����ϱ�" onClick="window.close()"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif"></td>
				</tr>
			</table>

		<% } else if(del_ABC.equals("B")) { %>
			<table border="0" width="100%" cellpadding ="0" cellspacing="2" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
				<tr height="60" bgcolor="#DBDBDB">
					<td width="100%" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">���� ���õ� ���� ��� ���迡 �����Ǿ��� ������ �Դϴ�.<br>�̹� �����Ǿ��� �������� ������ �� �����ϴ�.</td>
				</tr>
				<tr>
					<td width="100%" rowspan="14" bgcolor="#FFFFFF" valign="top" align="center"><BR><BR><!--input type="button" value="â �ݱ�" onClick="window.close()"--><a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></td>
				</tr>
			</table>
			
		<% } else if(del_ABC.equals("C")) { %>
			<table border="0" width="100%" cellpadding ="0" cellspacing="2" bgcolor="#ffffff" style="width: 100%; border-top: 2px; solid #ffffff; font-size: 9pt;">
				<tr height="30" bgcolor="#DBDBDB">
					<td colspan="2" width="27%" style="background-color: #FCFCFC; text-align: left;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;���� ���õ� ������ ���迡 ������ �������� �ֽ��ϴ�. �̹� �����Ǿ��� �������� ������ �� �����ϴ�.</td>
				</tr>
				<tr height="40" bgcolor="#DBDBDB">
					<td align="left" width="27%" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">������ �����ڵ�</td>
					<td align="left" bgcolor="#FFFFFF" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"><textarea cols="60" rows="3" readonly><%=del_NQ.toString()%></textarea></td>
				</tr>
				<tr height="30" bgcolor="#DBDBDB">
					<td colspan="2" width="27%" style="background-color: #FCFCFC; text-align: left;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">&nbsp;&nbsp;���� ���õ� ������ �����Ͻðڽ��ϱ�? ������ ������ ������ �� �����ϴ�.</td>
				</tr>
				<tr height="40" bgcolor="#DBDBDB">
					<td align="left" width="27%" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;">���� �����ڵ�</td>
					<td align="left" bgcolor="#FFFFFF" style="background-color: #FCFCFC; text-align: center;  border-top: 1px solid #a9da6d; border-bottom: 1px solid #a9da6d; border-right: 1px solid #a9da6d; border-left: 1px solid #a9da6d;"><textarea cols="60" rows="3" readonly><%=res2%></textarea></td>
				</tr>				
				<tr>
					<td colspan="2" width="17%" rowspan="14" bgcolor="#FFFFFF" valign="top" align="center"><input type="image" value="�����ϱ�" name="submit" src="../../images/bt_q_delete_yj1.gif">&nbsp;&nbsp;&nbsp;<!--input type="button" value="����ϱ�" onClick="window.close()"--><a href="javascript:window.close();"><img border="0" src="../../images/user_static_yj1_2.gif"></td>
				</tr>
			</table>			
		<% } %>
		</TD>
			<TD></TD>
		</TR>

		<TR style="height: 10px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>
		</form>
	</body>
</html>
<%
//******************************************************************************
//   ���α׷� : user_time_list.jsp
//   �� �� �� : ���νð� ���� ����Ʈ
//   ��    �� : ���νð� ���� ����Ʈ
//   �� �� �� : qt_userid
//   �ڹ����� : 
//   �� �� �� : 2008-06-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	ExtendTimeBean[] rst = null;

    try {
	    rst = ExtendTime.getExtendTimeList(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }	
%>

<HTML>
 <HEAD>
  <TITLE> :: �ð������� ����Ʈ :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
</HEAD>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ð������� ����Ʈ</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr" align=center>
				<td width=5%>NO</td>
				<td width=10%>���̵�</td>
				<td width=10%>����</td>
				<td>�������</td>
				<td width=10%>����ð�</td>
				<td width=10%>����ۿ���</td>
				<td width=15%>��Ͻð�</td>
			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:260px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="6">�ð������� ����Ʈ�� �����ϴ�.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
				%>
				<tr id="td" align="center">
					<td width=5%><%=i+1%></td>
					<td width=10%><%=rst[i].getUserid()%></td>
					<td width=10%><%=rst[i].getName()%></td>
					<td><%=rst[i].getExt_reason()%></td>
					<td width=10%><%=rst[i].getExt_min()%></td>
					<td width=10%><%=rst[i].getYn_start()%></td>
					<td width=15%><%=ComLib.nullChk(rst[i].getRegdate())%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		</div>

	</div>
	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
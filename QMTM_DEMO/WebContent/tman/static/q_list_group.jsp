<%
//******************************************************************************
//   ���α׷� : q_list_group.jsp
//   �� �� �� : ������� ���� 
//   ��    �� : ������� ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.statics.StaticQBean, qmtm.tman.statics.StaticQ
//   �� �� �� : 2008-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.statics.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	java.text.DecimalFormat df = new java.text.DecimalFormat(",##0.00"); 
%>

<script language="javascript">
	function q_list(id_q) {
		document.q_list.location.href= "q_list.jsp?id_exam=<%=id_exam%>&id_q="+id_q;
		document.q_list2.location.href= "q_list2.jsp?id_exam=<%=id_exam%>&id_q="+id_q;
	}
</script>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<%
	StaticQBean[] scoreQ = null;

	try {
		scoreQ = StaticQ.getQList(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

%>
	<table width="100%" border="0" >
		<tr>
			<td height="400" valign="top" rowspan="2" width="60%">
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC" width="100%" id="tableA">
		<tr height="30" bgcolor="#FFFFFF" id="tr3">
			<td align="center" bgcolor="#D9D9D9">�����ڵ�</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">��������</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">�����</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">�����</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">�����</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">�հ�</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">O</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">X</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">��</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">��</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">��</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">��</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">��</td>
		</tr>
		
		<% if(scoreQ == null) { %>

		<tr bgcolor="#FFFFFF" height="35" id="td">
			<td colspan="13" align="center">������踦 �����ž� Ȯ���� �� �ֽ��ϴ�.</td>
		</tr>

		<%
			} else {
				double o_rate_res = 0.0;
				for(int q = 0; q < scoreQ.length; q++) {
					int all_cnt = 1;
					
					if(scoreQ[q].getAll_sum() == 0) {
						all_cnt = 1;
					} else {
						all_cnt = scoreQ[q].getAll_sum();
					}

					double o_rate = 0.0;
					
					o_rate_res = (Double.parseDouble(String.valueOf(scoreQ[q].getO_cnt())) / Double.parseDouble(String.valueOf(all_cnt))) * 100;

		%>
		<tr bgcolor="#FFFFFF" height="25" id="td">
			<td align="center"><a href="javascript:q_list(<%=scoreQ[q].getId_q()%>);"><%=scoreQ[q].getId_q()%></a></td>
			<td align="center"><%=scoreQ[q].getQtype()%></td>
			<td align="center"><%=scoreQ[q].getExcount()%></td>
			<td align="center"><%=scoreQ[q].getCacount()%></td>
			<td align="center"><%=df.format(o_rate_res)%></td>
			<td align="center"><%=scoreQ[q].getAll_sum()%></td>
			<td align="center"><%=scoreQ[q].getO_cnt()%></td>
			<td align="center"><%=scoreQ[q].getX_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx1_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx2_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx3_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx4_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx5_cnt()%></td>
		</tr>
		<%
				}
			}
		%>
	</table>
	</td>
	<td valign="top" width="40%">
	<% if(scoreQ == null) { %>
	&nbsp;
	<% } else { %>
	<table border="0" width="95%" align="center">
	<tr>
		<td>
	<iframe src="q_list.jsp?id_exam=<%=id_exam%>&id_q=<%=scoreQ[0].getId_q()%>" frameborder="0" name="q_list" width="100%" height="350"  marginwidth="0" marginheight="0" scrolling="auto">
			</iframe><td>
		</tr>
		<tr>
			<td valign="top">
			<iframe src="q_list2.jsp?id_exam=<%=id_exam%>&id_q=<%=scoreQ[0].getId_q()%>" frameborder="0" name="q_list2" width="100%" height="350"  marginwidth="0" marginheight="0" scrolling="auto">
			</iframe>
			</td>
		</tr>
	</table>
	<% } %>
	</td>
	</tr>
	</table>
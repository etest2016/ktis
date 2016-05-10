<%
//******************************************************************************
//   ���α׷� : q_static.jsp
//   �� �� �� : ������� ���� 
//   ��    �� : ������� ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.statics.StaticQBean, qmtm.tman.statics.StaticQ
//   �� �� �� : 2008-07-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String id_q = request.getParameter("id_q");
%>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<%
	QunitBean qbean = null;
	
	try {
		qbean = Qunit.getBean(Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	int cacount = qbean.getCacount();
	int id_qtype = qbean.getId_qtype();
	int[] arrEx_order = qbean.getArrEx_order();
	String ans = qbean.getCa();
	String explain = qbean.getExplain();
	boolean arrHasEx = true;

	String exlabel = "��,��,��,��,��,��,��,��,";

	String[] arrEx = new String[8];

	String[] arrExlabel = exlabel.split(",");

	if (id_qtype <= 3) {
		arrHasEx = true;
	  } else {
		arrHasEx = false;
	  }
	  
	int arrExcount = qbean.getExcount();

	for (int j = 0; j < arrExcount; j++) {
		arrEx[j] = arrExlabel[j] + " " + QmTm.delTag(qbean.getArrEx()[j]);
	}
%>

<table border="0" width="100%" height="250">
	<tr>
		<td align="center">
			<table border="0" width="90%" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" style="border-bottom: 2px solid #8b9eba; border-top: 2px solid #8b9eba; padding: 5px 10px 4px 14px;"><font color="#949494"><b><%=id_q%>.</b></font></td>
					<td align="left" style="border-bottom: 2px solid #8b9eba; border-top: 2px solid #8b9eba; padding: 5px 10px 4px 14px;"><font color="#000"> <%=qbean.getQ()%></font></td>
				</tr>
				<tr>
					<td height="10" colspan="2"></td>
				</tr>
				<!-- ���� -->
				<% if (arrHasEx) { %>
				<% if(arrExcount == 2) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<% } else if(arrExcount == 3) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
			    <% } else if(arrExcount == 4) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<% } else if(arrExcount == 5) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<% } else if(arrExcount == 6) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[5]%>&nbsp;&nbsp;<%= qbean.getEx6() %></td>
				</tr>
				<% } else if(arrExcount == 7) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[5]%>&nbsp;&nbsp;<%= qbean.getEx6() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[6]%>&nbsp;&nbsp;<%= qbean.getEx7() %></td>
				</tr>
				<% } else if(arrExcount == 8) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[5]%>&nbsp;&nbsp;<%= qbean.getEx6() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[6]%>&nbsp;&nbsp;<%= qbean.getEx7() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[7]%>&nbsp;&nbsp;<%= qbean.getEx8() %></td>
				</tr>
				<% } %>
				<% } %>
				<tr>
					<td height="10" colspan="2"></td>
				</tr>
				<tr>
					<td width="2%"></td>
					<td><font color="#949494"><b>���� : <%=ans.replace("{|}",", ").replace("{^}"," �Ǵ� ")%></b></font></td>
				</tr>
				<tr>
					<td height="10" colspan="2"></td>
				</tr>
				<tr>
					<td width="2%"></td>
					<td><font color="#949494"><b>�ؼ� :</b></font> <%=explain%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
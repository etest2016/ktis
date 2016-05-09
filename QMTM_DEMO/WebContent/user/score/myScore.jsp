<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="qmtm.ComLib, etest.score.User_ScoreList, etest.score.User_ScoreListBean"%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	User_ScoreListBean[] rst = null;

	try {
	  rst = User_ScoreList.getBeans(userid);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<html>
<head>
<title>��������ȸ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="stylesheet" href="../css/indie_style.css" type="text/css">

</head>

<%@ include file="../include/include_top.jsp" %>
<img src='../images/title_myscore.gif'>
<br><br>


	<table cellspacing='0' cellpadding='0' class="table" border='0'>
		<tr class="tt">          
			<td>������</td>
			<td>�����</td>
			<td>������ȸ��</td>          
		</tr>
	<%
		// No record
		if (rst == null){
	%>
		<tr>
			<td colspan="3" class="blank">����� ��ȸ �� ������ �����ϴ�.</td>  
		</tr>
	<%
		} // End of (rst.length == 0)

		// Has Record(s)
		else
		{
			// Loop for Records
			for (int i = 0; i < rst.length; i++)
			{
	%>
		<tr class="td">    		
			<td><%= rst[i].getCourse() %></td>
		<%  
			  // ���� �� �ؼ��������� ���� �ɼ��ϰ��
			  if (rst[i].getYn_open_qa().equalsIgnoreCase("A")) { 
		%>
					<td class='point_b'><%= rst[i].getTitle() %></td>
					<td>���������</td> 
		<% } %>
	  
		<% 
			 // ������� ���� ������ ����, ������� ���� ���� �� ����, �ؼ� ���� �ɼ��� ���
			 if (rst[i].getYn_open_qa().equalsIgnoreCase("B") || rst[i].getYn_open_qa().equalsIgnoreCase("C")) { 
		%>
					<td><a href="scoreinfo.jsp?id_exam=<%= rst[i].getId_exam() %>&userid=<%= userid %>"><%= rst[i].getTitle() %></a></td>
					<td>�Ⱓ���� ����</td>
		<% } %>
		<% 
			 // ������ȸ �Ⱓ�� ������ ����, ������ȸ �Ⱓ�� ���� �� ����, �ؼ� ���� �ɼ��� ���...
			 if (rst[i].getYn_open_qa().equalsIgnoreCase("D") || rst[i].getYn_open_qa().equalsIgnoreCase("E")) { 
		%>
		 <!-- �����Ⱓ�� -->
		  <% if (User_ScoreList.isOpenScore(rst[i].getStat_start(), rst[i].getStat_end())) { %>
		  <td >
			<a href="scoreinfo.jsp?id_exam=<%= rst[i].getId_exam() %>&userid=<%= userid %>"><%= rst[i].getTitle() %></a>
		  </td>
		  <td >
			<%= rst[i].getStat_start().toString().substring(0,16) %> ����<br>
			<%= rst[i].getStat_end().toString().substring(0,16) %> ����
		  </td>
		  <!-- �����Ⱓ�� �ƴ� -->
		  <% } else { %>
		  <td >
			<a href="javascript:alert('���� ��ȸ�Ⱓ�� �ƴմϴ�');"><%= rst[i].getTitle() %></a>
		  </td>
		  <td >
			<%= rst[i].getStat_start().toString().substring(0,16) %> ����<br>
			<%= rst[i].getStat_end().toString().substring(0,16) %> ����
		  </td>
		  <% } %>
	  <% } %>
	 </tr>
	<%
		} // end of for loop
	}     // end of if (rst.length > 0)
	%>
</table>
<br>

<%@ include file="../include/include_bottom.jsp" %>
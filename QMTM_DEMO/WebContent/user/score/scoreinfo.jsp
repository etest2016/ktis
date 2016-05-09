<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.ComLib, etest.score.User_ScoreUnit, etest.score.User_ScoreUnitBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	User_ScoreUnitBean beans = null;

	try {
	    beans = User_ScoreUnit.getBean(userid, id_exam);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	if (beans == null) {
%>
		<Script language="JavaScript">
			alert("���迡 �������� �ʾҽ��ϴ�.");
			history.back();
		</Script>
<%
		if(true) return;
	}
%>

<html>
<head>
<title>����������ȸ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<link rel="stylesheet" href="../css/style.css" type="text/css">

<script language="JavaScript">
   
   function ftndetail() 
   {
	   window.open("../score/qa.jsp?userid=<%=userid%>&id_exam=<%= id_exam %>", "statistic", "status=yes,resizable=yes,scrollbars=yes,toolbar=no,width=1000,height=700");
   }

   function openStat()
   {
       window.open("multistat.jsp?id_exam=<%= id_exam %>&userid=<%=userid%>", "statistic", "status=yes,resizable=yes,scrollbars=yes,toolbar=no,width=1000,height=700");
   }

</script>

</head>

<%@ include file="../include/include_top.jsp" %>
<img src='../images/title_myscore.gif'>
<br><br>

<table cellspacing='0' cellpadding='0' class="table" border='0'>
   	<tr class="tt">          
   		<td>�����</td>
		<td>����</td>
		<td>������ȸ����</td>
		<td>��������</td>		
	<% if(beans.getYn_open_qa().equalsIgnoreCase("C") || beans.getYn_open_qa().equalsIgnoreCase("E")) { %>
  	    <td align="center">����, �ؼ� �� ä��</td>
	<% } %>
   	</tr>
	<tr class="td">    
		<td><%= beans.getTitle() %></td>    
	    <td><%= beans.getAllotting() %></td> 
	<% if (beans.getYn_end().equalsIgnoreCase("N")) { %>
		<td colspan=3>�̿Ϸ�</td>
	<% }else if(beans.getYn_end().equalsIgnoreCase("Y") && beans.getScore() == -1) {%>
		<td colspan=3>��ä��</td>
	<% } else {		
		// ���� �� �ؼ� �������� ���� �ϰ��
		if(beans.getYn_open_qa().equalsIgnoreCase("A")) {
	%> 
		<td>�Ⱓ��������</td>
		<td>�����</td>
	<% 
		// ��� ���� ���� ������ ���� �ϰ��
		} else if(beans.getYn_open_qa().equalsIgnoreCase("B")) {
	%>
		<td>�Ⱓ��������</td>
		<td><%=beans.getScore()%> ��</td>
	<% 
		// ��� ���� ���� ���� ���� �� �ؼ� ���� �ϰ��
		} else if(beans.getYn_open_qa().equalsIgnoreCase("C")) {
	%>
		<td>�Ⱓ��������</td>
		<td><%=beans.getScore()%> ��</td>
		<td><a href="javascript:ftndetail();"><img src="../images/view1.gif" border="0"></a></td>
	<%
		// ������ȸ �Ⱓ�� ������ ���� �ϰ��
		} else if(beans.getYn_open_qa().equalsIgnoreCase("D")) {
			if(beans.getYn_stat_day().equalsIgnoreCase("Y")) { // ������ȸ �Ⱓ���ϰ�� ������ �����ش�.
	%>	
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td><%=beans.getScore()%> ��</td>
	<%      
			} else {
	%>
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td>��ȸ���ھƴ�</td>
	<%	
		}		
		} else if(beans.getYn_open_qa().equalsIgnoreCase("E")) { // ������ȸ �Ⱓ�� ���� ���� �� �ؼ� ���� �ϰ�� 
			if(beans.getYn_stat_day().equalsIgnoreCase("Y")) { // ������ȸ �Ⱓ���ϰ�� ������ �����ش�.
	%>	
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td><%=beans.getScore()%> ��</td>
		<td><a href="javascript:ftndetail();"><img src="../images/view1.gif" border="0"></a></td>
	<%      
		} else { 
	%>
		<td><%=beans.getStat_start()%> ~ <%=beans.getStat_end()%></td>
		<td colspan=2>��ȸ���ھƴ�</td>	
	<%
		}
		}
	}
	%>
  </tr>	

</table>

<!-- ������� ������ -->
	<% if (beans.getYn_stat().equalsIgnoreCase("Y")) { %>
	<br><br>

		<!-- ������ȸ�Ⱓ -->
		  <% if (beans.getScore() > 0) { %>
		  <img onclick="openStat()" onmouseover="this.style.cursor='hand'" src="../images/data.gif" border="0" WIDTH="108" HEIGHT="24">
		  <% } else { %>
		  <img onclick="alert('���迡 �������� �ʾ����Ƿ� ������踦 ���Ǽ� �����ϴ�')" onmouseover="this.style.cursor='hand'" src="../images/data.gif" border="0" WIDTH="108" HEIGHT="24">
		  <% } %>

	<% } %>
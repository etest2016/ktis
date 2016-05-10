<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.ComLib, etest.score.User_ScoreUnit, etest.score.User_ScoreUnitBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = "";
	userid = (String)session.getAttribute("current_userid");

	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

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
		<Script type="text/javascript">
			alert("�򰡿� �������� �ʾҽ��ϴ�.");
			history.back();
		</Script>
<%
		if(true) return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>�򰡰������ȸ</title>
	<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="../css/top.css" />
	<script type="text/javascript">
	   
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
<body>
	<a name="top"></a>

	<jsp:include page="../include/include_top.jsp" flush="false">
		<jsp:param name="active_menu_item" value="score" />
    </jsp:include>

	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>�򰡸�</th>
					<th>����</th>
					<th>������ȸ����</th>
					<th>��������</th>
		<% if(beans.getYn_open_qa().equalsIgnoreCase("C") || beans.getYn_open_qa().equalsIgnoreCase("E")) { %>
					<th>����, �ؼ� �� ä��</th>
		<% } %>
				</tr>
			</thead>
			<tbody>	
				<tr>    
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
					<td><a href="javascript:ftndetail();" class="btn">����</a></td>
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
					<td><a href="javascript:ftndetail();" class="btn">����</a></td>
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
			 </tbody>
		</table>

	<!-- ������� ������ -->
	<% if (beans.getYn_stat().equalsIgnoreCase("Y")) { %>
		<br><br>

		<!-- ������ȸ�Ⱓ -->
		  <% if (beans.getScore() > 0) { %>
			<button onclick="openStat()" class="btn"><i class="icon-list-alt"></i> ����ڷẸ��</button>
		  <% } else { %>
		  	<button onclick="alert('�򰡿� �������� �ʾ����Ƿ� ������踦 ���Ǽ� �����ϴ�')" class="btn"><i class="icon-list-alt"></i> ����ڷẸ��</button>
		  <% } %>

	<% } %>

	</div>

	<div class="container_bottom"><!--�ٴ� �κ� ���̾ƿ�--></div>

</body>
</html>
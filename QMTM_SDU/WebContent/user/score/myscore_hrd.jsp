<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="qmtm.ComLib, etest.User_QmTm, etest.score.User_ScoreList, etest.score.User_ScoreListBean"%>
<%@ page import="etest.LoginManager" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<%!
	LoginManager loginManager = LoginManager.getInstance();
%>
<%

	//*********************HRD ���� �Ķ���� ���� üũ����**********************
	String userid;
	String hrd_score = (String)session.getAttribute("current_score");
	
	if(hrd_score == "" || hrd_score == null) {	
		userid = request.getParameter("userid");	
		if (userid == null) { userid = ""; } else { userid = userid.trim(); }	
	} else {
		userid = (String)session.getAttribute("current_userid");
	}
	
	if (userid == "") {	
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}
	//*********************HRD ���� �Ķ���� ���� üũ����**********************
	
	String userName = "";
	String pwd = userid;

	if(hrd_score == "" || hrd_score == null) {
		// ����� ����
		try {
			userName = User_QmTm.getName(userid, pwd);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "close"));
			
		    if(true) return;
	    }
		
		// ���� ������ �����Ѵ�.
		session.setAttribute("current_userid", userid);
		session.setAttribute("current_username", userName);
		session.setAttribute("current_score", "score_hrd");
		session.setMaxInactiveInterval(60*60*4);		

		// �̹� ������ ���̵����� üũ�Ѵ�.
		if(loginManager.isUsing(userid)) {
			// ���� �����ڸ� �α׾ƿ� ��Ų��.
			loginManager.removeSession(userid);
			
			// ���ο� ������ ����Ѵ�. setSession�Լ��� �����ϸ� valueBound()�Լ��� ȣ��ȴ�.
			loginManager.setSession(session, userid);
		} else {
			loginManager.setSession(session, userid);
		}	
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>eTest</title>
	<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="../css/top.css" />
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
				<th>������</th>
				<th>�򰡸�</th>
				<th>������ȸ��</th>
			</tr>
			</thead>
			<tbody>
			<%
				// No record
				if (rst == null){
			%>
				<tr>
					<td colspan="3">����� ��ȸ �� �򰡰� �����ϴ�.</td>  
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
				<tr>    		
					<td><%= rst[i].getCourse() %></td>
				<%  
					  // ���� �� �ؼ��������� ���� �ɼ��ϰ��
					  if (rst[i].getYn_open_qa().equalsIgnoreCase("A")) { 
				%>
							<td class='point_b'><%= rst[i].getTitle() %></td>
							<td>���������</td> 
				<%	  } %>
			  
				<% 
					  // ������� ���� ������ ����, ������� ���� ���� �� ����, �ؼ� ���� �ɼ��� ���
					  if (rst[i].getYn_open_qa().equalsIgnoreCase("B") || rst[i].getYn_open_qa().equalsIgnoreCase("C")) { 
				%>
							<td><a href="scoreinfo.jsp?id_exam=<%= rst[i].getId_exam() %>&userid=<%= userid %>"><%= rst[i].getTitle() %></a></td>
							<td>�Ⱓ���� ����</td>
				<%	  } %>
				<% 
					  // ������ȸ �Ⱓ�� ������ ����, ������ȸ �Ⱓ�� ���� �� ����, �ؼ� ���� �ɼ��� ���...
					  if (rst[i].getYn_open_qa().equalsIgnoreCase("D") || rst[i].getYn_open_qa().equalsIgnoreCase("E")) { 
				%>
				<!-- �����Ⱓ�� -->
				<%	      if (User_ScoreList.isOpenScore(rst[i].getStat_start(), rst[i].getStat_end())) { %>
							<td>
								<a href="scoreinfo.jsp?id_exam=<%= rst[i].getId_exam() %>&userid=<%= userid %>"><%= rst[i].getTitle() %></a>
							</td>
							<td >
								<%= rst[i].getStat_start().toString().substring(0,16) %> ����<br>
								<%= rst[i].getStat_end().toString().substring(0,16) %> ����
							</td>
							<!-- �����Ⱓ�� �ƴ� -->
				<%	      } else { %>
							<td >
								<a href="javascript:alert('���� ��ȸ�Ⱓ�� �ƴմϴ�');"><%= rst[i].getTitle() %></a>
							</td>
							<td>
								<%= rst[i].getStat_start().toString().substring(0,16) %> ����<br>
								<%= rst[i].getStat_end().toString().substring(0,16) %> ����
							</td>
				<%	      } %>
			  <%	  } %>
			 </tr>
			<%
					} // end of for loop
				}     // end of if (rst.length > 0)
			%>
			</tbody>
		</table>
	</div>

	<div class="container_bottom"><!--�ٴ� �κ� ���̾ƿ�--></div>

</body>
</html>
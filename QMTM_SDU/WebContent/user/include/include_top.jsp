<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	String username = (String)session.getAttribute("current_username");
	if (username == null) { username= ""; } else { username = username.trim(); }
	
	String hrd_exam = (String)session.getAttribute("current_exam");
	if (hrd_exam == null) { hrd_exam= ""; } else { hrd_exam = hrd_exam.trim(); }
	
	String hrd_score = (String)session.getAttribute("current_score");
	if (hrd_score == null) { hrd_score= ""; } else { hrd_score = hrd_score.trim(); }
	
	// MENU Active ����
	String active_menu_item = (String)request.getParameter("active_menu_item");
	
	String is_active_menu_guide = "";
	String is_active_menu_exam = "";
	String is_active_menu_score = "";
	
	if(active_menu_item.equals("guide")) {
		is_active_menu_guide = "active";
	} else if (active_menu_item.equals("exam")) {
		is_active_menu_exam = "active";
	} else if (active_menu_item.equals("score")) {
		is_active_menu_score = "active";
	}
%>    

<div class="userinfo"><!--������ ����-->
	<%=username %>��, ȯ���մϴ�. &nbsp;&nbsp;
	<%if(hrd_exam.equals("exam_hrd") || hrd_score.equals("score_hrd")) { %>
	<a href="<%=request.getContextPath() %>/user/logout_hrd.jsp" style="text-decoration: none;"><span class="label">�����ϱ�</span></a>
	<% } else { %>
	<a href="<%=request.getContextPath() %>/user/logout.jsp" style="text-decoration: none;"><span class="label">�α׾ƿ�</span></a>
	<% } %>
</div>

<div class="title"><!--�ΰ� �� Ÿ��Ʋ ǥ��-->
	<img src="<%=request.getContextPath() %>/user/images/title2.gif">
</div>

<div class="container_top">	
	<ul class="nav nav-pills">
	  <li class="<%= is_active_menu_guide %>" id="menu_guide">
		<a href="<%=request.getContextPath() %>/user/intro/guide.jsp">�̿�ȳ�</a>
	  </li>
	  <% if(hrd_exam.equals("") && hrd_score.equals("")) { %>
	  <li class="<%= is_active_menu_exam %>" id="menu_exam"><a href="<%=request.getContextPath() %>/user/exam/mytest.jsp">������</a></li>
	  <li class="<%= is_active_menu_score %>" id="menu_score"><a href="<%=request.getContextPath() %>/user/score/myScore.jsp">������ȸ</a></li>
	  <% } else if(hrd_exam.equals("exam_hrd")) { %>
	  <li class="<%= is_active_menu_exam %>" id="menu_exam"><a href="<%=request.getContextPath() %>/user/exam/mytest_hrd.jsp">������</a></li>
	  <% } else if(hrd_score.equals("score_hrd")) { %>
	  <li class="<%= is_active_menu_score %>" id="menu_score"><a href="<%=request.getContextPath() %>/user/score/myscore_hrd.jsp">������ȸ</a></li>
	  <% } %> 
	</ul>
</div>
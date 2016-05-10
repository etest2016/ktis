<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	String username = (String)session.getAttribute("current_username");
	if (username == null) { username= ""; } else { username = username.trim(); }
	
	// MENU Active 설정
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

<div class="userinfo"><!--응시자 정보-->
	<%=username %>님, 환영합니다. &nbsp;&nbsp;<a href="<%=request.getContextPath() %>/user/logout.jsp" style="text-decoration: none;"><span class="label">로그아웃</span></a>
</div>

<div class="title"><!--로고 및 타이틀 표시-->
	<img src="<%=request.getContextPath() %>/user/images/title2.gif">
</div>

<div class="container_top">
	<ul class="nav nav-pills">
	  <li class="<%= is_active_menu_guide %>" id="menu_guide">
		<a href="<%=request.getContextPath() %>/user/intro/guide_score_hrd.jsp">이용안내</a>
	  </li>
	  <!-- <li class="<%= is_active_menu_exam %>" id="menu_exam"><a href="<%=request.getContextPath() %>/user/exam/mytest.jsp">평가응시</a></li>-->
	  <li class="<%= is_active_menu_score %>" id="menu_score"><a href="<%=request.getContextPath() %>/user/score/myScore.jsp">성적조회</a></li>
	</ul>
</div>
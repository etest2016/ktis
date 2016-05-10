<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userid = "";
	
	userid = (String)session.getAttribute("current_userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>eTest</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<frameset cols="0,*" frameborder="NO" border="0" framespacing="0"> 
<frame name="left" scrolling="NO" noresize src="">
<% if(userid.length() == 0) { %>
<frame name="mainFrame" src="sso_login_chk.jsp">
<% } else { %>
<frame name="mainFrame" src="intro/guide.jsp">
<% } %>
</frameset>   
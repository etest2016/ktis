<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="qmtm.ComLib, etest.exam.User_ExamListBean, etest.exam.User_ExamList"%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	User_ExamListBean[] rst = null;

	try {
	  rst = User_ExamList.getBeans(userid);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>

<html>
<head>
<title>시험응시리스트</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<SCRIPT LANGUAGE="JavaScript">
<!--
	function GoTest(id_exam){

		location.href="etest.jsp?id_exam="+id_exam+"&userid=<%=userid%>";
		
	}
//-->
</SCRIPT>
</head>

<%@ include file="../include/include_top.jsp" %>
<img src='../images/title_mytest.gif'>
<!--div class='sub'>시험목록</div-->
<br><br>
<table border='0' cellspacing='0' cellpadding='0' class='table'>
  <tr class='tt'>    
    <td>강의명</td>  
    <td>시험명</td>
    <td>시험기간</td>    
  </tr>
<% if (rst == null) { %>
  <tr class='blank'>
    <td colspan="3">개설되어진 시험이 없습니다.</td>
  </tr>
<%
   } else {
        for (int i = 0; i < rst.length; i++) {
%>
  <tr class='td'>  
    <td><%= rst[i].getCourse() %></td>
    <td><p align="center"><a href="javascript: GoTest('<%= rst[i].getId_exam() %>');"><%= rst[i].getTitle() %></a></p></td>
    <td><%= rst[i].getExam_start().toString().substring(0,16) %> ~ <%= rst[i].getExam_end().toString().substring(0,16) %></td> 
  </tr>
<%
       }
   }
%>
</table>

<%@ include file="../include/include_bottom.jsp" %>
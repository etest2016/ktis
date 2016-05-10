<%@ page contentType="text/xml; charset=EUC-KR" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = " qmtm.CommonUtil,qmtm.DBPool, qmtm.ComLib, qmtm.QmTmException, qmtm.tman.CourseAnsResultBean,  qmtm.tman.CourseAnsResultUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String id_course = request.getParameter("id_course");
	String filename = "course_ans_result_" + id_course + ".xls";
	response.setHeader("Content-Disposition", "attachment; filename=" + filename); 
    response.setHeader("Content-Description", "JSP Generated Data");

%>
<html>
<head></head>
<body>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr align="center" height="30" >
			<td bgcolor="#9DBFFF">USER ID</td>
			<td bgcolor="#9DBFFF">이름</td>
			<td bgcolor="#9DBFFF">소속</td>
			<td bgcolor="#9DBFFF">팀</td>
			<td bgcolor="#9DBFFF">총점</td>
			<td bgcolor="#9DBFFF">통과</td>
			<td bgcolor="#9DBFFF">시험명</td>		
		</tr>

<% 	
	
    // 데이타 가져오기
	CourseAnsResultBean[] rst = null;

	try {
		rst = CourseAnsResultUtil.getBeans(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

    if(rst == null) {
%>
		<tr height="27" align="center">
			<td colspan="7">조회할 데이터가 없습니다.</td>
		</tr>
<%
	} else {
		for(int i=0; i<rst.length; i++) 
		{
%>
     	<tr height="27" align="center">
			<td><%=rst[i].getUserid()%></td>
			<td><%=rst[i].getUsername()%></td>
			<td><%=rst[i].getSosok1()%></td>
			<td><%=rst[i].getSosok2()%></td>
			<td><%=rst[i].getTotal()%></td>
			<td><%=rst[i].getSuccess()%></td>
			<td><%=rst[i].getExam_title()%></td>
		</tr>
<%
		}
		
	}

	rst = null;
	System.gc();
%>
	</table>
</body>
</html>

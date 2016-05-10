

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*" %>
<%@ include file = "/common/login_chk.jsp" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=ExamNonPaper.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
	
	PaperNonExportBean[] beans = null;
	
	try {
		beans = PaperNonExport.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
%>
<table border="1">
<% for(int i=0; i<beans.length; i++) { %>
<tr>
<td width="7%">
<%=beans[i].getUserid()%>
</td>
<td width="7%">
<%=beans[i].getName()%>
</td>
<td width="15%">
<%=beans[i].getQ()%>
</td>
<td width="5%">
<%=beans[i].getAllotting()%>
</td>
<td width="66%">
<%=beans[i].getUserans1()%>
</td>
</tr>
<% } %>
</table>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}
%>

<html>
<head>

<title> :: ������ ����� :: </title>


<frameset rows="65, *" frameborder="NO" border="0" framespacing="0">
    <frame name="paperTop" src="p_top.jsp?id_exam=<%=id_exam%>" noresize scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0">	
	<frameset cols="155,*" frameborder="NO" border="0" framespacing="0">
		<frame name="paperLeft" src="p_left.jsp?id_exam=<%=id_exam%>" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0">
		<frame name="paperMain" src="p_main.jsp?id_exam=<%=id_exam%>" scrolling="NO" frameborder="NO" marginwidth="0" marginheight="0">
	</frameset>
</frameset>
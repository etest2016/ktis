<%@ page contentType="text/html; charset=EUC-KR" %>
<%	
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = "";
	String username = "";
	session.invalidate(); 
%>
<script type="text/javascript">
	top.window.close();
</script>
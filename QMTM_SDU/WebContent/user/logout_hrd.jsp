<%@ page contentType="text/html; charset=EUC-KR" %>
<%	
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = "";
	String username = "";
	String id_course = "";
	String id_subject = "";
	String id_exam_gubun = "";
	String hrd_exam = "";
	String hrd_score = "";
	session.invalidate(); 
%>
<script type="text/javascript">
	top.window.close();
</script>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*"%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // Oracle 학생 정보 연동
	try {
		StuList.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
%>

<Script language="javascript">
	alert("학생 정보 연동이 완료되었습니다.");
	window.close();
</script>
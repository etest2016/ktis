<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*"%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // Oracle 선생님 정보 연동
	try {
		ProfList.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
%>

<Script language="javascript">
	alert("선생님 정보 연동이 완료되었습니다.");
	window.close();
</script>
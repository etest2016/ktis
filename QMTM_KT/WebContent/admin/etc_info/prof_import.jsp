<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*"%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // Oracle ������ ���� ����
	try {
		ProfList.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
%>

<Script language="javascript">
	alert("������ ���� ������ �Ϸ�Ǿ����ϴ�.");
	window.close();
</script>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = "E080421114816WS";
%>

<script language="javascript">

 function get_inwon_list(bigo) {
	inwon1 = new ActiveXObject("Microsoft.XMLHTTP");
	inwon1.onreadystatechange = get_inwon_list_callback;
	inwon1.open("GET", "inwon_lists.jsp?id_exam=<%=id_exam%>&bigos="+bigo, true);
	inwon1.send();
 }

 function get_inwon_list_callback() {
	if(inwon1.readyState == 4) {
		if(inwon1.status == 200) {
			if(typeof(document.all.inwon_lists) == "object") {
				alert(inwon1.responseText);
				document.all.inwon_lists.innerHTML = inwon1.responseText;
			}
		}
	}
 }

 </script>

 <BODY id="tman">
 <input type="button" value="확인하기" onClick="get_inwon_list('Y');">

 </body>
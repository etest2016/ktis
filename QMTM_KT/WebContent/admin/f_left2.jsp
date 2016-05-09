<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	TreeBean[] rst = null;

	try {
		rst = TreeList2.getBeans2("admin");
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<html>
<head>
	<title>Admin 관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link rel="StyleSheet" href="../../css/tree.css" type="text/css">
	<script type="text/javascript" src="tree.js"></script>

	<script type="text/javascript">
		<!--
		var Tree = new Array;
		// nodeId | parentNodeId | nodeName | nodeUrl | nodeCode | nodeGubun
		//document.write("<table id='tree' cellpadding='0' cellspacing='0' border='0'>");
		//document.write("<TR id='top'><TD id='left'></TD><TD id='center'></TD><TD id='right'></TD></TR>");
		//document.write("<TR id='middle'><TD id='left'></TD><TD id='center'>");
		<% if(rst == null) { %>
			document.write("<div class='tree'>");
			document.write("<BR><BR>&nbsp;&nbsp;&nbsp;");
			document.write("<img src=\"img/base.gif\" align=\"absbottom\" alt=\"\" /><a href=\"course_create.jsp\" target=\"fraMain\" />QMAN 카테고리</a><br />");
			document.write("</div>");
		<% } else {
				for (int i = 0; i < rst.length; i++) { 
		%>
					Tree[<%=i%>]  = "<%=rst[i].getId_node()%>|<%=String.valueOf(rst[i].getId_parentnode())%>|<%=rst[i].getNode_name()%>|create.jsp?id_node=<%=rst[i].getId_node()%>&node_rid=<%=rst[i].getId_parentnode()%>&node_gubun=<%=rst[i].getNode_gubun()%>";
		<% 
			   }
		%>
			document.write("<div class='tree'>");
				createTree(Tree);
			document.write("</div>");

		<%
		   }
		%>
		//document.write("</TD><TD id='right'></TD></TR>");
		//document.write("<TR id='bottom'><TD id='left'></TD><TD id='center'></TD><TD id='right'></TD></TR></TABLE>&nbsp;");
		//-->
	</script>
</head>

<BODY id="admin">
</body>
</html>

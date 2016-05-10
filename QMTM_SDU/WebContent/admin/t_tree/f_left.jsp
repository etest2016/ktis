<%
//******************************************************************************
//   ���α׷� : f_left.asp
//   �� �� �� : ������ ������ �������� Ʈ��
//   ��    �� : ������ ������ �������� Ʈ��
//   �� �� �� : q_subject, q_chapter, q_chapter2
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib, qmtm.TreeBean, qmtm.TreeList
//   �� �� �� : 2010-05-30
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� :     
//	 �������� : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.TreeBean, qmtm.TreeList " %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
    
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	TreeBean[] rst = null;

	try {
		rst = TreeList.getBeans("qmtm");
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}    
%>

<html>
<head>
	<title>Admin ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
			document.write("<div class='tree' style='overflow-y:scroll; height: 365px; overflow-x:scroll; width: 200px;'>");
			document.write("<BR>&nbsp;&nbsp;&nbsp;");
			document.write("<img src=\"../../images/base.gif\" align=\"absbottom\" alt=\"\" /><a href=\"course_create.jsp\" target=\"fraMain\" />������� ī�װ�</a><br />");
			document.write("</div>");
		<% } else {
				for (int i = 0; i < rst.length; i++) { 
		%>
					Tree[<%=i%>]  = "<%=rst[i].getId_node()%>|<%=String.valueOf(rst[i].getId_parentnode())%>|<%=rst[i].getNode_name()%>|create.jsp?id_node=<%=rst[i].getId_node()%>&node_rid=<%=rst[i].getId_parentnode()%>&node_gubun=<%=rst[i].getNode_gubun()%>|<%=rst[i].getNode_gubun()%>";
		<% 
			   }
		%>
			document.write("<div class='tree' style='overflow-y:scroll; height: 365px; overflow-x:scroll; width: 200px;'>");
				createTree(Tree);
			document.write("</div>");
			document.write("<p>&nbsp;</p>");
			document.write("<p>&nbsp;</p>");

		<%
		   }
		%>
		//document.write("</TD><TD id='right'></TD></TR>");
		//document.write("<TR id='bottom'><TD id='left'></TD><TD id='center'></TD><TD id='right'></TD></TR></TABLE>&nbsp;");
		//-->
	</script>
</head>

<BODY id="admin" style="background-image: url(../img/bg_tree_t.gif); background-repeat: no-repeat;">
</body>
</html>

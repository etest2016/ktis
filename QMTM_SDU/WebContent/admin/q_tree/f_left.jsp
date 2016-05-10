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
<%@ include file = "/common/admin_chk.jsp" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	TreeBean[] rst = null;

	try {
		rst = TreeList.getBeans2("qmtm");
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
	<link rel="StyleSheet" href="dtree.css" type="text/css" />
	<script type="text/javascript" src="dtree.js"></script>

	<script type="text/javascript">
		<!--
		d = new dTree('d');
		// nodeId | parentNodeId | nodeName | nodeUrl | nodeCode | nodeGubun
		<% if(rst == null) { %>


		<% } else { %>

				document.write("<div class='tree' style='position: absolute; top: -30px; overflow-x:auto; width: 335px; height:512px;'>");
				d.add('0','-1','ī�װ� ��ȸ');

		<%
				for (int i = 0; i < rst.length; i++) {
					String img_icon = "";
					String img_icon_open = "";
					if(rst[i].getNode_gubun().equals("G1")) {
						img_icon = "img/course.gif";
						img_icon_open = "img/course_open.gif";
					} else if(rst[i].getNode_gubun().equals("M1")) {
						img_icon = "img/subject.gif";
						img_icon_open = "img/subject_open.gif";
					}

		%>
					d.add('<%=rst[i].getId_node()%>','<%=String.valueOf(rst[i].getId_parentnode())%>','<%=rst[i].getNode_name()%>','create.jsp?id_node=<%=rst[i].getId_node()%>&node_rid=<%=rst[i].getId_parentnode()%>&node_gubun=<%=rst[i].getNode_gubun()%>','<%=rst[i].getNode_name()%>','fraMain','<%=img_icon%>','<%=img_icon_open%>');	
									
		<%					
				}
		%>
				document.write(d);
				document.write("</div>");
				document.write("<p>&nbsp;</p>");
				document.write("<p>&nbsp;</p>");
				document.write("<p>&nbsp;</p>");
		<%
		   }
		%>
	</script>
</head>

<BODY id="admin" style="background-image: url(../img/bg_tree_q.gif); background-repeat: no-repeat;">
</body>
</html>

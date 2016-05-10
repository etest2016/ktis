<%
//******************************************************************************
//   프로그램 : f_left.asp
//   모 듈 명 : 관리자 페이지 문제관리 트리
//   설    명 : 관리자 페이지 문제관리 트리
//   테 이 블 : q_subject, q_chapter, q_chapter2
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.TreeBean, qmtm.TreeList
//   작 성 일 : 2010-05-30
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 :     
//	 수정사항 : 
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
	<title>Admin 관리</title>
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
				d.add('0','-1','카테고리 조회');

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

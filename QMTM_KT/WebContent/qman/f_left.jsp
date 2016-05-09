<%
//******************************************************************************
//   프로그램 : f_left.asp
//   모 듈 명 : 문제관리 좌측 프레임
//   설    명 : 문제관리 좌측 프레임
//   테 이 블 : q_subject, q_chapter, q_chapter2
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.TreeBean, qmtm.TreeList
//   작 성 일 : 2010-06-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 :   
//******************************************************************************
%>        

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.TreeBean, qmtm.TreeList, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil, java.util.Date, java.util.Calendar " %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
	
	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int year = 0;

	String years = request.getParameter("years");
	if (years == null) { years = ""; } else { years = years.trim(); }	

	if(years.length() == 0) {
		Calendar cal = Calendar.getInstance();
		year = cal.get(Calendar.YEAR);
		years = String.valueOf(year);
	} else {
		year = Integer.parseInt(years);
	}

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String aligns = request.getParameter("aligns");
	if (aligns == null) { aligns = "q_subject"; } else { aligns = aligns.trim(); }		

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	// 그룹구분목록 가지고오기
	GroupKindBean[] rst2 = null;

	try {
		if(userid.equals("qmtm")) {
			rst2 = GroupKindUtil.getBeans2();
		} else {
			rst2 = GroupKindUtil.getBeans2(userid);
		}
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	if(id_category.length() == 0) {
		id_category = "1";
	}
	
	TreeBean[] rst = null;

	if(!id_subject.equals("")) {

	if(userid.equals("qmtm")) {
		
		try {
			rst = TreeList.getQBeans2(userid, years, id_category, aligns, id_subject);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
	} else {
		
		try {
			rst = TreeList.getQMgrBeans(userid, years, id_category, aligns, id_subject);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
		}
	}

	}

	TreeBean[] rst3 = null;

	if(userid.equals("qmtm")) {		

		try {
			rst3 = TreeList.getAdmSubjectBeans(userid, years, id_category, aligns);		
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}	

	} else {

		try {
			rst3 = TreeList.getAdmSubjectBeans2(userid, years, id_category, aligns);		
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}	

	}
	
%>

<html>
<head>
	<title>QMAN 관리</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link rel="StyleSheet" href="../css/tree.css" type="text/css">
	<link rel="StyleSheet" href="../css/style.css" type="text/css">
	<script type="text/javascript" src="tree.js"></script>
	<link rel="StyleSheet" href="dtree.css" type="text/css" />
	<script type="text/javascript" src="dtree.js"></script>

	<script type="text/javascript">
		
		function cat_select() {
			var frm = document.forms1;

			var years = frm.years.value;
			var id_category = frm.id_category.value;
			var aligns;
			if(frm.aligns[0].checked == true) {
				aligns = "q_subject";
			} else {
				aligns = "regdate";
			}

			location.href="f_left.jsp?years="+years+"&id_category="+id_category+"&aligns="+aligns;
		}
		
		function cat_select2(sel) {
					
			location.href="f_left.jsp?years=<%=years%>&id_category=<%=id_category%>&aligns=<%=aligns%>&id_subject="+sel;

		}
	</script>
	
	<table border="0" align="center">
	<tr>
		<td>
		<form name="forms1" method="post">
		<select name="years">
	<% for(int j=2011; j<2020; j++) { %>	
		<option value="<%=j%>" <% if(year == j) { %>selected<% } %>><%=j%></option>
	<% } %>
	</select>
	<Select name="id_category">
	<% if(rst2 == null) { %>
		<option value="">분야없음</option>
	<%
		} else {
			for(int k=0; k<rst2.length; k++) {
	%>
		<option value="<%=rst2[k].getId_category()%>" <% if(id_category.equals(rst2[k].getId_category())) { %>selected<% } %>><%=rst2[k].getCategory()%></option>
	<%
			}
		}
	%>
		</select>
		<td>
		<td rowspan="2" valign="middle" align="center"><input type="button" value="검색" class="form5" onClick="cat_select();"> </td>
	</tr>
	<tr>
		<td><input type="radio" name="aligns" value="q_subject" <%if(aligns.equals("q_subject")) { %>checked<% } %>>&nbsp;과목명&nbsp;<input type="radio" name="aligns" value="regdate" <%if(aligns.equals("regdate")) { %>checked<% } %>>&nbsp;날짜별</td>
	</form>
	</tr>
	</table>
	<script type="text/javascript">
		<!--
		d = new dTree('d');
		// nodeId | parentNodeId | nodeName | nodeUrl | nodeCode | nodeGubun
		<% if(rst == null) { %>
			
		<% } else { %>

				document.write("<div class='tree' style='position: absolute; top: 13px;  overflow-y:scroll; height: 365px; overflow-x:scroll; width: 200px;'>");
				d.add('0','-1','문제관리 카테고리');
		<%
				for (int i = 0; i < rst.length; i++) {
					String img_icon = "";
					String img_icon_open = "";
					if(rst[i].getNode_gubun().substring(0,2).equals("S1")) {
						img_icon = "img/course.gif";
						img_icon_open = "img/course_open.gif";
					} else if(rst[i].getNode_gubun().substring(0,2).equals("U1")) {
						img_icon = "img/subject.gif";
						img_icon_open = "img/subject_open.gif";
					} else if(rst[i].getNode_gubun().substring(0,2).equals("U2")) {
						img_icon = "img/folder.gif";
						img_icon_open = "img/folderopen.gif";
					}
					
		%>
					d.add('<%=rst[i].getId_node()%>','<%=String.valueOf(rst[i].getId_parentnode())%>','<%=rst[i].getNode_name()%>','question/q.jsp?id_node=<%=rst[i].getId_node()%>&node_rid=<%=rst[i].getId_parentnode()%>&node_gubun=<%=rst[i].getNode_gubun()%>','','fraMain','<%=img_icon%>','<%=img_icon_open%>');	
		
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
		//-->
	</script>
</head>

<BODY id="admin" style="background-image: url(img/bg_tree.gif); background-repeat: no-repeat;">
<div style="position: absolute; top: 115px; left: 30px;">
		<form name="forms2">
		<select name="id_subject" onChange="cat_select2(this.value);" width="40">
			<% if(rst3 == null) { %>
			<option value="">개설된 과목이 없습니다.</option>
			<% } else { %>
			    <option value="">과목을 선택해 주세요.</option>
				<% for(int i=0; i<rst3.length; i++) { %>				
				<option value="<%=rst3[i].getId_node()%>" <% if(id_subject.equals(rst3[i].getId_node())) { %> selected <% } %>><%if(rst3[i].getNode_name().length() > 18) { %><%=rst3[i].getNode_name().substring(0,18)+"."%><% } else { %><%=rst3[i].getNode_name()%><% } %></option>
				<% } %>
			<% } %>
			</select>
		</form>
	</div>
</BODY>
</html>
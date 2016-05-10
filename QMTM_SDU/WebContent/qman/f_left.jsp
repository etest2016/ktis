<%
//******************************************************************************
//   프로그램 : f_left.asp
//   모 듈 명 : 문제관리 좌측 프레임
//   설    명 : 문제관리 좌측 프레임
//   테 이 블 : c_category, c_midcategory, q_subject, q_chapter
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.TreeMgrBean, qmtm.TreeMgrUtil, 
//              qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil
//   작 성 일 : 2013-01-30
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 :   
//******************************************************************************
%>        
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.TreeBean, qmtm.TreeList " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
	
	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String usergrade = (String)session.getAttribute("usergrade"); // 권한
	
	String term_info = request.getParameter("term_info");
	if (term_info == null) { term_info = ""; } else { term_info = term_info.trim(); }

	String aligns = request.getParameter("aligns");
	if (aligns == null) { aligns = "course"; } else { aligns = aligns.trim(); }		

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String term_id = "";
	if(term_info.length() == 0) {
		term_id = "2016-1"; //(String)session.getAttribute("term_info");
	} else {
		term_id = term_info; 
	}
	
	String id_group = "";
	
	String[] arrTerm_id;
	arrTerm_id = term_id.split("-");	
		
	TreeBean[] rst = null;

	if(userid.equals("qmtm") || usergrade.equals("M")) {		

		try {
			rst = TreeList.getAdmSubjBeans(arrTerm_id[0], arrTerm_id[1], aligns);		
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}	 
 
	} else {

		try {
			rst = TreeList.getSubjBeans(id_group, arrTerm_id[0], arrTerm_id[1], aligns);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}	

	}	
	
	TreeBean[] rst2 = null;
	
	if(!id_subject.equals("")) {
		
		if(userid.equals("qmtm") || usergrade.equals("M")) {		

			try {
				rst2 = TreeList.getAdmCptBeans(arrTerm_id[0], arrTerm_id[1], aligns, id_subject);		
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

				if(true) return;
			}	 
	 
		} else {

			try {
				rst2 = TreeList.getCptBeans(id_group, arrTerm_id[0], arrTerm_id[1], aligns, id_subject);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));

				if(true) return;
			}	

		}	
		
	} 	
	
%>

<html>
<head>
	<title>QMAN 관리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="StyleSheet" href="../css/tree.css" type="text/css">
	<link rel="StyleSheet" href="../css/style.css" type="text/css">
	<link rel="StyleSheet" href="dtree.css" type="text/css" />
	<script type="text/javascript" src="dtree.js"></script>

	<script type="text/javascript">
		
		function cat_select() {
			var frm = document.forms1;
			
			var term_info = frm.term_info.value;
			var aligns;
			if(frm.aligns[0].checked == true) {
				aligns = "course";			
			} else if(frm.aligns[1].checked == true) {
				aligns = "regdate";
			} else {
				aligns = "orders";
			}
			
			var id_subject = frm.id_subject.value;

			location.href="f_left.jsp?term_info="+term_info+"&aligns="+aligns+"&id_subject="+id_subject;
		}
				
				
	</script>
	
	<script type="text/javascript">
		<!--
		d = new dTree('d');
		// nodeId | parentNodeId | nodeName | nodeUrl | nodeCode | nodeGubun
		<% if(rst2 == null) { %>
			
		<% } else { %>

				document.write("<div class='tree' style='position: absolute; top: 30px; padding-top:3px; overflow-y:auto; width: 335px; height: 447px; overflow-x:auto;'>");
				d.add('0','-1','문제관리 카테고리');
		<%
				for (int i = 0; i < rst2.length; i++) {
					String img_icon = "";
					String img_icon_open = "";
					if(rst2[i].getNode_gubun().substring(0,1).equals("S")) {
						img_icon = "img/subject.gif";
						img_icon_open = "img/subject_open.gif";
					} else if(rst2[i].getNode_gubun().substring(0,1).equals("U")) {
						img_icon = "img/chapter.gif";
						img_icon_open = "";
					} else {
						img_icon = "img/course.gif";
						img_icon_open = "img/course_open.gif";
					}
		%>
					d.add('<%=rst2[i].getId_node()%>','<%=String.valueOf(rst2[i].getId_parentnode())%>','<%=ComLib.toStrHtml(rst2[i].getNode_name())%>','question/q.jsp?id_node=<%=rst2[i].getId_node()%>&node_rid=<%=rst2[i].getId_parentnode()%>&node_gubun=<%=rst2[i].getNode_gubun()%>','<%=ComLib.toStrHtml(rst2[i].getNode_name())%>','fraMain','<%=img_icon%>','<%=img_icon_open%>');	
									
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

<BODY id="admin" style="background-image: url(img/bg_tree.gif); background-repeat: no-repeat; over-flow:none;">

	<div style="position: absolute; top: 65px; left: 30px;">
		<table border="0" align="center">
		<tr>
			<td>
			<form name="forms1" method="post">
			<Select name="term_info">
				<option value=<%=arrTerm_id[0]%>-<%=arrTerm_id[1]%>><%=arrTerm_id[0]%>년도 1학기</option>
			</select>
			<input type="radio" name="aligns" value="course" <%if(aligns.equals("course")) { %>checked<% } %>>&nbsp;가나다순&nbsp;<input type="radio" name="aligns" value="regdate" <%if(aligns.equals("regdate")) { %>checked<% } %>>&nbsp;등록일자&nbsp;<input type="radio" name="aligns" value="orders" <%if(aligns.equals("orders")) { %>checked<% } %>>&nbsp;정렬순</td>
		</tr>	
		<tr>
			<td>
			<select name="id_subject" onChange="cat_select2(this.value);" style="width:270px;">
			<% if(rst == null) { %>
			<option value="">개설된 과목이 없습니다.</option>
			<% } else { %>
				<option value="">과목을 선택하세요</option>				    
				<% for(int i=0; i<rst.length; i++) { %>				
				<option value="<%=rst[i].getId_node()%>" <% if(id_subject.equals(rst[i].getId_node())) { %> selected <% } %>><%=rst[i].getNode_name()%></option>
				<% } %>
			<% } %>
			</select>&nbsp;<input type="button" value="조회하기" class="form5" onClick="cat_select();">
			</td>
		</tr>	
		</form>		
		</table>
	</div>	
	
</BODY>
</html>


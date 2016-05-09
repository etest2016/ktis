<%
//******************************************************************************
//   프로그램 : f_main.jsp
//   모 듈 명 : 과정관리
//   설    명 : 과정관리 페이지
//   테 이 블 : c_course
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean 
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 :    
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if (userid.length() == 0 || id_category.length() == 0) {
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}

    // 과정목록 가지고오기	
	TmanTreeBean[] rst = null; 

	try {
		rst = TmanTree.getBeans(id_category);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	GroupKindBean rst2 = null;

    try {
	    rst2 = GroupKindUtil.getBean(id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
   
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_insert() {
		window.open("course_insert.jsp?id_category=<%=id_category%>","insert","width=400, height=250, scrollbars=no");
    }

	function sub_view(id_course) {
		window.open("course/course_view.jsp?id_category=<%=id_category%>&id_course="+id_course,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
	<div id="main">

		<div id="mainTop">
			<div class="title">카테고리 관리<span>: 카테고리 리스트</span></div>
			<div class="location">카테고리 관리 > <span><%=rst2.getCategory()%></span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt">
				<TD  colspan="6"><a onfocus="this.blur();" href="javascript:sub_insert();"><img src="../../images/bt_a_newcourse.gif"></a></TD>
			</TR>
			<tr id="tr">
				<td align="center" bgcolor="#DBDBDB">NO</td>
				<td bgcolor="#DBDBDB" align="center">개설년도</td>
				<td bgcolor="#DBDBDB" align="center">과정코드</td>
				<td bgcolor="#DBDBDB" align="center">과정명</td>
				<td bgcolor="#DBDBDB" align="center">유효여부</td>
				<td bgcolor="#DBDBDB">등록일자</td>
			</tr>
			<% if(rst == null) { %>
			<tr height="30" bgcolor="#FFFFFF">
				<td class="blank" colspan="6">등록되어진 과정이 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>
			<tr id="td" height="30" bgcolor="#FFFFFF">
				<td align="center"><%=i+1%></td>
				<td align="center"><%=rst[i].getYears()%></td>
				<td align="center"><a onfocus="this.blur();" href="javascript:sub_view('<%=rst[i].getId_course()%>');"><%=rst[i].getId_course()%></a></td>
				<td align="center"><a onfocus="this.blur();" href="../q_tree/category_list.jsp?id_course=<%=rst[i].getId_course()%>"><%=rst[i].getCourse()%></a></td>
				<td align="center"><%=rst[i].getYn_valid()%></td>
				<td align="center"><%=rst[i].getRegdate()%></td>
				<!--<td align="center"><a onfocus="this.blur();" href="javascript:sub_group_insert('<%=rst[i].getId_course()%>');"><img src="../../images/bt_ttree_fmain_yj2.gif"></a></td>-->
			</tr>
			<%
				   }
				}
			%>
		</table>
	
	</div>
	<jsp:include page="../../copyright.jsp"/>
		
 </BODY>
</HTML>
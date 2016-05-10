<%
//******************************************************************************
//   프로그램 : midcategory_list.jsp
//   모 듈 명 : 소영역 리스트
//   설    명 : 소영역 리스트 페이지
//   테 이 블 : id_category, id_midcategory
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.MidGroupKindBean, qmtm.admin.etc.MidGroupKindUtil 
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.MidGroupKindBean, qmtm.admin.etc.MidGroupKindUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if(id_category.length() == 0 ) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}    
	
	// 그룹구분목록 가지고오기
	MidGroupKindBean[] rst = null;

	try {
		rst = MidGroupKindUtil.getBeans(id_category);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../../js/jquery.js"></script>
  <script type="text/javascript" src="../../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup("group_insert.jsp","insert","top=0, left=0, width=400, height=300, scrollbars=no");
    }

	function view(id_category) {
		
		$.posterPopup("group_view.jsp?id_category="+id_category,"view","top=0, left=0, width=400, height=300, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">카테고리 조회 리스트</div>
			<div class="location">ADMIN > 카테고리 조회 > <span>소영역조회</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">		
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">대영역명</td>
			<td bgcolor="#DBDBDB">소영역코드</td>
			<td bgcolor="#DBDBDB">소영역명</td>
			<!--<td bgcolor="#DBDBDB">정렬순서</td>-->
			<td bgcolor="#DBDBDB">공개유무</td>
			<td bgcolor="#DBDBDB">등록일자</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="6">등록되어진 소영역코드가 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getCategory()%></td>
			<td><%=rst[i].getId_midcategory()%></td>
            <td><a href="course_list.jsp?id_midcategory=<%=rst[i].getId_midcategory()%>"><%=rst[i].getMidcategory()%></a></td> 
			<!--<td><%=rst[i].getOrders()%></td>-->
			<td><%=rst[i].getYn_valid()%></td>
			<td><%=rst[i].getRegdate()%></td>
		</tr>
		<%
			   }
			}
		%>
	</table>
	</div>
		
 </BODY>
</HTML>
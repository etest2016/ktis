<%
//******************************************************************************
//   프로그램 : group_list.jsp
//   모 듈 명 : 대영역구분 리스트
//   설    명 : 대영역구분 리스트 페이지
//   테 이 블 : c_cateogry
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    // 대영역목록 가지고오기
	CategoryBean[] rst = null;

	try {
		rst = CategoryUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup('group_insert.jsp','insert','width=400, height=300, scrollbars=no top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }

	function view(id_category) {
		
		$.posterPopup('group_view.jsp?id_category='+id_category,'view','width=400, height=300, scrollbars=no top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">대영역코드관리</div>
			<div class="location">ADMIN > 코드정보관리 > <span>대영역코드관리</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<!-- <tr id="bt">
			<TD colspan="5"><input type="button" value="대영역코드등록" class="form5" onClick="insert();">&nbsp;&nbsp;<b>대영역명을 클릭하면 정보를 수정/삭제할 수 있습니다</b></TD>
		</TR>-->
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">대영역코드</td>
			<td bgcolor="#DBDBDB">대영역명</td>
			<td bgcolor="#DBDBDB">공개여부</td>
			<td bgcolor="#DBDBDB">등록일자</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="5">등록되어진 대영역코드가 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getId_category()%></td>
			<td><%=rst[i].getCategory()%></td>
			<td><%if(rst[i].getYn_valid().equals("Y")) {%>공개<%} else {%>비공개<%}%></td>
			<td><%=rst[i].getRegdate()%></td>
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
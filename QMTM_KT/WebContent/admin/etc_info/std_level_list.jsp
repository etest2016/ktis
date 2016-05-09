<%
//******************************************************************************
//   프로그램 : std_level_list.jsp
//   모 듈 명 : 레벨코드 리스트
//   설    명 : 레벨코드 리스트 페이지
//   테 이 블 : r_std_level
//   자바파일 : qmtm.admin.etc.StdLevelBean,
//              qmtm.admin.etc.StdLevelUtil 
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // 레벨코드목록 가지고오기
	StdLevelBean[] rst = null;

	try {
		rst = StdLevelUtil.getBeans();
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">
	function insert() {
		window.open("std_level_insert.jsp","insert","top=0, left=0, width=400, height=250, scrollbars=no");
    }

	function view(std_level) {
		
		window.open("std_level_view.jsp?std_level="+std_level,"view","top=0, left=0, width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
    <div id="main">		
		<div id="mainTop">
			<div class="title">레벨코드 리스트</div>
			<div class="location">ADMIN > 기타정보관리 > <span>레벨코드관리</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<td colspan="4"><a href="javascript:insert();"><img src="../../../images/l_purpose.gif"></a></TD>
		</TR>
		<tr id="tr">
			<td width="7%" align="center">NO</td>
			<td>레벨코드</td>
			<td align="left">레벨명</td>
			<td>등록일자</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="4">등록되어진 레벨코드가 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getStd_level()%></td>
			<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getStd_level()%>');"><%=rst[i].getLevel_nm()%></a></div><div style="float: left; margin-top: 1px; margin-left: 3px;"><img src="../../images/info2.gif"></div></td>
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
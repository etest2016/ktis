<%
//******************************************************************************
//   프로그램 : group_list2.jsp
//   모 듈 명 : 소영역구분 리스트
//   설    명 : 소영역구분 리스트 페이지
//   테 이 블 : c_midcateogry
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    // 그룹구분목록 가지고오기
	MidCategoryBean[] rst = null;

	try {
		rst = MidCategoryUtil.getBeans();
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
		$.posterPopup('group_insert2.jsp','insert','width=400, height=300, scrollbars=no, top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }

	function view(id_midcategory) {
		
		$.posterPopup('group_view2.jsp?id_midcategory='+id_midcategory,'view','width=400, height=300, scrollbars=no, top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">소영역코드관리</div>
			<div class="location">ADMIN > 코드정보관리 > <span>소영역코드관리</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<!--<tr id="bt">
			<TD colspan="6"><input type="button" value="소영역코드등록" class="form5" onClick="insert();">&nbsp;&nbsp;<b>소영역명을 클릭하면 정보를 수정/삭제할 수 있습니다</b></TD>
		</TR>-->
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">대영역명</td>
			<td bgcolor="#DBDBDB">소영역코드</td>
			<td bgcolor="#DBDBDB">소영역명</td>
			<td bgcolor="#DBDBDB">공개여부</td>
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
			<td><%=rst[i].getMidcategory()%></td>
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
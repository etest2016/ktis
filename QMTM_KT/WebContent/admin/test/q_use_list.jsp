<%
//******************************************************************************
//   프로그램 : q_use_list.jsp
//   모 듈 명 : 문제용도 리스트
//   설    명 : 문제용도 리스트 페이지
//   테 이 블 : r_q_use
//   자바파일 : qmtm.admin.etc.QuseBean,
//              qmtm.admin.etc.QuseUtil 
//   작 성 일 : 2008-04-08
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


    // 문제용도목록 가지고오기
	QuseBean[] rst = null;

	try {
		rst = QuseUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">
	function insert() {
		window.open("q_use_insert.jsp","insert","top=0, left=0, width=400, height=280, scrollbars=no");
    }

	function view(id_q_use) {
		
		window.open("q_use_view.jsp?id_q_use="+id_q_use,"view","top=0, left=0, width=400, height=280, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
    <form name="form1" method="post" action="m_list.jsp">
	<div id="main">		
		<div id="mainTop">
			<div class="title">문제용도 리스트</div>
			<div class="location">ADMIN > 기타정보관리 > <span>문제용도코드관리</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt">
				<td colspan="4"><a href="javascript:insert();"><img src="../../../images/q_purpose.gif"></a></td>
			</tr>
			<tr id="tr">
					<td width="7%">NO</td>
					<td>코드</td>
					<td style="text-align: left;">문제용도</td>
					<td style="text-align: left;">설명</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="4">등록되어진 문제용도가 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><%=rst[i].getId_q_use()%></td>
				<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getId_q_use()%>');"><%=rst[i].getQ_use()%></a></div><div style="float: left; padding-top: 1px; padding-left: 5px;"><img src="../../../images/info2.gif"></div></td>
				<td><%=rst[i].getRmk()%>&nbsp;</td>
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
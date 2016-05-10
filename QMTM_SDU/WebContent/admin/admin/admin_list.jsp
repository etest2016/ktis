<%
//******************************************************************************
//   프로그램 : admin_list.jsp
//   모 듈 명 : 전체 관리자 리스트
//   설    명 : 전체 관리자 리스트 페이지
//   테 이 블 : qt_adminid
//   자바파일 : qmtm.ComLib, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil 
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // 전체 관리자목록 가지고오기
	AdminBean[] rst = null;

	try {
		rst = AdminUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

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
		$.posterPopup('admin_insert.jsp','insert','width=500, height=250, scrollbars=no, top='+(screen.height-250)/2+', left='+(screen.width-500)/2);
    }

	function view(userid) {
		$.posterPopup('admin_edit.jsp?userid='+userid,'view','width=500, height=250, scrollbars=no, top='+(screen.height-250)/2+', left='+(screen.width-500)/2);
   
    }

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">관리자 관리<span>: 관리자 추가, 수정, 삭제 관리</span></div>
			<div class="location">ADMIN > <span>관리자 관리</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="8"><input type="button" value="관리자 등록" class="form5" onClick="insert();">&nbsp;&nbsp;<b>아이디를 클릭하면 관리자 정보를 수정/삭제 할 수 있습니다.</b></td></tr>
			<tr id="tr">
				<td width="4%">NO</td>
				<td width="10%">아이디</td>
				<td width="10%">성명</td>
				<td width="18%">이메일</td>
				<td width="10%">휴대폰</td>
				<td>관리자소속</td>
				<td width="12%">계정사용여부</td>
				<td width="10%">등록일자</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="8">등록되어진 관리자가 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
					   String yn_use = rst[i].getYn_valid();

					   if(yn_use.equalsIgnoreCase("Y")) {
						   yn_use = "사용";
					   } else {
						   yn_use = "미사용";
					   }
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getUserid()%>');" onfocus="this.blur();"><%=rst[i].getUserid()%></a></div><div style="float: left; margin-top: 1px; margin-left: 3px;"><img src="../../images/info2.gif"></div></td>
				<td><%=rst[i].getName()%></td>
				<td><%=ComLib.nullChk2(rst[i].getEmail())%></td>
				<td><%=ComLib.nullChk2(rst[i].getHp())%></td>
				<td>&nbsp;<%=ComLib.nullChk2(rst[i].getContent1())%></td>
				<td><%=yn_use%></td>
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
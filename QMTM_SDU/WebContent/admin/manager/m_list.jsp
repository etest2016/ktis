<%
//******************************************************************************
//   프로그램 : m_list.jsp
//   모 듈 명 : 전체 담당자리스트
//   설    명 : 전체 담당자리스트 페이지
//   테 이 블 : qt_workerid
//   자바파일 : qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil 
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // 전체 담당자목록 가지고오기
	ManagerBean[] rst = null;

	try {
		rst = ManagerUtil.getBeans();
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
		$.posterPopup('manager_insert.jsp','insert','width=500, height=450, scrollbars=no, top='+(screen.height-450)/2+', left='+(screen.width-500)/2);
    }

	function view(userid) {
		$.posterPopup('manager_view.jsp?userid='+userid,'view','width=500, height=450, scrollbars=no, top='+(screen.height-450)/2+', left='+(screen.width-500)/2);
    }

	function q_list(userid) {
		$.posterPopup('q_manager_list.jsp?userid='+userid,'q_list','width=1200, height=570, scrollbars=yes, top='+(screen.height-570)/2+', left='+(screen.width-1000)/2);
	}

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">담당자 관리<span>: 담당자 추가, 삭제 및 권한 관리</span></div>
			<div class="location">ADMIN > <span>담당자 관리</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<!--<tr id="bt"><Td colspan="9"><input type="button" value="담당자 등록" class="form5" onClick="insert();">&nbsp;&nbsp;<b>아이디를 클릭하면 담당자 정보를 수정/삭제 할 수 있습니다.</b></td></tr>-->
			<tr id="tr">
				<td width="4%">NO</td>
				<td width="10%">아이디</td>
				<td width="10%">성명</td>
				<td width="18%">이메일</td>
				<td width="10%">휴대폰</td>
				<td>담당자소속</td>
				<td width="12%">계정사용여부</td>
				<td width="10%">등록일자</td>
				<td width="10%">권한조회</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="9">등록되어진 담당자가 없습니다.</td>
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
				<td><%=rst[i].getUserid()%></td>
				<td><%=rst[i].getName()%></td>
				<td><%=ComLib.nullChk2(rst[i].getEmail())%></td>
				<td><%=ComLib.nullChk2(rst[i].getHp())%></td>
				<td>&nbsp;<%=ComLib.nullChk2(rst[i].getContent1())%></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getRegdate()%></td>
				<td><input type="button" value="과정별 권한조회" class="form" onClick="q_list('<%=rst[i].getUserid()%>');"></td>
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
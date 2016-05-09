<%
//******************************************************************************
//   프로그램 : q_list.jsp
//   모 듈 명 : 문제은행 담당자리스트
//   설    명 : 문제은행 담당자리스트 페이지
//   테 이 블 : q_worker_subj, q_workerid
//   자바파일 : qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil
//   작 성 일 : 2010-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>    

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerBean, qmtm.admin.manager.ManagerUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // 문제은행 담당자목록 가지고오기
	ManagerBean[] rst = null;

	try {
		rst = ManagerUtil.getQMgrBeans();
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
	function insert() {
		window.open("manager_insert.jsp","insert","top=0, left=0, width=500, height=370, scrollbars=no");
    }

	function view(userid) {
		window.open("manager_view.jsp?userid="+userid,"view","top=0, left=0, width=500, height=370, scrollbars=no");
    }

	function q_list(userid) {
		window.open("q_manager_list.jsp?userid="+userid,"q_list","top=0, left=0, width=800, height=570, scrollbars=yes");
	}	
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">
		
		<div id="mainTop">
			<div class="title">문제관리 담당자 리스트</div>
			<div class="location">ADMIN > 담당자관리 > <span>문제관리 담당자</span></div>
		</div>

	<table border="0"cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt"><!--<Td colspan="6"><a href="javascript:insert();"><img src="../../images/bt_aqman_newworker.gif"></a></td>--></tr>

		<tr id="tr">
			<td width="7%">NO</td>
			<td align="left">아이디</td>
			<td align="left">성명</td>
			<td>유효여부</td>
			<td>등록일자</td>
			<td width="120">&nbsp;</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="6">등록되어진 담당자가 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
				   String yn_use = rst[i].getYn_valid();

				   if(yn_use.equalsIgnoreCase("Y")) {
					   yn_use = "가능";
				   } else {
					   yn_use = "불가능";
				   }
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getUserid()%>');"><%=rst[i].getUserid()%></a></div><div style="float: left; margin-top: 1px; margin-left: 3px;"><img src="../../images/info2.gif"></div></td>
			<td align="left"><%=rst[i].getName()%></td>
			<td><%=yn_use%></td>
			<td><%=rst[i].getRegdate()%></td>
			<td><a href="javascript:q_list('<%=rst[i].getUserid()%>');"><img src="../../images/bt3_qman_mn.gif"></a></td>
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
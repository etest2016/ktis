<%
//******************************************************************************
//   프로그램 : course_list.jsp
//   모 듈 명 : 과정 리스트
//   설    명 : 과정 리스트 페이지
//   테 이 블 : id_category, id_midcategory, c_course
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil
//   작 성 일 : 2013-01-28
//   작 성 자 : 이테스트 석준호
//   수 정 일 :    
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>
 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }	

	if (userid.length() == 0) {
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
    // 과정목록 가지고오기
	CourseKindBean[] rst = null; 

	try {
		rst = CourseKindUtil.getBeansAll();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

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
		$.posterPopup('course_insert.jsp','insert','width=400, height=300, scrollbars=no, top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }

	function view(id_category, id_midcategory, id_course) {
		
		$.posterPopup('course_view.jsp?id_category='+id_category+'&id_midcategory='+id_midcategory+'&id_course='+id_course,'view','width=400, height=350, scrollbars=no, top='+(screen.height-350)/2+', left='+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">과정코드관리</div>
			<div class="location">ADMIN > 코드정보관리 > <span>과정코드관리</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<!--<tr id="bt">
			<TD colspan="9"><input type="button" value="과정코드등록" class="form5" onClick="insert();">&nbsp;&nbsp;<b>과정명을 클릭하면 정보를 수정/삭제할 수 있습니다</b></TD>
		</TR>-->
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">대영역명</td>
			<td bgcolor="#DBDBDB">소영역명</td>
			<td bgcolor="#DBDBDB">과정코드</td>
			<td bgcolor="#DBDBDB">과정명</td>
			<td bgcolor="#DBDBDB">정렬순서</td>
			<td bgcolor="#DBDBDB">공개여부</td>			
			<td bgcolor="#DBDBDB">등록일자</td>
		</tr>
		<% if(rst == null) { %>
		<tr> 
			<td class="blank" colspan="8">등록되어진 과정 코드가 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {

				   String yn_valid = "";
				   if(rst[i].getYn_valid().equals("Y")) {
					  yn_valid = "공개";  
				   } else {
					  yn_valid = "비공개";
				   }
				   
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getCategory()%></td>
			<td><%=rst[i].getMidcategory()%></td>
			<td><%=rst[i].getId_course()%></td> 
			<td><%=rst[i].getCourse()%></td> 
			<td><%=rst[i].getOrders()%></td>
			<td><%=yn_valid%></td>			
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
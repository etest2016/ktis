<%
//******************************************************************************
//   프로그램 : category_list.jsp
//   모 듈 명 : 과정 리스트
//   설    명 : 과정 리스트 페이지
//   테 이 블 : id_category, id_midcategory, c_course
//   자바파일 : qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil
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

	String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory = ""; } else { id_midcategory = id_midcategory.trim(); }

	if (userid.length() == 0 || id_midcategory.length() == 0) {
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}
	
    // 과정목록 가지고오기
	CourseKindBean[] rst = null; 

	try {
		rst = CourseKindUtil.getBeans(id_midcategory);   
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	
%>
<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		<div id="mainTop">
			<div class="title">카테고리 조회 리스트</span></div>
			<div class="location">카테고리 조회 > 카테고리 조회 > <span>과정조회</span></div>
		</div>
		<table border="0" cellpadding ="0" cellspacing="0" id="tablea">
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
	
 </BODY>
</HTML>
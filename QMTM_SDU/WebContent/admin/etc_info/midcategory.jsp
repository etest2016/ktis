<%
//******************************************************************************
//   프로그램 : midcategory.jsp
//   모 듈 명 : 소영역 SelectBox
//   설    명 : 대영역 아래에 소영역 정보 가지고 오기
//   테 이 블 : c_midcategory
//   자바파일 : qmtm.ComLib, qmtm.TreeMgrUtil, qmtm.TreeMgrBean
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.TreeMgrUtil, qmtm.TreeMgrBean" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	String id_midcategory = request.getParameter("id_midcategory");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 소영역목록 가지고오기
	TreeMgrBean[] rst = null;

	try {
		rst = TreeMgrUtil.getCategory(id_category, "orders");
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>
<select name="id_midcategory" style="width:200" onChange="get_order_list(this.value);">
<% if(rst == null) { %>
	<option value="">등록 소영역 없음</a>
<%
	} else {
%>
	<option value="">소영역을 선택하세요</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_midcategory()%>" <% if(id_midcategory.equals(rst[i].getId_midcategory())) { %>selected<% } %>><%=rst[i].getMidcategory()%></option>
<%
		}
	}
%>
</select>
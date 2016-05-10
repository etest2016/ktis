<%
//******************************************************************************
//   프로그램 : standarda.jsp
//   모 듈 명 : 대분류 SelectBox
//   설    명 : 모듈 아래에 대분류 정보 가지고 오기
//   테 이 블 : q_standard_a
//   자바파일 : qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_chapter = request.getParameter("id_chapter");

	String selects = request.getParameter("selects");

	// 대분류 리스트 가져오기

	QstandardABean[] rst = null;

    try {
	    rst = QstandardAUtil.getSelectBeans(id_chapter);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<select name="q_ks" style="width:300" onChange="get_standardb_list(this.value);">
<% if(rst == null) { %>
	<option value="" <%if(selects.equals("")) {%>selected<%}%>>등록 대분류 없음</a>
<%
	} else {
%>
	<option value=" " <%if(selects.equals("")) {%>selected<%}%>>대분류를 선택하세요</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_standarda()%>" <%if(selects.equals(rst[i].getId_standarda())) {%>selected<%}%>><%=rst[i].getStandarda()%></option>
<%
		}
	}
%>
</select>
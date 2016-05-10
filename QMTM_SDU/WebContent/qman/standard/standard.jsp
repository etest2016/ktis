<%
//******************************************************************************
//   프로그램 : standard.jsp
//   모 듈 명 : 소분류 SelectBox
//   설    명 : 대분류 아래에 소분류 정보 가지고 오기
//   테 이 블 : q_standard_b
//   자바파일 : qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_standarda = request.getParameter("id_standarda");

	String selects = request.getParameter("selects");

	// 소분류 리스트 가져오기

	QstandardBBean[] rst = null;

    try {
	    rst = QstandardBUtil.getSelectBeans(id_standarda);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<select name="q_to" style="width:300">
<% if(rst == null) { %>
	<option value="" <%if(selects.equals("")) {%>selected<%}%>>등록 소분류 없음</a>
<%
	} else {
%>
	<option value=" " <%if(selects.equals("")) {%>selected<%}%>>소분류를 선택하세요</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_standardb()%>" <%if(selects.equals(rst[i].getId_standardb())) {%>selected<%}%>><%=rst[i].getStandardb()%></option>
<%
		}
	}
%>
</select>
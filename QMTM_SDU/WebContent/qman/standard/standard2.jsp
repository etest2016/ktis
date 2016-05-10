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

	// 소분류 리스트 가져오기

	QstandardBBean[] rst = null;

    try {
	    rst = QstandardBUtil.getSelectBeans(id_standarda);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<select name="q_tos" style="width:255" disabled>
<% if(rst == null) { %>
<option value="">등록 소분류 없음</a>
<%
	} else {
%>
	<option value="">소분류를 선택하세요.</option>
<%
		for(int i=0; i<rst.length; i++) {
%>
	<option value="<%=rst[i].getId_standardb()%>"><%=rst[i].getStandardb()%></option>
<%
		}
	}
%>
</select>
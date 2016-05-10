<%
//******************************************************************************
//   프로그램 : lecture.jsp
//   모 듈 명 : 강좌 리스트 페이지
//   설    명 : 해당 과정 아래에 강좌 정보 가지고 오기
//   테 이 블 : q_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2013-02-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }
	
	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// 과정 아래 강좌정보 가지고오기
	SubjectTmanBean[] rst2 = null;

    try {
	    rst2 = SubjectTmanUtil.getBeans(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<select name="id_subject" style="width:400" onChange="cat_select(this.value);">
<% if(rst2 == null) { %>
	<option value="" <% if(id_subject.equals("")) { %>selected<% } %>>강좌정보 없음</a>
<%
	} else {
%>
	<option value="">강좌을 선택하세요.</a>
<%
		for(int i=0; i<rst2.length; i++) {
%>
	<option value="<%=rst2[i].getId_subject()%>" <% if(id_subject.equals(rst2[i].getId_subject())) { %>selected<% } %>>(<%=rst2[i].getOpen_year()%>/<%=rst2[i].getOpen_month()%>)<%=rst2[i].getSubject()%></option>
<%
		}
	}
%>
</select>
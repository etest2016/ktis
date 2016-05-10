<%
//******************************************************************************
//   ���α׷� : lecture.jsp
//   �� �� �� : ���� ����Ʈ ������
//   ��    �� : �ش� ���� �Ʒ��� ���� ���� ������ ����
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2013-02-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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

	// ���� �Ʒ� �������� ���������
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
	<option value="" <% if(id_subject.equals("")) { %>selected<% } %>>�������� ����</a>
<%
	} else {
%>
	<option value="">������ �����ϼ���.</a>
<%
		for(int i=0; i<rst2.length; i++) {
%>
	<option value="<%=rst2[i].getId_subject()%>" <% if(id_subject.equals(rst2[i].getId_subject())) { %>selected<% } %>>(<%=rst2[i].getOpen_year()%>/<%=rst2[i].getOpen_month()%>)<%=rst2[i].getSubject()%></option>
<%
		}
	}
%>
</select>
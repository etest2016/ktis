<%
//******************************************************************************
//   ���α׷� : change_cpt1.jsp
//   �� �� �� : ��� ����Ʈ ������
//   ��    �� : �ش� ���� �Ʒ��� ��� ���� ������ ����
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.ComLib, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean
//   �� �� �� : 2013-02-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }
	
	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null || id_chapter.equals("")) { id_chapter= ""; } else { id_chapter = id_chapter.trim(); }

	// ��� ������ ����
	ExamUtilBean[] cpts = null;

    try {
	    cpts = ExamUtil.getCpt1Beans(id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<select name="id_chapter" style="width:300" >
<% if(cpts == null) { %>
	<option value="0" <% if(id_chapter.equals("0")) { %>selected<% } %>>�ܿ����� ����</a>
<%
	} else {
%>
	<option value="0" <% if(id_chapter.equals("0")) { %>selected<% } %>>�ܿ��� �����ϼ���.</a>
<%
		for(int i=0; i<cpts.length; i++) {
%>
	<option value="<%=cpts[i].getId_q_chapter()%>" <% if(id_chapter.equals(cpts[i].getId_q_chapter())) { %>selected<% } %>><%=cpts[i].getChapter()%></option>
<%
		}
	}
%>
</select>
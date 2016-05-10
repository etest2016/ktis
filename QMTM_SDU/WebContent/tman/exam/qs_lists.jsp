<%
//******************************************************************************
//   ���α׷� : qs_lists.jsp
//   �� �� �� : �׷캰 ���� ���� ����Ʈ
//   ��    �� : �׷캰 ���� ���� ����Ʈ
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2008-04-29
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");

	String bigos = request.getParameter("bigos");

	// �׷캰 ���� ������ ����
	ExamQsBean[] qs_list = null;

	ExamQsBean[] ref_list = null;

    if(bigos.equals("1") || bigos.equals("2")) {
		try {
		    qs_list = ExamUtil.getQsBeans(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }

		try {
		    ref_list = ExamUtil.getRefsBeans(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
		
	} else if(bigos.equals("3")) {
		try {
			qs_list = ExamUtil.getQsBeans2(id_exam);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }

		try {
		    ref_list = ExamUtil.getRefsBeans2(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
	} else if(bigos.equals("4")) {
		try {
			qs_list = ExamUtil.getQsBeans3(id_exam);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
		try {
		    ref_list = ExamUtil.getRefsBeans3(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
	    }
	} else if(bigos.equals("6")) {
		try {
			qs_list = ExamUtil.getQsBeans4(id_exam);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }

		try {
		    ref_list = ExamUtil.getRefsBeans4(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
	    }
	} else if(bigos.equals("7")) {
		try {
			qs_list = ExamUtil.getQsBeans5(id_exam);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }

		try {
		    ref_list = ExamUtil.getRefsBeans5(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
	} else if(bigos.equals("5")) {
		try {
			qs_list = ExamUtil.getQsBeans6(id_exam);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }

		try {
		    ref_list = ExamUtil.getRefsBeans6(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
	}

%>

<div style="overflow: auto; width:100%; height:225px; margin-top: 0px;">

<%
	if(bigos.equals("1") || bigos.equals("2")) {
%>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="100%" align="center">
	<tr bgcolor="#e6e6e6" height="35">
		<td align="center" width="35%">�����</td>
		<td align="center" width="25%">��������</td>
		<td align="center" width="25%">������</td>
		<td align="center" width="15%">���ļ���</td>
	</tr>
<%
	if(ref_list != null) { 
%>
		<input type="hidden" name="ref_YN" value="Y">
<%  } else { %>
		<input type="hidden" name="ref_YN" value="N">
<%
	}

	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_qtypes" value="<%=qs_list[i].getId_qtype()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><%=qs_list[i].getId_qtypes()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
	</tr>
<%
	}
%>
</table>
<%
	} else if(bigos.equals("3")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="100%" align="center">
	<tr bgcolor="#e6e6e6" height="35">
		<td align="center" width="35%">�����</td>
		<td align="center" width="35%">�ܿ���</td>
		<td align="center" width="15%">������</td>
		<td align="center" width="15%">���ļ���</td>
	</tr>
<%
	if(ref_list != null) { 
%>
		<input type="hidden" name="ref_YN" value="Y">
<%  } else { %>
		<input type="hidden" name="ref_YN" value="N">
<%
	}

	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_chapters" value="<%=qs_list[i].getId_chapter()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><% if(qs_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=qs_list[i].getChapter()%><% } %></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
	</tr>
<%
	}
%>
</table>

<%
	} else if(bigos.equals("4")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="100%" align="center">
	<tr bgcolor="#e6e6e6" height="35">
		<td align="center" width="25%">�����</td>
		<td align="center" width="25%">�ܿ���</td>
		<td align="center" width="25%">��������</td>
		<td align="center" width="12%">������</td>
		<td align="center" width="13%">���ļ���</td>
	</tr>
<%
	if(ref_list != null) { 
%>
		<input type="hidden" name="ref_YN" value="Y">
<%  } else { %>
		<input type="hidden" name="ref_YN" value="N">
<%
	}

	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_chapters" value="<%=qs_list[i].getId_chapter()%>">
		<input type="hidden" name="id_qtypes" value="<%=qs_list[i].getId_qtype()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><% if(qs_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=qs_list[i].getChapter()%><% } %></td>
		<td align="center"><%=qs_list[i].getId_qtypes()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
	</tr>
<%
	}
%>
</table>

<%
	} else if(bigos.equals("6")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="100%" align="center">
	<tr bgcolor="#e6e6e6" height="35">
		<td align="center" width="25%">�����</td>
		<td align="center" width="25%">�ܿ���</td>
		<td align="center" width="25%">���̵�</td>
		<td align="center" width="12%">������</td>
		<td align="center" width="13%">���ļ���</td>
	</tr>
<%
	if(ref_list != null) { 
%>
		<input type="hidden" name="ref_YN" value="Y">
<%  } else { %>
		<input type="hidden" name="ref_YN" value="N">
<%
	}

	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_chapters" value="<%=qs_list[i].getId_chapter()%>">
		<input type="hidden" name="id_difficultys" value="<%=qs_list[i].getId_difficulty()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><% if(qs_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=qs_list[i].getChapter()%><% } %></td>
		<td align="center"><%=qs_list[i].getDifficulty()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
	</tr>
<%
	}
%>
</table>

<%
	} else if(bigos.equals("7")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="100%" align="center">
	<tr bgcolor="#e6e6e6" height="35">
		<td align="center" width="25%">�����</td>
		<td align="center" width="20%">�ܿ���</td>
		<td align="center" width="15%">��������</td>
		<td align="center" width="15%">���̵�</td>
		<td align="center" width="12%">������</td>
		<td align="center" width="13%">���ļ���</td>
	</tr>
<%
	if(ref_list != null) { 
%>
		<input type="hidden" name="ref_YN" value="Y">
<%  } else { %>
		<input type="hidden" name="ref_YN" value="N">
<%
	}

	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_chapters" value="<%=qs_list[i].getId_chapter()%>">
		<input type="hidden" name="id_qtypes" value="<%=qs_list[i].getId_qtype()%>">
		<input type="hidden" name="id_difficultys" value="<%=qs_list[i].getId_difficulty()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><% if(qs_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=qs_list[i].getChapter()%><% } %></td>
		<td align="center"><%=qs_list[i].getId_qtypes()%></td>
		<td align="center"><%=qs_list[i].getDifficulty()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
	</tr>
<%
	}
%>
</table>

<%
	} else if(bigos.equals("5")) {
%>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="100%" align="center">
	<tr bgcolor="#e6e6e6" height="35">
		<td align="center" >�����</td>
		<td align="center" width="25%">������</td>
		<td align="center" width="15%">���ļ���</td>
	</tr>
<%
	if(ref_list != null) { 
%>
		<input type="hidden" name="ref_YN" value="Y">
<%  } else { %>
		<input type="hidden" name="ref_YN" value="N">
<%
	}

	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
	</tr>
<%
	}
%>
</table>

<%
	}
%>
</div>
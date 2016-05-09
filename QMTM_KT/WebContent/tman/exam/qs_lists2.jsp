<%
//******************************************************************************
//   ���α׷� : qs_lists2.jsp
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

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	String bigos = request.getParameter("bigos");

	int ref_cnt_res = 0;

	// �׷캰 ���� ������ ����
	ExamQsBean[] qs_list = null;

	ExamQsBean[] ref_list = null;

    if(bigos.equals("1") || bigos.equals("2")) {
		try {
		    qs_list = ExamUtil.getRQsBeans(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
	    }

		try {
		    ref_list = ExamUtil.getRefBeans(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
	    }
		
	} else if(bigos.equals("3")) {
		try {
			qs_list = ExamUtil.getRQsBeans2(id_exam);
	    } catch(Exception ex) {
		    out.println(ex.getMessage());
	    }

		try {
		    ref_list = ExamUtil.getRefBeans(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
	    }
	} else if(bigos.equals("4")) {
		try {
			qs_list = ExamUtil.getRQsBeans3(id_exam);
	    } catch(Exception ex) {
		    out.println(ex.getMessage());
	    }
		
		try {
		    ref_list = ExamUtil.getRefBeans(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
	    }
	} else if(bigos.equals("6")) {
		try {
			qs_list = ExamUtil.getRQsBeans4(id_exam);
	    } catch(Exception ex) {
		    out.println(ex.getMessage());
	    }

		try {
		    ref_list = ExamUtil.getRefBeans(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
	    }
	} else if(bigos.equals("7")) {
		try {
			qs_list = ExamUtil.getRQsBeans5(id_exam);
	    } catch(Exception ex) {
		    out.println(ex.getMessage());
	    }

		try {
		    ref_list = ExamUtil.getRefBeans(id_exam);
		} catch(Exception ex) {
			out.println(ex.getMessage());
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

	if(ref_list == null) {
		ref_cnt_res = 0;
	} else {
		ref_cnt_res = ref_list.length;
	}
%>

<%
	if(bigos.equals("1") || bigos.equals("2")) {
%>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center">�����</td>
		<td align="center" width="15%">��������</td>
		<td align="center" width="10%">������</td>
		<td align="center" width="10%">���ļ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="10%">���⹮�׼�</td>
		<td align="center" width="10%">���׹���</td>
	</tr>
<%
	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_qtypes" value="<%=qs_list[i].getId_qtype()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><%=qs_list[i].getId_qtypes()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
		<td align="center"><input type="button" value="��������" onClick="q_extract('<%=i%>', '<%=qs_list[i].getCnts()%>', '<%=qs_list.length%>', '<%=ref_cnt_res%>')"></td>
		<td align="center"><input type="text" class="input" name="ch_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ch_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
	}
%>
</table>
<p>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�ܿ���</td>
		<td align="center" width="12%">������ ������</td>
		<td align="center" width="12%">���� �׷��</td>
		<td align="center" width="12%">��������</td>
		<td align="center" width="12%">������ �׷��</td>
		<td align="center" width="12%">���׺� ����</td>
	</tr>
<%
	if(ref_list != null) {
%>
	<input type="hidden" name="ref_YN" value="Y">
<%
		int ii = 1;
		for(int i=0; i<ref_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs2" value="<%=i+1%>">
		<input type="hidden" name="ref_subject" value="<%=ref_list[i].getId_subject()%>">
		<input type="hidden" name="ref_chapter" value="<%=ref_list[i].getId_chapter()%>">
		<input type="hidden" name="qs<%=i%>" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_order" value="<%=(qs_list.length + ii)%>">
		<td>&nbsp;<% if(ref_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=ref_list[i].getChapter()%><% } %></td>
		<td align="center"><%=ref_list[i].getRef_cnts()%></td>
		<td align="center"><%=ref_list[i].getRef_cnts2()%></td>
		<td align="center"><input type="button" value="��������" onClick="ref_extract('<%=i%>', '<%=ref_list[i].getRef_cnts()%>', '<%=ref_list[i].getRef_cnts2()%>', '<%=ref_list.length%>', '<%=qs_list.length%>')"></td>
		<td align="center"><input type="text" class="input" name="ref_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ref_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
			ii++;
		}
	} else {
%>
	<input type="hidden" name="ref_YN" value="N">
<%
	}
%>
</table>

<%
	} else if(bigos.equals("3")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�����</td>
		<td align="center" width="20%">�ܿ���</td>
		<td align="center" width="10%">������</td>
		<td align="center" width="10%">���ļ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="10%">���⹮�׼�</td>
		<td align="center" width="10%">���׹���</td>
	</tr>
<%
	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25"> 
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_chapters" value="<%=qs_list[i].getId_chapter()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><% if(qs_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=qs_list[i].getChapter()%><% } %></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
		<td align="center"><input type="button" value="��������" onClick="q_extract('<%=i%>', '<%=qs_list[i].getCnts()%>', '<%=qs_list.length%>', '<%=ref_cnt_res%>')"></td>
		<td align="center"><input type="text" class="input" name="ch_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ch_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
	}
%>
</table>

<p>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�ܿ���</td>
		<td align="center" width="12%">������ ������</td>
		<td align="center" width="12%">���� �׷��</td>
		<td align="center" width="12%">��������</td>
		<td align="center" width="12%">������ �׷��</td>
		<td align="center" width="12%">���׺� ����</td>
	</tr>
<%
	if(ref_list != null) {
%>
	<input type="hidden" name="ref_YN" value="Y">
<%
		int ii = 1;
		for(int i=0; i<ref_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
	    <input type="hidden" name="idxs2" value="<%=i+1%>">
		<input type="hidden" name="ref_subject" value="<%=ref_list[i].getId_subject()%>">
		<input type="hidden" name="ref_chapter" value="<%=ref_list[i].getId_chapter()%>">
		<input type="hidden" name="qs<%=i%>" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_order" value="<%=(qs_list.length + ii)%>">
		<td>&nbsp;<% if(ref_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=ref_list[i].getChapter()%><% } %></td>
		<td align="center"><%=ref_list[i].getRef_cnts()%></td>
		<td align="center"><%=ref_list[i].getRef_cnts2()%></td>
		<td align="center"><input type="button" value="��������" onClick="ref_extract('<%=i%>', '<%=ref_list[i].getRef_cnts()%>', '<%=ref_list[i].getRef_cnts2()%>', '<%=ref_list.length%>', '<%=qs_list.length%>')"></td>
		<td align="center"><input type="text" class="input" name="ref_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ref_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
			ii++;
		}
	} else {
%>
	<input type="hidden" name="ref_YN" value="N">
<%
	}
%>
</table>

<%
	} else if(bigos.equals("4")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center">�����</td>
		<td align="center" width="15%">�ܿ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="10%">������</td>
		<td align="center" width="10%">���ļ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="10%">���⹮�׼�</td>
		<td align="center" width="10%">���׹���</td>
	</tr>
<%
	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_chapters" value="<%=qs_list[i].getId_chapter()%>">
		<input type="hidden" name="id_qtypes" value="<%=qs_list[i].getId_qtype()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><% if(qs_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=qs_list[i].getChapter()%><% } %></td>
		<td align="center"><%=qs_list[i].getId_qtypes()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
		<td align="center"><input type="button" value="��������" onClick="q_extract('<%=i%>', '<%=qs_list[i].getCnts()%>', '<%=qs_list.length%>', '<%=ref_cnt_res%>')"></td>
		<td align="center"><input type="text" class="input" name="ch_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ch_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
	}
%>
</table>
<p>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�ܿ���</td>
		<td align="center" width="12%">������ ������</td>
		<td align="center" width="12%">���� �׷��</td>
		<td align="center" width="12%">��������</td>
		<td align="center" width="12%">������ �׷��</td>
		<td align="center" width="12%">���׺� ����</td>
	</tr>
<%
	if(ref_list != null) {
%>
	<input type="hidden" name="ref_YN" value="Y">
<%
		int ii = 1;
		for(int i=0; i<ref_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs2" value="<%=i+1%>">
		<input type="hidden" name="ref_subject" value="<%=ref_list[i].getId_subject()%>">
		<input type="hidden" name="ref_chapter" value="<%=ref_list[i].getId_chapter()%>">
		<input type="hidden" name="qs<%=i%>" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_order" value="<%=(qs_list.length + ii)%>">
		<td>&nbsp;<% if(ref_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=ref_list[i].getChapter()%><% } %></td>
		<td align="center"><%=ref_list[i].getRef_cnts()%></td>
		<td align="center"><%=ref_list[i].getRef_cnts2()%></td>
		<td align="center"><input type="button" value="��������" onClick="ref_extract('<%=i%>', '<%=ref_list[i].getRef_cnts()%>', '<%=ref_list[i].getRef_cnts2()%>', '<%=ref_list.length%>', '<%=qs_list.length%>')"></td>
		<td align="center"><input type="text" class="input" name="ref_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ref_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
			ii++;
		}
	} else {
%>
	<input type="hidden" name="ref_YN" value="N">
<%
	}
%>
</table>

<%
	} else if(bigos.equals("6")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�����</td>
		<td align="center" width="15%">�ܿ���</td>
		<td align="center" width="10%">���̵�</td>
		<td align="center" width="10%">������</td>
		<td align="center" width="10%">���ļ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="10%">���⹮�׼�</td>
		<td align="center" width="10%">���׹���</td>
	</tr>
<%
	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">
		<input type="hidden" name="id_chapters" value="<%=qs_list[i].getId_chapter()%>">
		<input type="hidden" name="id_qtypes" value="<%=qs_list[i].getId_qtype()%>">
		<input type="hidden" name="id_difficultys" value="<%=qs_list[i].getId_difficulty()%>">
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><% if(qs_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=qs_list[i].getChapter()%><% } %></td>
		<td align="center"><%=qs_list[i].getDifficulty()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
		<td align="center"><input type="button" value="��������" onClick="q_extract('<%=i%>', '<%=qs_list[i].getCnts()%>', '<%=qs_list.length%>', '<%=ref_cnt_res%>')"></td>
		<td align="center"><input type="text" class="input" name="ch_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ch_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
	}
%>
</table>
<P>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�ܿ���</td>
		<td align="center" width="12%">������ ������</td>
		<td align="center" width="12%">���� �׷��</td>
		<td align="center" width="12%">��������</td>
		<td align="center" width="12%">������ �׷��</td>
		<td align="center" width="12%">���׺� ����</td>
	</tr>
<%
	if(ref_list != null) {
%>
	<input type="hidden" name="ref_YN" value="Y">
<%
		int ii = 1;
		for(int i=0; i<ref_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs2" value="<%=i+1%>">
		<input type="hidden" name="ref_subject" value="<%=ref_list[i].getId_subject()%>">
		<input type="hidden" name="ref_chapter" value="<%=ref_list[i].getId_chapter()%>">
		<input type="hidden" name="qs<%=i%>" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_order" value="<%=(qs_list.length + ii)%>">
		<td>&nbsp;<% if(ref_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=ref_list[i].getChapter()%><% } %></td>
		<td align="center"><%=ref_list[i].getRef_cnts()%></td>
		<td align="center"><%=ref_list[i].getRef_cnts2()%></td>
		<td align="center"><input type="button" value="��������" onClick="ref_extract('<%=i%>', '<%=ref_list[i].getRef_cnts()%>', '<%=ref_list[i].getRef_cnts2()%>', '<%=ref_list.length%>', '<%=qs_list.length%>')"></td>
		<td align="center"><input type="text" class="input" name="ref_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ref_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
			ii++;
		}
	} else {
%>
	<input type="hidden" name="ref_YN" value="N">
<%
	}
%>
</table>

<%
	} else if(bigos.equals("7")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center">�����</td>
		<td align="center" width="15%">�ܿ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="8%">���̵�</td>
		<td align="center" width="8%">������</td>
		<td align="center" width="10%">���ļ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="10%">���⹮�׼�</td>
		<td align="center" width="10%">���׹���</td>
	</tr>
<%
	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
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
		<td align="center"><input type="button" value="��������" onClick="q_extract('<%=i%>', '<%=qs_list[i].getCnts()%>', '<%=qs_list.length%>', '<%=ref_cnt_res%>')"></td>
		<td align="center"><input type="text" class="input" name="ch_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ch_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
	}
%>
</table>
<p>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�ܿ���</td>
		<td align="center" width="12%">������ ������</td>
		<td align="center" width="12%">���� �׷��</td>
		<td align="center" width="12%">��������</td>
		<td align="center" width="12%">������ �׷��</td>
		<td align="center" width="12%">���׺� ����</td>
	</tr>
<%
	if(ref_list != null) {
%>
	<input type="hidden" name="ref_YN" value="Y">
<%
		int ii = 1;
		for(int i=0; i<ref_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs2" value="<%=i+1%>">
		<input type="hidden" name="ref_subject" value="<%=ref_list[i].getId_subject()%>">
		<input type="hidden" name="ref_chapter" value="<%=ref_list[i].getId_chapter()%>">
		<input type="hidden" name="qs<%=i%>" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_cnts" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_order" value="<%=(qs_list.length + ii)%>">
		<td>&nbsp;<% if(ref_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=ref_list[i].getChapter()%><% } %></td>
		<td align="center"><%=ref_list[i].getRef_cnts()%></td>
		<td align="center"><%=ref_list[i].getRef_cnts2()%></td>
		<td align="center"><input type="button" value="��������" onClick="ref_extract('<%=i%>', '<%=ref_list[i].getRef_cnts()%>', '<%=ref_list[i].getRef_cnts2()%>', '<%=ref_list.length%>', '<%=qs_list.length%>')"></td>
		<td align="center"><input type="text" class="input" name="ref_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ref_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
			ii++;
		}
	} else {
%>
	<input type="hidden" name="ref_YN" value="N">
<%
	}
%>
</table>

<%
	} else if(bigos.equals("5")) {
%>

<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center">�����</td>		
		<td align="center" width="8%">������</td>
		<td align="center" width="10%">���ļ���</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="10%">���⹮�׼�</td>
		<td align="center" width="10%">���׹���</td>
	</tr>
<%
	for(int i=0; i<qs_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs" value="<%=i+1%>">
		<input type="hidden" name="id_subjects" value="<%=qs_list[i].getId_subject()%>">		
		<td>&nbsp;<%=qs_list[i].getQ_subject()%></td>
		<td align="center"><%=qs_list[i].getCnts()%></td>
		<td align="center"><input type="text" class="input" name="align_orders" size="3" value="<%=(i+1)%>"></td>
		<td align="center"><input type="button" value="��������" onClick="q_extract('<%=i%>', '<%=qs_list[i].getCnts()%>', '<%=qs_list.length%>', '<%=ref_cnt_res%>')"></td>
		<td align="center"><input type="text" class="input" name="ch_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ch_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
	}
%>
</table>
<p>
<table cellpadding='0' cellspacing='1' border=0 bgcolor="#CCCCCC" width="580">
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" >�ܿ���</td>
		<td align="center" width="12%">������ ������</td>
		<td align="center" width="12%">���� �׷��</td>
		<td align="center" width="12%">��������</td>
		<td align="center" width="12%">������ �׷��</td>
		<td align="center" width="12%">���׺� ����</td>
	</tr>
<%
	if(ref_list != null) {
%>
	<input type="hidden" name="ref_YN" value="Y">
<%
		int ii = 1;
		for(int i=0; i<ref_list.length; i++) {
%>
	<tr bgcolor="#FFFFFF" height="25">
		<input type="hidden" name="idxs2" value="<%=i+1%>">
		<input type="hidden" name="ref_subject" value="<%=ref_list[i].getId_subject()%>">
		<input type="hidden" name="ref_chapter" value="<%=ref_list[i].getId_chapter()%>">
		<input type="hidden" name="qs<%=i%>" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_cnts" value="<%=ref_list[i].getRef_cnts()%>">
		<input type="hidden" name="ref_order" value="<%=(qs_list.length + ii)%>">
		<td>&nbsp;<% if(ref_list[i].getChapter() == null) { %>�ܿ�����<% } else { %><%=ref_list[i].getChapter()%><% } %></td>
		<td align="center"><%=ref_list[i].getRef_cnts()%></td>
		<td align="center"><%=ref_list[i].getRef_cnts2()%></td>
		<td align="center"><input type="button" value="��������" onClick="ref_extract('<%=i%>', '<%=ref_list[i].getRef_cnts()%>', '<%=ref_list[i].getRef_cnts2()%>', '<%=ref_list.length%>', '<%=qs_list.length%>')"></td>
		<td align="center"><input type="text" class="input" name="ref_qs<%=i%>" size="3" value="0" readonly></td>
		<td align="center"><input type="text" class="input" name="ref_score<%=i%>" size="3" value="0" readonly></td>
	</tr>
<%
			ii++;
		}
	} else {
%>
	<input type="hidden" name="ref_YN" value="N">
<%
	}
%>
</table>

<%
	}
%>
<%
//******************************************************************************
//   ���α׷� : exam_kind_list.jsp
//   �� �� �� : �׷챸�� ����Ʈ
//   ��    �� : �׷챸�� ����Ʈ ������
//   �� �� �� : r_exam_kind
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil 
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.ExamKindBean, qmtm.admin.etc.ExamKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // �׷챸�и�� ���������
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">
	function insert() {
		window.open("exam_kind_insert.jsp","insert","top=0, left=0, width=400, height=300, scrollbars=no");
    }

	function view(id_exam_kind) {
		
		window.open("exam_kind_view.jsp?id_exam_kind="+id_exam_kind,"view","top=0, left=0, width=400, height=300, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">�׷챸�� ����Ʈ</div>
			<div class="location">ADMIN > ��Ÿ�������� > <span>�׷챸���ڵ����</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<TD colspan="4"><a href="javascript:insert();"><img src="../../images/g_purpose.gif"></a></TD>
		</TR>
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">�ڵ�</td>
			<td bgcolor="#DBDBDB">�׷챸��</td>
			<td bgcolor="#DBDBDB">����</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="4">��ϵǾ��� �׷챸���� �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getId_exam_kind()%></td>
			<td><a href="javascript:view('<%=rst[i].getId_exam_kind()%>');"><%=rst[i].getExam_kind()%></a></td>
			<td><%=ComLib.nullChk(rst[i].getRmk())%>&nbsp;</td>
		</tr>
		<%
			   }
			}
		%>
	</table>
	</div>

	<jsp:include page="../../copyright.jsp"/>
		
		
 </BODY>
</HTML>
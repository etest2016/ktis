<%
//******************************************************************************
//   ���α׷� : exam_kind_sub_list.jsp
//   �� �� �� : ���豸�� ����Ʈ
//   ��    �� : ���豸�� ����Ʈ ������
//   �� �� �� : r_exam_kind_sub
//   �ڹ����� : qmtm.admin.etc.ExamKindSubBean,
//              qmtm.admin.etc.ExamKindSubUtil 
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // ���豸�и�� ���������
	ExamKindSubBean[] rst = null;

	try {
		rst = ExamKindSubUtil.getBeans();
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <script language="JavaScript">
	function insert() {
		window.open("exam_kind_sub_insert.jsp","insert","top=0, left=0, width=400, height=300, scrollbars=no");
    }

	function view(id_exam_kind_sub) {
		
		window.open("exam_kind_sub_view.jsp?id_exam_kind_sub="+id_exam_kind_sub,"view","top=0, left=0, width=400, height=300, scrollbars=no");
    }
 </script>

 </HEAD>

 
 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">���豸�� ����Ʈ</div>
			<div class="location">ADMIN > ��Ÿ�������� > <span>���豸�� �ڵ����</span></div>
		</div>
			<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<TD colspan="4"><a href="javascript:insert();"><img src="../../../images/e_purpose.gif"></a></TD>
		</TR>
	<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>			
			<td bgcolor="#DBDBDB">�����ڵ�</td>
			<td bgcolor="#DBDBDB">�׷챸��</td>
			<td bgcolor="#DBDBDB">�����</td>			
		</tr>
		<% if(rst == null) { %>
		<tr height="30" bgcolor="#FFFFFF">
			<td class="blank" colspan="4">��ϵǾ��� ���豸���� �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td align="center"><%=i+1%></td>			
			<td align="center"><%=rst[i].getId_exam_kind_sub()%></td>
			<td align="center"><%=rst[i].getExam_kind()%></td>
			<td align="center"><a href="javascript:view('<%=rst[i].getId_exam_kind_sub()%>');"><%=rst[i].getExam_kind_sub()%></a></td>			
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
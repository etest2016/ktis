<%
//******************************************************************************
//   ���α׷� : std_grade_list.jsp
//   �� �� �� : �г��ڵ� ����Ʈ
//   ��    �� : �г��ڵ� ����Ʈ ������
//   �� �� �� : r_std_grade
//   �ڹ����� : qmtm.admin.etc.StdGradeBean,
//              qmtm.admin.etc.StdGradeUtil 
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


    // �г��ڵ��� ���������
	StdGradeBean[] rst = null;

	try {
		rst = StdGradeUtil.getBeans();
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
		window.open("std_grade_insert.jsp","insert","top=0, left=0, width=400, height=250, scrollbars=no");
    }

	function view(std_grade) {
		
		window.open("std_grade_view.jsp?std_grade="+std_grade,"view","top=0, left=0, width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">�г��ڵ� ����Ʈ</div>
			<div class="location">ADMIN > ��Ÿ�������� > <span>�г��ڵ����</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<TD colspan="4"><a href="javascript:insert();"><img src="../../../images/s_purpose.gif"></a></TD>
		</TR>
		<tr id="tr">
			<td width="7%" align="center">NO</td>
			<td>�г��ڵ�</td>
			<td align="left">�г��</td>
			<td>�������</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="4">��ϵǾ��� �г��ڵ尡 �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getStd_grade()%></td>
			<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getStd_grade()%>');"><%=rst[i].getGrade_nm()%></a></div><div style="float: left; margin-top: 1px; margin-left: 3px;"><img src="../../images/info2.gif"></div></td>
			<td><%=rst[i].getRegdate()%></td>
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
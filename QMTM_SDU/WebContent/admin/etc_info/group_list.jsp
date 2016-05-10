<%
//******************************************************************************
//   ���α׷� : group_list.jsp
//   �� �� �� : �뿵������ ����Ʈ
//   ��    �� : �뿵������ ����Ʈ ������
//   �� �� �� : c_cateogry
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    // �뿵����� ���������
	CategoryBean[] rst = null;

	try {
		rst = CategoryUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup('group_insert.jsp','insert','width=400, height=300, scrollbars=no top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }

	function view(id_category) {
		
		$.posterPopup('group_view.jsp?id_category='+id_category,'view','width=400, height=300, scrollbars=no top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">�뿵���ڵ����</div>
			<div class="location">ADMIN > �ڵ��������� > <span>�뿵���ڵ����</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<!-- <tr id="bt">
			<TD colspan="5"><input type="button" value="�뿵���ڵ���" class="form5" onClick="insert();">&nbsp;&nbsp;<b>�뿵������ Ŭ���ϸ� ������ ����/������ �� �ֽ��ϴ�</b></TD>
		</TR>-->
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">�뿵���ڵ�</td>
			<td bgcolor="#DBDBDB">�뿵����</td>
			<td bgcolor="#DBDBDB">��������</td>
			<td bgcolor="#DBDBDB">�������</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="5">��ϵǾ��� �뿵���ڵ尡 �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getId_category()%></td>
			<td><%=rst[i].getCategory()%></td>
			<td><%if(rst[i].getYn_valid().equals("Y")) {%>����<%} else {%>�����<%}%></td>
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
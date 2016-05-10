<%
//******************************************************************************
//   ���α׷� : f_main.jsp
//   �� �� �� : �뿵�� ����Ʈ
//   ��    �� : �뿵�� ����Ʈ ������
//   �� �� �� : id_category
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.GroupKindUtil, qmtm.admin.etc.GroupKindBean 
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // �׷챸�и�� ���������
	GroupKindBean[] rst = null;

	try {
		rst = GroupKindUtil.getBeans();
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
	
	function view(id_category) {
		
		$.posterPopup("group_view.jsp?id_category="+id_category,"view","top=0, left=0, width=400, height=300, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">ī�װ� ��ȸ ����Ʈ</div>
			<div class="location">ADMIN > ī�װ� ��ȸ > <span>�뿵����ȸ</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">		
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
			<td><a href="midcategory/midcategory_list.jsp?id_category=<%=rst[i].getId_category()%>"><%=rst[i].getCategory()%></a></td>
			<td><%=rst[i].getYn_valid()%></td>
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
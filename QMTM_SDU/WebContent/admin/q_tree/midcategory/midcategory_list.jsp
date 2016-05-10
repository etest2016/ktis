<%
//******************************************************************************
//   ���α׷� : midcategory_list.jsp
//   �� �� �� : �ҿ��� ����Ʈ
//   ��    �� : �ҿ��� ����Ʈ ������
//   �� �� �� : id_category, id_midcategory
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.MidGroupKindBean, qmtm.admin.etc.MidGroupKindUtil 
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.MidGroupKindBean, qmtm.admin.etc.MidGroupKindUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if(id_category.length() == 0 ) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}    
	
	// �׷챸�и�� ���������
	MidGroupKindBean[] rst = null;

	try {
		rst = MidGroupKindUtil.getBeans(id_category);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../../js/jquery.js"></script>
  <script type="text/javascript" src="../../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup("group_insert.jsp","insert","top=0, left=0, width=400, height=300, scrollbars=no");
    }

	function view(id_category) {
		
		$.posterPopup("group_view.jsp?id_category="+id_category,"view","top=0, left=0, width=400, height=300, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">ī�װ� ��ȸ ����Ʈ</div>
			<div class="location">ADMIN > ī�װ� ��ȸ > <span>�ҿ�����ȸ</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">		
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">�뿵����</td>
			<td bgcolor="#DBDBDB">�ҿ����ڵ�</td>
			<td bgcolor="#DBDBDB">�ҿ�����</td>
			<!--<td bgcolor="#DBDBDB">���ļ���</td>-->
			<td bgcolor="#DBDBDB">��������</td>
			<td bgcolor="#DBDBDB">�������</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="6">��ϵǾ��� �ҿ����ڵ尡 �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getCategory()%></td>
			<td><%=rst[i].getId_midcategory()%></td>
            <td><a href="course_list.jsp?id_midcategory=<%=rst[i].getId_midcategory()%>"><%=rst[i].getMidcategory()%></a></td> 
			<!--<td><%=rst[i].getOrders()%></td>-->
			<td><%=rst[i].getYn_valid()%></td>
			<td><%=rst[i].getRegdate()%></td>
		</tr>
		<%
			   }
			}
		%>
	</table>
	</div>
		
 </BODY>
</HTML>
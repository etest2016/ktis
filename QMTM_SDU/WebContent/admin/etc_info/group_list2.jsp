<%
//******************************************************************************
//   ���α׷� : group_list2.jsp
//   �� �� �� : �ҿ������� ����Ʈ
//   ��    �� : �ҿ������� ����Ʈ ������
//   �� �� �� : c_midcateogry
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    // �׷챸�и�� ���������
	MidCategoryBean[] rst = null;

	try {
		rst = MidCategoryUtil.getBeans();
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
		$.posterPopup('group_insert2.jsp','insert','width=400, height=300, scrollbars=no, top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }

	function view(id_midcategory) {
		
		$.posterPopup('group_view2.jsp?id_midcategory='+id_midcategory,'view','width=400, height=300, scrollbars=no, top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">�ҿ����ڵ����</div>
			<div class="location">ADMIN > �ڵ��������� > <span>�ҿ����ڵ����</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<!--<tr id="bt">
			<TD colspan="6"><input type="button" value="�ҿ����ڵ���" class="form5" onClick="insert();">&nbsp;&nbsp;<b>�ҿ������� Ŭ���ϸ� ������ ����/������ �� �ֽ��ϴ�</b></TD>
		</TR>-->
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">�뿵����</td>
			<td bgcolor="#DBDBDB">�ҿ����ڵ�</td>
			<td bgcolor="#DBDBDB">�ҿ�����</td>
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
			<td><%=rst[i].getMidcategory()%></td>
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
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
<%@ page import="qmtm.ComLib, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

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

  <script language="JavaScript">
	function insert() {
		window.open("group_insert.jsp","insert","top=0, left=0, width=400, height=300, scrollbars=no");
    }

	function view(id_category) {
		
		window.open("group_view.jsp?id_category="+id_category,"view","top=0, left=0, width=400, height=300, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">�о߱׷� ����Ʈ</div>
			<div class="location">ADMIN > ��Ÿ�������� > <span>�о߱׷� ����</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<tr id="bt">
			<TD colspan="4"><a href="javascript:insert();"><img src="../../images/g_purpose.gif"></a></TD>
		</TR>
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">�ڵ�</td>
			<td bgcolor="#DBDBDB">�о߸�</td>
			<td bgcolor="#DBDBDB">�������</td>
		</tr>
		<% if(rst == null) { %>
		<tr>
			<td class="blank" colspan="4">��ϵǾ��� �о߰� �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getId_category()%></td>
			<td><a href="javascript:view('<%=rst[i].getId_category()%>');"><%=rst[i].getCategory()%></a></td>
			<td><%=rst[i].getRegdate()%>&nbsp;</td>
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
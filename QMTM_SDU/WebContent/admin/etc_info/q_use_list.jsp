<%
//******************************************************************************
//   ���α׷� : q_use_list.jsp
//   �� �� �� : �����뵵 ����Ʈ
//   ��    �� : �����뵵 ����Ʈ ������
//   �� �� �� : r_q_use
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    // �����뵵��� ���������
	QuseBean[] rst = null;

	try {
		rst = QuseUtil.getBeans();
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
		$.posterPopup('q_use_insert.jsp','insert','width=400, height=280, scrollbars=no, top='+(screen.height-280)/2+', left='+(screen.width-400)/2);
    }

	function view(id_q_use) {
		
		$.posterPopup('q_use_view.jsp?id_q_use='+id_q_use,'view','width=400, height=280, scrollbars=no, top='+(screen.height-280)/2+', left='+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	
    <form name="form1" method="post" action="m_list.jsp">
	<div id="main">		
		<div id="mainTop">
			<div class="title">�����뵵 ����Ʈ</div>
			<div class="location">ADMIN > �ڵ��������� > <span>�����뵵�ڵ����</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt">
				<td colspan="4"><input type="button" value="�����뵵�ڵ���" class="form5" onClick="insert();">&nbsp;&nbsp;<b>�����뵵���� Ŭ���ϸ� ������ ����/������ �� �ֽ��ϴ�</b></TD>
			</tr>
			<tr id="tr">
					<td width="7%">NO</td>
					<td>�����뵵�ڵ�</td>
					<td style="text-align: left;">�����뵵</td>
					<td style="text-align: left;">����</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="4">��ϵǾ��� �����뵵�� �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><%=rst[i].getId_q_use()%></td>
				<td><div style="float: left;"><a href="javascript:view('<%=rst[i].getId_q_use()%>');"><%=rst[i].getQ_use()%></a></div><div style="float: left; padding-top: 1px; padding-left: 5px;"><img src="../../images/info2.gif"></div></td>
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
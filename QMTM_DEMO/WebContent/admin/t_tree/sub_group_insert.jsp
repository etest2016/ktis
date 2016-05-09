<%
//******************************************************************************
//   ���α׷� : subject_group_insert.jsp
//   �� �� �� : ����׷� ���
//   ��    �� : ����׷� ��� �˾� ������
//   �� �� �� : c_subjec, q_subject
//   �ڹ����� : qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean
//   �� �� �� : 2008-04-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.admin.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("UTF8");

	String id_course = request.getParameter("id_course");

    // ����� ������ ��� ���������
	TmanTreeBean[] rst = null;

	try {
		rst = TmanTree.getAddBeans(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}	
%>

<HTML>
 <HEAD>
  <TITLE> :: ������ :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="JavaScript">
	function checks() {
		var frm = document.form1;
		var cnt = 0;

		if (frm.subjects.length == undefined) { //�Ѱ��϶� üũ
			if(frm.subjects.checked==true ) {
			   cnt = cnt + 1;
			} 
		}else{

			for(i=0;i<frm.subjects.length;i++) {
				if(frm.subjects[i].checked) {
					cnt = cnt + 1;
				}
			}
		}
			
		if(cnt == 0) {
			alert("������ �����ϼ���.!!!");
			return false;
		}

		frm.submit();
    }	
 </script>

 </HEAD>

 <BODY id="popup2">

	<form name="form1" method="post" action="sub_group_insert_ok.jsp">
	<input type="hidden" name="id_course" value="<%=id_course%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ��� <span>������ ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA">
			 <tr id="tr">
				<td width="7%">����</td>
				<td>�����ڵ�</td>
				<td>�����</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="3">�߰��Ͻ� ������ �����ϴ�.</td>
			</tr>
			
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>		
			<tr id="td">
				<input type="hidden" name="names<%=rst[i].getId_subject()%>" value="<%=rst[i].getSubject()%>">
				<td align="center"><input type="checkbox" name="subjects" value="<%=rst[i].getId_subject()%>"></td>			
				<td align="center"><%=rst[i].getId_subject()%></td>
				<td align="center"><%=rst[i].getSubject()%></td>			
			</tr>
			<%
				   }
				}
			%>
		</table>
	
	</div>

	<div id="button">
		<% if(rst != null) { %><img onClick="checks();" src="../../images/bt_sja_1.gif" style="cursor:hand"><% } %>&nbsp;&nbsp;<img src="../../images/bt_close_1.gif" align="top" style="cursor:hand" onClick="window.close();">
	</div>

	</form>	

 </BODY>
</HTML>
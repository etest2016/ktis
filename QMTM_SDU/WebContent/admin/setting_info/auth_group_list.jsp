<%
//******************************************************************************
//   ���α׷� : auth_group_list_excel.jsp
//   �� �� �� : ���ѱ׷켳�� ������
//   ��    �� : ���ѱ׷켳�� ���� ������
//   �� �� �� : 
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   �� �� �� : 2016-04-25
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }
	
	String rsts = "";
	
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	<script type="text/javascript" src="../../js/jquery.js"></script>
    <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
 
	<script type="text/javaScript">
		
		function auth_group_write() {
			$.posterPopup("auth_group_write.jsp","gWrite","width=650, height=450, scrollbars=no");
		}

		function group_subject_write() {
			
		}

		function group_member_write() {
	
		}
	
	</script>

</head>

<BODY id="tman">
	
	<form name="form1" method="post" action="auth_group_list.jsp">
	
	<div id="main">

		<div id="mainTop">
			<div class="title">���ѱ׷� ���� <span>��ϵ� �׷쿡 ���ؼ� ������ ������ �� �ֽ��ϴ�.</span></div>
			<div class="location">�������� ><span> ���ѱ׷켳��</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="12">
					<select name="field">
					<option value="id_group" <% if(field.equals("id_group")) { %> selected <% } %>>�׷��ڵ�</option>
					<option value="groupname" <% if(field.equals("groupname")) { %> selected <% } %>>�׷��</option>
					</select>&nbsp;&nbsp;
					<input type="text" class="input" name="str" size="25" value="<%=str%>" onClick="document.form1.str.value == ''">&nbsp;&nbsp;<a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
				<td colspan="2" align="right"><input type="button" value="���ѱ׷���" class="form" onClick="auth_group_write();"></td>
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">�׷��ڵ�</td>
				<td bgcolor="#D8D8D8">�׷��</td>
				<td bgcolor="#D8D8D8">������������</td>
				<td bgcolor="#D8D8D8">�����������</td>
				<td bgcolor="#D8D8D8">��������</td>
				<td bgcolor="#D8D8D8">��������</td>
				<td bgcolor="#D8D8D8">��������</td>
				<td bgcolor="#D8D8D8">�������</td>
				<td bgcolor="#D8D8D8">���������</td>
				<td bgcolor="#D8D8D8">ä������</td>
				<td bgcolor="#D8D8D8">�������</td>
				<td bgcolor="#D8D8D8">�����ñ���</td>
				<td bgcolor="#D8D8D8">��������</td>
				<td bgcolor="#D8D8D8">�׷�����</td>
			</tr>
<% if(rsts == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="14">��ϵ� ���ѱ׷��� �����ϴ�.</td>
			</tr>
<% 
	} else { 		
		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td>123</td>
				<td>�׽�Ʈ�׷�</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td>Y</td>
				<td><input type="button" value="������" class="form6" onClick="group_subject_write();"></td>
				<td><input type="button" value="���������" class="form6" onClick="group_member_write();"></td>
			</tr>
<%	
	}
%>
		</table>
		
	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
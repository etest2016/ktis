<%
//******************************************************************************
//   ���α׷� : exam_ing_list.jsp
//   �� �� �� : �������� ���� ������
//   ��    �� : �������� ���� ������
//   �� �� �� : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   �� �� �� : 2008-06-23
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
	
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
	
</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_ing_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">���ø���͸� <span>���ø���͸���Ȳ�� Ȯ���� �� �ֽ��ϴ�.</span></div>
			<div class="location">�����򰡰��� ><span> ���ø���͸�</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="7">
					<select name="">
						<option value="">2016��1�б�</option>
					</select>&nbsp;
					<select name="">
						<option value="">������ü</option>
						<option value="">aaaaaaaaaaaaaaaaaaaaaaa</option>
					</select>&nbsp;					
					<select name="">
						<option value="">��ü</option>
					</select>&nbsp;					
					<input type="text" class="input" size="20">&nbsp;&nbsp;<input type="button" value="�˻��ϱ�" class="form4">
				</td>	
				<td colspan="6" align="right"><input type="button" value="���ð����ϰ�ä��" class="form">&nbsp;&nbsp;<input type="button" value="���ð������ä��" class="form"></td>			
			</tr>
			<tr id="bt3">
				<td colspan="13" align="right">
					<strong>���õ� ������ ó��</strong> <input type="button" value="�̺�Ʈ�α�" class="form6">&nbsp;&nbsp;<input type="button" value="��ȷα�" class="form6">&nbsp;&nbsp;<input type="button" value="���νð�����ó��" class="form6">&nbsp;&nbsp;<input type="button" value="������ó��" class="form6">&nbsp;&nbsp;<input type="button" value="������ۼ�" class="form6">&nbsp;&nbsp;<input type="button" value="��������ó��" class="form6">
				</td>				
			</tr>
			
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">				
				<td bgcolor="#D8D8D8">�����</td>
				<td bgcolor="#D8D8D8">�򰡸�</td>
				<td bgcolor="#D8D8D8">�й�</td>
				<td bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">��������ȣ</td>
				<td bgcolor="#D8D8D8">����ð�</td>
				<td bgcolor="#D8D8D8">�������ð�</td>
				<td bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">���ýð�</td>
				<td bgcolor="#D8D8D8">�ʰ��ð�</td>
				<td bgcolor="#D8D8D8">��ֿ���</td>
				<td bgcolor="#D8D8D8">����IP</td>
				<td bgcolor="#D8D8D8">�ڵ�����</td>				
			</tr>

			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">				
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		</table>
		
	</div>

	
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
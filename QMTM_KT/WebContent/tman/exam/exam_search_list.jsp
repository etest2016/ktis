<%
//******************************************************************************
//   ���α׷� : exam_search_list.jsp
//   �� �� �� : ����˻� ���� ������
//   ��    �� : ����˻� ���� ������
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList
//   �� �� �� : 2010-06-01
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }

	// �˻��� �������� ���������
	ExamListBean[] rst = null;

	if(field.length() > 0 && str.length() > 0) {

		try {
			if(userid.equals("qmtm")) {
				rst = ExamList.getAdmSearchBeans(field, str, userid);
			} else {
				rst = ExamList.getSearchBeans(field, str, userid);
			}
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));

		    if(true) return;
	    }
	}
%>

<html>
<head>
	<title></title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
	<script language="JavaScript">
		function send() {
			var frm = document.form1;
			
			if(frm.str.value == "") {
				alert("�˻������� �Է��ϼ���");
				frm.str.focus();
				return;
			} else {
				frm.submit();
			}
		}

		function edits(id_exam) {
			window.open("exam_edit.jsp?id_exam="+id_exam,"edit","width=850, height=650, scrollbars=yes, top=0, left=0");
	    }
	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_search_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">���� �˻� <span>�˻��� �׸��� ���� �� �˻������� �Է��ϼ���.</span></div>
			<div class="location">������� > <span> ���� �˻�</span></div>	
		</div>

		<TABLE cellpadding="0" cellspacing="0" border="0" width="100%" id="tablea">
			<tr id="bt3">
				<td colspan="9">
					<select name="field">
					<option value="a.title" <% if(field.equals("a.title")) { %> selected <% } %>>�����</option>
					<option value="c.name" <% if(field.equals("c.name")) { %> selected <% } %>>������ ����</option>
					<option value="a.userid" <% if(field.equals("a.userid")) { %> selected <% } %>>������ ���̵�</option>
					</select>&nbsp;&nbsp;
					
					<input type="text" class="input" name="str" size="15" value="<%=str%>" onClick="document.form1.str.value == ''">&nbsp;&nbsp;<!--<input type="button" value="Ȯ���ϱ�" onClick="send();">--><a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
			</tr>
		
			<tr id="tr">
				<td>������</td>
				<td>��������</td>
				<td>���谡�ɿ���</td>
				<td>����Ⱓ</td>
				<td>������ȸ�Ⱓ</td>
				<td>������</td>
			</tr>
	<%
		if(rst == null) {
	%>
			<tr>
				<td class="blank" colspan="6">�˻��� �������� �����ϴ�.</td>
			</tr>
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {

	%>
			<tr id="td" align="center">
			    <td align="left">&nbsp;<%=rst[i].getCourse()%></td>
				<td align="left">&nbsp;<a href="exam_list.jsp?id_exam=<%=rst[i].getId_exam()%>"><%=rst[i].getTitle()%></a></td>
				<td><%=rst[i].getYn_enable()%></td>
				<td><%=rst[i].getExam_start1()%>~<br><%=rst[i].getExam_end1()%></td>
				<td><%=rst[i].getStat_start()%>~<br><%=rst[i].getStat_end()%></td>
				<td><%=rst[i].getName()%></td>
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
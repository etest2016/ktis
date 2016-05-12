<%
//******************************************************************************
//   ���α׷� : exam_log_list.jsp
//   �� �� �� : �������� ���� ������
//   ��    �� : �������� ���� ������
//   �� �� �� : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib, qmtm.common.WorkExamLog, qmtm.common.WorkExamLogBean, java.util.Date, java.util.Calendar
//   �� �� �� : 2013-01-29
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.common.WorkExamLog, qmtm.common.WorkExamLogBean, java.util.Date, java.util.Calendar" %>
<%@ include file = "../../common/paging.jsp" %> 
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
	
	String exam_start = request.getParameter("exam_start");
	if (exam_start == null) { exam_start = ""; } else { exam_start = exam_start.trim(); }
	
	String gubun = request.getParameter("gubun");
	if (gubun == null) { gubun = ""; } else { gubun = gubun.trim(); }

	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }

	if(gubun.length() == 0) {
		gubun = "";
	}

	if(field.length() == 0) {
		field = "";
	}

	String tmp_page = request.getParameter("page");
	if (tmp_page == null) { tmp_page= ""; } else { tmp_page = tmp_page.trim(); }

	String url = "exam_log_list.jsp";	

	String add_tag = "&gubun="+gubun+"&exam_start="+exam_start+"&field="+field+"&str="+str;
    	
	int total_page = 0; // �� ������
    int total_count = 0; // �� ���ڵ� ��
	int current_page = 0; // ���� ������
	int page_scale = 150; // �� ȭ�鿡 �������� �Խù� ��
	int remain = 0; // ������ ����� ���� �������� ���.
	int start_rnum = 0; // ���� ������ �Խù� ���۹�ȣ
	int end_rnum = 0; // ���� ������ �Խù� ����ȣ

	if(tmp_page.length() == 0) {
		current_page = 1;
	} else {
		current_page = Integer.parseInt(tmp_page);
	}
	
	WorkExamLogBean[] rst = null;

	if(exam_start.length() > 0) {

		try {
			total_count = WorkExamLog.getCounts(gubun, exam_start, field, str);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		remain = total_count % page_scale;
		
		if(remain == 0) {
			total_page = total_count / page_scale;
		} else {
			total_page = total_count / page_scale + 1;
		}

		int lists = (current_page - 1) * page_scale;
		
		try {
			rst = WorkExamLog.getBeans(page_scale, lists, gubun, exam_start, field, str);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));		    

		    if(true) return;
		}
	}
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
	
	<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
		$(function() {
			$.datepicker.setDefaults($.datepicker.regional['ko']);
			$( ".date_picker" ).datepicker();
		});
	</script>
 
	<script language="JavaScript">
		function send() {
			var frm = document.form1;
			
			if(frm.exam_start.value == "") {
				alert("�˻����ڸ� �Է��ϼ���");
				frm.exam_start.focus();
				return;
			} else {
				frm.submit();
			}
		}

	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_log_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">Admin�αװ��� <span>�˻��� ���ڸ� �Է��ϸ� Admin���÷α׸� Ȯ���� �� �ֽ��ϴ�.</span></div>
			<div class="location">ADMIN ><span> ����������Ȳ�׷αװ��� > Admin�αװ���</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="9">
					<b>�αױ��м���</b> : <Select name="gubun">
					<option value="" <%if(gubun.equals("")) { %>selected<% } %>>��ü</option>					
					<option value="���輳��" <%if(gubun.equals("���輳��")) { %>selected<% } %>>�����</option>
					<option value="�������" <%if(gubun.equals("�������")) { %>selected<% } %>>�������</option>
					<option value="�������" <%if(gubun.equals("�������")) { %>selected<% } %>>�������</option>
					<option value="����ڵ��" <%if(gubun.equals("����ڵ��")) { %>selected<% } %>>����ڵ��</option>
					<option value="����ڻ���" <%if(gubun.equals("����ڻ���")) { %>selected<% } %>>����ڻ���</option>
					<option value="�����ϰ�����" <%if(gubun.equals("�����ϰ�����")) { %>selected<% } %>>�����ϰ�����</option>
					<option value="�����������" <%if(gubun.equals("�����������")) { %>selected<% } %>>�����������</option>
					<option value="������ü" <%if(gubun.equals("������ü")) { %>selected<% } %>>������ü</option>
					<option value="����������" <%if(gubun.equals("����������")) { %>selected<% } %>>����������</option>
					<option value="������߰�" <%if(gubun.equals("������߰�")) { %>selected<% } %>>������߰�</option>
					<option value="���������" <%if(gubun.equals("���������")) { %>selected<% } %>>���������</option>
					<option value="���������" <%if(gubun.equals("���������")) { %>selected<% } %>>���������</option>
					<option value="���û��º���" <%if(gubun.equals("���û��º���")) { %>selected<% } %>>���û��º���</option>
					<option value="���������" <%if(gubun.equals("���������")) { %>selected<% } %>>���������</option>
					<option value="DB�������������" <%if(gubun.equals("DB�������������")) { %>selected<% } %>>DB�������������</option>
					<option value="���������ä��" <%if(gubun.equals("���������ä��")) { %>selected<% } %>>���������ä��</option>
					<option value="����������ä��" <%if(gubun.equals("����������ä��")) { %>selected<% } %>>����������ä��</option>
					<option value="��������ó��" <%if(gubun.equals("��������ó��")) { %>selected<% } %>>��������ó��</option>
					<option value="�ܴ���ä��" <%if(gubun.equals("�ܴ���ä��")) { %>selected<% } %>>�ܴ���ä��</option>
					<option value="������ä��" <%if(gubun.equals("������ä��")) { %>selected<% } %>>������ä��</option>
					<option value="�Ǳ���ä��" <%if(gubun.equals("�Ǳ���ä��")) { %>selected<% } %>>�Ǳ���ä��</option>					
					<option value="���νð�����" <%if(gubun.equals("���νð�����")) { %>selected<% } %>>���νð�����</option>
					<option value="���ѽð��ϰ�����" <%if(gubun.equals("���ѽð��ϰ�����")) { %>selected<% } %>>���ѽð��ϰ�����</option>
					<option value="���ѽð�����" <%if(gubun.equals("���ѽð�����")) { %>selected<% } %>>���ѽð�����</option>
					<option value="�������" <%if(gubun.equals("�������")) { %>selected<% } %>>�������</option>					
				</select>&nbsp;&nbsp;
				<b>�˻�����</b> : <input type="text" class="input date_picker" name="exam_start" size="12" readonly>&nbsp;&nbsp;
				<b>�˻�����</b> : <select name="field">
				<option value="" <%if(field.equals("")) { %>selected<% } %>>��ü</option>
				<option value="a.course" <%if(field.equals("a.course")) { %>selected<% } %>>�����</option>
				<option value="b.title" <%if(field.equals("b.title")) { %>selected<% } %>>�����</option>
				<option value="d.name" <%if(field.equals("d.name")) { %>selected<% } %>>����ڸ�</option>
				</select>&nbsp;&nbsp;
				<input type="text" class="input" name="str" size="20">&nbsp;&nbsp;<a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>			
				</td>				
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">NO</td>
				<td bgcolor="#D8D8D8">��޴�</td>
				<td bgcolor="#D8D8D8">�߸޴�</td>
				<td bgcolor="#D8D8D8">�Ҹ޴�</td>				
				<td bgcolor="#D8D8D8">������ID</td>
				<td bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">�󼼳���</td>
				<td bgcolor="#D8D8D8">�����</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="9">�˻������� �Է��ϼ���..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {	
			int list_num = total_count - (current_page - 1) * page_scale - i;
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td><%=list_num%></td>
				<td><%=rst[i].getCourse()%></td>
				<td><%=rst[i].getTitle()%></td>
				<td><%if(rst[i].getUserid() == null) { %>������<% } else { %><%=rst[i].getUserid()%><% } %></td>
				<td><%=rst[i].getName()%></td>
				<td><%=rst[i].getGubun()%></td>
				<td><textarea cols="45" rows="5" readonly><%=rst[i].getBigo()%></textarea></td>
				<td><%=rst[i].getRegdate()%></td>
			</tr>
<%
		}
	}
%>
		</table>
		
		<P>

		<table border="0" width="100%">
			<tr>
				<td align="center"><%= PageNumber(current_page, total_page, url, add_tag) %></td>
			</tr>
		</table>
		
	</form>

	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</html>
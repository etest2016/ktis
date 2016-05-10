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
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamSchedule, qmtm.tman.exam.ExamScheduleBean, java.util.Date, java.util.Calendar " %>
<%@ include file = "../../common/calendar.jsp" %>
<%@ include file = "/common/login_chk.jsp" %>
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

	String exam_end = request.getParameter("exam_end");
	if (exam_end == null) { exam_end = ""; } else { exam_end = exam_end.trim(); }

	int year, month;

	String months = "";

    Calendar cal = Calendar.getInstance();
    year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;

	if(month > 9) {
		months = String.valueOf(month);
	} else {
		months = "0" + String.valueOf(month);
	}

    cal.set(year, month, 1);

    int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	if(exam_start.length() == 0 && exam_end.length() == 0) {
		exam_start = String.valueOf(year) + "-" + months +"-01";
		exam_end = String.valueOf(year) + "-" + months +"-"+String.valueOf(lastDay);
	}

	ExamScheduleBean[] rst = null;

	if(exam_start.length() > 0 && exam_end.length() > 0) {

		try {
			rst = ExamSchedule.getInwonRes2(exam_start, exam_end, userid);
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
 
	<script type="text/javascript">
		function send() {
			var frm = document.form1;
			
			if(frm.exam_start.value == "") {
				alert("�˻����ڸ� �Է��ϼ���");
				frm.exam_start.focus();
				return;
			} else if(frm.exam_end.value == "") {
				alert("�˻����ڸ� �Է��ϼ���");
				frm.exam_end.focus();
				return;
			} else {
				frm.submit();
			}
		}

		function schedule() {
			location.href="exam_schedule.jsp";
		}

		function excel_down() {
			location.href="exam_ing_list_excel.jsp?exam_start=<%=exam_start%>&exam_end=<%=exam_end%>";
		}
	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_ing_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">���� ����ǥ <span>�˻��� �������ڸ� �Է��ϸ� ������Ȳ�� Ȯ���� �� �ֽ��ϴ�.</span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../../images/icon_location.gif"> ������� > ���� ����ǥ</div>
		</div>


		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="3">
					<input type="text" class="input date_picker" name="exam_start" size="12" readonly value="<%=exam_start%>"> ~ <input type="text" class="input date_picker" name="exam_end" size="12" readonly value="<%=exam_end%>">&nbsp;&nbsp;<!--<input type="button" value="Ȯ���ϱ�" onClick="send();">--><a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
				<td colspan="4" align="right"><input type="button" value="�޷����� ����" class="form5" onClick="schedule();">&nbsp;&nbsp;<input type="button" value="�������� �ٿ�ε�" class="form5" onClick="excel_down();"></td>
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">������</td>
				<td bgcolor="#D8D8D8">�����</td>
				<td bgcolor="#D8D8D8">����Ⱓ</td>
				<td bgcolor="#D8D8D8">����ο�</td>
				<td bgcolor="#D8D8D8">�����ο�</td>
				<td bgcolor="#D8D8D8">�������ο�</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="6">�˻����ڸ� �Է��ϼ���..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td align="left">&nbsp;<%=rst[i].getCourse()%></td>
				<td align="left">&nbsp;<%=rst[i].getTitle()%></td>
				<td><%=rst[i].getExam_start()%>����<br><%=rst[i].getExam_end()%>����</td>
				<td><%=rst[i].getTot_inwon()%> ��</td>
				<td><%=rst[i].getAns_inwon()%> ��</td>
				<td><%=rst[i].getTot_inwon() - rst[i].getAns_inwon()%> ��</td>
			</tr>
<%
		}
	}
%>
		</table>
		
	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
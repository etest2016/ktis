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
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamScheduleBean, qmtm.tman.exam.ExamSchedule" %>
<%@ include file = "../../common/calendar.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = "-1"; } else { id_subject = id_subject.trim(); }	

	if (id_course.length() == 0 || id_subject.length() ==0) { 
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	String exam_start = request.getParameter("exam_start");
	if (exam_start == null) { exam_start = ""; } else { exam_start = exam_start.trim(); }

	String exam_end = request.getParameter("exam_end");
	if (exam_end == null) { exam_end = ""; } else { exam_end = exam_end.trim(); }
	
	ExamScheduleBean[] rst = null;

	if(exam_start.length() > 0 && exam_end.length() > 0) {

		if(userid.equals("qmtm")) {
			
			try {
				rst = ExamSchedule.getInwonResDown(id_course, exam_start, exam_end);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));		    

				if(true) return;
			}
		
		} else {

			try {
				rst = ExamSchedule.getInwonResDown2(id_course, userid, exam_start, exam_end);
			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "close"));		    

				if(true) return;
			}

		}
	} 
%>

<html>
<head>
	<title>�򰡰�� �ٿ�ε�</title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
	<script language="JavaScript">
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
		
		function excel_down() {
			location.href="exam_ing_list_excel.jsp?exam_start=<%=exam_start%>&exam_end=<%=exam_end%>";
		}

		function ans_excel() {
			 
			 var frmx = document.form2;
		 
			 var selectId = "";
			 var k = 0;

			 if(frmx.id_exam.length == undefined) {
				 if(frmx.id_exam.checked == true) {
					 selectId = selectId +"'"+ frmx.id_exam.value + "',";
					 k = k + 1;
				 }
			 } else if(frmx.id_exam.length != undefined) {
				 for (i=0; i<=frmx.id_exam.length -1; i++) {
					 if (frmx.id_exam[i].checked == true) {
						selectId = selectId +"'"+ frmx.id_exam[i].value + "',";
						k = k + 1;
					 }
				 }
			 }

			 if(k == 0) {
				 alert("���ð�� �ٿ���� ������ �������ּ���.");
			 } else {
				 frmx.id_exams.value = selectId.substring(0,selectId.length-1);

				 frmx.action="ans_static_excel.jsp";
				 frmx.method="post";
				 frmx.submit();
			 }
		}

		function q_excel() {
			 
			 var frmx = document.form2;
		 
			 var selectId = "";
			 var k = 0;

			 if(frmx.id_exam.length == undefined) {
				 if(frmx.id_exam.checked == true) {
					 selectId = selectId +"'"+ frmx.id_exam.value + "',";
					 k = k + 1;
				 }
			 } else if(frmx.id_exam.length != undefined) {
				 for (i=0; i<=frmx.id_exam.length -1; i++) {
					 if (frmx.id_exam[i].checked == true) {
						selectId = selectId +"'"+ frmx.id_exam[i].value + "',";
						k = k + 1;
					 }
				 }
			 }

			 if(k == 0) {
				 alert("���׺м���� �ٿ���� ������ �������ּ���.");
			 } else {
				 frmx.id_exams.value = selectId.substring(0,selectId.length-1);

				 frmx.action="q_static_excel.jsp";
				 frmx.method="post";
				 frmx.submit();
			 }
		}

	</script>

</head>

<BODY id="popup2">
	
	<form name="form1" method="post" action="exam_data_down.jsp">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�򰡰�� �ٿ�ε�<span>������ ���迡 ���ð��, ���׺� �м������ �ٿ�ε��� �� �ֽ��ϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="9">
					<input type="text" class="input" name="exam_start" size="12" readonly onClick="MiniCal(this)" value="<%=exam_start%>"> ~ <input type="text" class="input" name="exam_end" size="12" readonly onClick="MiniCal(this)" value="<%=exam_end%>">&nbsp;&nbsp;<!--<input type="button" value="Ȯ���ϱ�" onClick="send();">--><a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
				</form>
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">������</td>
				<td bgcolor="#D8D8D8">�����</td>
				<td bgcolor="#D8D8D8">���������</td>
				<td bgcolor="#D8D8D8">����������</td>
				<td bgcolor="#D8D8D8">����ο�</td>
				<td bgcolor="#D8D8D8">�����ο�</td>
				<td bgcolor="#D8D8D8">�������ο�</td>				
			</tr>
			<form name="form2">
			<input type="hidden" name="id_exams">
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="8">�˻����ڸ� �Է��ϼ���..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
			
				<td><input type="checkbox" name="id_exam" value="<%=rst[i].getId_exam()%>"></td>
				<td align="left"><%=rst[i].getCourse()%></td>
				<td align="left"><%=rst[i].getTitle()%></td>
				<td><%=rst[i].getExam_start()%></td>
				<td><%=rst[i].getExam_end()%></td>
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
	<div id="button">
		<input type="button" value="���ð�������ٿ�" class="form" onClick="ans_excel();">&nbsp;&nbsp;<input type="button" value="���׺м������ٿ�" class="form" onClick="q_excel();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

	</form>

 </BODY>
</HTML>
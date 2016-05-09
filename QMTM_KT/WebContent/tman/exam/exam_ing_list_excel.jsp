<%
//******************************************************************************
//   ���α׷� : exam_ing_list_excel.jsp
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
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamSchedule, qmtm.tman.exam.ExamScheduleBean " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=examList.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
	
	String userid = CommonUtil.get_Cookie(request, "userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String exam_start = request.getParameter("exam_start");
	if (exam_start == null) { exam_start = ""; } else { exam_start = exam_start.trim(); }

	String exam_end = request.getParameter("exam_end");
	if (exam_end == null) { exam_end = ""; } else { exam_end = exam_end.trim(); }

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
</head>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr bgcolor="#FFFFFF" align="center" height="30" >
				<td bgcolor="#D8D8D8">������</td>
				<td bgcolor="#D8D8D8">�����</td>
				<td bgcolor="#D8D8D8">���������</td>
				<td bgcolor="#D8D8D8">����������</td>
				<td bgcolor="#D8D8D8">����ο�</td>
				<td bgcolor="#D8D8D8">�����ο�</td>
				<td bgcolor="#D8D8D8">�������ο�</td>		
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td align="center" colspan="7">�˻����ڸ� �Է��ϼ���..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr bgcolor="#FFFFFF" height="27" align="center">
				<td align="left">&nbsp;<%=rst[i].getCourse()%></td>
				<td align="left">&nbsp;<%=rst[i].getTitle()%></td>
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
		
</body>

</html>
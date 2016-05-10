<%
//******************************************************************************
//   ���α׷� : course_and_result_to_excel.jsp
//   �� �� �� : ������ ������ ��� �� ���� �����ٿ�ε�
//   ��    �� : ������� Ʈ������ ���� ���ý� ������ ������ ���� �����ٿ�ε� ��
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2013-03-14
//   �� �� �� : ���׽�Ʈ �̹���
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamSchedule, qmtm.tman.exam.ExamScheduleBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");	
	String usergrade = (String)session.getAttribute("usergrade"); // ����

    String course_name = "";

    // ������ ���������
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	ExamScheduleBean[] rst = null;

	try {
		rst = ExamSchedule.getInwonRes3(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));		    

		if(true) return;
	}

%>

<HTML>
 <HEAD>
  <TITLE> Tman Main </TITLE>
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="../js/jquery.js"></script>
  <script type="text/javascript">
	function go_to_course_list() {
		location.href = "course_list.jsp?id_course=<%=id_course%>";
	}

	function go_to_course_ans_result_to_excel() {
		location.href = "course_ans_result_to_excel.jsp?id_course=<%=id_course%>";
	}

	function excel_down() {
		location.href="course_ans_result_to_excel_download.jsp?id_course=<%=id_course%>";
	}

	var mygrid;

	$(document).ready(function(){

	});
 </script>
 </HEAD>

 <BODY id="admin">	

	<div id="main">
		<div class="tab"><a href="javascript:go_to_course_list();" onfocus="this.blur();"><img src="../images/tabtA01.gif"></a><a href="javascript:go_to_course_ans_result_to_excel();" onfocus="this.blur();"><img src="../images/tabtA02_.gif"></a></div>		
		<div id="mainTop">
			<div class="title">������ ���ð�� <span>: ������ ������ ����� ������ �ٿ� ���� �� �ֽ��ϴ�.</span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../images/icon_location.gif"> ������ : <%=course_name%></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">			
			<tr id="bt">
				<Td colspan="6"><input type="button" value="�����ٿ�ε�" class="form6" onClick="excel_down();"></td>				
			</tr>
			<tr id="tr">
				<td width="20%">������</td>
				<td width="20%">�����</td>
				<td>����Ⱓ</td>
				<td width="10%">����ο�</td>
				<td width="10%">�����ο�</td>
				<td width="10%">�������ο�</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="6">��ȸ�� ���� ����� �����ϴ�.</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td>&nbsp;<%=rst[i].getCourse()%></td>
				<td>&nbsp;<%=rst[i].getTitle()%></td>
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
		
 </BODY>
</HTML>
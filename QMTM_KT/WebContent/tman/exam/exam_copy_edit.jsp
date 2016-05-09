<%
//******************************************************************************
//   ���� �׷� : exam_copy_edit.jsp
//   ��  ��  �� : �����ϰ����� ����
//   ��       �� : �����ϰ����� ����
//   ��  ��  �� : exam_m
//   �ڹ� ���� : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   ��  ��  �� : 2008-06-15
//   ��  ��  �� : ���׽�Ʈ ����ȣ
//   ��  ��  �� : 
//   ��  ��  �� : 
//	  ���� ���� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	if (id_course.length() == 0 || id_subject.length() ==0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	

    // ���� �Ʒ� �������� ���������
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getGrpBeans(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }	
%>

<HTML>
 <HEAD>
  <TITLE> :: �����ϰ� ���� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function exam_copy() {

		var frmx = document.form1;
		 
		 var selectId = "";
		 var k = 0;

		 if(frmx.id_exams.length == undefined) {
			 if(frmx.id_exams.checked == true) {
				 selectId = selectId + frmx.id_exams.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.id_exams.length != undefined) {
			 for (i=0; i<=frmx.id_exams.length -1; i++) {
				 if (frmx.id_exams[i].checked == true) {
					selectId = selectId + frmx.id_exams[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
			 alert("������ ������ �������ּ���.");
		 } else {
			 var str = confirm("üũ�� ���迡 ���ؼ� �ϰ����� ���� �۾��� �����Ͻðڽ��ϱ�?");

			 if(str == true) {
				window.open("exam_group_edit.jsp?id_exam="+selectId.substring(0,selectId.length-1),"edit_exam","width=750, height=640, scrollbars=no, top=0, left=0");
			 }
		 }		
    }

 </script>

</HEAD>

<BODY id="popup2">

	<form name="form1" method="post" action="exam_group_edit.jsp">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����ϰ� ����<span>������ ������� �ϰ� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">����</td>
				<td width="35%">��������</td>
				<td width="15%">���谡�ɿ���</td>
				<td width="20%">����ð�</td>
				<td>����������</td>
			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:260px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="5">�ϰ� ���� �� ������ �����ϴ�.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
				%>
				<tr id="td" align="center">
					<td width="5%"><input type="checkbox" name="id_exams" value="<%=rst[i].getId_exam()%>"></td>
					<td width="35%">&nbsp;<%=rst[i].getTitle()%></td>
					<td width="15%"><%=rst[i].getYn_enable()%></td>
					<td width="20%"><%=rst[i].getExam_start1()%></td>
					<td><%=rst[i].getExam_end1()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		</div>

	</div>
	<div id="button">
		<a href="javascript:exam_copy();"><img src="../../images/bt_subj_list_3.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
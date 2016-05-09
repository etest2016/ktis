<%
//******************************************************************************
//   ���� �׷� : exam_copy.jsp
//   ��  ��  �� : ���� ����
//   ��       �� : ���� ����
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
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

    // ���� �Ʒ� �������� ���������
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getBeans(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }	
%>

<HTML>
 <HEAD>
  <TITLE> :: ���� ���� :: </TITLE>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function exam_copy() {

		var frmx = document.form1;
			
		var selectId = "";
		var k = 0;

		if(frmx.id_exam.length == undefined) {
			 if(frmx.id_exam.checked == true) {
				 k = k + 1;
			 }
		} else if(frmx.id_exam.length != undefined) {
			 for (i=0; i<=frmx.id_exam.length -1; i++) {
				 if (frmx.id_exam[i].checked == true) {				
					k = k + 1;
				 }
			 }
		}

		if(k == 0) {
			alert("������ ������ �������ּ���.");
		} else {
			
			var str = confirm("üũ�� ���迡 ���ؼ� �ϰ����� �۾��� �����Ͻðڽ��ϱ�?");

			if(str == true) {
				document.form1.submit();
			}
		}
    }

 </script>

</HEAD>

<BODY id="popup2">

	<form name="form1" method="post" action="exam_copy_ok.jsp">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ����<span>�⺻ ������ �����Ͽ� �� ������ ����մϴ�.</span></div></td>
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
				<td width="20%">���������</td>
				<td>����������</td>
			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:210px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="5">������ ������ �����ϴ�.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
				%>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" value="<%=rst[i].getId_exam()%>-<%=rst[i].getTitle()%>"></td>
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

		<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">			
			<tr>
				<td id="left" width="30%">������ ������ ���� ����</td>
				<td><select name="paper_cnt">
				<% for(int j=1; j<11; j++) { %>
				<option value="<%=j%>"><%=j%></option>
				<% } %>
				</select>
				</td>
			</tr>
		</table>

	</div>
	<div id="button">
		<a href="javascript:exam_copy();"><img src="../../images/bt_subj_list_2.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
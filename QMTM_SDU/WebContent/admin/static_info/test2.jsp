<%
//******************************************************************************
//   ���� �׷� : exam_copy.jsp
//   �� ��  �� : ���� ����
//   ��     �� : ���� ����
//   �� ��  �� : exam_m
//   �ڹ� ���� : qmtm.ComLib, qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   �� ��  �� : 2013-02-12
//   �� ��  �� : ���׽�Ʈ ����ȣ
//   �� ��  �� : 
//   �� ��  �� : 
//	 ���� ���� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	
%>

<HTML>
 <HEAD>
  <TITLE> :: ���� ���� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function exam_copy() {

		var frmx = document.form2;
			
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
				document.form2.submit();
			}
		}
    }

	// �ܿ� 1���� ���������
	function get_cpt1_list(id_course, id_subject) {

		var frm = document.form1;
		
		cpt1 = new ActiveXObject("Microsoft.XMLHTTP");
		cpt1.onreadystatechange = get_cpt1_list_callback;
		cpt1.open("GET", "lecture.jsp?id_course="+id_course+"&id_subject="+id_subject, true);
		cpt1.send();
	}

	function get_cpt1_list_callback() {

		if(cpt1.readyState == 4) {
			if(cpt1.status == 200) {
				if(typeof(document.all.div_cpt1) == "object") {
					document.all.div_cpt1.innerHTML = cpt1.responseText;
				}
			}
		}
	}

	function cat_select(sel) {

		var frm = document.form1;

		frm.submit();
		
	}

 </script>

</HEAD>

<BODY id="popup2" >


	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ ���Ѽ���<span>�˻��� �����ڿ��� ������ ������ �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="20%"><li>������ �˻�</td>
				<td><select name="id_course" >
					<option>����</option>
					</select>&nbsp;&nbsp;<input type="text" class="input" size="30">&nbsp;&nbsp;
					<input type="button" value="�˻��ϱ�" class="form4">
				</td>
			</tr>			
			
		</table>		
	</div>	
	<BR>

		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">����</td>
				<td width="25%">�а�</td>
				<td width="20%">����</td>
				<td width="25%">���</td>
				<td width="25%">����</td>
			</tr>
		</table>
		
		
			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">�׽�Ʈ�а�</td>
					<td width="20%">����</td>
					<td width="25%">098765</td>
					<td width="25%">ȫ����</td>
				</tr>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">�׽�Ʈ�а�</td>
					<td width="20%">����</td>
					<td width="25%">098765</td>
					<td width="25%">ȫ����</td>
				</tr>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">�׽�Ʈ�а�</td>
					<td width="20%">����</td>
					<td width="25%">098765</td>
					<td width="25%">ȫ����</td>
				</tr>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">�׽�Ʈ�а�</td>
					<td width="20%">����</td>
					<td width="25%">098765</td>
					<td width="25%">ȫ����</td>
				</tr>
				
			</table>


	</div>
	<div id="button">
	<input type="button" value="���ѵ���ϱ�" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>


 </BODY>
</HTML>
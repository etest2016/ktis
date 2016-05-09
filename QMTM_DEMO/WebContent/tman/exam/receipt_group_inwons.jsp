<%
//******************************************************************************
//   ���α׷� : receipt_inwons.jsp
//   �� �� �� : �����ο�
//   ��    �� : �����ο� ������
//   �� �� �� : exam_receipt, qt_userid
//   �ڹ����� : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//              qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//              qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//              qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   �� �� �� : 2008-06-23
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*, java.util.*" %>

<%@ include file="../../common/paging.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String[] arrId_exam = id_exam.split(",");

	String tmp_page = request.getParameter("page");
	if (tmp_page == null) { tmp_page= ""; } else { tmp_page = tmp_page.trim(); }

	String url = "receipt_group_inwons.jsp";	

	String add_tag = "&id_exam="+id_exam;

	String field = "";
	String str = "";
    	
	int total_page = 0; // �� ������
    int total_count = 0; // �� ���ڵ� ��
	int current_page = 0; // ���� ������
	int page_scale = 100; // �� ȭ�鿡 �������� �Խù� ��
	int remain = 0; // ������ ����� ���� �������� ���.
	int start_rnum = 0; // ���� ������ �Խù� ���۹�ȣ
	int end_rnum = 0; // ���� ������ �Խù� ����ȣ

	if(tmp_page.length() == 0) {
		current_page = 1;
	} else {
		current_page = Integer.parseInt(tmp_page);
	}
	
	try {
		total_count = ReceiptUtil.getCounts(arrId_exam[0], field, str);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	remain = total_count % page_scale;
	
	if(remain == 0) {
		total_page = total_count / page_scale;
	} else {
		total_page = total_count / page_scale + 1;
	}

    int lists = (current_page - 1) * page_scale;
	
	ReceiptBean[] rst = null;	
	
	try {
		rst = ReceiptUtil.getBeans(arrId_exam[0], page_scale, lists, field, str);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: ����� ��� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
	function Sends() {
		if(document.form1.file.value == "") {
			alert("����� ����� ������ �������ּ���.");
			return;
		} 

		document.form1.submit();
    }

	function check_enable() {
		var frmx = document.form1;
		
		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = true;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = true;
			 }
		 }
	 }

	 function check_disable() {
		var frmx = document.form1;
		
		if(frmx.userid.length == undefined) {
			 frmx.userid.checked = false;
		} else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 frmx.userid[i].checked = false;
			 }
		}
	 }

	 function q_delete() {
		
		var frmx = document.form1;
		
		var selectId = "";
		var k = 0;

		if(frmx.userid.length == undefined) {
			 if(frmx.userid.checked == true) {
				 selectId = selectId + frmx.userid.value + ",";
				 k = k + 1;
			 }
		 } else if(frmx.userid.length != undefined) {
			 for (i=0; i<=frmx.userid.length -1; i++) {
				 if (frmx.userid[i].checked == true) {
					selectId = selectId + frmx.userid[i].value + ",";
					k = k + 1;
				 }
			 }
		 }

		 if(k == 0) {
		    alert("������ ����ڸ� �������ּ���.");			
		 } else {
		    var st = confirm("�̹� ���迡 ������ ����ڴ� �������� �ʽ��ϴ�.\n\n������ ����ڸ� �����Ͻðڽ��ϱ�?" );

			if (st == true) {																
				document.forms1.inwons.value = selectId.substring(0,selectId.length-1);
				document.forms1.action = 'receipt_inwons_group_delete.jsp';
				document.forms1.method = 'post';
				document.forms1.submit();
				
				//location.href="receipt_inwons_delete.jsp?id_exam=<%=id_exam%>&inwons="+selectId.substring(0,selectId.length-1);			
		  	}
	     }
	}

	function m_reg() {
		window.open("receipt_user_group_search.jsp?id_exam=<%=id_exam%>","m_reg","width=900, height=550, scrollbars=yes, top=0, left=0");
	}

  </Script>
   
</HEAD>

<BODY id="popup2">

	<form name="forms1" method="post">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="inwons">
	</form>
	
	<form name="form1" method="post" action="receipt_group_upload.jsp" enctype="multipart/form-data">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">����� ���<span>������ �����ϰ�� ���������� �̿��ؼ� ����ڸ� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="100"><li>��������</td>
				<td colspan="3"><input type="file" name="file" size="70" class="form2">&nbsp;&nbsp;<input type="button" value="����� ���" class="form" onClick="Sends();"></td>
			</tr>	
		</table>
		</div>
	</div>
	

	<div id="contents">
		
		<table border="0" width="100%" style="margin-bottom: 0px;">
			<tr>
				<Td height="5"></td>
			</tr>
			<tr>
				<td align="left"><img src="../../images/bt_q_list_yj1.gif" onClick="check_enable();">&nbsp;&nbsp;<img src="../../images/bt_q_list2_yj1.gif"  onClick="check_disable();">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="���ô���ڻ���" class="form2" onclick="q_delete();">&nbsp;&nbsp;<input type="button" value="����� �˻����" class="form2" onclick="m_reg();"></td>
				<td align="right">����� �ο��� �� <b><font color="red"><%=total_count%></font></b> �� �Դϴ�.</td>
			</tr>
		</table>
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%" style="margin-bottom: 0px;">
			<tr id="tr">			
				<td width="4%">����</td>
				<td width="5%">NO</td>
				<td width="11%">���̵�</td>
				<td width="11%">��й�ȣ</td>
				<td width="11%">����</td>
				<td width="12%">�ι�/��</td>
				<td width="12%">����</td>
				<td width="12%">����</td>
				<td width="12%">ȸ��</td>
				<td width="10%">�������</td>
			</tr>
		</table>
		
		<div style="overflow: auto; width:100%; height:360px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="90%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="10">��ϵ� ����ڰ� �����ϴ�.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
							int list_num = total_count - (current_page - 1) * page_scale - i;
				%>
				<tr id="td" align="center">
					<td width="4%"><input type="checkbox" name="userid" class="form2" value="<%=rst[i].getUserid()%>"></td>
					<td width="5%">&nbsp;<%=list_num%></td>
					<td width="11%"><%=rst[i].getUserid()%></td>
					<td width="11%"><%=rst[i].getPassword()%></td>
					<td width="11%"><%=rst[i].getName()%></td>
					<td width="12%"><%=ComLib.nullChk(rst[i].getSosok1())%></td>
					<td width="12%"><%=ComLib.nullChk(rst[i].getJikwi())%></td>
					<td width="12%"><%=ComLib.nullChk(rst[i].getJikmu())%></td>
					<td width="12%"><%=ComLib.nullChk(rst[i].getCompany())%></td>					
					<td width="10%"><%=rst[i].getRegdate()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		</div>

		<P>

		<table border="0" width="100%">
			<tr>
				<td align="center"><%= PageNumber(current_page, total_page, url, add_tag) %></td>
			</tr>
		</table>

	</div>

	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
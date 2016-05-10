<%
//******************************************************************************
//   ���α׷� : nonscore_file.jsp
//   �� �� �� : ����� ���� �� ���� ���
//   ��    �� : ����� ���� �� ���� ���
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2013-03-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.answer.AnswerMarkNon, qmtm.tman.answer.AnswerMarkNonBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	String id_q = request.getParameter("id_q");	
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }
	
	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// �ش� ����� ���� ����, ����, �ؼ��� ��ȸ�Ѵ�.
	AnswerMarkNonBean rst = null;

	try {
		rst = AnswerMarkNon.getBeans3(id_q, id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}	

	String strQ = rst.getQ();
	String strCa = rst.getCa();
	String strExplain = ComLib.nullChk(rst.getExplain());
	double allotting = rst.getAllotting();
	
%>

<HTML>
 <HEAD>
  <TITLE> :: �����(�Ǳ���) ���� �� ���� ��� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
	function Sends() {
		if(document.form1.file.value == "") {
			alert("����� ���������� �������ּ���.");
			return;
		} 

		var str = confirm("�ش� ������ ���� �� ������ ����մϴ�.\n\n����� �����ڰ� ������� �ð��� �����ɸ��� �ֽ��ϴ�.\n\n���� �� ������ ����Ͻðڽ��ϱ�?");

		if(str) {
			document.form1.submit();
		}
    }
	
  </Script>
   
</HEAD>

<BODY id="popup2">

	<form name="form1" method="post" action="nonscore_upload.jsp" enctype="multipart/form-data">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="id_q" value="<%=id_q%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����(�Ǳ���) ���� �� ���� ���</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	
	<div id="contents">
		<img src="../../images/sub2_webscore1.gif">
		<div class="box">		
			[�����ڵ� <%= id_q %>] <%= strQ %>&nbsp;&nbsp;&nbsp;[����] <%= allotting %><br>
			[�ؼ�(ä������)] <%= strExplain %>
		</div>
	</div>
	<br>
	<div id="contents">		
		<div align="right">		
			<a href="<%=ComLib.getConfig("adminurl")%>/PracticeSample.zip"><b>[�ϰ���ϻ������ϴٿ�ε�]</b></a>
		</div>
	</div>
	
	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="15%"><li>��������</td>
				<td colspan="3"><input type="file" name="file" size="65" class="form2">&nbsp;&nbsp;<input type="button" value="�������� ���" class="form" onClick="Sends();"></td>
				</form>
			</tr>	
		</table>
		</div>
	</div>	
	
	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>
	</form>
 </BODY>
</HTML>
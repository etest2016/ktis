<%
//******************************************************************************
//   ���α׷� : subject_insert.jsp
//   �� �� �� : ������
//   ��    �� : ������� ������ �˾� ������
//   �� �� �� : 
//   �ڹ����� : qmtm.ComLib
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: �ű԰��� ��� :: </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
  
  <Script language="JavaScript">
  	function checks() {
  		if(document.frmdata.subject.value == "") {
  			alert("������� ����ϼ���.");
  			document.frmdata.subject.focus();
  			return;
  		} else {
  			document.frmdata.submit();
  		}  		
  	}
  </Script>
  
 </HEAD>

 <BODY id="popup2">

<form name="frmdata" method="post" action="subject_insert_ok.jsp">
<input type="hidden" name="id_course" value="<%=id_course%>">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ű԰��� ��� <span>�� ������ ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">
		<table style="border: 2px solid #ddd;">
			<tr height="50">
				<td>&nbsp;&nbsp;&nbsp;�����</td>
				<td><input type="text" class="input" name="subject" size="25">&nbsp;</td>
				<td><img src="../../../images/bt5_sjinsert_yj2.gif" onClick="checks();" style="cursor:hand">&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</table>
	</div>

	<div id="button">
		<input type="image" value="���" onclick="window.close();" src="../../../images/bt5_exit_yj1.gif">
	</div>

	</form>

 </BODY>
</HTML>
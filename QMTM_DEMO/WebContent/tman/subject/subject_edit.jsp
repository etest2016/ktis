<%
//******************************************************************************
//   ���α׷� : subject_edit.jsp
//   �� �� �� : �������
//   ��    �� : ������� ������� ������
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2010-06-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // ���� ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // ���� ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// �������� ���������
	SubjectTmanBean rst = null;

    try {
	    rst = SubjectTmanUtil.getBean(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>
<HTML>
<HEAD>
<TITLE> �ܿ����� ���� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

  <Script language="JavaScript">
  	function checks() {
  		if(document.frmdata.subject.value == "") {
  			alert("�ܿ����� ����ϼ���.");
  			document.frmdata.subject.focus();
  			return;
  		} else {
  			document.frmdata.submit();
  		}  		
  	}
  </Script>
  
</HEAD>

<BODY id="popup2">

<form name="frmdata" method="post" action="subject_update.jsp">
<input type="hidden" name="id_course" value="<%=id_course%>">
<input type="hidden" name="id_subject" value="<%=id_subject%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ܿ����� ���� <span>�ܿ��� �� �������� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ܿ���</td>
				<td><input type="text" class="input" size="30" name="subject" value="<%=rst.getSubject()%>"></td>
			</tr>
			<tr>
				<td id="left">��������</td>
				<td><input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> ����&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> �����</td>
			</tr>
		</table>
	</div>

	<div id="button">
    <img src="../../images/bt5_edit_yj1.gif" onClick="checks();" style="cursor:hand">&nbsp;&nbsp;<img border="0" src="../../images/bt5_exit_yj1.gif" style="cursor:hand" onClick="window.close();">
	</div>

	</form>

</BODY>
</HTML>
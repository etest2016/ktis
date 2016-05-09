<%
//******************************************************************************
//   ���α׷� : subject_view.jsp
//   �� �� �� : ����Ȯ��
//   ��    �� : ������� ����Ȯ�� �˾� ������
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2010-06-09
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

	String yn_valid = "";
	if(rst.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "����";
	} else {
		yn_valid = "�����";
	}
%>

<script language="javascript">
    // ���� ����
	function cpt_edit() {
		location.href="subject_edit.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>";
	}
	
	//--  ���� ����üũ
    function cpt_delete()  {
       var st = confirm("*����* �ܿ������� �����Ͻðڽ��ϱ�? \n\n���� �� ���� ������ ���� �����ϼž� �մϴ�." );
       if (st == true) {
           document.location = "subject_delete.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>";
       }
    }
</script>
<HTML>
<HEAD>
<TITLE> �ܿ����� Ȯ�� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">


<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ܿ����� Ȯ�� <span>�ܿ�Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ܿ���</td>
				<td width="200"><%=rst.getSubject()%></td>
			</tr>
			<tr>
				<td id="left">��������</td>
				<td><%=yn_valid%></td>
			</tr>	
			<tr>
				<td id="left">�������</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
		</table>
		</div>


<div id="button">
<a href="javascript:cpt_edit();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:cpt_delete();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
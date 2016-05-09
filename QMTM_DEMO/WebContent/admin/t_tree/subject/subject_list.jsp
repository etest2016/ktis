<%
//******************************************************************************
//   ���α׷� : subject_list.jsp
//   �� �� �� : �������
//   ��    �� : ������� Ʈ������ ���� ���ý� �����ִ� ������
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
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_edit() {
		window.open("subject_edit.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  ���� ����üũ
    function sub_delete()  {
       var st = confirm("*����* ���������� �����Ͻðڽ��ϱ�? \n\n���� �� ���� ������ ���� �����ϼž� �մϴ�.");
	   if (st == true) {
           window.open("subject_delete.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>&bigo=Y","edit","width=400, height=250, scrollbars=no");
       }
    }	
 </script>

 </HEAD>

 <BODY id="admin">	

    <div id="main">
		<div id="mainTop">
			<div class="title">��������[<%=rst.getSubject()%>]</div>
		<div class="location"> ������ > <span><%=rst.getSubject()%></span></div>
	</div>

	<TABLE cellpadding="0" cellspacing="0" border="0" id="tableC" width="100%">
		<TR id="top">
			<TD id="left"></TD>
			<TD id="center"></TD>
			<TD id="right"></TD>
		</TR>
		<TR id="middle">
			<TD id="left"></TD>
			<TD id="center">

				<table id="tableA" cellpadding="0" cellspacing="0" border="0">
					<tr id="tr2" height="30" bgcolor="#DBDBDB"  align="center">
						<td bgcolor="#DBDBDB" align="center">�����ڵ�</td>
						<td bgcolor="#DBDBDB">�����</td>
						<td bgcolor="#DBDBDB">�������</td>
						<td bgcolor="#DBDBDB">�����ϱ�</td>
						<td bgcolor="#DBDBDB">�����ϱ�</td>
					</tr>
					<tr id="td" height="30" bgcolor="#FFFFFF">
						<td align="center"><%=id_subject%></td>
						<td align="center"><%=rst.getSubject()%></td>
						<td align="center"><%=rst.getRegdate()%></td>
						<td align="center"><a href="javascript:sub_edit();"><img src="../../../images/bt5_edit.gif"></a></td>
						<td align="center"><a href="javascript:sub_delete();"><img src="../../../images/bt5_delete.gif"></a></td>
					</tr>		
				</table>
			</TD>
			<TD id="right"></TD>
		</TR>
		<TR id="bottom">
			<TD id="left"></TD>
			<TD id="center"></TD>
			<TD id="right"></TD>
		</TR>
		</TABLE>
		
		</div>
		<jsp:include page="../../../copyright.jsp"/>
	
	
 </BODY>
</HTML>
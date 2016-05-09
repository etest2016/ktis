<%
//******************************************************************************
//   ���α׷� : subject_list.jsp
//   �� �� �� : �������
//   ��    �� : �������� Ʈ������ ���� ���ý� �����ִ� ������
//   �� �� �� : q_subject, q_chapter
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree, 
//             qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree, qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil" %>

<%
	response.setDateHeader("Expires", 0);   
	request.setCharacterEncoding("EUC-KR");   

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0 || id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
     
    // �������� ���������
	QmanTreeBean rst = null;

    try {
	    rst = QmanTree.getBean_2(id_q_subject);
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
		window.open("subject_edit.jsp?id_q_subject=<%=id_q_subject%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  ���� ����üũ
    function sub_delete()  {
       var st = confirm("*����* ���������� �����Ͻðڽ��ϱ�? \n\n���� �� �����ܿ��� ���� �����ϼž� �մϴ�." );
       if (st == true) {
           window.open("subject_delete.jsp?id_q_subject=<%=id_q_subject%>","edit","width=400, height=250, scrollbars=no");
       }
    }
		
 </script>

 </HEAD>
	
 <BODY id="admin">	

	<div id="main">

		<div id="mainTop">
			<div class="title">��������</div>
			<div class="location">ī�װ����� > <%=rst.getCategory()%> > <span><%=rst.getQ_subject()%></span></div>
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
					<!--tr id="sub_title"><td colspan="5">��������</td></tr-->
					<tr id="tr2">
						<td>�����ڵ�</td>
						<td>�����</td>
						<td>�������</td>
						<td>�����ϱ�</td>
						<td>�����ϱ�</td>
					</tr>
					<tr id="td" align="center" height="40">
						<td><%=id_q_subject%></td>
						<td><%=rst.getQ_subject()%></td>
						<td><%=rst.getRegdate()%></td>
						<td><a href="javascript:sub_edit();" onfocus="this.blur();"><img src="../../../images/bt5_edit.gif"></a></td>
						<td><a href="javascript:sub_delete();" onfocus="this.blur();"><img src="../../../images/bt5_delete.gif"></a></td>
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
	
	<jsp:include page="../../../copyright.jsp"/>
	
 </BODY>
</HTML>
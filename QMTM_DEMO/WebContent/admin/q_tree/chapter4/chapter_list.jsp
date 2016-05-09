<%
//******************************************************************************
//   ���α׷� : chapter_list.jsp
//   �� �� �� : �׹�° �ܿ�����
//   ��    �� : �������� Ʈ������ �׹�° �ܿ� ���ý� �����ִ� ������
//   �� �� �� : q_chapter4  
//   �ڹ����� : qmtm.admin.Chapter4QmanBean, qmtm.admin.Chapter4QmanUtil
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.*, qmtm.admin.qman.*" %>

<%
	response.setDateHeader("Expires", 0);   
	request.setCharacterEncoding("EUC-KR");

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    // �ܿ�4 ���� ���������
	Chapter4QmanBean rst = null;

    try {
	    rst = Chapter4QmanUtil.getBean(id_q_chapter);
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
		window.open("chapter_edit.jsp?id_subject=<%=rst.getId_q_subject()%>&id_chapter1=<%=rst.getId_q_chapter()%>&id_chapter2=<%=rst.getId_q_chapter2()%>&id_chapter3=<%=rst.getId_q_chapter3()%>&id_q_chapter=<%=id_q_chapter%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  �ܿ� ����üũ
    function sub_delete()  {
       var st = confirm("*����* �ܿ������� �����Ͻðڽ��ϱ�? \n\n���� �� �����ܿ��� ���� �����ϼž� �մϴ�." );
       if (st == true) {
           window.open("chapter_delete.jsp?id_subject=<%=rst.getId_q_subject()%>&id_chapter1=<%=rst.getId_q_chapter()%>&id_chapter2=<%=rst.getId_q_chapter2()%>&id_chapter3=<%=rst.getId_q_chapter3()%>&id_q_chapter=<%=id_q_chapter%>&bigos=Y","edit","width=400, height=250, scrollbars=no");
       }
    }	
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">

		<div id="mainTop">
			<div class="title">���� �ܿ�4 ���� <span>������ �ܿ�3�� ������ �� �� ���� �ܿ��� ��ȸ �� ����, ���� �� �� �ֽ��ϴ�</span></div>
			<div class="location"> ������ > ����������� > <span><%=rst.getChapter()%></span></div>
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
	
	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="tr2">
				<td>�ܿ�4�ڵ�</td>
				<td>�ܿ�4��</td>
				<td>�������</td>
				<td>�����ϱ�</td>
				<td>�����ϱ�</td>
			</tr>
			<tr id="td" align="center">
				<td><%=id_q_chapter%></td>
				<td><%=rst.getChapter()%></td>
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
	
	</div>
	<jsp:include page="../../../copyright.jsp"/>
 </BODY>
</HTML>
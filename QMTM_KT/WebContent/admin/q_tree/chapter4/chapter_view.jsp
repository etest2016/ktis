<%
//******************************************************************************
//   ���α׷� : chapter_view.jsp
//   �� �� �� : �׹�° �ܿ�Ȯ��
//   ��    �� : �������� �׹�° �ܿ�Ȯ�� �˾� ������
//   �� �� �� : q_chapter4
//   �ڹ����� : qmtm.admin.qman.Chapter4QmanBean, qmtm.admin.qman.Chapter4QmanUtil
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_subject = request.getParameter("id_subject"); 
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String id_chapter1 = request.getParameter("id_chapter1"); 
	if (id_chapter1 == null) { id_chapter1 = ""; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2"); 
	if (id_chapter2 == null) { id_chapter2 = ""; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("id_chapter3"); 
	if (id_chapter3 == null) { id_chapter3 = ""; } else { id_chapter3 = id_chapter3.trim(); }
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_subject.length() == 0 || id_chapter1.length() == 0 || id_chapter2.length() == 0 || id_chapter3.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// �ܿ����� ���������
	Chapter4QmanBean rst = null;

    try {
	    rst = Chapter4QmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
    // �ܿ� ����
	function cpt_edit() {
		location.href="chapter_edit.jsp?id_subject=<%=id_subject%>&id_chapter1=<%=id_chapter1%>&id_chapter2=<%=id_chapter2%>&id_chapter3=<%=id_chapter3%>&id_q_chapter=<%=id_q_chapter%>";
	}
	
	//--  �ܿ� ����üũ
    function cpt_delete()  {
       var st = confirm("*����* �ܿ������� �����Ͻðڽ��ϱ�? \n\n���� �� �ش� �ܿ��� ���Ե� ������ ���� �����ϼž� �մϴ�." );
       if (st == true) {
           document.location = "chapter_delete.jsp?id_subject=<%=id_subject%>&id_chapter1=<%=id_chapter1%>&id_chapter2=<%=id_chapter2%>&id_chapter3=<%=id_chapter3%>&id_q_chapter=<%=id_q_chapter%>";
       }
    }
</script>

<TITLE> :: �ܿ� Ȯ�� :: </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">
</head>

<BODY id="popup2">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ܿ� Ȯ�� <span>�ܿ������� Ȯ���մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�ܿ���&nbsp;</td>
				<td width="220">&nbsp;&nbsp;<%=rst.getChapter()%></td>
			</tr>
			<tr>
				<td id="left">���ļ���&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rst.getChapter_order()%></td>
			<tr>
				<td id="left">�������&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
<!--<input type="button" value="�����ϱ�" onClick="cpt_edit();">--><a href="javascript:cpt_edit();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="�����ϱ�" onClick="cpt_delete();">--><a href="javascript:cpt_delete();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>
</div>
	
	
	</form>

</body>
</HTML>
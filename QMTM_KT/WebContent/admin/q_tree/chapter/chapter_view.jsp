<%
//******************************************************************************
//   ���α׷� : chapter_view.jsp
//   �� �� �� : �ܿ�Ȯ��
//   ��    �� : �������� �ܿ�Ȯ�� �˾� ������
//   �� �� �� : q_chapter
//   �ڹ����� : qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ    
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>    

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_subject == null || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// �ܿ����� ���������
	ChapterQmanBean rst = null;

    try {
	    rst = ChapterQmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>
<html>
<head>
<title></title>
<script language="javascript">
    // �ܿ� ����
	function cpt_edit() {
		location.href="chapter_edit.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>";
	}
	
	//--  �ܿ� ����üũ
    function cpt_delete()  {
       var st = confirm("*����* �ܿ������� �����Ͻðڽ��ϱ�? \n\n���� �� �����ܿ��� ���� �����ϼž� �մϴ�." );
       if (st == true) {
		   document.location = "chapter_delete.jsp?id_q_subject=<%=id_q_subject%>&id_q_chapter=<%=id_q_chapter%>&bigos=N";
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
				<td width="230">&nbsp;&nbsp;<%=rst.getChapter()%></td>
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
<%
//******************************************************************************
//   ���α׷� : exam_list.jsp
//   �� �� �� : ����� �� ä�������
//   ��    �� : ����� �� ä�������
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   �� �� �� : 2009-01-21
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*, etest.scorehelp.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	AnswerMarkBean[] beans = null;

	try {
		beans = AnswerMark.getBeans(id_exam);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<html>
<head>
<title> :: ä������� :: </title>
<link rel="StyleSheet" href="../css/style.css" type="text/css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="JavaScript">

	function ans_mark_dan(id_q) {
		$.posterPopup("score_help_Res2.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_dan","width=1100, height=780, scrollbars=yes, top=0, left=0, fullscreen=no");
	}

	function equal_exe(id_q){
		var chk = confirm("��� ��� �� ó���ϴµ� ������ �ο��� �� \n��ȱ��̿� ���� ������ �ð��� �ҿ�˴ϴ�. \n\n���� �����Ͻðڽ��ϱ�?")
		if(chk == true)
		{
			$.posterPopup("ans_equal_frame.jsp?id_exam=<%=id_exam%>&id_q="+id_q, "equal_exe", "width=1100, height=780, scrollbars=yes, top=0, left=0");
		}
	}

	function score_win_non(id_q) {
		$.posterPopup("exam_ans_score_insert.jsp?id_exam=<%=id_exam%>&id_q="+id_q, "scoreNon", "width=1100, height=780, scrollbars=yes, top=0, left=0");
	}

	function equal_win_non(id_q) {
		$.posterPopup("ans_equal_result.jsp?id_exam=<%= id_exam %>&id_q="+id_q, "scoreNon2", "width=1100, height=780, scrollbars=yes, top=0, left=0");		
	}

	/*

	function comp_del(id_q) {
		var chk = confirm("*����) ��� ��� �� �����  �ʱ�ȭ�˴ϴ�.\n\n���� �����Ͻðڽ��ϱ�?")
		if(chk == true)
		{
			$.posterPopup("comp_del.jsp?id_exam=<%=id_exam%>&id_q=" + id_q, "comp_del", "scorllbars=no, width=600 height=600");
		}
	}

	function ans_mark_non(id_q) {
		$.posterPopup("non_frame.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
	}

	*/

</script>
</head>

<body id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">ä������� <span>������ ä������� ���񽺸� �̿��� ä��</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<img src='../images/qlistA.gif'>

		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr" align="center">
				<td width="10%"> �����ڵ� </td>
				<td> ���� </td>
				<td width="18%"> &nbsp; </td>
				<td width="22%">ä��</td>
			</tr>

			<% if(beans == null) { %>
			<tr>
				<td colspan="4" class="blank">�ܴ���, ����� ������ �����ϴ�.</td>
			</tr>
			<% } else {
					for(int i=0; i<beans.length; i++) { 
						if(beans[i].getId_qtype() == 4) {
			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;"><%=beans[i].getQ()%></td>
				<td><% if(beans[i].getCacount() > 1) { %>����������� : <%=beans[i].getYn_caorder()%><br><% } %>
				��ҹ��� ���� : <%=beans[i].getYn_case()%><br>
				��ĭ üũ : <%=beans[i].getYn_blank()%></td>
				<td><a href="javascript:ans_mark_dan('<%=beans[i].getId_q()%>')"><img src="../images/bt5_mark.gif"></a></td>
			</tr>
			<%
						}
					}
				}
			%>
		</table>

		<img src='../images/qlistE.gif'>

		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr align="center" id="tr">
				<td width="10%" id="left"> �����ڵ� </td>
				<td> ���� </td>
				<td width="18%"> &nbsp; </td>
				<td width="22%">ä��</td>
			</tr>

			<% if(beans == null) { %>
			<tr>
				<td colspan="4" class="blank">�ܴ���, ����� ������ �����ϴ�.</td>
			</tr>
			<% } else {
					for(int i=0; i<beans.length; i++) { 
						if(beans[i].getId_qtype() != 4) {
			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;"><%=beans[i].getQ()%></td>
				<td><% if(beans[i].getCacount() > 1) { %>����������� : <%=beans[i].getYn_caorder()%><br><% } %>
				��ҹ��� ���� : <%=beans[i].getYn_case()%><br>
				��ĭ üũ : <%=beans[i].getYn_blank()%></td>
				<td><img src="../images/bt5_mark.gif" onclick="javascript:score_win_non('<%=beans[i].getId_q()%>');" style="cursor: pointer;"></td>
			</tr>
			<%
						}
					}
				}
			%>
		</table>

	</div>
	<div id="button">
		
	<img src="../images/bt5_exit_yj1.gif" style="cursor: pointer;" onclick="window.close();">
		
	</div>

</body>

</html>
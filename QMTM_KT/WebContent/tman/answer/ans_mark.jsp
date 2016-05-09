<%
//******************************************************************************
//   ���α׷� : ans_mark.jsp
//   �� �� �� : ����� ��ȸ
//   ��    �� : ����� ��ȸ
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   �� �� �� : 2008-06-02
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String userid = CommonUtil.get_Cookie(request, "userid"); // ����� ���̵�
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {            
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	AnswerMarkBean[] beans = null;

	try {
		beans = AnswerMark.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

<html>
<head>
<title> :: ���׺� ����ä�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

	function ans_mark_dan(id_q) {
		window.open("../../scorehelp/score_help_Res2.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_dan","width=1100, height=780, scrollbars=yes, top=0, left=0, fullscreen=no");
		//window.open("ans_mark_dan.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_dan","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
		//window.open("http://exam.gnu.ac.kr/score_help/exam_ans_score.asp?id_exam=<%=id_exam%>&userid=<%=userid%>&id_q="+id_q,"mark_dan","width=1100, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
	}

	function ans_mark_non(id_q) {
		window.open("non_frame.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
		//window.open("http://exam.gnu.ac.kr/score_help/exam_ans_non_score.asp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=1100, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
	}

</script>
</head>

<body id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���׺� ����ä�� <span>���׺� ������ ����� ä���մϴ�. || <font color=red><b>���׺� ä���� �Ϸ�Ǹ� ä�����º����� Ŭ���ؼ� �Ϸ�ó���մϴ�.</b></font></span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">

		<table border="0" cellpadding="0" cellspacing="0" id="tableA">
			<tr id="tr" align="center">
				<td width="11%"> �����ڵ� </td>
				<td width="12%"> ��������&nbsp;&nbsp; </td>
				<td> ���� </td>
				<td width="15%"> &nbsp; </td>
				<td width="10%">ä��</td>
				<td width="10%">ä������</td>
			</tr>

			<% if(beans == null) { %>
			<tr>
				<td colspan="6" class="blank">�ܴ���, ����� ������ �����ϴ�.</td>
			</tr>
			<% } else {
					String qtypes = "";
					for(int i=0; i<beans.length; i++) { 
						if(beans[i].getId_qtype() == 4) {
							qtypes = "<img src='../../images/qlistA.gif'>";
						} else {
							qtypes = "<img src='../../images/qlistE.gif'>";
						}

						String scoreChk = "";
						String scoreChk_str = "";

						try {
							scoreChk = AnswerMark.getScoreChk(id_exam, beans[i].getId_q());
						} catch(Exception ex) {
							out.println(ComLib.getExceptionMsg(ex, "back"));

							if(true) return;
						}

						if(scoreChk == null) {
							scoreChk = "";
							scoreChk_str = "[ä�����º���]";
						} else {
							scoreChk_str = "[ä���Ϸ�]";
						}
						
			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td><%=qtypes%></td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;"><%=beans[i].getQ()%></td>
				<td><% if(beans[i].getCacount() > 1) { %>����������� : <%=beans[i].getYn_caorder()%><br><% } %>
				��ҹ��� ���� : <%=beans[i].getYn_case()%><br>
				��ĭ üũ : <%=beans[i].getYn_blank()%></td>
				<td>
				<% if(beans[i].getId_qtype() == 4) { %>
				<a href="javascript:ans_mark_dan('<%=beans[i].getId_q()%>')">
				<% } else { %>
				<a href="javascript:ans_mark_non('<%=beans[i].getId_q()%>')">
				<% } %>
				<img src="../../images/bt_check_yj1.gif"></a>
				</td>
				<td><font color=red></b><% if(scoreChk.equals("Y")) { %><%=scoreChk_str%><% } else { %><a href="score_id_q_chk.jsp?id_exam=<%=id_exam%>&id_q=<%=beans[i].getId_q()%>"><%=scoreChk_str%></a><% } %></b></font></td>
			</tr>
			<%
					}
				}
			%>
		</table>

	</div>
	<div id="button">
		
	<img src="../../images/bt5_exit_yj1.gif" style="cursor: hand;" onclick="window.close();">
		
	</div>

</body>

</html>
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

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*,  org.apache.commons.lang3.StringEscapeUtils" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid"); // ����� ���̵�
	
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {            
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	AnswerMarkBean[] beans = null;

	try {
		beans = AnswerMark.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
%>

<html>
<head>
<title> :: ������ ����ä�� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<script type="text/javascript" src="../../js/tablesort.js"></script>

<script language="JavaScript">

	function ans_mark_dan(id_q) {

		$.posterPopup("ans_mark_dan.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_dan","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");		
	}

	function ans_mark_non(id_q) {
		$.posterPopup("non_frame.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"mark_non","width=1000, height=700, scrollbars=yes, top=0, left=0, fullscreen=yes");
	}

	function excel_reg(id_q) {
		$.posterPopup("nonscore_file.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"excel_reg","width=800, height=400, scrollbars=yes, top="+(screen.height-400)/2+", left="+(screen.width-800)/2);
	}

	function ans_inwon(id_exam, id_q) {
		$.posterPopup("../../scorehelp/answer_user_score.jsp?id_exam=<%=id_exam%>&id_q="+id_q,"ans_inwon","width=400, height=400, scrollbars=yes, top="+(screen.height-400)/2+", left="+(screen.width-400)/2);
	}

	function ans_dan_inwon(id_exam) {
		$.posterPopup("../../scorehelp/answer_dan_user_score.jsp?id_exam=<%=id_exam%>","ans_dan_inwon","width=400, height=400, top=0, left=0, scrollbars=yes, top="+(screen.height-400)/2+", left="+(screen.width-400)/2);
	}

</script>

<style>
	.wrap {word-braker:break-all}
</style>
</head>

<body id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ ����ä�� <span>������ ������ ����� ä���մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>			
		</table>
		
		
	</div>

	<div id="contents">
		<table border="0" width="100%">
			<tr>
				<td align="right"><input type="button" value="���ΰ�ħ" onClick="location.reload();" class="form"></td>
			</tr>
		</table>	
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tableA" onclick="sortColumn(event)">
			<THEAD>
			<tr id="tr" align="center">
				<td width="10%"> �����ڵ� ���</td>
				<td width="12%"> �������� ���</td>
				<td width="68%"> ���� ���</td>
				<td width="10%">ä��</td>
			</tr>
			</THEAD>

			<% if(beans == null) { %>
			<TBODY>
			<tr>
				<td colspan="4" class="blank">�ܴ���, ����� ������ �����ϴ�.</td>
			</tr>
			</TBODY>
			<% } else {
					String qtypes = "";
					for(int i=0; i<beans.length; i++) { 
						if(beans[i].getId_qtype() == 4) {
							qtypes = "�ܴ���";
						} else {
								qtypes = "�����";
							}

						ImsiAnswerMarkBean rst = null;

						try {
							rst = AnswerMark.getScoreInwon(id_exam, beans[i].getId_q(), beans[i].getId_qtype());
						} catch(Exception ex) {
							out.println(ComLib.getExceptionMsg(ex, "close"));

							if(true) return;
						}

			%>
			<tr id="td" align="center">
				<td id="left"><b><li><%=beans[i].getId_q()%></b>&nbsp;&nbsp;&nbsp;</td>
				<td><font color=green><B><%=qtypes%></B></font></td>
				<td style="text-align:left; padding: 15px 5px 18px 5px;">
					<div class="wrap" ><%=ComLib.htmlDel(beans[i].getQ())%></div>
				</td>
				<td>
				<% if(beans[i].getId_qtype() == 4) { %>
				<a href="javascript:ans_mark_dan('<%=beans[i].getId_q()%>')">
				<% } else { %>
				<a href="javascript:ans_mark_non('<%=beans[i].getId_q()%>')">
				<% } %>
				<img src="../../images/bt_check_yj1.gif"></a>
				</td>				
			</tr>
			<%
					}
				}
			%>
		</table>

	</div>
	<div id="button">
		
	<img src="../../images/bt5_exit_yj1.gif" style="cursor: pointer;" onclick="window.close();">
		
	</div>

</body>

</html>
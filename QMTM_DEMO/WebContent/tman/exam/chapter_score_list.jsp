<%
//******************************************************************************
//   ���� �׷� : exam_copy.jsp
//   ��  ��  �� : ���� ����
//   ��       �� : ���� ����
//   ��  ��  �� : exam_m
//   �ڹ� ���� : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   ��  ��  �� : 2008-06-15
//   ��  ��  �� : ���׽�Ʈ ����ȣ
//   ��  ��  �� : 
//   ��  ��  �� : 
//	  ���� ���� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) { 
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

    // ���� �Ʒ� �������� ���������
	ChapterScoreBean[] rst = null;

    try {
	    rst = ChapterScore.getBeans(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }	
%>

<HTML>
 <HEAD>
  <TITLE> :: �ܿ��� �䱸���� ���� ���� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function score_insert(id_chapter) {

		window.open("chapter_score.jsp?id_exam=<%=id_exam%>&id_chapter="+id_chapter,"score_insert","width=350, height=200");
    }

 </script>

</HEAD>

<BODY id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ܿ��� �䱸���� ����<span>�ܿ��� �䱸���� ������� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">				
				<td width="25%">�ܿ��ڵ�</td>
				<td>�ܿ���</td>
				<td width="25%">�䱸���������</td>	
				<td width="10%">��������</td>	
			</tr>
		</table>
		
			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="4">������ �ܿ��� �����ϴ�.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {

							double score = 0;
							try {
								score = ChapterScore.getScore(id_exam, rst[i].getId_chapter());
							} catch(Exception ex) {
								out.println(ComLib.getExceptionMsg(ex, "close"));

								if(true) return;
							}
				%>
				<tr id="td" align="center">
					<td width="25%">&nbsp;<%=rst[i].getId_chapter()%></td>
					<td><%=rst[i].getChapter()%></td>
					<td width="25%"><%if(score == -1) { %>������<% } else { %><%=score%><% } %></td>
					<td width="10%"><input type="button" value="����ϱ�" class="form" onClick="score_insert('<%=rst[i].getId_chapter()%>');"></td>
				</tr>
				<%
						}
					}
				%>
			</table>
		
	</div>
	<div id="button">
		<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
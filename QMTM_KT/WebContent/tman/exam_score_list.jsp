<%
//******************************************************************************
//   ���α׷� : course_list.jsp
//   �� �� �� : �����Ʒ� �������
//   ��    �� : ������� Ʈ������ ���� ���ý� �����ִ� ������
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   �� �� �� : 2008-04-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.answer.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String course_name = "";

    // ���Ǹ� ���������
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// ���� �Ʒ� �������� ���������
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getMarkBeans(id_course, "-1", userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

%>

<HTML>
 <HEAD>
  <TITLE> Tman Main </TITLE>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="../js/tablesort.js"></script>

 <script language="JavaScript">

	function exam_score(id_exam) {
		window.open("answer/ans_mark.jsp?id_exam="+id_exam,"exam_score","width=950, height=640, scrollbars=yes");
    }

 </script>

 </HEAD>

 <BODY id="tman">
	<div id="main">

		<div id="mainTop">
			<div class="title"><font class="point_t_n">ä������</font> ���� ��� <span> ä���ڷ� ������ ���� ����Դϴ�.</span></div>
			<div class="location">������� > <span><%=course_name%> </span>&nbsp;&nbsp;</div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" onclick="sortColumn(event)">
			<THEAD>
			<tr id="tr">
				<td>�������� ���</td>
				<td>���谡�ɿ���</td>
				<td>����Ⱓ ���</td>
				<td>������ȸ�Ⱓ ���</td>
				<td>ä������ ���</td>
				<td>&nbsp;</td>
			</tr>
			</THEAD>
	<%
		if(rst == null) {
	%>
			<TBODY>
			<tr>
				<td class="blank" colspan="6">��ϵǾ��� ������ �����ϴ�.</td>
			</tr>
			</TBODY>
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {

				ImsiAnswerMarkBean rst2 = null;

				try {
					rst2 = AnswerMark.getAllScoreInwon(rst[i].getId_exam());
				} catch(Exception ex) {
					out.println(ComLib.getExceptionMsg(ex, "close"));

					if(true) return;
				}
	%>
			<tr id="td" align="center">
				<td style="padding-left: 20px; text-align: left;"><%=rst[i].getTitle()%></td>
				<td><% if (rst[i].getYn_enable().equals("Y")){%><img src="../images/icon_y.gif"><%}else{%><img src="../images/icon_n.gif"><%}%></td>
				<td><%=rst[i].getExam_start1()%> ����<br><%=rst[i].getExam_end1()%> ����</td>
				<%if(rst[i].getYn_open_qa().equals("A")) { %>
				<td align="center">�Ⱓ��������</td>
				<% } else { %>
				<td><%=rst[i].getStat_start()%> ����<br><%=rst[i].getStat_end()%> ����</td>
				<% } %>
				<td><font color=red><b>
				<% if(rst2.getAll_score() == 0) { // ��ä�� ���� %>
					[��ä��]
					<% 
						} else { 
							if(rst2.getNo_score() > 0 || (rst2.getAll_q() > rst2.getAll_score())) { 
					%>
					[ä��������]
					<%		} else { %>
					[ä���Ϸ�]
					<%
							}
						}
					%>
				</b></font></td>
				<td><input type="button" value="ä���ϱ�" class="form" onClick="exam_score('<%=rst[i].getId_exam()%>');"></td>
			</tr>
	<%
			}
		}
	%>
		</table>

	</div>
	<jsp:include page="../copyright.jsp"/>

 </BODY>
</HTML>
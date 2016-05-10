<%@page contentType="text/html; charset=EUC-KR" errorPage="../errorAll.jsp" %>
<%@page import="qmtm.*, etest.scorehelp.*, java.sql.*"%>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	//String userid =	get_cookie(request, "userid");
	////////////////////////////////////////////////
	String userid = request.getParameter("userid");
	String id_course = request.getParameter("id_course");
	String workerid = "";
	////////////////////////////////////////////////

	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }
	if (userid == "") {
	  throw new QmTmException("[exam_list.jsp] �α��Ŀ� ����ϼ���");
	}
%>
<%
	Score_ExamListBean[] rst;
	try {
	  rst = Score_ExamList.getBeans(id_course);
	}
	catch (Exception ex) {
	  throw new QmTmException("[�������� ����]@prev@db");
	}

	try {
	  workerid = Score_ExamList.getWorkerid(userid, id_course);
	}
	catch (Exception ex) {
	  throw new QmTmException("[�������� ����]@prev@db");
	}
%>

<html>
<head>
<title>�ܴ��� �� ����� ��ä��</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="javascript">
	function ftnCourse() {
		document.frmdata.action = "./exam_list.jsp";
		document.frmdata.submit();
	}

	function p_score_win(id_exam) {
		$.posterPopup("./m_frame.jsp?id_exam="+id_exam, "p_scorewin", "menubar=no, scrollbars=yes, width=1000, height=700, fullscreen");
	}
	
	function ftnExam() {
		var frm = document.frmdata;
		
		document.frmdata.action = "exam_list.jsp";
		document.frmdata.submit();
	}	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">
</HEAD>

<BODY oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">
<TABLE cellpadding="0" cellspacing="0" border="0" class="Layout">
	<TR>
		<!-- ���� ��� -->
		<TD class="Left" rowspan="2">&nbsp;</TD>
		<!-- ���� ��� Ÿ��Ʋ �� ���� ��ġ ǥ�� -->
		<TD class="CenterTop">
			<div id="L">
			<img src="../images/title_ad_web.gif">
			</div>
		</TD>
		<TD class="Right" rowspan="2">&nbsp;</TD>
	</TR>
	<TR>		
		<TD class="CenterMain">
		<!-- ���� ���� -->
		<form name="frmdata" method="post">

			<table border="0" cellspacing="0" cellpadding="0" class="Btype" style="margin-top: 10px;"> 
				<tr class="title"> 
					<td id="Tleft">�򰡸�</td>
					<td>������</td>
					<td>�ܴ��� ����</td>
					<td>����� ����</td>
					<td>������ ä��</td>
					<td>�����ں� ä��<%= workerid %></td>
				</tr>	
			<% 
				if (rst == null) { 
			%>
				<tr class='blank'>
					<td colspan="6">ä���� ������ �����ϴ�.</td>
				</tr>
			<% 
				} else { 
					for (int i = 0; i < rst.length; i++) {
			%>

					<tr> 
						<td id="Tleft"><%= rst[i].getTitle() %></td>
						<td><%= rst[i].getExam_start() %> ~ <%= rst[i].getExam_end() %></td>
						<td><B><%= rst[i].getNums1() %></B> ����</td>
						<td><B><%= rst[i].getNums2() %></B> ����</td>
						<td><img src="../images/bt3_mark.gif" onclick="location.href('./exam_score_list.jsp?id_exam=<%= rst[i].getId_exam() %>');" class="link"></td>
						<td><img src="../images/bt3_mark.gif" class="link" onclick="javascript:p_score_win('<%= rst[i].getId_exam() %>')"></td>
					</tr>				
			<%
					}
				}
			%>
			</table>

			<TABLE class="Etype" cellpadding="0" cellspacing="0" border="0"> 
				<TR>
					<TD>
						<li>�ܴ��� �Ǵ� ����� ������ �������� ���� �򰡴� �� ä�� ���� �޴��� �� ��Ͽ��� Ȯ���� �� �����ϴ�.</li>
						<li>������ ä���� �ش� �򰡿� ������ ������ ���� ���� ������ �� �����ڵ��� ��ȿ� ������ �ο��ϴ� ����Դϴ�.</li>
						<li>�����ں� ä���� �ش� ���� �����ڵ� �������� �ܴ��� Ȥ�� ����� ������ ����� ���� ä���ϴ� ����Դϴ�.</li>
					</TD>
				</TR>
				<TR>
					<TD id="bt"></TD>
				</TR>
			</TABLE>
			</form>
		</TD>
	</TR>
	<!-- �ϴ� ī�Ƕ���Ʈ -->

</TABLE>

</BODY>
</HTML>

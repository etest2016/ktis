<%
//******************************************************************************
//   ���α׷� : paper_option.jsp
//   �� �� �� : ���������ɼ� ����
//   ��    �� : ���������ɼ� ����
//   �� �� �� : exam_m, q_chapter
//   �ڹ����� : qmtm.tman.exam.ExamPaperGuide, ExamPaperGuideBean
//   �� �� �� : 2008-05-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, qmtm.tman.exam.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	// ������ ������ ������´�.
	int papercnt = 0;

	try {
		papercnt = ExamUtil.getPaperCnt(id_exam);
	}
	catch (Exception ex) {
		out.println(ex.getMessage());
	}
	
	// �ش� �������� ������ ������´�.
	ExamPaperOptionBean rst = null;
	
	try {
		rst = ExamPaperOption.getBean(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	String randomtype = "";
	String type_msg = "";

	if(rst.getId_randomtype().equals("NN")) {
		randomtype = "��������";
		type_msg = "������ ���� ������ ���� �ʰ� ������ ������ �����մϴ�.";
	} else if(rst.getId_randomtype().equals("NQ")) {
		randomtype = "���� ����";
		type_msg = "���� ������ ��� �����ڰ� ������ ����ŭ ���� �ٸ� �������� ����ϴ�.";
	} else if(rst.getId_randomtype().equals("NT")) {
		randomtype = "���� �� ���� ����";
		type_msg = "������ ���� ������ ��� �����ڰ� ������ ����ŭ ���� �ٸ� �������� ����ϴ�.";
	} else if(rst.getId_randomtype().equals("YQ")) {
		randomtype = "�������� => ��������";
		type_msg = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ� ���� �˻��� ���� �׷쿡�� ������ �����ؼ� ���� �ٸ� ������ ������ ����ϴ�.";
	} else if(rst.getId_randomtype().equals("YT")) {
		randomtype = "�������� => ���� �� ���⼯��";
		type_msg = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ� ���� �˻��� ���� �׷쿡�� ������ �����ؼ� �� ������ ���� ������ ��� ���� �ٸ� ������ �� ����ϴ�.";
	}

	// ���������� ������ ������´�.
	ExamPaperOptionBean[] rst2 = null;
	
	try {
		rst2 = ExamPaperOption.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// �ܿ��� ������ ������´�.
	ExamPaperOptionBean[] rst3 = null;
	
	try {
		rst3 = ExamPaperOption.getBeans2(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<HTML>
 <HEAD>
  <TITLE> ���� ���� </TITLE>

 <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
 <script language="JavaScript" type="text/javascript">
    <!--
    function SetScrollPos_Sample(tagDIV)
    {
        var positionTop = 0;
        if (tagDIV != null)
        {
            positionTop = parseInt(tagDIV.scrollTop, 10);
            document.getElementById("SAMPLE_TABLE").style.top = positionTop;
        }
    }

	function guide_write() {
		$.posterPopup("paper_guide_write.jsp?id_exam=<%=id_exam%>","guide_write","width=350, height=250, scrollbars=no");
	}

	function guide_view(nr_q) {
		$.posterPopup("paper_guide_view.jsp?id_exam=<%=id_exam%>&nr_q="+nr_q,"guide_view","width=350, height=250, scrollbars=no");
	}

	//-->

</script>

 </HEAD>

 <BODY id="popup2">
   

   <div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ ���� Ȯ��<span>���� �⺻���� �� ������Ȳ�� Ȯ���Ҽ� �ֽ��ϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">

				<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%" bgcolor="#C2C9D9">
					<tr bgcolor="#FFFFFF" height="30" id="bt2">
						<td align="left"><B>* ���� �⺻ ����</B></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td>
							<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
								<tr id="tr3">
									<td width='20%'>�׸�</td>
									<td width='25%'>��</td>
									<td>����</td>
								</tr>
								<tr>
									<td id="left">&nbsp;�����</td>
									<td><%=rst.getTitle()%></td>
									<td>&nbsp;</td>
								</tr>

								<tr>
									<td id="left">&nbsp;�����ڵ�</td>
									<td><%=rst.getId_exam()%></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td id="left">&nbsp;�����������</td>
									<td><%=rst.getExam_start()%></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td id="left">&nbsp;������������</td>
									<td><%=rst.getExam_end()%></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td id="left">&nbsp;1�������� ������</td>
									<td><%=rst.getQcntperpage()%> ����</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td id="left">&nbsp;������</td>
									<td><%=rst.getQcount()%> ����</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td id="left">&nbsp;����</td>
									<td><%=rst.getAllotting()%> ��</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td id="left">&nbsp;���ѽð�</td>
									<td><%=rst.getLimittime()/60%> ��</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td id="left">&nbsp;������������</td>
									<td><%=randomtype%></td>
									<td>&nbsp;<%=type_msg%></td>
								</tr>
								<tr>
									<td id="left">&nbsp;������ ����</td>
									<td><%=papercnt%> ��</td>
									<td>&nbsp;</td>
								</tr>
							</td>
					</tr>
			</table>

		<br><BR>
	
			<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%" bgcolor="#C2C9D9">
					<tr bgcolor="#FFFFFF" height="30" id="bt2">
						<td align="left"><B>* ���������� ���� ��Ȳ</B></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td>
							<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
								<tr id="tr3">
									<td width='33%'>��������</td>
									<td width='33%'>������</td>
									<td>����</td>
								</tr>
									<% 
										if(rst2 == null) {
									%>
								<tr bgcolor="#FFFFFF" height="45" align="center" id="td">
									<td align="center" colspan="3">������ ������ Ȯ�ΰ����մϴ�.</td>
								</tr>
									<%
										} else {
											for(int i=0; i<rst2.length; i++) { 
									%>
								<tr bgcolor="#FFFFFF" height="25" align="center" id="td">
									<td><%=rst2[i].getId_qtype()%></td>
									<td><%=rst2[i].getQtype_cnt()%> ����</td>
									<td><%=rst2[i].getAllotting2()%> ��</td>
								</tr>
									<% 
											} 
										}
									%>
							</table>
						</td>
					</tr>
				</table>
	

	<br>
	
			<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%" bgcolor="#C2C9D9">
					<tr bgcolor="#FFFFFF" height="30" id="bt2">
						<td align="left"><B>* �ܿ��� ���� ��Ȳ</B></td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td>
							<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
								<tr id="tr3">
									<td width='25%'>�ܿ�</td>
									<td width='25%'>��������</td>
									<td width='25%'>������</td>
									<td width='25%'>����</td>
								</tr>
									<% 
										if(rst3 == null) {
									%>
								<tr bgcolor="#FFFFFF" height="45" align="center" id="td">
									<td align="center" colspan="4">������� �������� ���ų� ������ �������� �ܿ��� ���� ���� �Դϴ�.</td>
								</tr>
									<%
										} else {
											for(int i=0; i<rst3.length; i++) { 
									%>
								<tr bgcolor="#FFFFFF" height="25" align="center" id="td">
									<td><%=rst3[i].getChapter()%></td>
									<td><%=rst3[i].getId_qtype2()%></td>
									<td><%=rst3[i].getQtype_cnt2()%> ����</td>
									<td><%=rst3[i].getAllotting3()%> ��</td>
								</tr>
									<% 
											} 
										}
									%>
							</table>
							</td>
					</tr>
				</table>
	</div>
	
	<div id="button">
	<a href="javascript:window.close();"><img src="../../images/bt5_exit_yj1.gif" border="0"></a>
	</div>
				
 </BODY>
</HTML>
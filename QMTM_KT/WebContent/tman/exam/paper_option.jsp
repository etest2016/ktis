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
  <TITLE> ���� �����ɼ� </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
 <link rel="StyleSheet" href="../../css/style.css" type="text/css">

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
		window.open("paper_guide_write.jsp?id_exam=<%=id_exam%>","guide_write","width=350, height=250, scrollbars=no");
	}

	function guide_view(nr_q) {
		window.open("paper_guide_view.jsp?id_exam=<%=id_exam%>&nr_q="+nr_q,"guide_view","width=350, height=250, scrollbars=no");
	}

	//-->

</script>

 </HEAD>

<BODY id="popup2">
   
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ���� �ɼ� �� ������Ȳ Ȯ��</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		
		<div class="subtitle">���� ���� �ɼ�</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="20%"><li>�����</td>
				<td width="37%"><%=rst.getTitle()%></td>
				<td id="left" width="23%"><li>�����ڵ�</td>
				<td width="20%"><%=rst.getId_exam()%></td>
			</tr>
			<tr>
				<td id="left"><li>��ü ���׼�</td>
				<td><%=rst.getQcount()%> ����</td>
				<td id="left"><li>1�������� ���׼�</td>
				<td><%=rst.getQcntperpage()%> ����</td>
			</tr>
			<tr>
				<td id="left"><li>����</td>
				<td><%=rst.getAllotting()%> ��</td>
				<td id="left"><li>���ѽð�</td>
				<td><%=rst.getLimittime()/60%> ��</td>
			</tr>
			<tr>
				<td id="left"><li>������������</td>
				<td><%=randomtype%></td>
				<td id="left"><li>������ ����</td>
				<td><%=papercnt%> ��</td>
			</tr>
			
		</table>
			
		<br>

		<div class="subtitle">���������� ���� ��Ȳ</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%">
			<tr id="tr">
				<td width='33%'>��������</td>
				<td width='33%'>������</td>
				<td>����</td>
			</tr>
			<% 
				if(rst2 == null) {
			%>
			<tr height="45">
				<td class="blank" colspan="3">������ ������ Ȯ�ΰ����մϴ�.</td>
			</tr>
			<%
				} else {
					for(int i=0; i<rst2.length; i++) { 
			%>
			<tr id="td" align="center">
				<td><%=rst2[i].getId_qtype()%></td>
				<td><%=rst2[i].getQtype_cnt()%> ����</td>
				<td><%=rst2[i].getAllotting2()%> ��</td>
			</tr>
			<% 
					} 
				}
			%>
		</table>
	
		<div class="subtitle">�ܿ��� ���� ��Ȳ</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%">
			
			<tr id="tr">
				<td width='25%'>�ܿ�</td>
				<td width='25%'>��������</td>
				<td width='25%'>������</td>
				<td width='25%'>����</td>
			</tr>
			<% 
				if(rst3 == null) {
			%>
			<tr height="45">
				<td class="blank" colspan="4">������� �������� ���ų� ������ ���׵��� �ܿ��� ���� ���� �Դϴ�.</td>
			</tr>
				<%
					} else {
						for(int i=0; i<rst3.length; i++) { 
				%>
			<tr id="td" align="center">
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
	</div>

	<div id="button">
		<img src="../../images/bt5_exit_yj1_11.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: hand;">
	</div>

	</form>

</BODY>
</HTML>
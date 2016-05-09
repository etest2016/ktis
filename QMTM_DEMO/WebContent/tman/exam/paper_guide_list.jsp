<%
//******************************************************************************
//   ���α׷� : paper_guide_list.jsp
//   �� �� �� : ���� �ȳ��� ����Ʈ
//   ��    �� : �ش� ������� ���� �ȳ��� ����Ʈ
//   �� �� �� : exam_m, exam_paper_guide
//   �ڹ����� : qmtm.tman.exam.ExamPaperGuide, ExamPaperGuideBean
//   �� �� �� : 2008-05-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, java.sql.*" %>

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

	// �ش� ���迡 �����ȳ����� ������´�.
	ExamPaperGuideBean[] rst = null;
	
	try {
		rst = ExamPaperGuide.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<HTML>
 <HEAD>
  <TITLE> ���� �ȳ��� </TITLE>
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
		window.open("paper_guide_write.jsp?id_exam=<%=id_exam%>","guide_write","width=350, height=260, scrollbars=no");
	}

	function guide_view(nr_q) {
		window.open("paper_guide_view.jsp?id_exam=<%=id_exam%>&nr_q="+nr_q,"guide_view","width=350, height=260, scrollbars=no");
	}

	//-->

</script>

 </HEAD>

 <BODY id="popup2">
	
	  <div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� �ȳ������� <span>�����ȳ��� ����Ȯ�� �� ���</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents" style="text-align: center;">


		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%">
			<tr id="bt2"><td colspan="2"><a href="javascript:guide_write();"><img src="../../../images/bt_paper_guide_wyj1.gif"></a></td></tr>
			<tr id="tr">
				<td width="20%">�������۹�ȣ</td>
				<td>���ù� ����</td>	
			</tr>
			<%
				if(rst == null) {
			%>
			<tr>
				<td class="blank" colspan="6">��ϵ� �����ȳ����� �����ϴ�.</td>
			</tr>
			<%
				} else {
					for(int i=0; i<rst.length; i++) {
			%>
			<tr id="td" align="center">
				<td><a href="javascript:guide_view('<%=rst[i].getNr_q()%>');"><%=rst[i].getNr_q()%></a></td>
				<td align="center">
					<table width="95%" border="0" bgcolor="#CCCCCC" cellspacing="0" cellpadding="0" style="border-top: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC;  border-left: 1px solid #CCCCCC;">
						<tr bgcolor="#FFFFFF">
							<td><%=rst[i].getGuide_msg()%></td>
						</tr>
					</table>
				</td>
			</tr>
			<%
					}
				}
			%>
		</table>
	</div>
	
	<div id="button">
		<img src="../../../images/bt_close_1.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: hand;">
	</div>
		
 </BODY>
</HTML>
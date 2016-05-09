<%
//******************************************************************************
//   ���α׷� : p_main.jsp
//   �� �� �� : ������ ���� Main ������
//   ��    �� : ������ ���� Main ������
//   �� �� �� : exam_m, q, exam_paper2
//   �ڹ����� : qmtm.tman.exam.ExamUtil
//   �� �� �� : 2008-04-21
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.common.ExamPaper, qmtm.common.ExamPaperBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	int nr_sets = Integer.parseInt(nr_set);

	// ������ ������ ������´�.
	ExamPaperBean[] rst = null;

    try {
	    rst = ExamPaper.getBeans(id_exam, nr_sets);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<HTML>
<HEAD>
<TITLE> ��������Ʈ </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<style>
	
	body { margin: 0px; padding: 0px 20px 20px 20px; 
		scrollbar-face-color:#FFFFFF; 
		scrollbar-shadow-color:#CCC;
		scrollbar-highlight-color: #CCC;
		scrollbar-3dlight-color: #FFFFFF;
		scrollbar-darkshadow-color: #FFFFFF;
		scrollbar-track-color: #FFFFFF;
		scrollbar-arrow-color: #CCC; 
	}
	body, table, tr, td, div { font: 12px; color: #666666; }
	a:link { text-decoration: none; color: #FFFFFF; font-weight: bold; font-size: 12px; }
	a:visited { text-decoration: none; color: #FFFFFF; font-weight: bold; font-size: 12px; }
	a:active { text-decoration: none; font-size: 12px; }
	a:hover { color: #FFFFFF; text-decoration: underline; font-weight: bold; font-size: 12px;  }

</style>

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

	function parent_reload() {
		top.opener.location.reload();
	}

//-->
</script>

</HEAD>

<BODY >

	<div class="F2"><%=nr_set%>�� ������</div>

			
	<div id="SAMPLE_DIV" style="width: 100%; height: 100%; margin-top: 7px; " onScroll="SetScrollPos_Sample(this);">
			
		<table border='0' cellpadding='0' cellspacing='0'>
			<tr>
				<td width="50"><img src="../../images/mpaper_table1.gif"></td>
				<td width="60"><img src="../../images/mpaper_table2.gif"></td>
				<td width="95"><img src="../../images/mpaper_table3.gif"></td>
				<td width="115"><img src="../../images/mpaper_table4.gif"></td>
				<td width="70"><img src="../../images/mpaper_table5.gif"></td>
				<td width="50"><img src="../../images/mpaper_table6.gif"></td>
				<td width="100"><img src="../../images/mpaper_table7.gif"></td>
				<td width="50"><img src="../../images/mpaper_table8.gif"></td>
				<td width="40"><img src="../../images/mpaper_table9.gif"></td>
				<td width="80"><img src="../../images/mpaper_table10.gif"></td>
			</tr>
		</table>

		<div style="overflow-y: scroll; height: 476px; text-align: left; width: 708px;">

			<%
				if(rst == null) {
			%>
		
			<div style="width: 100%; text-align:center;"><br><br><p>������� �������� �����ϴ�.</p><br></div>

			<%	
				} else {
					String qtypes = "";
					String diffs = "";
					for(int i=0; i<rst.length; i++) {
						if(rst[i].getId_qtype() == 1) {
							qtypes = "<img src='../../images/qlistD.gif'>"; //OX��
						} else if(rst[i].getId_qtype() == 2) {
							qtypes = "<img src='../../images/qlistC.gif'>"; //������
						} else if(rst[i].getId_qtype() == 3) {
							qtypes = "<img src='../../images/qlistB.gif'>"; //���� �����
						} else if(rst[i].getId_qtype() == 4) {
							qtypes = "<img src='../../images/qlistA.gif'>"; //�ܴ���
						} else if(rst[i].getId_qtype() == 5) {
							qtypes = "<img src='../../images/qlistE.gif'>"; //�����
						}

						if(rst[i].getId_difficulty1() == 0) {
							diffs = "����";
						} else if(rst[i].getId_difficulty1() == 1) {
							diffs = "�ֻ�";
						} else if(rst[i].getId_difficulty1() == 2) {
							diffs = "��";
						} else if(rst[i].getId_difficulty1() == 3) {
							diffs = "��";
						} else if(rst[i].getId_difficulty1() == 4) {
							diffs = "��";
						} else if(rst[i].getId_difficulty1() == 5) {
							diffs = "����";
						}
			%>
				<table border='0' cellpadding='0' cellspacing='0'>
					<tr height="25" align="center" <% if (i%2==1) { %>bgcolor="#fafafa" <%}%>>
						<td style="border-bottom: 1px solid #d8d8d8;" width="50"><%=rst[i].getNr_q()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="60"><%=rst[i].getId_q()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="95"><%=qtypes%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="115"><%=rst[i].getId_ref()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="70"><%if(rst[i].getEx_order() == null || rst[i].getEx_order().equals("")) { %>&nbsp;<% } else { %><%=rst[i].getEx_order()%><% } %></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="50"><%=rst[i].getCacount()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="100"><%if(rst[i].getCa() == null || rst[i].getCa().equals("")) { %>&nbsp;<% } else { %><%=rst[i].getCa().replace("{|}",",").replace("{^}","�Ǵ�")%><% } %></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="50"><%=diffs%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="40"><%=rst[i].getAllotting()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="60"><%=rst[i].getPage()%></td>
					</tr>
				</table>
			
			<%
					}
				}
			%>
		</div>
		
	</div>		

</BODY>
</HTML>

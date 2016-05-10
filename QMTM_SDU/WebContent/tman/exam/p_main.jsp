<%
//******************************************************************************
//   프로그램 : p_main.jsp
//   모 듈 명 : 시험지 생성 Main 프레임
//   설    명 : 시험지 생성 Main 프레임
//   테 이 블 : exam_m, q, exam_paper2
//   자바파일 : qmtm.tman.exam.ExamUtil
//   작 성 일 : 2008-04-21
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.common.ExamPaper, qmtm.common.ExamPaperBean" %>
<%@ include file = "/common/login_chk.jsp" %>
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

	// 시험지 정보를 가지고온다.
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
<TITLE> 문제리스트 </TITLE>
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
	a:link { text-decoration: underline; color: #0189c0; font-weight: bold; font-size: 12px; }
	a:visited { text-decoration: none; color: #0189c0; font-weight: bold; font-size: 12px; }
	a:active { text-decoration: none; font-size: 12px; }
	a:hover { color: #0189c0; text-decoration: underline; font-weight: bold; font-size: 12px;  }

</style>
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

	function parent_reload() {
		top.opener.location.reload();
	}

	function q_change(id_q) {
	    $.posterPopup("q_change.jsp?id_exam=<%=id_exam%>&id_qs="+id_q,"q_change","width=1100, height=640, scrollbars=yes, top="+(screen.height-640)/2+", left="+(screen.width-1100)/2);
	}

//-->
</script>

</HEAD>

<BODY >

	<div class="F2"><%=nr_set%>번 시험지&nbsp;&nbsp;<font color=red><b>(문제코드를 클릭하면 해당 문제 교체작업을 할 수 있습니다.)</b></font></div>
			
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
		
			<div style="width: 100%; text-align:center;"><br><br><p>만들어진 시험지가 없습니다.</p><br></div>

			<%	
				} else {
					String qtypes = "";
					String diffs = "";
					for(int i=0; i<rst.length; i++) {
						if(rst[i].getId_qtype() == 1) {
							qtypes = "<img src='../../images/qlistD.gif'>"; //OX형
						} else if(rst[i].getId_qtype() == 2) {
							qtypes = "<img src='../../images/qlistC.gif'>"; //선다형
						} else if(rst[i].getId_qtype() == 3) {
							qtypes = "<img src='../../images/qlistB.gif'>"; //복수 답안형
						} else if(rst[i].getId_qtype() == 4) {
							qtypes = "<img src='../../images/qlistA.gif'>"; //단답형
						} else if(rst[i].getId_qtype() == 5) {
							if(rst[i].getYn_practice().equals("Y")) {
								qtypes = "실기형"; //실기형
							} else {
								qtypes = "<img src='../../images/qlistE.gif'>"; //논술형
							}
						}

						if(rst[i].getId_difficulty1() == 0) {
							diffs = "없음";
						} else if(rst[i].getId_difficulty1() == 1) {
							diffs = "최상";
						} else if(rst[i].getId_difficulty1() == 2) {
							diffs = "상";
						} else if(rst[i].getId_difficulty1() == 3) {
							diffs = "중";
						} else if(rst[i].getId_difficulty1() == 4) {
							diffs = "하";
						} else if(rst[i].getId_difficulty1() == 5) {
							diffs = "최하";
						}
			%>
				<table border='0' cellpadding='0' cellspacing='0'>
					<tr height="25" align="center" <% if (i%2==1) { %>bgcolor="#fafafa" <%}%>>
						<td style="border-bottom: 1px solid #d8d8d8;" width="50"><%=rst[i].getNr_q()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="60"><a href="javascript:" onClick="q_change(<%=rst[i].getId_q()%>);"><%=rst[i].getId_q()%></a></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="95"><%=qtypes%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="115"><%=rst[i].getId_ref()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="70"><%if(rst[i].getEx_order() == null || rst[i].getEx_order().equals("")) { %>&nbsp;<% } else { %><%=rst[i].getEx_order()%><% } %></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="50"><%=rst[i].getCacount()%></td>
						<td style="border-bottom: 1px solid #d8d8d8;" width="100"><%if(rst[i].getCa() == null || rst[i].getCa().equals("")) { %>&nbsp;<% } else { %><%=rst[i].getCa().replace("{|}",",").replace("{^}","또는")%><% } %></td>
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

<%
//******************************************************************************
//   프로그램 : q_list_group.jsp
//   모 듈 명 : 성적통계 관리 
//   설    명 : 성적통계 관리
//   테 이 블 : 
//   자바파일 : qmtm.tman.statics.StaticQBean, qmtm.tman.statics.StaticQ
//   작 성 일 : 2008-06-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.statics.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	java.text.DecimalFormat df = new java.text.DecimalFormat(",##0.00"); 
%>

<script language="javascript">
	function q_list(id_q) {
		document.q_list.location.href= "q_list.jsp?id_exam=<%=id_exam%>&id_q="+id_q;
		document.q_list2.location.href= "q_list2.jsp?id_exam=<%=id_exam%>&id_q="+id_q;
	}
</script>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<%
	StaticQBean[] scoreQ = null;

	try {
		scoreQ = StaticQ.getQList(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

%>
	<table width="100%" border="0" >
		<tr>
			<td height="400" valign="top" rowspan="2" width="60%">
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC" width="100%" id="tableA">
		<tr height="30" bgcolor="#FFFFFF" id="tr3">
			<td align="center" bgcolor="#D9D9D9">문제코드</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">문제유형</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">보기수</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">정답수</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">정답률</td>
			<td align="center" width="8%" bgcolor="#D9D9D9">합계</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">O</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">X</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">①</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">②</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">③</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">④</td>
			<td align="center" width="5%" bgcolor="#D9D9D9">⑤</td>
		</tr>
		
		<% if(scoreQ == null) { %>

		<tr bgcolor="#FFFFFF" height="35" id="td">
			<td colspan="13" align="center">성적통계를 돌리셔야 확인할 수 있습니다.</td>
		</tr>

		<%
			} else {
				double o_rate_res = 0.0;
				for(int q = 0; q < scoreQ.length; q++) {
					int all_cnt = 1;
					
					if(scoreQ[q].getAll_sum() == 0) {
						all_cnt = 1;
					} else {
						all_cnt = scoreQ[q].getAll_sum();
					}

					double o_rate = 0.0;
					
					o_rate_res = (Double.parseDouble(String.valueOf(scoreQ[q].getO_cnt())) / Double.parseDouble(String.valueOf(all_cnt))) * 100;

		%>
		<tr bgcolor="#FFFFFF" height="25" id="td">
			<td align="center"><a href="javascript:q_list(<%=scoreQ[q].getId_q()%>);"><%=scoreQ[q].getId_q()%></a></td>
			<td align="center"><%=scoreQ[q].getQtype()%></td>
			<td align="center"><%=scoreQ[q].getExcount()%></td>
			<td align="center"><%=scoreQ[q].getCacount()%></td>
			<td align="center"><%=df.format(o_rate_res)%></td>
			<td align="center"><%=scoreQ[q].getAll_sum()%></td>
			<td align="center"><%=scoreQ[q].getO_cnt()%></td>
			<td align="center"><%=scoreQ[q].getX_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx1_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx2_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx3_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx4_cnt()%></td>
			<td align="center"><%=scoreQ[q].getEx5_cnt()%></td>
		</tr>
		<%
				}
			}
		%>
	</table>
	</td>
	<td valign="top" width="40%">
	<% if(scoreQ == null) { %>
	&nbsp;
	<% } else { %>
	<table border="0" width="95%" align="center">
	<tr>
		<td>
	<iframe src="q_list.jsp?id_exam=<%=id_exam%>&id_q=<%=scoreQ[0].getId_q()%>" frameborder="0" name="q_list" width="100%" height="350"  marginwidth="0" marginheight="0" scrolling="auto">
			</iframe><td>
		</tr>
		<tr>
			<td valign="top">
			<iframe src="q_list2.jsp?id_exam=<%=id_exam%>&id_q=<%=scoreQ[0].getId_q()%>" frameborder="0" name="q_list2" width="100%" height="350"  marginwidth="0" marginheight="0" scrolling="auto">
			</iframe>
			</td>
		</tr>
	</table>
	<% } %>
	</td>
	</tr>
	</table>
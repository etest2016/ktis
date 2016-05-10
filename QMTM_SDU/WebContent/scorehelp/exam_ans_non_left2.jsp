<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String kwd_rate = request.getParameter("kwd_rate");
	if (kwd_rate == null) { kwd_rate= ""; } else { kwd_rate = kwd_rate.trim(); }


	Score_EqualMarkingBean mBean = null;

	try {
		mBean = Score_EqualMarking.getCompResult(id_exam, Integer.parseInt(id_q), userid, "Y");
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());
		if(true) return;
	}
%>

<html>
<head>
<title>모사답안 비교</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">

<script language="JavaScript">
	
</script>

</head>

<table border="0" width="100%" cellpadding="5">
	<tr>
	<td align="center">
<table width='100%' bgcolor="#FFFFFF">
	<tr>
		<td><font color="#336600"><B>■</font> 모사판정 근거 답안리스트</B></td>
	</tr>
</table>
<table border='0' cellspacing='1' cellpadding='3' width='100%' bgcolor='#FFFFFF'>
  <tr align="center" bgcolor='#95DB95' height="35">    
    <td width=5%><B>NO</B></td>      
	<td width=45%><B>응시자</B></td>      
	<td width=50%><B>모사율</B></td>    
  </tr>

 <%
	if (mBean == null) {
%>

  <tr bgcolor="#FFFFFF">
	<td colspan="2" align="center">응시자 데이타가 없습니다.</td>
  </tr>	

<%
	} else {
		String t_userid = mBean.getT_userid();
		String o_t_comp_rate = mBean.getO_t_res_rate();
		String t_o_comp_rate = mBean.getT_o_res_rate();
		String equal_ans_list = mBean.getEqual_ans();

		String[] arrUser = t_userid.split(QmTm.OR_GUBUN_re, -1);
		String[] arrData1 = o_t_comp_rate.split(QmTm.OR_GUBUN_re, -1);
		String[] arrData2 = t_o_comp_rate.split(QmTm.OR_GUBUN_re, -1);
		String[] arrEqual = equal_ans_list.split(QmTm.OR_GUBUN_re, -1);
		
		String search_pos = "";
		String search1 = "";
		String search2 = "";

		int i = 0, j = 0;

		for(i=0; i<arrEqual.length; i++) {
			for(j=0; j<arrUser.length; j++) {
				if(arrEqual[i].equals(arrUser[j])) {
					search_pos = search_pos + Integer.toString(j) + "{^}";
					break;
				}
			}
		}

		if (search_pos.length() > 0) {
			search_pos = search_pos.substring(0, search_pos.length() -3);
			String[] arrPos = search_pos.split(QmTm.LIKE_GUBUN_re, -1);
			for (i=0; i<arrPos.length; i++) {
%>

  <tr align="center" height="25">    
    <td><b><%= (i+1) %></b></td>
	<td><B><%= arrUser[Integer.parseInt(arrPos[i])] %></B></td>  
    <td><B>
		<a href="exam_ans_non_main2.jsp?bigo=1&id_exam=<%=id_exam%>&id_q=<%=id_q%>&o_userid=<%=userid%>&t_userid=<%= arrUser[Integer.parseInt(arrPos[i])] %>
		&equal_rate=<%= arrData1[Integer.parseInt(arrPos[i])] %>" target="main"><%= arrData1[Integer.parseInt(arrPos[i])] %> %</a>, 
		<a href="exam_ans_non_main2.jsp?bigo=2&id_exam=<%=id_exam%>&id_q=<%=id_q%>&o_userid=<%= arrUser[Integer.parseInt(arrPos[i])] %>&t_userid=<%=userid%>
		&equal_rate=<%= arrData2[Integer.parseInt(arrPos[i])] %>" target="main"><%= arrData2[Integer.parseInt(arrPos[i])] %> %</a></B></td>
  </tr>
 
  <tr bgcolor="#DBDBDB">
	<td colspan="3"></td>
  </tr>	
<%
			}
		}
	}
%>
</table>

</td>
</tr>
</table>
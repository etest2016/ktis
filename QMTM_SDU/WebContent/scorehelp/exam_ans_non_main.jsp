<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*, java.util.*, java.util.regex.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }


	String o_userid = request.getParameter("o_userid");
	if (o_userid == null) { o_userid= ""; } else { o_userid = o_userid.trim(); }


	String t_userid = request.getParameter("t_userid");
	if (t_userid == null) { t_userid= ""; } else { t_userid = t_userid.trim(); }


	String equal_rate = request.getParameter("equal_rate");
	if (equal_rate == null) { equal_rate= ""; } else { equal_rate = equal_rate.trim(); }


	String bigo = request.getParameter("bigo");
	if (bigo == null) { bigo= ""; } else { bigo = bigo.trim(); }
%>
<html>
<head>
<title>답안비교결과화면</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
</head>

<body style="margin: 0px 20px 20px 5px;">

	<%
		if (bigo == "") {
	%>
	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center">왼쪽 응시자 리스트에서 답안비교할 모사율을 클릭하세요.</td>
		</tr>
	</table>
	<%
		} else {
			Score_EqualMarkingBean mBean = null;

			try {
				mBean = Score_EqualMarking.getAns(id_exam, Integer.parseInt(id_q), o_userid);
			} catch(Exception ex) {
				//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
				out.println(ex.getMessage());
				if(true) return;
			}

			String o_ans = "";
			String o_end_time = "";

			o_ans = mBean.getUserans();
			o_end_time = mBean.getEnd_time();

			o_ans = o_ans.replace(")", "");
			o_ans = o_ans.replace("(", "");
			o_ans = o_ans.replace(",", "");
			o_ans = o_ans.replace(".", "");
			o_ans = o_ans.replace("*", "");
			o_ans = o_ans.replace("[", "");
			o_ans = o_ans.replace("|", "");
			o_ans = o_ans.replace("\r\n", " ");

			String[] arrO_ans = o_ans.split(" ");

			Score_EqualMarkingBean mBean2 = null;

			try {
				mBean2 = Score_EqualMarking.getAns(id_exam, Integer.parseInt(id_q), t_userid);
			} catch(Exception ex) {
				//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
				out.println(ex.getMessage());
				if(true) return;
			}

			String t_ans = "";
			String t_end_time = "";

			t_ans = mBean2.getUserans();
			t_end_time = mBean2.getEnd_time();

			t_ans = t_ans.replace(")", "");
			t_ans = t_ans.replace("(", "");
			t_ans = t_ans.replace(",", "");
			t_ans = t_ans.replace(".", "");
			t_ans = t_ans.replace("*", "");
			t_ans = t_ans.replace("[", "");
			t_ans = t_ans.replace("|", "");
			t_ans = t_ans.replace("\r\n", " ");

			String[] arrT_ans = t_ans.split(" ");

			int p = 0, q = 0;
			String aPos = "";
			String bPos = "";
			String sPos = "";
			String[] arrResult = new String[arrT_ans.length];

			Pattern pt = null;
			Matcher mt = null;

			//응시자의 답안 하이라이트 처리
			for (p=0; p<arrO_ans.length; p++) {
				aPos = "";

				pt = Pattern.compile(arrO_ans[p]);

				if (arrO_ans[p].trim().length() > 0) {
					for(q=0; q < arrT_ans.length; q++) {
						mt = pt.matcher(arrT_ans[q]);
						if(mt.find()) {
							arrResult[q] = "<font color=red>" + arrT_ans[q] + "</font>";
							sPos = sPos + Integer.toString(q) + ",";
							
							//응시자의 답안과 일치하는 검색어의 위치를 기억한다.
							if (aPos != Integer.toString(p)) {
								bPos = bPos + Integer.toString(p) + ",";
								aPos = Integer.toString(p);
							}
						}
					}
				}
			}

			String sResultAns = "";

			if (sPos != "") {
				sPos = sPos.substring(0, sPos.length()-1);
				String[] arrPos = sPos.split(",");

				int iPos = 0;
				for (p=0; p<arrPos.length; p++) {
					iPos = Integer.parseInt(arrPos[p]);
					arrT_ans[iPos] = arrResult[iPos];
				}
			}

			for (p=0; p<arrT_ans.length; p++) {
				sResultAns = sResultAns + arrT_ans[p] + " ";
			}


			String SearchCa = "";

			if (Double.parseDouble(equal_rate) >= 100) {
				SearchCa = "<font color=blue>" + o_ans + "</font>";
			} else if (bPos != "") {
				//모범답안 하이라이트 처리
				bPos = bPos.substring(0, bPos.length()-1);
				String[] arrPosCa = bPos.split(",");

				int iPos = 0;
				for (p=0; p<arrPosCa.length; p++) {
					iPos = Integer.parseInt(arrPosCa[p]);
					arrO_ans[iPos] = "<font color=blue>" + arrO_ans[iPos] + "</font>";
				}

				for (p=0; p<arrO_ans.length; p++) {
					SearchCa = SearchCa + arrO_ans[p] + " ";
				}
			} else {
				SearchCa = o_ans;
			}
	%>

	<form name="forms"> 

	<div class="title">답안비교 결과</div>

	
	<table border='0' width='100%'>
		<tr>
			<td align="right">
			<% if (Integer.parseInt(bigo) == 1) { %>
				<input type="checkbox" name="t_userid" value="<%=t_userid%>" onClick="window.parent.tops.change(this.value, this.name)"> 모사근거답안으로 판정
			<% } %>
			&nbsp;&nbsp;<font color="green"><B>모사율 : <%=equal_rate%> %</B></td>
		</tr>
	</table>
	<table border='0' cellspacing='0' cellpadding='3' width='100%' id="tableD">
	  <tr height="25">    
		<td width="20%" align="right" id="left"><B>원본 응시자</B>&nbsp;</td>      
		<td width="30%" align="left" bgcolor="#FFFFFF">&nbsp;<B><%=o_userid%></B></td>      
		<td width="20%" align="right" id="left"><B>비교 응시자</B>&nbsp;</td>      
		<td width="30%" align="left" bgcolor="#FFFFFF">&nbsp;<B><%=t_userid%></B></td>      
	  </tr>

	  <tr height="25">    
		<td width="20%" align="right" id="left"><B>답안길이</B>&nbsp;</td>      
		<td width="30%" align="left" bgcolor="#FFFFFF">&nbsp;<B><%= o_ans.length() %> Len</B></td>      
		<td width="20%" align="right" id="left"><B>답안길이</B>&nbsp;</td>      
		<td width="30%" align="left" bgcolor="#FFFFFF">&nbsp;<B><%= t_ans.length() %> Len</B></td>      
	  </tr>

	  <tr height="25">    
		<td width="20%" align="right" id="left"><B>답안저장시간</B>&nbsp;</td>      
		<td width="30%" align="left" bgcolor="#FFFFFF">&nbsp;<B><%= o_end_time %></B></td>      
		<td width="20%" align="right" id="left"><B>답안저장시간</B>&nbsp;</td>      
		<td width="30%" align="left" bgcolor="#FFFFFF">&nbsp;<B><%= t_end_time %></B></td>      
	  </tr>

	  <tr>    
		<td width="45%" bgcolor="#FFFFFF" colspan="2" valign="top"><br><%= SearchCa %><br>&nbsp;</td>  
		<td width="45%" bgcolor="#FFFFFF" colspan="2" valign="top"><br><%= sResultAns %><br>&nbsp;</td>  
	  </tr>
	</table>

	</form>
	<%
		}
	%>

</body>
</html>

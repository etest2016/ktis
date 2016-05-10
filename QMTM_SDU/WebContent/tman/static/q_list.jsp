<%
//******************************************************************************
//   프로그램 : q_list.jsp
//   모 듈 명 : 성적통계 관리 
//   설    명 : 성적통계 관리
//   테 이 블 : 
//   자바파일 : qmtm.tman.exam.QunitBean, qmtm.tman.exam.Qunit
//   작 성 일 : 2008-06-09
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 :  
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}	
	
%>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<%
	QunitBean qbean = null;
	
	try {
		qbean = Qunit.getBean(Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	int cacount = qbean.getCacount();
	int id_qtype = qbean.getId_qtype();
	int[] arrEx_order = qbean.getArrEx_order();
	String ans = qbean.getCa();
	boolean arrHasEx = true;

	String exlabel = "①,②,③,④,⑤,⑥,⑦,⑧,";

	String[] arrEx = new String[8];

	String[] arrExlabel = exlabel.split(",");

	if (id_qtype <= 3) {
		arrHasEx = true;
	  } else {
		arrHasEx = false;
	  }
	  
	int arrExcount = qbean.getExcount();

	for (int j = 0; j < arrExcount; j++) {
		arrEx[j] = arrExlabel[j] + " " + QmTm.delTag(qbean.getArrEx()[j]);
	}
%>

<table border="0" width="100%" style="border-top:1px solid #86d2f6; border-bottom:1px solid #86d2f6;">
	<tr>
		<td align="center">
			<table border="0" width="90%">
				<tr>
					<td valign="top"><%=id_q%>.</td>
					<td align="left"> <%=qbean.getQ()%></td>
				</tr>
				<tr>
					<td height="10" colspan="2"></td>
				</tr>
				<!-- 보기 -->
				<% if (arrHasEx) { %>
				<% if(arrExcount == 2) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<% } else if(arrExcount == 3) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
			    <% } else if(arrExcount == 4) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<% } else if(arrExcount == 5) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<% } else if(arrExcount == 6) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[5]%>&nbsp;&nbsp;<%= qbean.getEx6() %></td>
				</tr>
				<% } else if(arrExcount == 7) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[5]%>&nbsp;&nbsp;<%= qbean.getEx6() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[6]%>&nbsp;&nbsp;<%= qbean.getEx7() %></td>
				</tr>
				<% } else if(arrExcount == 8) { %>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[0]%>&nbsp;&nbsp;<%= qbean.getEx1() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[1]%>&nbsp;&nbsp;<%= qbean.getEx2() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[2]%>&nbsp;&nbsp;<%= qbean.getEx3() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[3]%>&nbsp;&nbsp;<%= qbean.getEx4() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[4]%>&nbsp;&nbsp;<%= qbean.getEx5() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[5]%>&nbsp;&nbsp;<%= qbean.getEx6() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[6]%>&nbsp;&nbsp;<%= qbean.getEx7() %></td>
				</tr>
				<tr>
					<td align="center" width="2%" valign="top">&nbsp;</td>
		            <td valign="top"><%=arrExlabel[7]%>&nbsp;&nbsp;<%= qbean.getEx8() %></td>
				</tr>
				<% } %>
				<% } %>
				<tr>
					<td height="10" colspan="2"></td>
				</tr>
				<tr>
					<td width="2%"></td>
					<td>
					<% if(id_qtype == 3 || id_qtype == 4) { %>
						정답 : <%=ans.replace("{|}",", ").replace("{^}"," 또는 ")%>
					<% } else { %>
						정답 : <%=ans %>
					<% } %>
					</td>
				</tr>

			</table>
		</td>
	</tr>
</table>
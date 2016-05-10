<%@page contentType="text/html; charset=EUC-KR" %>
<%@page import="qmtm.QmTm, etest.scorehelp.*, java.sql.*"%>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	String id_num = request.getParameter("id_q");

	if (id_num == null || id_num == "") {
		response.sendRedirect("/error/page_error.jsp");
		if(true) return ;	
	}

	int id_q = Integer.parseInt(id_num);
	String kwd_ans = request.getParameter("kwd_ans");

	if (kwd_ans == null) {
		kwd_ans = "";
	}

	String sPg = request.getParameter("Page");
	if (sPg == null || sPg == "" || sPg == "0") {
		sPg = "1";
	}
	int iPage = Integer.parseInt(sPg);

	int TotRecord = 0;
	int TotPage = 0;
	int pgSize = 7;
	int segment = 0;


	Score_DanAnsBean2 bean = null;
	try {
		bean = Score_DanAns2.getQ(id_exam, id_q);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println("0." + ex.getMessage());
		if(true) return;
	}

	String q = bean.getQ();
	double allotting = bean.getAllotting();
	String ca = bean.getCa();
	TotRecord = bean.getUsercount();

	ca = ca.replace(QmTm.LIKE_GUBUN, " 또는 ");
	ca = ca.replace(QmTm.OR_GUBUN, ", ");

	Score_DanAnsBean2[] rst;
	try {
		rst = Score_DanAns2.userAns(id_exam, id_q, kwd_ans, iPage, pgSize, "N");
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println("1." + ex.getMessage());
		if(true) return;
	}

	segment = TotRecord % pgSize;
	if (segment > 0) {
		TotPage = (TotRecord - segment) / pgSize + 1;
	} else {
		TotPage = TotRecord / pgSize;
	}
%>	

<html>
<head>
<title>단답형 문제 웹채점</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">

<script language="JavaScript">
	function score_comp() {
		var frm = document.form1;

		if(frm.score_bigos.checked == false) {
			alert("단답형 채점 방식을 선택하셔야 합니다.");
			return;
		} else {			
				frm.submit();
		}
	}

	function chkBox(bool) { // 전체선택/해제 
	    var obj = document.getElementsByName("ichecks"); 
		for (var i=0; i<obj.length; i++) obj[i].checked = bool;  
	} 

	function ans_tot_score(bigo) {
		var frm = document.form3;
		if (bigo == "0")
		{
			frm.tot_score.value = 0;			
		} else if(bigo == "1") {
			frm.tot_score.value = <%=allotting%>;			
		} else {
			var k = 0;
			var obj = document.getElementsByName("ichecks");
			for (var i=0; i<obj.length; i++)
			{
				if(obj[i].checked == true) {
					k = k + 1;
				} 
			}			
			// 채점대상 응시자 체크 유무...
			if (k == 0 ) {
				alert("채점할 오답 그룹을 선택하세요.");
				return;
			} else if (frm.tot_score.value == "")
			{
				alert("점수를 입력하세요.");
				frm.tot_score.focus();				
				return;
			} else if(frm.tot_score.value > <%=allotting%>)  {
				alert("부분점수가 배점보다 높게 입력되었습니다.");
				frm.tot_score.value = "";
				frm.tot_score.focus();
				return;
			} else if(frm.tot_score.value < 0)  {
				alert("부분점수는 0점보다 높게 입력해야 합니다..");
				frm.tot_score.value = "";
				frm.tot_score.focus();
				return;
			} else {
				frm.submit();
			}
		}
	}

	function kew_search() {
		frm = document.form2;

		if(frm.kwd_ans.value == "") {
			alert("키워드를 입력하세요.");
			frm.kwd_ans.focus();
		} else {
			frm.submit();
		}
	}
</script>
</head>

<!--<body oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">-->
<body>
<!-- 타이틀 디자인 -->
<div style="width: 100%; height: 70px; background-image: url(../images/bg.gif); text-align: right;">
	<img src="../images/bt_re.gif" onclick="javascript:window.location.reload();" style="cursor: pointer;"><img src="../images/bt_out.gif" style="cursor: pointer;" onclick="javascript:window.close()">
</div>
<!-- 단답형 문제 웹채점 -->
<div style="width: 100%; margin: 0px 30px 0px 30px;">
	<img src="../images/title_ad_webscore.gif">
</div>
<!-- 본문 -->
<div style="width: 100%; margin: 30px 40px 40px 40px;">
	
	<!-- 문제 정보 -->
	<img src="../images/sub2_webscore1.gif"><br>
	<div class="box">	
	[문제코드 <b><%= id_q %></b>] <%= q %> [배점 <B><%= allotting%>점</B>]<br>[정답] <font class="point"><%= ca %>	</font>
	</div>
	<hr>
	<img src="../images/sub2_webscore3.gif">
	<form name="form2" method="post" action="">
		<input type="hidden" name="id_exam" value="<%=id_exam%>">
		<input type="hidden" name="id_q" value="<%=id_q%>">		
	<TABLE width="100%" cellpadding="0" cellspacing="0" border="0">
		<TR>
			<td width="85">:: 키워드 검색</td>
			<TD>
				<% if(kwd_ans != "") { %>
					<a href="exam_ans_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>">[전체 리스트 보기]</a>&nbsp;&nbsp;검색한키워드 : <font color="red"><b><%=kwd_ans%></b></font><br>
				<% } %>
				<input type="text" name="kwd_ans" size="15">&nbsp;&nbsp;<img type="button" value="검색하기" onClick="kew_search()" src="../images/bt3_search.gif" style="cursor: pointer;">&nbsp;<img src="../images/bt3_webscore1.gif" onclick="location.href('exam_ans_score_end.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>');" style="cursor: pointer;">
			</TD>
			<TD align="right">총 <font color='red'><%=TotRecord%></font> 개의 오답리스트가 존재합니다.</TD>
		</TR>
	</TABLE>
	</form>
	

	<table border="0" cellspacing="0" cellpadding="0" class="Btype" style="margin-top: 10px; margin-bottom: 10px;">
		<tr class="title">    
			<form name="form3" method="post" action="score_tot_U2.jsp">
				<input type="hidden" name="id_exam" value="<%=id_exam%>">
				<input type="hidden" name="id_q" value="<%=id_q%>">
			<td width="20"><INPUT type=checkbox onclick="chkBox(this.checked)"></td>
			<td>NO</td>
			<td>제출답안</td>
			<td>제출자수</td>
		</tr>	  
	<%
		if (rst == null) {
	%>
		<tr>  
			<td colspan="4" class="blank">단답형 문제 미채점자가 없습니다.</td>
		</tr>
	<%
		}
		else {
			String answer = "";
			int newno = 0;
			newno = TotRecord;
			newno = newno - (pgSize * (iPage-1));

			for(int i=0; i<rst.length; i++) { 
				answer = rst[i].getAnswer().replace(QmTm.LIKE_GUBUN, " 또는 ");
				answer = answer.replace(QmTm.OR_GUBUN, ", ");
				answer = answer.replace("\"", "&#34;");
	%>
		<tr>
			<td><input type="checkbox" name="ichecks" value="<%= answer %>"></td>
			<td><%= newno %></td>
			<% if (answer.trim().length() == 0) { %>
			<td>&nbsp;</td>
			<% } else { %>
			<td><%= answer %></td>
			<% } %>
			<td><%= rst[i].getCnt() %> 명</td>
		</tr> 

		<%
				newno = newno-1;
			}
		}
		%>
	</table>
		
	:: 동일 답안자 일괄채점 &nbsp;<img type="button" src="../images/bt3_true.gif" onClick="ans_tot_score(1, <%=allotting%>)" style="cursor: pointer;">&nbsp;<img type="button" src="../images/bt3_false.gif" onClick="ans_tot_score(0, <%=allotting%>)"  style="cursor: pointer;">&nbsp;&nbsp;&nbsp;<input type="text" name="tot_score" size="3"> 점 &nbsp;&nbsp;&nbsp;<img  style="cursor: pointer;" src="../images/bt3_mark.gif" type="button" onClick="ans_tot_score();"></form>


	<!-- 페이징 처리 부분... -->
	<table width="100%" cellpadding="3" cellspacing="0" border="0" bgcolor="f6f6f6" style="margin-bottom: 80px;">
		<tr>
			<td align="right">
				<font color='red'><%=iPage%></font> / <%=TotPage%> page&nbsp;&nbsp;&nbsp;
				 <!-- 페이징 처리하는 부분-->
				<%
					int GSize = 10;
					int PreGNum = (iPage - 1) / GSize;
					int EndPNum = PreGNum * GSize;
					int k = 0;

					String Tar = "Page=" + Integer.toString(EndPNum);
					Tar = Tar + "&id_exam=" + id_exam;
					Tar = Tar + "&id_q=" + id_q;
					
					//Tar = Tar & "&kwd_ans=" & kwd_ans

					if (EndPNum > 0) {
				%>
					[<a href="exam_ans_score.jsp?<%=Tar%>">이 전</a>]
				<%
					}

					int LCount = GSize;
					int intI = EndPNum + 1;

					for (intI=EndPNum + 1; intI<=TotPage; intI++) {
						Tar = "";
						Tar = Tar + "Page=" + Integer.toString(intI);
						Tar = Tar + "&id_exam=" + id_exam;
						Tar = Tar + "&id_q=" + Integer.toString(id_q);
				%>
					[<a href="exam_ans_score.jsp?<%=Tar%>"><%=intI%></a>]
				<%
						LCount = LCount -1;
						if (LCount == 0) {
							break;
						}
					}

					intI = EndPNum + (GSize + 1);
					Tar = "";
					Tar = Tar + "Page=" + Integer.toString(intI);
					Tar = Tar + "&id_exam=" + id_exam;
					Tar = Tar + "&id_q=" + Integer.toString(id_q);

					if (intI <= TotPage) {
				%>
					[<a href="exam_ans_score.jsp?<%=Tar%>">다음</a>]
				<%
					}
				%>
			</td>
		</tr> 
	</table>

</div>
</Body>
</Html>
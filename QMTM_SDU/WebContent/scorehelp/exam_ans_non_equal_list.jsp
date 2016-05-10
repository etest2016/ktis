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

	String equal_ans = request.getParameter("equal_ans");
	if (equal_ans== null) { equal_ans= ""; } else { equal_ans = equal_ans.trim(); }

	if (equal_ans.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}


	String q = "";
	double allotting = 0;
	int qcount = 0;

	Score_EquallistBean3 mBean = null;

	try {
		mBean = Score_Equallist.getQ(id_exam, Integer.parseInt(id_q));
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println("aaa" + ex.getMessage());
		if(true) return;
	}


	q = mBean.getQ();
	q = q.replace("<BR>", "");
	q = q.replace("</BR>", "");
	q = q.replace("<P>", "");
	q = q.replace("</P>", "");
	allotting = mBean.getAllotting();
	qcount = mBean.getQcount();

	Score_EquallistBean[] rst = null;
	try {
		rst = Score_Equallist.getList(id_exam, Integer.parseInt(id_q), equal_ans);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());
		if(true) return;
	}

	int TotRecord = 0;
	if (rst != null) {
		TotRecord = rst.length;
	}

%>

<html>
<head>
<title>논술형 문제 채점</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
<link rel="stylesheet" href="../css/form_style.css" type="text/css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="JavaScript">
	function search_move(search_kwd) {
		var frm = document.form1;
		var blanks = " ";
		frm.search_ans_result.value = frm.search_ans_result.value + search_kwd + blanks; 		
		frm.search_ans.value = "";
		frm.search_ans.focus();
	}

	function onEnters() {	
		var frm = document.form1;		
		var keyCode = window.event.keyCode;

		if(keyCode == 13) {
			frm.search_ans_result.value = frm.search_ans_result.value + frm.search_ans.value + "\n"; 		
			frm.search_ans.value = "";
			frm.search_ans.focus();		
		}
	}

	function checks() {

		var frm = document.form1;
			
		if(frm.compare_bigo[0].checked == true)
		{			
			frm.search_ans.disabled = false;
			frm.search_ans.focus();
		} else {
			frm.search_ans.value = "";
			frm.search_ans_result.value = "";
			frm.search_ans.disabled = true;			
		}

		if(frm.compare_bigo[1].checked == true)
		{				
			frm.basic_ans.disabled = false;
			frm.basic_ans.focus();
		} else {			
			frm.basic_ans.value = "";
			frm.basic_ans.disabled = true;
		}
	}
	
	function ans_comp() {
		var frm = document.form1;
		var k = 0;
		
		var keyCode = window.event.keyCode;
		if(keyCode == 13) {
			return;
		}
		
		for (var i=0; i<frm.compare_bigo.length; i++)
		{
			if(frm.compare_bigo[i].checked == true) {
				k = k + 1;
			} 
		}			
		
		if(k == 0) {
			alert("채점 비교 방식을 선택하셔야 합니다.");
			return;
		} else if(frm.compare_bigo[0].checked == true && frm.search_ans_result.value == "") {
			alert("비교할 키워드를 입력하세요.");
			frm.search_ans.focus();
			return;
        } else if(frm.compare_bigo[1].checked == true && frm.basic_ans.value == "") {
			alert("비교할 모범답안을 입력하세요.");
			frm.basic_ans.focus();
			return;
		} else {			
				frm.submit();
		}
	}

	function equal_values() {
		var frm = document.form2;
		if (frm.equal_value.value == "" && frm.k_equal_value.value == "" && frm.ans_len_value.value == "")
		{
			alert("검색할 유사율을 입력하세요.")
			frm.k_equal_value.focus();
			return;
		} else if (frm.equal_value.value > 100 || frm.equal_value.value < 0)
		{
			alert("유사율은 [0 ~ 100] 사이 값만 입력가능합니다.");
			frm.equal_value.value = "";
			frm.equal_value.focus();
		} else {
			frm.submit();
		}
	}

	function ans_Comp(userid, ans_rate, ans_rate2) {
		var ansCompWin;
		ansCompWin = $.posterPopup("ans_comp.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&comp_bigo=2&userid="+userid+"&ans_rate="+ans_rate+"&ans_rate2="+ans_rate2, "compwin", "menubar=no, scrollbars=yes, width=700, height=450");
		ansCompWin.focus();
	}

	function search_Comp(userid2) {
		var searchCompWin;
		searchCompWin = $.posterPopup("search_comp.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&comp_bigo=1&userid="+userid2, "searchwin", "menubar=no, scrollbars=yes, width=500, height=400");
		searchCompWin.focus();
	}

	// 배점 관련 체크..
	function score_Chk(allotting) {
		var frm = document.form3;
		//var allot = Integer.parseInt(allotting);				
		if (frm.tot_score.value > allotting)
		{
			alert("배점보다 부여하신 점수가 큽니다.");
			return;
		} else if(frm.tot_score.value > allotting)
		{
			alert("부여하신 점수가 0 보다 작습니다. 0 이상 값을 입력하시기 바랍니다.");
			return;
		} 
	}

	function ans_score(uid, score, allot) {
		var searchCompWin;
		scoreWin = $.posterPopup("score_U.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+uid+"&score="+score+"&allot="+allot, "scorewin", "menubar=no, scrollbars=no, width=350, height=150");
		scoreWin.focus();
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
			var obj = document.getElementsByName("checks");
			for (var i=0; i<obj.length; i++)
			{
				if(obj[i].checked == true) {
					k = k + 1;
				} 
			}			
			// 채점대상 응시자 체크 유무...
			if (k == 0 ) {
				alert("채점할 응시자를 선택하세요.");
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

	function chkBox(bool) { // 전체선택/해제 
	    var obj = document.getElementsByName("checks"); 
		for (var i=0; i<obj.length; i++) obj[i].checked = bool;  
	} 

	function revBox() { // 전체반전 
		var obj = document.getElementsByName("checks"); 
	    for (var i=0; i<obj.length; i++) obj[i].checked = !obj[i].checked; 
	} 

	function equal_reason(o_userid) {
		var equal_reason_Win;
		equal_reason_Win = $.posterPopup("equal_reason_view.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+o_userid, "reasonwin", "menubar=no, scrollbars=no, width=350, height=150");
		equal_reason_Win.focus();		
	}

	function equal_ans_comp(userid2) {
		var equalansComp;
		equalansComp = $.posterPopup("exam_ans_non_frm2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+userid2, "compwin", "menubar=no, scrollbars=yes, width=1000, height=700");
		equalansComp.focus();
	}
</script>

</head>
<body>

	<table border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr height="70">
			<td style="background-image: url(../images/bg.gif);" align="right"><a href="javascript:window.location.reload();" onFocus="this.blur()"><img src="../images/bt_re.gif"></a><a href="javascript:window.close()" onFocus="this.blur()"><img src="../images/bt_out.gif" border="0"></a></td>
		</tr>
	</table>

	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center" style="padding-left: 30px; padding-right: 30px;">
				
				<div class="title">논술형 문제 정보</div>
	
				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="TableD">
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>문제번호</B></td>  
						<td bgcolor="#FFFFFF">&nbsp;<%=id_q%></td>
						<td width="15%" align="center" id="left"><B>배점</B></td> 
						<td bgcolor="#FFFFFF">&nbsp;<%=allotting%> 점</td>	
					</tr>
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>문제</B></td>  
						<td height="30" bgcolor="#FFFFFF" colspan="3">&nbsp;<%=q%></td>
					</tr>
				</table>

				<hr size="1" width="90%" bgcolor="#FFFFFF">
				
				<div class="title">모사판정답안자 리스트</div>

				<table border='0' width='100%'>
					<tr>
						<td align="left"><div style="float: left; padding-top: 3px;">&nbsp;&nbsp;총 <font color='red'><b><%=TotRecord%></b></font> 명</div><div style="float: left;">&nbsp;&nbsp;&nbsp;<a href="ans_non_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>"><img src="../images/bt8_d.gif"></a>&nbsp;<a href="ans_non_score2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>"><img src="../images/bt8_a.gif"></a></div></td>		
					</tr>
				</table>

				<table border='0' cellspacing='0' cellpadding='3' width='100%' bgcolor='#FFFFFF' id="TableD">
					<tr align="center" bgcolor='#95DB95' height="30" id="tr">    
						<form name="form3" method="post" action="score_tot_U.jsp">
						<input type="hidden" name="id_exam" value="<%=id_exam%>">
						<input type="hidden" name="id_q" value="<%=id_q%>">
						<td width="7%"><B><INPUT type=checkbox onclick=chkBox(this.checked) class="form3"></B></td>  
						<td width="5%"><B>NO</B></td>  
						<td width="17%"><B>응시자</B></td>
						<td width="15%"><B>키워드 유사율</B></td>    
						<td width="15%"><B>모범답안 유사율</B></td>    
						<td width="15%"><B>응시자 답안길이</B></td>    
						<td width="10%"><B>모사판정답안</B></td>    
						<td ><B>개별채점</B></td>    
					</tr>
	  
					<% 
						if (rst == null) {
					%>

					<tr bgcolor="#FFFFFF" align="center" height="30">  
						<td colspan="8" class="blank"><B>모사판정 답안자가 없습니다.</B></td>
					</tr>

	 	
					<%
						} else {
							int i = 0;
							int newno = 0;

							for (i=0; i<rst.length; i++) {
								
								String usernames = "";
									
								try {
									usernames = Score_AnsNon.getUserName(rst[i].getUserid());
								} catch(Exception ex) {
									out.println(ex.getMessage());
									if(true) return;
								}
								
								Score_EquallistBean2 myBean = null;
								
								try {
									myBean = Score_Equallist.getUserData(id_exam, rst[i].getUserid(), Integer.parseInt(id_q));
								} catch(Exception ex) {
									//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
									out.println(ex.getMessage());
									if(true) return;
								}

								int nr_q = myBean.getNr_q();
								String points = myBean.getPoints().trim();
								String equal_chk = myBean.getEqual_chk();
								double score = myBean.getScore();
								String equal_ans2 = myBean.getEqual_ans();
								int equal_ans_cnt = 0;

								if(equal_ans2 == null) {
									equal_ans_cnt = 0;
								} else {
									String[] arrEqual_ans2 = equal_ans2.split(QmTm.OR_GUBUN_re, -1);
									equal_ans_cnt = arrEqual_ans2.length;
								}						
								
								newno++;

								String[] tmpPoints = new String[qcount];
								if (points == "") {
									for (int x=0; x<qcount; x++) {
										tmpPoints[x] = "";
									}
								} else {
									tmpPoints = points.split(QmTm.Q_GUBUN_re, -1);
								}

								Score_EqualMarkingBean myBean2 = null;
								try {
									myBean2 = Score_EqualMarking.getAns2(id_exam, Integer.parseInt(id_q), rst[i].getUserid());
								} catch(Exception ex) {
									//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
									out.println(ex.getMessage());

									if(true) return;
								}

								String sAns = "";
								sAns = myBean2.getUserans();

								sAns = sAns.replace(")","");
								sAns = sAns.replace("(","");
								sAns = sAns.replace(",","");
								sAns = sAns.replace(".","");
								sAns = sAns.replace("*","");
								sAns = sAns.replace("[","");
								sAns = sAns.replace("\r\n"," ");
					%>
	  
					<tr bgcolor="#FFFFFF" align="center" height="22" id="td">    
						<td><input type="checkbox" name="checks" value="<%= rst[i].getUserid() %>" class="form3"></td>
						<td><%= newno %></td>   	
						<td><%= rst[i].getUserid() %>(<%=usernames%>)</td>   	
						<td><a href="javascript:search_Comp('<%= rst[i].getUserid() %>')"><font color="red"><%= rst[i].getSearch_result_rate() %></font> %</a></td>
						<td><a href="javascript:ans_Comp('<%= rst[i].getUserid() %>', '<%= rst[i].getAns_result_rate() %>', '<%= rst[i].getAns_result_rate2() %>')"><%= rst[i].getAns_result_rate() %>%</a></td>
						<td><b><%= sAns.length() %> Len</b></td>	
						<td><a href="javascript:" onClick="equal_ans_comp('<%= rst[i].getUserid() %>')"><font color="red"><b><%= equal_ans_cnt %> 명</b></font></a></td>	
						<td><a href="javascript:ans_score('<%= rst[i].getUserid() %>', '<%= tmpPoints[nr_q-1] %>', '<%= allotting %>')"><img src="../images/bt3_mark.gif" border="0"></a></td>    
					</tr>  


					<%
							}	
						}
					%>

				</table>

				<table border='0' width='100%'>
					<tr>
						<td align="left"><div style="float: left;"><!--<a href="javascript:" onclick="chkBox()">전체선택</a> || <a href="javascript:" onclick="revBox()">선택해제</a>&nbsp;&nbsp;&nbsp;-->선택응시자 일괄채점 : <input type="text" name="tot_score" size="3" class="form2"> 점</div><div style="float: left;"> &nbsp;&nbsp;<img src="../images/bt3_true.gif" style="cursor: pointer;" onClick="ans_tot_score(1, <%=allotting%>);">&nbsp;&nbsp;<img src="../images/bt3_false.gif" style="cursor: pointer;" onClick="ans_tot_score(0, <%=allotting%>)">&nbsp;&nbsp;<img src="../images/bt3_mark.gif" style="cursor: pointer;" onClick="ans_tot_score(<%=allotting%>)"></div></td>
						</form>		
					</tr>
				</table>

			</td>
		</tr>
	</table>

</body>
</html>

<%
//******************************************************************************
//   프로그램 : ans_non_score.jsp
//   모 듈 명 : 논술형 채점도우미
//   설    명 : 논술형 문제 채점 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2009-01-22
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*, java.util.*, java.util.regex.*" %>

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

	//페이징 처리
	String sPg = request.getParameter("Page");
	if (sPg == null || sPg == "" || sPg == "0") {
		sPg = "1";
	}
	int iPage = Integer.parseInt(sPg);

	int TotRecord = 0;
	int TotPage = 0;
	int pgSize = 10;
	int segment = 0;

	
	Score_AnsEqualBean rst = null;

	try {
		rst = Score_AnsEqual.getBean(id_exam, id_q);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());

		if(true) return;
	}

	String allotting = rst.getAllotting();
	String q = rst.getQ();
	
	/*
	q = Replace(q, "<BR>", "");
	q = Replace(q, "</BR>", "");
	q = Replace(q, "<P>", "");
	q = Replace(q, "</P>", "");
	*/
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
		if (frm.equal_value.value == "" && frm.k_equal_value.value == "")
		{
			alert("검색할 유사율 또는 답안길이를 입력하세요.")
			frm.k_equal_value.focus();
			return;
		} else if (!(frm.k_equal_value.value >= '0'))
		{
			alert("유사율은 숫자만 입력가능합니다.");
			frm.k_equal_value.value = "";
			frm.k_equal_value.focus();
			return;
		} else if (!(frm.equal_value.value >= '0'))
		{
			alert("유사율은 숫자만 입력가능합니다.");
			frm.equal_value.value = "";
			frm.equal_value.focus();
			return;
		} else if (frm.k_equal_value.value > 100 || frm.k_equal_value.value < 0)
		{
			alert("유사율은 [0 ~ 100] 사이 값만 입력가능합니다.");
			frm.k_equal_value.value = "";
			frm.k_equal_value.focus();
			return;
		} else if (frm.equal_value.value > 100 || frm.equal_value.value < 0)
		{
			alert("유사율은 [0 ~ 100] 사이 값만 입력가능합니다.");
			frm.equal_value.value = "";
			frm.equal_value.focus();
			return;
		} else {			
			frm.submit();			
		}
	}

	function ans_Comp(userid, ans_rate) {
		var ansCompWin;
		ansCompWin = $.posterPopup("ans_comp.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+userid+"&ans_rate="+ans_rate, "compwin", "menubar=no, scrollbars=yes, width=700, height=450");
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
		scoreWin = $.posterPopup("score_U.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+uid+"&score="+score+"&allot="+allot, "scorewin", "menubar=no, scrollbars=no, width=350, height=200");
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

<BODY Style="margin:0px;">

	<!-- 타이틀 디자인 -->
	<div style="width: 100%; height: 70px; background-image: url(../images/bg_mark_top.gif); text-align: right;"><img src="../images/bt_re.gif" onclick="location.href='ans_non_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>';" style="cursor: pointer;"><img src="../images/bt_out.gif" style="cursor: pointer;" onclick="javascript:window.close();"></div>
	<!-- 단답형 문제 웹채점 -->
	<div style="width: 100%; margin: 0px 30px 10px 30px;">
		<img src="../images/title_ad_webscore3.gif">
	</div>


	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center" style="padding-left: 30px; padding-right: 30px;">
				<div class="title">논술형 문제 정보</div>

				<table border="0" cellpadding="0" cellspacing="0" id="tableD" width="100%">
					<tr height="30">
						<td width="15%" align="center" id="left"><B>문제번호</B></td>  
						<td bgcolor="#FFFFFF">&nbsp;<%=id_q%></td>
						<td width="15%" align="center" id="left"><B>배점</B></td> 
						<td bgcolor="#FFFFFF">&nbsp;<%=allotting%> 점</td>	
					</tr>
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>문제</B></td>  
						<td height="30" bgcolor="#FFFFFF" colspan="3" >&nbsp;<%=q%></td>
					</tr>
				</table>

				<hr size="1" width="100%" bgcolor="#FFFFFF">
				
				<div class="title">채점방식 선택</div><br>

				<table border='0' width='100%'>
					<tr>
					<form name="form1" method="post" action="score_help_Res.jsp" onsubmit="return false;">
					<input type="hidden" name="id_exam" value="<%=id_exam%>">
					<input type="hidden" name="id_q" value="<%=id_q%>">
						<td height = "25" width="45%">&nbsp;<input type="checkbox" name="compare_bigo" value="1" onClick="checks()" class="form3"> <B>키워드 이용한 비교 채점</B> (키워드를 등록하세요)</td>
						<td height = "25" width="45%">&nbsp;<input type="checkbox" name="compare_bigo" value="2" onClick="checks()" class="form3"> <B>모범답안 이용한 비교 채점</B> (모범답안을 등록하세요)</td>
						<td rowspan="2" align="right" valign="top"><img src="../images/bt3_action.gif" style="cursor: pointer;" onClick="ans_comp();"><td>
					</tr>	
					<tr>
						<td><table border="0">
							<tr>
								<td valign="top">&nbsp;<input type="text" name="search_ans" size="12" disabled onKeydown="onEnters()" class="form2">&nbsp;<font size="4" color="blue"><B><a href="javascript:" onClick="search_move(document.form1.search_ans.value)">▶</a></B></font></td>
								<td>&nbsp;<textarea name="search_ans_result" cols="25" rows="4" readonly></textarea></td>
							</tr>
						</table>
						</td>
						<td>&nbsp;&nbsp;<textarea name="basic_ans" cols="42" rows="4" disabled></textarea></td>
					</form>
					</tr>
				</table>

				<hr size="1" width="90%" bgcolor="#FFFFFF">

				<%
					// 문제수 정보를 가져온다
					int qcnt = 0;
					
					try {
						qcnt = Score_AnsNon.getQcnt(id_exam);
					} catch(Exception ex) {
						out.println("getQcnt" + ex.getMessage());
						if(true) return;

						//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
					}

					// 모사 답안자 
					//String equal_ans = Request("equal_ans");
					String equal_ans = "";

					// 채점자가 입력한 키워드 유사율..
					int k_equal_value = 0;
					if (request.getParameter("k_equal_value")!=null){
						k_equal_value = Integer.parseInt(request.getParameter("k_equal_value"));
					}


					// 채점자가 입력한 모범답안 유사율..
					int equal_value = 0;
					if (request.getParameter("equal_value")!=null){
						equal_value = Integer.parseInt(request.getParameter("equal_value"));
					}


					// 채점자가 입력한 응시자 답안길이..
					int ans_len_value = 0;
					if (request.getParameter("ans_len_value")!=null){
						ans_len_value = Integer.parseInt(request.getParameter("ans_len_value"));
					}

					//페이징 처리를 위해 전체 레코드를 구해서 전체 페이지를 구한다.
					try {
						TotRecord = Score_AnsNon.getCount(id_exam, id_q, k_equal_value, equal_value, ans_len_value, "N");
						segment = TotRecord % pgSize;
						if (segment > 0) {
							TotPage = (TotRecord - segment) / pgSize + 1;
						} else {
							TotPage = TotRecord / pgSize;
						}
					} catch(Exception ex) {
						out.println("getCount" + ex.getMessage());
						if(true) return;
						//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
					}

					Score_AnsNonBean[] beans = null;
					
					try {
						//beans = Score_AnsNon.getBeans(id_exam, id_q);
						beans = Score_AnsNon.getBeans(id_exam, id_q, k_equal_value, equal_value, ans_len_value, "N", iPage, pgSize);
					} catch(Exception ex) {
						out.println("getBeans" + ex.getMessage());
						if(true) return;
						//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
					}

					//if(beans != null) {
						//TotRecord = beans.length;
					//}
					
					//	강진아
					//	TotPage   = Rst.PageCount

				%>
				
				
				<div class="title">미채점자 리스트</div>				

				<table border='0' width='100%'>
					<form name="form2" method="post" action="ans_non_score.jsp">
					<input type="hidden" name="id_exam" value="<%=id_exam%>">
					<input type="hidden" name="id_q" value="<%=id_q%>">
					<tr>
						<td align="left" colspan="2"><div style="float: left; padding-top: 3px;">&nbsp;&nbsp;총 <font color='red'><b><%=TotRecord%></b></font> 명&nbsp;&nbsp;&nbsp;<% if(beans != null){ //if(beans[0].getBasic_ans_len()!=0){ %><b>모범답안길이 : <font color=red><%=beans[0].getBasic_ans_len()%>Len</font></b><%}//}%>&nbsp;&nbsp;&nbsp;</div><div style="float: left;"><a href="ans_non_score2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>"><img src="../images/bt8_a.gif"></a></div></td>
					</tr>
					<tr>
						<td align="right"><%if (k_equal_value!=0 || equal_value!=0 || ans_len_value!=0) {%><a 
				href="ans_non_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>">[전체 리스트 보기]</a>&nbsp;&nbsp;<%}%><B> 키워드 유사율 
				검색 : <input type="text" name="k_equal_value" size="3" class="form2" value="<%=k_equal_value%>">&nbsp;% ↑,&nbsp;</B>&nbsp;&nbsp;<B> 모범답안 유사율 검색 :<input 
				type="text" name="equal_value" size="3" class="form2" value="<%=equal_value%>">&nbsp;% ↑,&nbsp;</B><!--&nbsp;&nbsp;<B> 답안길이 검색 : <input type="text" 
				name="ans_len_value" size="3" class="form2" value="<%=ans_len_value%>">&nbsp;Len ↑&nbsp;</B>-->
						</td>
						<td width="70" align="right"><img src="../images/bt3_search.gif" style="cursor: pointer;" onClick="equal_values()"></td>
					</tr>
					</form>
				</table>

				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="tableD" style="margin-top: 5px;">
					<tr align="center" bgcolor='#95DB95' height="30" id="tr">    
					<form name="form3" method="post" action="score_tot_U.jsp">
					<input type="hidden" name="id_exam" value="<%=id_exam%>">
					<input type="hidden" name="id_q" value="<%=id_q%>">
						<td width="4%"><INPUT type=checkbox onclick=chkBox(this.checked) class="form3"></td>  
						<td width="4%">NO</td>
						<td width="10%"><B>응시자</B></td>
						<td width="13%"><B>키워드 유사율</B></td>
						<td width="13%"><B>모범답안 유사율</B></td>
						<td width="13%"><B>응시자 답안길이</B></td>
						<td ><B>응시자답안</B></td>
						<td width="10%"><B>개별채점</B></td>
					</tr>
  
					<%
						// 현재 페이지값을 전송받는다
						if(beans == null) {

					%>

					<tr bgcolor="#FFFFFF" align="center" height="30">
						<td colspan="8" class="blank"><B>응시자별 답안 비교 결과 값이 없습니다.</B></td>
					</tr>

					<tr bgcolor="#DBDBDB">
						<td colspan="8"></td>
					</tr>

					<%
						} else {

							int newno = TotRecord;
							newno = newno - (pgSize * (iPage-1));

							String basic_anss = "";
				
							try {
								basic_anss = Score_Comp.getBasicAnsGroup(id_exam, id_q, 1);
							} catch(Exception ex) {
								//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
								out.println(ex.getMessage());
								if(true) return;
							}

							for(int i=0; i<beans.length; i++) {

								String userid = beans[i].getUserid();
								/*String usernames = "";

								try {
									usernames = Score_AnsNon.getUserName(userid);
								} catch(Exception ex) {
									out.println(ex.getMessage());
									if(true) return;
								}*/

								Score_AnsNonBean rs = null;

								try {
									rs = Score_AnsNon.getPoint(id_exam, id_q, userid);
								} catch(Exception ex) {
									out.println("getPoint" + ex.getMessage());
									if(true) return;
									//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
								}

								double q_allotting = rs.getAllotting();
								String points = rs.getPoints();
								int nr_q = rs.getNr_q();

								String tmpPoints = rs.getPoints().trim();
								String[] arrPoints = new String[qcnt];

								if (tmpPoints == "") {
									for (int cc=0; cc<qcnt; cc++) {
										arrPoints[cc] = "";
									}
								} else {
									arrPoints = tmpPoints.split(QmTm.Q_GUBUN_re, -1);
								}								
								
								String[] arrSearch = basic_anss.split(" ");
								String myAns = "";
								
								myAns = beans[i].getUserans().replace("null", "").trim();
								myAns = myAns.replace(")","");
								myAns = myAns.replace("(","");
								myAns = myAns.replace("|","");
								//엔터값을 스페이스로 변환
								//myAns = myAns.replace("\r\n"," ");

								String[] arrMyAns = myAns.split(" ");
								String[] arrResult = new String[arrMyAns.length];
								String sPos = "";

								Pattern pt = null;
								Matcher mt = null;
								int pa = 0;
								int qa = 0;

								for (pa=0; pa<arrSearch.length; pa++) {
									pt = Pattern.compile(arrSearch[pa]);

									if (arrSearch[pa].trim().length() > 0) {
										for(qa=0; qa < arrMyAns.length; qa++) {

											mt = pt.matcher(arrMyAns[qa]);
											if(mt.find()) {
												arrResult[qa] = "<font color=red>" + arrMyAns[qa] + "</font>";
												sPos = sPos + Integer.toString(qa) + ",";
											}
										}
									}
								}

								String sResultAns = "";

								if (sPos != "") {
									sPos = sPos.substring(0, sPos.length()-1);

									String[] arrPos = sPos.split(",");

									int iPos = 0;
									for (pa=0; pa<arrPos.length; pa++) {
										iPos = Integer.parseInt(arrPos[pa]);
										arrMyAns[iPos] = arrResult[iPos];
									}
								}

								for (pa=0; pa<arrMyAns.length; pa++) {
									sResultAns = sResultAns + arrMyAns[pa] + " ";
								}								
								
					%>
					<tr bgcolor="#FFFFFF" align="center" id="td">    
						<td><input type="checkbox" name="checks" value="<%= userid %>" class="form3"></td>
						<td><%= newno %></td>
						<td><%=userid%></td>   	
						<td><a href="javascript:search_Comp('<%=userid%>')"><font color="red"><%=beans[i].getSearch_result_rate()%> %</font></a></td>
						<td><a href="javascript:ans_Comp('<%=userid%>', '<%=beans[i].getAns_result_rate()%>')"><%=beans[i].getAns_result_rate()%> %</a></td>
						<td><b><%=sResultAns.replace("null", "").length()%> Len</b></td>
						<td><%=sResultAns%></td>
						<td><a href="javascript:ans_score('<%=userid%>', '<%= arrPoints[nr_q -1] %>', '<%= q_allotting %>')"><img src="../images/bt3_mark.gif" border="0"></a></td>    
					</tr>
					
					<%		
								newno = newno-1;
							}
						}
					%>
				</table>

				<table border='0' width='100%' style="margin-top: 5px;">
					<tr>
						<td align="left" width="200"><!--<a href="javascript:" onclick="chkBox()">전체선택</a> || <a href="javascript:" onclick="revBox()">선택해제</a>&nbsp;&nbsp;&nbsp;-->선택응시자 일괄채점 : <input type="text" name="tot_score" size="3" class="form2"> 점 </td>
						<td align="left">&nbsp;&nbsp;<img src="../images/bt3_true.gif" onClick="ans_tot_score(1, <%=allotting%>)" style="cursor: pointer;">&nbsp;&nbsp;<img src="../images/bt3_false.gif" onClick="ans_tot_score(0, <%=allotting%>)" style="cursor: pointer;">&nbsp;&nbsp;<img src="../images/bt3_mark.gif"  onClick="ans_tot_score(<%=allotting%>)" style="cursor: pointer;"></td>
						</form>
						<td align="right">

							<!-- 페이징 처리 부분... -->
							<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td colspan='6' height="10" align="center">
									<font color='red'><b><%= iPage %></b></font> / <b><%=TotPage%></b> page&nbsp;&nbsp;&nbsp;
									 <!-- 페이징 처리하는 부분-->
									<%

										int GSize = 10;
										int PreGNum = (iPage - 1) / GSize;
										int EndPNum = PreGNum * GSize;
										int k = 0;
										String Tar = "";
										
										Tar = "Page=" + EndPNum;
										Tar = Tar + "&equal_value=" + equal_value;
										Tar = Tar + "&k_equal_value=" + k_equal_value;
										Tar = Tar + "&ans_len_value=" + ans_len_value;
										Tar = Tar + "&id_exam=" + id_exam;
										Tar = Tar + "&id_q=" + id_q;

										//이전그룹시작---------------
										//이전그룹이 있다면 출력한다
										if (EndPNum > 0){

									%>
										[<a href="ans_non_score.jsp?<%=Tar%>">이 전</a>]
									<% 
										}
										//이전그룹 끝---------------

										//현재그룹시작---------------
										//현재그룹을 출력한다 (Gsize만큼)

										int LCount = GSize;
										int intI = EndPNum + 1;

										//for (int i=0; i<=TotPage; i++) {
										for (intI=EndPNum + 1; intI<=TotPage; intI++) {
											Tar = "";
											Tar = Tar + "Page=" + intI;
											Tar = Tar + "&equal_value=" + equal_value;	
											Tar = Tar + "&k_equal_value=" + k_equal_value;
											Tar = Tar + "&ans_len_value=" + ans_len_value;
											Tar = Tar + "&id_exam=" + id_exam;
											Tar = Tar + "&id_q=" + id_q;
										
									%>
										[<a href="ans_non_score.jsp?<%=Tar%>"><%=intI%></a>]
									<%
											LCount = LCount -1;
											if (LCount == 0) {
												break;
											}

										}

										//현재그룹 끝--------------- 

										//다음그룹시작---------------
										intI = EndPNum + (GSize + 1);
										
										Tar = "";
										Tar = Tar + "Page=" + intI;
										Tar = Tar + "&equal_value=" + equal_value;	
										Tar = Tar + "&k_equal_value=" + k_equal_value;
										Tar = Tar + "&ans_len_value=" + ans_len_value;
										Tar = Tar + "&id_exam=" + id_exam;
										Tar = Tar + "&id_q=" + id_q;

										//다음그룹이 있다면 출력한다
										if (intI <= TotPage ) {
										
									%>
										[<a href="ans_non_score.jsp?<%=Tar%>">다음</a>]
									<% 
										//다음그룹 끝---------------
										
										}

									%>
									</td>
								</tr> 
							</table>

						</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
	<BR><BR><BR>

</body>
</html>
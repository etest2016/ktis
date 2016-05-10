<%
//******************************************************************************
//   프로그램 : static_main.jsp
//   모 듈 명 : 성적통계 관리 
//   설    명 : 성적통계 관리
//   테 이 블 : s_t_result
//   자바파일 : qmtm.tman.statics.StaticScoreBean, qmtm.tman.statics.StaticScore 
//   작 성 일 : 2008-06-09
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

	double start = 0;
	double end = 0;

	String inits = "init_static";

	String search_gubun = request.getParameter("sch");
	if (search_gubun == null) { search_gubun= ""; } else { search_gubun = search_gubun.trim(); }

	if(search_gubun.length() == 0) {
		search_gubun = "A";
	} else {
		search_gubun = request.getParameter("sch");
		inits = "user_static";
	}

	String areas = "";

	String areas2 = request.getParameter("areas");
	if (areas2 == null) { areas2 = ""; } else { areas2 = areas2.trim(); }

	String areas3 = request.getParameter("areas2");
	if (areas3 == null) { areas3 = ""; } else { areas3 = areas3.trim(); }
	
	if(search_gubun.equals("A")) {
		if(areas2.length() == 0) {
			areas = "90,100";
		} else {
			areas = areas2;
		}
	} else {
			areas = areas3;
	}

	String pStatic = request.getParameter("pStatic");
	if (pStatic == null) { pStatic = "N"; } else { pStatic = pStatic.trim(); }

	String[] arrAreas = areas.split(",", -1); 

	StaticScoreBean scoreA = null;

	try {
		scoreA = StaticScore.getTList(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	StringBuffer score_inwon = new StringBuffer();

	double inwon_g1 = 0;
	double inwon_g2 = 0;
	double inwon_g3 = 0;
	double inwon_g4 = 0;
	double inwon_g5 = 0;

	double inwon_min1 = 0;
	double inwon_min2 = 0;
	double inwon_min3 = 0;
	double inwon_min4 = 0;
	double inwon_min5 = 0;

	double inwon_rate2 = 0;

	StaticScoreBean[] scoreP = null;

	try {
		scoreP = StaticScore.getPList(id_exam, search_gubun, Double.parseDouble(arrAreas[0]), Double.parseDouble(arrAreas[1]));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

<html>
<head>

<title>성적통계</title>
<script language="JavaScript" type="text/javascript">
    <!--

	var now_btn;

	function SetScrollPos_Sample(tagDIV)
    {
        var positionTop = 0;
        if (tagDIV != null)
        {
            positionTop = parseInt(tagDIV.scrollTop, 10);
            document.getElementById("SAMPLE_TABLE").style.top = positionTop;
        }
    }

	// 메뉴별로 페이지 보여주기..
	function movieLayout(obj) {

		now_btn = obj;
		
		var pStatics = "<%=pStatic%>";

		if(obj == "all_static" || obj == "q_static") {
			pStatics = "N";
		} 
		
		if(pStatics == "Y") {
			obj = "user_static";
		}

		if(obj == "init_static") {
			document.all.id_all_static.style.display = "block";
			document.all.id_user_static.style.display = "none";
			document.all.id_q_static.style.display = "none";
		} else if(obj == "all_static") {
			document.all.id_all_static.style.display = "block";
			document.all.id_user_static.style.display = "none";
			document.all.id_q_static.style.display = "none";
		} else if(obj == "user_static") {
			document.all.id_all_static.style.display = "none";
			document.all.id_user_static.style.display = "block";
			document.all.id_q_static.style.display = "none";
		} else if(obj == "q_static") {
			document.all.id_all_static.style.display = "none";
			document.all.id_user_static.style.display = "none";
			document.all.id_q_static.style.display = "block";
		}
	}

	function static_exec() {
		var st = confirm("성적 통계 처리를 하시겠습니까?\n\n성적 통계 처리 작업은 서버에 많은 부하를 주게 되므로\n반드시 동시 시험이 없는 서버가 한가한 시간에 작업을 진행해야 됩니다.\n\n계속하시겠습니까?");

		if (st == true) {
			window.open("static_exec.jsp?id_exam=<%=id_exam%>","static_exec","width=500, height=150");
		}
	}

	function static_excel() {

		if(now_btn == "init_static" || now_btn == "all_static") {
			location.href="static_excel.jsp?id_exam=<%=id_exam%>";
			//window.open("static_excel.jsp?id_exam=<%=id_exam%>","static_excel","width=1, height=1");
		} else if(now_btn == "user_static") {
			location.href="static_excel2.jsp?id_exam=<%=id_exam%>&search_gubun=<%=search_gubun%>&area1=<%=arrAreas[0]%>&area2=<%=arrAreas[1]%>";
		} else if(now_btn == "q_static") {
			location.href="static_execl3.jsp?id_exam=<%=id_exam%>";
		}
	}

    //-->
</script>
	
</head>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<form name="form1" method="post" action="static_main.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="pStatic" value="Y">

<body onLoad="movieLayout('<%=inits%>')" id="popup">

	<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR id="top">
			<TD id="left"></TD>
			<TD id="right"></TD>
		</TR>
		<TR id="main">
			<td id="left">

	<table border="0" width="95%">
		<tr height="30">
			<td align="left">&nbsp;<!--<input type="button" value="엑셀저장" onClick="static_excel();">--><a href="javascript:static_excel();"><img src="../../images/siatic_exsave_yj1.gif"></a>&nbsp;<!--<input type="button" value="성적통계" onClick="static_exec();">--><a href="javascript:static_exec();"><img src="../../images/siatic_static_yj1.gif"></a>&nbsp;<!--<input type="button" value="나가기" onClick="window.close();">--><a href="javascript:window.close();"><img src="../../images/siatic_close_yj1.gif"></a></td>
		</tr>
	</table>

	<table border="0" width="95%">
		<tr height="30">
			<td align="left">&nbsp;<!--<input type="button" value="전체 성적 통계" onClick="movieLayout('all_static')">--><a href="javascript:movieLayout('all_static');"><img src="../../images/bt_all_static_yj1.gif"></a>&nbsp;<!--<input type="button" value="개인 성적 통계" onClick="movieLayout('user_static')">--><a href="javascript:movieLayout('user_static');"><img src="../../images/bt_user_static_yj1.gif"></a>&nbsp;<!--<input type="button" value="문항 분석 통계" onClick="movieLayout('q_static')">--><a href="javascript:movieLayout('q_static');"><img src="../../images/bt_q_static_yj1.gif"></a></td>
		</tr>
	</table>

	<!-- 전체 성적 통계 시작-->
	<table width="100%" border="0" style="display:block;" id="id_all_static">
		<tr>
			<td height="350" valign="top">
			<table border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC"  width="100%" id="tableA">
				<tr height="40" bgcolor="#FFFFFF" id="tr3">
					<td align="center" bgcolor="#D9D9D9">평가명</td>
					<td align="center" width="5%" bgcolor="#D9D9D9">문제수</td>
					<td align="center" width="5%" bgcolor="#D9D9D9">배점</td>
					<td align="center" width="5%" bgcolor="#D9D9D9">평균</td>
					<td align="center" width="8%" bgcolor="#D9D9D9">상위 10% 평균</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">최고</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">최저</td>
					<td align="center" width="7%" bgcolor="#D9D9D9">응답자 수</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">0~9</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">10~19</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">20~29</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">30~39</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">40~49</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">50~59</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">60~69</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">70~79</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">80~89</td>
					<td align="center" width="4%" bgcolor="#D9D9D9">90~100</td>
				</tr>
				<% 					
					if(scoreA == null) { 
				%>
				<tr bgcolor="#FFFFFF" height="30" id="td">
					<td align="center" colspan="18">성적통계 데이타가 없습니다.</td>
				</tr>
				<% } else {

	score_inwon.append(scoreA.getInwon1());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon2());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon3());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon4());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon5());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon6());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon7());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon8());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon9());
	score_inwon.append(",");
	score_inwon.append(scoreA.getInwon10());

	String[] arrScore_inwon = score_inwon.toString().split(",", -1);

	int score_inwon_max = QmTm.getMax(arrScore_inwon);

	double inwon_rate = score_inwon_max / 5.0;

	java.text.DecimalFormat df = new java.text.DecimalFormat(",##0.0");

	inwon_g1 = inwon_rate;
	inwon_g2 = inwon_g1 + inwon_rate;
	inwon_g3 = inwon_g2 + inwon_rate;
	inwon_g4 = inwon_g3 + inwon_rate;
	inwon_g5 = inwon_g4 + inwon_rate;

	inwon_min1 = 0.0;
	inwon_min2 = 0.0;
	inwon_min3 = 0.0;
	inwon_min4 = 0.0;
	inwon_min5 = 0.0;

	inwon_rate2 = 220.0 / score_inwon_max;

	if((score_inwon_max * 20) > 220) {
		inwon_min1 = ((score_inwon_max * 20) - 220) / 5.0;
		inwon_min2 = inwon_min1 + inwon_min1;
		inwon_min3 = inwon_min2 + inwon_min1;
		inwon_min4 = inwon_min3 + inwon_min1;
		inwon_min5 = inwon_min4 + inwon_min1;
	}
					
				%>

				<tr bgcolor="#FFFFFF" height="30" id="td">
					<td align="center"><%=scoreA.getTitle()%></td>
					<td align="center"><%=scoreA.getQcount()%></td>
					<td align="center"><%=scoreA.getAllotting()%></td>
					<td align="center"><%=scoreA.getAvg_score()%></td>
					<td align="center"><%=scoreA.getTop_score()%></td>
					<td align="center"><%=scoreA.getMax_score()%></td>
					<td align="center"><%=scoreA.getMin_score()%></td>
					<td align="center"><%=scoreA.getAll_inwon()%></td>
					<td align="center"><%=scoreA.getInwon1()%></td>
					<td align="center"><%=scoreA.getInwon2()%></td>
					<td align="center"><%=scoreA.getInwon3()%></td>
					<td align="center"><%=scoreA.getInwon4()%></td>
					<td align="center"><%=scoreA.getInwon5()%></td>
					<td align="center"><%=scoreA.getInwon6()%></td>
					<td align="center"><%=scoreA.getInwon7()%></td>
					<td align="center"><%=scoreA.getInwon8()%></td>
					<td align="center"><%=scoreA.getInwon9()%></td>
					<td align="center"><%=scoreA.getInwon10()%></td>
				</tr>
				<% } %>
			</table>
			</td>
		</tr>
		<tr>
			<td height="2" background="../../images/siatic_bgline_yj1.gif"></td>
		</tr>
		<tr>
			<td height="50" align="center">
			<div class="title">점수 분포도</div>
		</tr>
		<tr>
			<td align="center" valign="middle">
				<table border="0"  width="70%">
					<tr bgcolor="#ffffff">
						<td style="border-right:1px solid #86d2f6;" height="204" valign="bottom">
							<div style="position:relative;">
							<span style="position:absolute;bottom:<%=(inwon_g5 * 20) - inwon_min5%>px;right:5px;"><%=(int)inwon_g5%></span>
							<span style="position:absolute;bottom:<%=(inwon_g4 * 20) - inwon_min4%>px;right:5px;"><%=(int)inwon_g4%></span>
							<span style="position:absolute;bottom:<%=(inwon_g3 * 20) - inwon_min3%>px;right:5px;"><%=(int)inwon_g3%></span>
							<span style="position:absolute;bottom:<%=(inwon_g2 * 20) - inwon_min2%>px;right:5px;"><%=(int)inwon_g2%></span>
							<span style="position:absolute;bottom:<%=(inwon_g1 * 20) - inwon_min1%>px;right:5px;"><%=(int)inwon_g1%></span>
							<span style="position:absolute;bottom:0;right:5px;">0</span>
							</div>
						</td>

						<% 					
					if(scoreA != null) { 
				%>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
						<!-- 최대 height는 200px입니다 -->
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon1() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon1()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon2() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon2()%></span></div>
						</td>											
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon3() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon3()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon4() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon4()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon5() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon5()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon6() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon6()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon7() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon7()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon8() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon8()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon9() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon9()%></span></div>
						</td>
						<td align="center" valign="bottom" style="background:url(/img_myjls/bg_graph_line2.gif) repeat-x left bottom;background-color:#ffffff; border-top:1px solid #86d2f6; border-right:1px solid #86d2f6;">
							<div style="background-color:#81d2c9;width:50px;height:<%=scoreA.getInwon10() * inwon_rate2%>px;display:inline;color:#000000;position:relative"><span style="position:absolute;bottom:0;left:20px;"><%=scoreA.getInwon10()%></span></div>
						</td>
						</tr>
						<% } %>
						<tr bgcolor="#ffffff" align="center">
						<td></td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">0~9</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">10~19</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">20~29</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">30~39</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">40~49</td>
					    <td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">50~59</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">60~69</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">70~79</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;">80~89</td>
						<td style="border-top:1px solid #86d2f6;border-left:1px solid #86d2f6;border-right:1px solid #86d2f6;">90~100</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	<!-- 전체 성적 통계 종료 -->

	<!-- 개인 성적 통계 시작-->
	
	<table width="100%" border="0" style="display:none;" id="id_user_static">
		<tr align="right">
			<td><input type="radio" name="sch" value="A" <% if(search_gubun.equals("A")) { %> checked <% } %>>&nbsp;환산점수(/100) 기준
			<select name="areas">
				<option value="90,100" <% if(areas2.equals("90,100")) { %> selected <% } %>>90.00점 ~ 100.00점</option>
				<option value="80,89.99" <% if(areas2.equals("80,89.99")) { %> selected <% } %>>80.00점 ~ 89.99점</option>
				<option value="70,79.99" <% if(areas2.equals("70,79.99")) { %> selected <% } %>>70.00점 ~ 79.99점</option>
				<option value="60,69.99" <% if(areas2.equals("60,69.99")) { %> selected <% } %>>60.00점 ~ 69.99점</option>
				<option value="50,59.99" <% if(areas2.equals("50,59.99")) { %> selected <% } %>>50.00점 ~ 59.99점</option>
				<option value="40,49.99" <% if(areas2.equals("40,49.99")) { %> selected <% } %>>40.00점 ~ 49.99점</option>
				<option value="30,39.99" <% if(areas2.equals("30,39.99")) { %> selected <% } %>>30.00점 ~ 39.99점</option>
				<option value="20,29.99" <% if(areas2.equals("20,29.99")) { %> selected <% } %>>20.00점 ~ 29.99점</option>
				<option value="10,19.99" <% if(areas2.equals("10,19.99")) { %> selected <% } %>>10.00점 ~ 19.99점</option>
				<option value="0,9.99" <% if(areas2.equals("0,9.99")) { %> selected <% } %>>00.00점 ~ 09.99점</option>
				<option value="0,100" <% if(areas2.equals("0,100")) { %> selected <% } %>>전체응시자</option>
			</select>&nbsp;
			<input type="radio" name="sch" value="B" <% if(search_gubun.equals("B")) { %> checked <% } %>>&nbsp;백분위 기준
			<select name="areas2">
				<option value="0,9.99" <% if(areas3.equals("0,9.99")) { %> selected <% } %>>0.00% ~ 9.99%</option>
				<option value="10,19.99" <% if(areas3.equals("10,19.99")) { %> selected <% } %>>10.00% ~ 19.99%</option>
				<option value="20,29.99" <% if(areas3.equals("20,29.99")) { %> selected <% } %>>20.00% ~ 29.99%</option>
				<option value="30,39.99" <% if(areas3.equals("30,39.99")) { %> selected <% } %>>30.00% ~ 39.99%</option>
				<option value="40,49.99" <% if(areas3.equals("40,49.99")) { %> selected <% } %>>40.00% ~ 49.99%</option>
				<option value="50,59.99" <% if(areas3.equals("50,59.99")) { %> selected <% } %>>50.00% ~ 59.99%</option>
				<option value="60,69.99" <% if(areas3.equals("60,69.99")) { %> selected <% } %>>60.00% ~ 69.99%</option>
				<option value="70,79.99" <% if(areas3.equals("70,79.99")) { %> selected <% } %>>70.00% ~ 79.99%</option>
				<option value="80,89.99" <% if(areas3.equals("80,89.99")) { %> selected <% } %>>80.00% ~ 89.99%</option>
				<option value="90,99.99" <% if(areas3.equals("90,99.99")) { %> selected <% } %>>90.00% ~ 99.99%</option>
				<option value="0,100"  <% if(areas3.equals("0,100")) { %> selected <% } %>>전체응시자</option>
			</select>&nbsp;&nbsp;<input type="image" value="확인하기"  name="submit" src="../../images/user_static_yj1.gif" align="absmiddle" >
			</td>
		</tr>
		<tr>
			<td height="350" valign="top">

			<table border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC"  width="100%" id="tableA">
				<tr height="30" bgcolor="#FFFFFF" id="tr3">
					<td align="center" bgcolor="#D9D9D9">응시자 아이디</td>
					<td align="center" width="15%" bgcolor="#D9D9D9">성명</td>
					<td align="center" width="12%" bgcolor="#D9D9D9">득점</td>
					<td align="center" width="15%" bgcolor="#D9D9D9">환산점수(/100)</td>
					<td align="center" width="12%" bgcolor="#D9D9D9">석차</td>
					<td align="center" width="15%" bgcolor="#D9D9D9">백분위(%)</td>
				</tr>
				<%
					if(scoreP != null) {
						for(int p = 0; p < scoreP.length; p++) {
				%>
				<tr bgcolor="#FFFFFF" height="25" id="td">
					<td align="center"><%=scoreP[p].getUserid()%></td>
					<td align="center"><%=scoreP[p].getName()%></td>
					<td align="center"><%=scoreP[p].getScore()%></td>
					<td align="center"><%=scoreP[p].getPct_score()%></td>
					<td align="center"><%=scoreP[p].getU_rank()%></td>
					<td align="center"><%=scoreP[p].getPct_rank()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			</td>
		</tr>
	</table>
	
	<!-- 개인 성적 통계 종료 -->

	<!-- 문항 분석 통계 시작-->
		
	<table width="100%" border="0" style="display:none;" id="id_q_static">
		<tr>
			<td height="700" valign="top" rowspan="2" width="100%">
			<iframe src="q_list_group.jsp?id_exam=<%=id_exam%>" frameborder="0" width="100%" height="750"  marginwidth="0" marginheight="0" scrolling="no">
			</iframe>
			</td>
		</tr>	
	</table>
	<!-- 문항 분석 통계 종료 -->
	</TD>
	<TD id="right"><a href="javascript:window.close();"><img src="../../images/bt_popup_close.gif"></a></TD>
		</TR>
	</TABLE>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
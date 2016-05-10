<%
//******************************************************************************
//   프로그램 : exam_write.jsp
//   모 듈 명 : 시험등록
//   설    명 : 시험등록 페이지
//   테 이 블 : exam_m, r_exam_kind, r_exam_kind_sub, r_std_grade, r_std_level
//   자바파일 : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//             qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//             qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//             qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   작 성 일 : 2010-06-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*, java.util.*" %>
<%@ include file = "../../common/calendar.jsp" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");	
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		window.close();
	</script>
<%	
	}

	String userid = (String)session.getAttribute("userid");
	
	// 그룹구분목록 가지고오기
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
	
	// 시험지 디자인 가지고오기
	String paper_design = "";

	try {
		paper_design = TreeUtil.getDesign();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	String[] paper_types = paper_design.split(",");	

	// 보기표시유형 가지고오기
	RexlabelBean[] rst5 = null;

	try {
		rst5 = RexlabelUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	int cnts2 = 0;

	if(rst5 == null) {
		cnts2 = 0;
	} else {
		cnts2 = rst5.length;
	}

	Timestamp now = new Timestamp(System.currentTimeMillis());
%>

<html>
<head>
<title> :: 일괄시험 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">	
	var num=0

	function ImgClick(imgname,fnum){
		var imgname = imgname;
		var imgname2 = "";
		var fnum = fnum;
		
		
		for (i=0; i<5; i++){
			if (i==fnum){
				var j = i + 1
				document[imgname].src="../../images/tabA0"+j+"_.gif"
			}else{
				var j = i + 1
				imgnamea = "tabA"+j;
				document[imgnamea].src="../../images/tabA0"+j+".gif"
			}
		}

	}
	
	var ArrId_exam_kind = new Array();
	
	// 초기값 셋팅..
	function inits() {

		var frm = document.form1;
		
		yn_sametimes("N"); // 초기값은 비동시평가로 셋팅(동시평가로 셋팅시 Y 로 변경) 
		id_randomtypes("NN"); // 출제유형 초기값 셋팅 (초기값 : 섞지않음)
		yn_open_qas("A"); // 성적관련 옵션 초기값 셋팅 (초기값 : 정답 및 해설 공개하지 않음)
		paper_change(11); // 시험지 미리보기 이미지 초기값 셋팅 
		idexlabels(11, document.form1.fontname.value, document.form1.fontsize.value); // 보기표시유형, 글꼴, 글자크기 초기값 셋팅
		pwd_check(); // 시험 비밀번호 셋팅
	}

	function idexlabels(selects, selects2, selects3) {

		var selects = Number(selects);
		var selects3 = Number(selects3);
		var str = "";
		var strArea = "";
		var ArrId_exlabel = new Array();
		<% for(int i=0; i<cnts2; i++) { %>
			ArrId_exlabel[<%=i%>] = <%=rst5[i].getId_exlabel()%>;
			
			if(ArrId_exlabel[<%=i%>] == selects) {
				str = "<%=rst5[i].getExlabel()%>";
			}
        <% } %>

		var arr_data = str.split(",");

		strArea += '<textarea cols=80 rows=5 style="font-family:' + selects2 + ';font-size:' + selects3 + 'pt";>';
		strArea += '1. 다음 중 데이터 베이스 관리 시스템(DBMS)의\n';
		strArea += '&nbsp;기능으로 볼 수 없는 것은?\n\n';
		strArea += arr_data[0] +' 사용자의 질의결과에 대한 보고서를 작성한다.\n';
		strArea += arr_data[1] +' 무결성 검사를 침해하는 접근을 거부한다.\n';
		strArea += arr_data[2] +' 데이터의 조작과 처리가 복잡하다.\n';
		strArea += arr_data[3] +' 데이터 사전기능을 제공한다\n';
		strArea += '\n\n';
		strArea += '2. Jack read a lot of books and magazines\n';
		strArea += '&nbsp;(      ) he was sick.\n\n';
		strArea += arr_data[0] +' for\n';
		strArea += arr_data[1] +' during\n';
		strArea += arr_data[2] +' while\n';
		strArea += arr_data[3] +' at\n';
		strArea += "</textarea>";

		document.all.prepares.innerHTML = strArea;
	}

	function paper_change(checks) {
		strImage = "";

		strImage += "<img src=../paper_img/qmtm_paper"+checks+".jpg width=180 height=120>";

		document.all.paperImg.innerHTML = strImage;
	}
	
	function yn_open_qas(checks) {
		var frm = document.form1;

		if(checks == "A") {
			// 성적조회 시작시간 Disabled
			frm.stat_start1.disabled = true;
			frm.stat_start2.disabled = true;
			frm.stat_start3.disabled = true;
			frm.stat_start4.disabled = true;

			// 성적조회 종료시간 Disabled
			frm.stat_end1.disabled = true;
			frm.stat_end2.disabled = true;
			frm.stat_end3.disabled = true;
			frm.stat_end4.disabled = true;

			// 성적통계 서비스 Disabled
			frm.yn_stat.disabled = true;
		} else if(checks == "B") {
			// 성적조회 시작시간 Disabled
			frm.stat_start1.disabled = true;
			frm.stat_start2.disabled = true;
			frm.stat_start3.disabled = true;
			frm.stat_start4.disabled = true;

			// 성적조회 종료시간 Disabled
			frm.stat_end1.disabled = true;
			frm.stat_end2.disabled = true;
			frm.stat_end3.disabled = true;
			frm.stat_end4.disabled = true;

			// 성적통계 서비스 Enabled
			frm.yn_stat.disabled = false;
		} else if(checks == "C") {
			// 성적조회 시작시간 Disabled
			frm.stat_start1.disabled = true;
			frm.stat_start2.disabled = true;
			frm.stat_start3.disabled = true;
			frm.stat_start4.disabled = true;

			// 성적조회 종료시간 Disabled
			frm.stat_end1.disabled = true;
			frm.stat_end2.disabled = true;
			frm.stat_end3.disabled = true;
			frm.stat_end4.disabled = true;

			// 성적통계 서비스 Enabled
			frm.yn_stat.disabled = false;
		} else if(checks == "D") {
			// 성적조회 시작시간 Enabled
			frm.stat_start1.disabled = false;
			frm.stat_start2.disabled = false;
			frm.stat_start3.disabled = false;
			frm.stat_start4.disabled = false;

			// 성적조회 종료시간 Enabled
			frm.stat_end1.disabled = false;
			frm.stat_end2.disabled = false;
			frm.stat_end3.disabled = false;
			frm.stat_end4.disabled = false;

			// 성적통계 서비스 Enabled
			frm.yn_stat.disabled = false;
		} else if(checks == "E") {
			// 성적조회 시작시간 Enabled
			frm.stat_start1.disabled = false;
			frm.stat_start2.disabled = false;
			frm.stat_start3.disabled = false;
			frm.stat_start4.disabled = false;

			// 성적조회 종료시간 Enabled
			frm.stat_end1.disabled = false;
			frm.stat_end2.disabled = false;
			frm.stat_end3.disabled = false;
			frm.stat_end4.disabled = false;

			// 성적통계 서비스 Enabled
			frm.yn_stat.disabled = false;
		} 
	}

	function time_set() {
		var frm = document.form1;

		if(frm.time_setting2.checked == true) {
			// 입장시작 시간 Disabled
			frm.login_start1.disabled = true;
			frm.login_start2.disabled = true;
			frm.login_start3.disabled = true;
			frm.login_start4.disabled = true;

			// 입장종료 시간 Disabled
			frm.login_end1.disabled = true;
			frm.login_end2.disabled = true;
			frm.login_end3.disabled = true;
			frm.login_end4.disabled = true;
		} else {
			// 입장시작 시간 Disabled
			frm.login_start1.disabled = false;
			frm.login_start2.disabled = false;
			frm.login_start3.disabled = false;
			frm.login_start4.disabled = false;

			// 입장종료 시간 Disabled
			frm.login_end1.disabled = false;
			frm.login_end2.disabled = false;
			frm.login_end3.disabled = false;
			frm.login_end4.disabled = false;
		}
	}
	
	function yn_sametimes(yn_check) {
		var frm = document.form1;

		if(yn_check == "N") {
			
			document.all.time_setting.style.display = "none";
			
			// 입장시작 시간 Disabled
			frm.login_start1.disabled = true;
			frm.login_start2.disabled = true;
			frm.login_start3.disabled = true;
			frm.login_start4.disabled = true;

			// 입장종료 시간 Disabled
			frm.login_end1.disabled = true;
			frm.login_end2.disabled = true;
			frm.login_end3.disabled = true;
			frm.login_end4.disabled = true;

		} else {

			document.all.time_setting.style.display = "block";

			if(frm.time_setting2.checked == false) {				
				
				// 입장시작 시간 Enabled
				frm.login_start1.disabled = false;
				frm.login_start2.disabled = false;
				frm.login_start3.disabled = false;
				frm.login_start4.disabled = false;

				// 입장종료 시간 Enabled
				frm.login_end1.disabled = false;
				frm.login_end2.disabled = false;
				frm.login_end3.disabled = false;
				frm.login_end4.disabled = false;
			} else {

				// 입장시작 시간 Disabled
				frm.login_start1.disabled = true;
				frm.login_start2.disabled = true;
				frm.login_start3.disabled = true;
				frm.login_start4.disabled = true;

				// 입장종료 시간 Disabled
				frm.login_end1.disabled = true;
				frm.login_end2.disabled = true;
				frm.login_end3.disabled = true;
				frm.login_end4.disabled = true;

			}
		}
	}

	function id_randomtypes(types) {

		var frm = document.form1;

		if(types == "NN") {
			frm.configs.value = "문제와 보기 순서를 섞지 않고 지정한 순서로 출제합니다.";
		} else if(types == "NQ") {
			frm.configs.value = "문제 순서를 섞어서 출제자가 지정한 수만큼 각각 다른 시험지를 만듭니다.";
		} else if(types == "NT") {
			frm.configs.value = "문제와 보기 순서를 섞어서 출제자가 지정한 수만큼 각각 다른 시험지를 만듭니다.";
		} else if(types == "YQ") {
			frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에 따라 검색한 문제 그룹에서 문제를 추출해서 각각 다른 시험지 유형을 만듭니다.";
		} else if(types == "YT") {
			frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에 따라 검색한 문제 그룹에서 문제를 추출해서 각 문제의 보기 순서를 섞어서 각각 다른 시험지 를 만듭니다.";
		} 
	}
	
	// 메뉴별로 페이지 보여주기..
	function movieLayout(obj) {
		if(obj == "basic") {
			document.all.id_basics.style.display = "block";
			document.all.id_details.style.display = "none";
			document.all.id_scores.style.display = "none";
			document.all.id_designs.style.display = "none";
			document.all.id_guides.style.display = "none";
		} else if(obj == "detail") {
			document.all.id_basics.style.display = "none";
			document.all.id_details.style.display = "block";
			document.all.id_scores.style.display = "none";
			document.all.id_designs.style.display = "none";
			document.all.id_guides.style.display = "none";
		} else if(obj == "score"){
		    document.all.id_basics.style.display = "none";
			document.all.id_details.style.display = "none";
			document.all.id_scores.style.display = "block";
			document.all.id_designs.style.display = "none";
			document.all.id_guides.style.display = "none";
		} else if(obj == "design"){
		    document.all.id_basics.style.display = "none";
			document.all.id_details.style.display = "none";
			document.all.id_scores.style.display = "none";
			document.all.id_designs.style.display = "block";
			document.all.id_guides.style.display = "none";
		} else if(obj == "guide"){
		    document.all.id_basics.style.display = "none";
			document.all.id_details.style.display = "none";
			document.all.id_scores.style.display = "none";
			document.all.id_designs.style.display = "none";
			document.all.id_guides.style.display = "block";
		}
	}

	function Send() {
		
		var frm = document.form1;

		if(frm.title.value.length == 0) {
			alert("시험명을 입력하세요.!!!");			
			return;
		}
		
		frm.submit();
	}

	function pwd_check() {
		
		var frm = document.form1;
		
		if(frm.exam_pwd_yn.checked) {
			document.all.pwd_str.style.display = "block";
		} else {
			document.all.pwd_str.style.display = "none";
		}
	}

</script>

</head>

<body id="popup2" onload="inits();">
	
	<form name="form1" action="exam_group_insert.jsp" method="post">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">
	<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">일괄시험 등록 <span>일괄로 시험을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 420px;">

		

		<div style="display:;" id="id_basics">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01_.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<!--■ 시험 정보 설정-->
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>시험명</td>
					<td colspan="3"><input type="text" class="input" name="title" size="55"></td>
				</tr>
				<tr>
					<td id="left"><li>시험구분</td>
					<td colspan="3"><select name="id_exam_kind" >
					<% for(int i=0; i<rst.length;i++) { %>
						<option value="<%=rst[i].getId_exam_kind()%>"><%=rst[i].getExam_kind()%></option>
					<% } %>
					</select>
					</td>
				</tr>
				
			</table>

			<!--■ 시험일정--><br>
			
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>평가유형</td>
					<td colspan="3"><div style="float: left;"><input type="radio" name="yn_sametime" value="N" checked onClick="yn_sametimes('N');">&nbsp;비동시평가&nbsp;<input type="radio" name="yn_sametime" value="Y" onClick="yn_sametimes('Y');">&nbsp;동시평가</div><div id="time_setting" style="float: left; margin-left: 15px;"><input type="checkbox" name="time_setting2" value="Y" onClick="time_set();" checked> 자동설정&nbsp;&nbsp;<b>(입장시작시간은 시험시작시간 10분전,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입장종료시간은 시험종료시간과 같게 설정)</b></div></td>
				</tr>
				<tr>
					<td id="left"><li>입장시작시간</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.login_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="login_start1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
					&nbsp;<select name="login_start2">
					<% 
						String jj = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj = "0"+String.valueOf(j);
							} else {
								jj = String.valueOf(j);
							}
					%>
					<option value="<%=jj%>" <%if(now.toString().substring(11,13).equals(jj)) { %> selected <% } %>><%=jj%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="login_start3" size="3" value="00"> 분&nbsp;<input type="text" class="input" name="login_start4" size="3" value="00"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>입장종료시간</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.login_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="login_end1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
					&nbsp;<select name="login_end2">
					<% 
						String jj2 = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj2 = "0"+String.valueOf(j);
							} else {
								jj2 = String.valueOf(j);
							}
					%>
					<option value="<%=jj2%>" <%if(now.toString().substring(11,13).equals(jj2)) { %> selected <% } %>><%=jj2%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="login_end3" size="3" value="00"> 분&nbsp;<input type="text" class="input" name="login_end4" size="3" value="00"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>시험시작시간</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.exam_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="exam_start1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
					&nbsp;<select name="exam_start2">
					<% 
						String jj3 = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj3 = "0"+String.valueOf(j);
							} else {
								jj3 = String.valueOf(j);
							}
					%>
					<option value="<%=jj3%>" <%if(now.toString().substring(11,13).equals(jj3)) { %> selected <% } %>><%=jj3%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="00"> 분&nbsp;<input type="text" class="input" name="exam_start4" size="3" value="00"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>시험종료시간</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.exam_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="exam_end1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
					&nbsp;<select name="exam_end2">
					<% 
						String jj4 = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj4 = "0"+String.valueOf(j);
							} else {
								jj4 = String.valueOf(j);
							}
					%>
					<option value="<%=jj4%>" <%if(now.toString().substring(11,13).equals(jj4)) { %> selected <% } %>><%=jj4%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="00"> 분&nbsp;<input type="text" class="input" name="exam_end4" size="3" value="00"> 초</div>
					</td>
				</tr>

			</table>
		</div>
	
		<!--■ 시험세부정보-->

		<div style="display:none;" id="id_details">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02_.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>


			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>시험유형</td>
					<td><input type="radio" name="id_exam_type" value="0" checked>평가형&nbsp;&nbsp;&nbsp;<input type="radio" name="id_exam_type" value="1">자유모의고사형</td>
				</tr>			
				<tr>
					<td id="left"><li>시험인증유형</td>
					<td><input type="radio" name="id_auth_type" value="0" checked>로그인&nbsp;&nbsp;&nbsp;<!--<input type="radio" name="id_auth_type" value="1" checked >과정&nbsp;&nbsp;&nbsp;--><input type="radio" name="id_auth_type" value="2" onClick="alert('시험인증유형이 접수형일 경우에는 하단에 만들기 버튼을 눌러서 저장 후 응시자 등록이 가능합니다.')">접수</td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>시험비밀번호</td>
					<td><div style="float: left;"><input type="checkbox" name="exam_pwd_yn" value="Y" onClick="pwd_check();">&nbsp;해당 시험에 비밀번호를 설정함</div><div id="pwd_str" style="float: left; margin-left: 15px;"><font color=blue><b>비밀번호 등록 :</b></font> <input type="text" name="exam_pwd_str" size="17" maxlength="15"></div></td>
				</tr>				
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>제한시간</td>
					<td><input type="text" class="input" name="limittime" size="5" value="60"> 분</td>
					<td id="left" width="120"><li>배점</td>
					<td><input type="text" class="input" name="allotting" size="5" value="100"> 점</td>
				</tr>
				<tr>
					<td id="left"><li>출제할 문제 수</td>
					<td><input type="text" class="input" name="qcount" size="5" value="20"> 문제</td>
					<td id="left"><li>화면당 문제 수</td>
					<td><input type="text" class="input" name="qcntperpage" size="5" value="1"> 문제</td>
				</tr>
				<tr>
					<td id="left"><li>페이지 이동방식</td>
					<td colspan="3"><input type="radio" name="id_movepage" value="F" checked>&nbsp;이전, 다음 자유이동&nbsp;<input type="radio" name="id_movepage" value="N">&nbsp;다음만 이동가능</td>
				</tr>
			</table>

			<!--■ 출제유형--><br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>출제유형</td>
					<td style="line-height: 200%;">
						<input type="radio" name="id_randomtype" value="NN" checked onClick="id_randomtypes(this.value)">섞지않음<br>
						<input type="radio" name="id_randomtype" value="NQ" onClick="id_randomtypes(this.value)">문제섞기&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NT" onClick="id_randomtypes(this.value)">문제 및 보기섞기<br>
						<input type="radio" name="id_randomtype" value="YQ" onClick="id_randomtypes(this.value)">문제추출 => 문제섞기&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YT" onClick="id_randomtypes(this.value)">문제추출 => 문제 및 보기섞기<hr>
						&nbsp;<textarea name="configs" cols="70" rows="4" readonly></textarea>
					</td>
				</tr>				
				
			</table>
		</div>

		<div style="display:none;" id="id_scores"> 

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03_.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="150"><li>득점공개 설정</td>
					<td><input type="checkbox" name="yn_open_score_direct" value="Y" >답안제출 직후 웹 시험지에서 득점 바로 공개</td>
				</tr>
				<tr>
					<td id="left"><li>성적공개 옵션</td>
					<td>&nbsp;<select name="yn_open_qa" onChange="yn_open_qas(this.value);">
					<option value="A">정답 및 해설 공개하지 않음</option>
					<option value="B">답안 제출 직후 점수만 공개</option>
					<option value="C">답안 제출 직후 점수 및 정답해설 공개</option>
					<option value="D">성적 조회 기간에 점수만 공개</option>
					<option value="E">성적 조회 기간에 점수 및 정답해설 공개</option>
					</select>
					</td>
				</tr>
				<tr>
					<td id="left"><li>성적조회 시작시간</td>
					<td><div style="float: left; margin: 1px 10px 0px 5px;"><a href="javascript:" onClick="MiniCal(document.all.stat_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="stat_start1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
					&nbsp;<select name="stat_start2">
					<% 
							String jj5 = "";
							for(int j=0; j<=23; j++) { 
								if(j < 10) {
									jj5 = "0"+String.valueOf(j);
								} else {
									jj5 = String.valueOf(j);
								}
						%>
						<option value="<%=jj5%>" <%if(now.toString().substring(11,13).equals(jj5)) { %> selected <% } %>><%=jj5%></option>
						<% } %></select>
					시&nbsp;<input type="text" class="input" name="stat_start3" size="3" value="00"> 분&nbsp;<input type="text" class="input" name="stat_start4" size="3" value="00"> 초</div></td>
				</tr>
				<tr>
					<td id="left"><li>성적조회 종료시간</td>
					<td><div style="float: left; margin: 1px 10px 0px 5px;"><a href="javascript:" onClick="MiniCal(document.all.stat_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="stat_end1" readonly size="12"  value="<%=now.toString().substring(0,10)%>">
					&nbsp;<select name="stat_end2">
					<% 
							String jj6 = "";
							for(int j=0; j<=23; j++) { 
								if(j < 10) {
									jj6 = "0"+String.valueOf(j);
								} else {
									jj6 = String.valueOf(j);
								}
						%>
						<option value="<%=jj6%>" <%if(now.toString().substring(11,13).equals(jj6)) { %> selected <% } %>><%=jj6%></option>
						<% } %></select>
					시&nbsp;<input type="text" class="input" name="stat_end3" size="3" value="00"> 분&nbsp;<input type="text" class="input" name="stat_end4" size="3" value="00"> 초</td>
				</tr>
				<tr>
					<td id="left"><li>통계제공 여부</td>
					<td><input type="checkbox" name="yn_stat" value="Y" >응시자에게 성적통계 제공</td>
				</tr>
			</table>
		</div>

		<div style="display:none;" id="id_designs">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04_.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>디자인 선택</td>
					<td style="padding-left: 20px;">
						<% for(int i=0; i<6; i++) { %>
						<input type="radio" name="paper_type" value="<%=paper_types[i]%>" <%if(paper_types[i].equals("11")) { %> checked <% } %> onClick="paper_change(this.value);">&nbsp;시험지디자인 <%=i+1%><br>
						<% } %>
					</td>
					<td align="right"><div id="paperImg"></div></td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>보기 표시 유형</td>
					<td><select name="id_exlabel" onChange="idexlabels(this.value,document.form1.fontname.value,document.form1.fontsize.value);">
					<% for(int i=0; i<rst5.length;i++) { %>
						<option value="<%=rst5[i].getId_exlabel()%>" <% if(rst5[i].getId_exlabel() == 11) { %> selected <% } %>><%=rst5[i].getExlabel()%></option>
					<% } %>
					</td>
					<td id="left" width="120"><li>화면 글꼴 설정</td>
					<td>
						<select name="fontname" onChange="idexlabels(document.form1.id_exlabel.value,this.value,document.form1.fontsize.value);">
						<option value="굴림">굴림</option>
						<option value="굴림체">굴림체</option>
						<option value="궁서">궁서</option>
						<option value="궁서체">궁서체</option>
						<option value="돋움">돋움</option>
						<option value="돋움체">돋움체</option>
						<option value="바탕">바탕</option>
						<option value="바탕체">바탕체</option>
						<option value="Nanum Gothic">나눔고딕(웹폰트)</option>
						<option value="Nanum Gothic Coding">나눔고딕코딩(웹폰트)</option>
						<option value="Malgun Gothic">맑은고딕</option>
						<option value="Arial">Arial</option>
						<option value="Courier New">Courier New</option>
						<option value="Times New Roman">Times New Roman</option>
						</select>
						&nbsp;
						<select name="fontsize" onChange="idexlabels(document.form1.id_exlabel.value,document.form1.fontname.value,this.value);">
						<option value="9">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td id="left" width="120"><li>글꼴 미리보기</td>
					<td align="left" id="prepares" colspan="3">&nbsp;</td>
				</tr>
			</table>
			<!--■ 기타 --><br>
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>기타 설정</td>
					<td><input type="checkbox" name="web_window_mode" value="1" checked>&nbsp;시험지를 전체창으로 표시함<br><input type="checkbox" name="log_option" value="Y">&nbsp;시험지 응시자 상세로그 기능을 사용함</td>
				</tr>
			</table>
		</div>

		<div style="display:none;" id="id_guides">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05_.gif"></a></div>

			<textarea name="guide" rows="15" cols="120" style="width: 100%;"></textarea>
		</div>

	</div>
	<div id="button">
		<TABLE  border="0" cellpadding ="0" cellspacing="0">
			<TR>
				<TD><img src="../../images/yj1_exam_write_bt1.gif"></TD>
				<TD style="background-image: url(../../images/yj1_exam_write_bt1_2.gif); background-repeat: repeat-x;"><input type="radio" name="yn_enable" value="N" checked></TD>
				<TD><img src="../../images/yj1_exam_write_bt1_1.gif"></TD>
				<TD><img src="../../images/yj1_exam_write_bt2.gif"></TD>
				<TD style="background-image: url(../../images/yj1_exam_write_bt2_2.gif); background-repeat: repeat-x;"><input type="radio" name="yn_enable" value="Y"></TD>
				<TD><img src="../../images/yj1_exam_write_bt2_1.gif"></TD>
				<TD><a href="javascript:Send();"><img src="../../images/yj1_exam_write_bt3.gif"></a></TD>
				<TD><a href="javascript:window.close();"><img src="../../images/yj1_exam_write_bt4.gif"></a></TD>
			</TR>
		</TABLE>
	</div>				

	</form>
	
 </BODY>
</HTML>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
<%
//******************************************************************************
//   프로그램 : exam_write.jsp
//   모 듈 명 : 시험등록
//   설    명 : 시험등록 페이지
//   테 이 블 : r_exlabel
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.RexlabelBean, 
//              qmtm.admin.tman.SubjectTmanUtil, qmtm.admin.tman.SubjectTmanBean, 
//              qmtm.tman.exam.ExamUtil, qmtm.tman.exam.RexlabelUtil, java.sql.Timestamp
//   작 성 일 : 2013-02-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.tman.SubjectTmanUtil, qmtm.admin.tman.SubjectTmanBean, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil, java.sql.Timestamp, java.util.Calendar" %>
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

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
			
	SubjectTmanBean bean = null;

	try {
		bean = SubjectTmanUtil.getLectureBean(id_course, id_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	int course_no = 1;

	try {
		course_no = ExamUtil.getOrderCnt(id_course, id_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
	// 보기표시유형 가지고오기
	RexlabelBean[] rst2 = null;

	try {
		rst2 = RexlabelUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	int cnts2 = 0;

	if(rst2 == null) {
		cnts2 = 0;
	} else {
		cnts2 = rst2.length;
	}

	Timestamp now = new Timestamp(System.currentTimeMillis());
	
	String exam_date = "";
	String exam_start_hour = "";
	String exam_start_minute = "";
	String exam_end_hour = "";
	String exam_end_minute = "";
	String exam_time = "";
	
	String login_date = "";
	String login_start_hour = "";
	String login_start_minute = "";
	String login_end_hour = "";
	String login_end_minute = "";
	
	if(bean.getExam_date().equals("")) {
		exam_date = now.toString().substring(0,10);
		exam_start_hour = now.toString().substring(11,13);
		exam_start_minute = "00";
		exam_end_hour = now.toString().substring(11,13);
		exam_end_minute = "00";
		
		login_date = now.toString().substring(0,10);
		login_start_hour = now.toString().substring(11,13);
		login_start_minute = "00";
		login_end_hour = now.toString().substring(11,13);
		login_end_minute = "00";
	} else {
		exam_date = bean.getExam_date().substring(0,4)+"-"+bean.getExam_date().substring(4,6)+"-"+bean.getExam_date().substring(6,8);
		exam_start_hour = bean.getExam_start_hour();
		exam_start_minute = bean.getExam_start_minute();
		exam_end_hour = bean.getExam_end_hour();
		exam_end_minute = bean.getExam_end_minute();
			
		login_date = bean.getExam_date().substring(0,4)+"-"+bean.getExam_date().substring(4,6)+"-"+bean.getExam_date().substring(6,8);
		
		Timestamp login_start_time = Timestamp.valueOf(login_date + " "+ bean.getExam_start_hour() +":"+bean.getExam_start_minute()+":00.0");
		
		login_start_time.setTime(login_start_time.getTime()-1200000);
			
		login_start_hour = login_start_time.toString().substring(11,13);
		login_start_minute = login_start_time.toString().substring(14,16);
		login_end_hour = bean.getExam_start_hour();
		login_end_minute = bean.getExam_start_minute();
	}
%>

<html>
<head>
<title> :: 신규시험 등록 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
	<script src="../../js/jquery-ui-1.10.2/jquery-1.9.1.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
	<script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( ".date_picker" ).datepicker();
	});
  </script>		

<script type="text/javascript">	
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
		
		yn_sametimes("Y"); // 초기값은 동시평가로 셋팅(비동시평가로 셋팅시 N 로 변경) 
		selects(1);
		id_randomtypes("NN"); // 출제유형 초기값 셋팅 (초기값 : 섞지않음)
		yn_open_qas("A"); // 성적관련 옵션 초기값 셋팅 (초기값 : 정답 및 해설 공개하지 않음)
		paper_change(11); // 시험지 미리보기 이미지 초기값 셋팅 
		idexlabels(11, document.form1.fontname.value, "10"); // 보기표시유형, 글꼴, 글자크기 초기값 셋팅
		pwd_check(); // 시험 비밀번호 셋팅
	}

	function idexlabels(selects, selects2, selects3) {

		var selects = Number(selects);
		var selects3 = Number(selects3);
		var str = "";
		var strArea = "";
		var ArrId_exlabel = new Array();
		<% for(int i=0; i<cnts2; i++) { %>
			ArrId_exlabel[<%=i%>] = <%=rst2[i].getId_exlabel()%>;
			
			if(ArrId_exlabel[<%=i%>] == selects) {
				str = "<%=rst2[i].getExlabel()%>";
			}
        <% } %>

		var arr_data = str.split(",");

		strArea += '<textarea cols=50 rows=5 style="font-family:' + selects2 + ';font-size:' + selects3 + 'pt";>';
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
	
	function yn_sametimes(yn_check) {
		var frm = document.form1;

		if(yn_check == "N") {
			
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
			frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에  따라 검색한 문제 그룹에서 문제를 추출해서  각각 다른 시험지를 만듭니다.";
		} else if(types == "YT") {			
			frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에  따라 검색한 문제 그룹에서 문제를 추출해서 각 문제의 보기 순서를 섞어서  각각 다른 시험지를 만듭니다.";
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

		if(frm.title.value.replace(/\s/g, "")==""){
			alert("시험명을 입력하세요.!!!");			
			return;
		} else if(frm.exam_pwd_yn.checked) {
			if(frm.exam_pwd_str.value.replace(/\s/g, "")==""){
				alert("시험세부설정에서 시험비밀번호를 입력하세요.!!!");
				return;
			}
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
	
	function pass_check() {
		
		var frm = document.form1;
		
		if(frm.yn_success_score.checked) {
			frm.success_score.disabled = false;
			frm.success_score.value = 60;
		} else {
			frm.success_score.disabled = true;
			frm.success_score.value = "";			
		}
	}
	
	function selects(k) {
		if(k == 2) {
			document.all.receipts.style.display = "block";
			document.all.receipts2.style.display = "none";
		} else if(k == 1) {
			document.all.receipts2.style.display = "block";
			document.all.receipts.style.display = "none";
		} else {
			document.all.receipts.style.display = "none";
			document.all.receipts2.style.display = "none";
		}
	}

</script>

</head>

<body id="popup2" onload="inits();">
	
	<form name="form1" action="exam_insert.jsp" method="post">
	<input type="hidden" name="id_category" value="<%=bean.getId_category()%>">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">
	<input type="hidden" name="course_year" value="<%=bean.getOpen_year()%>">
	<input type="hidden" name="course_no" value="<%=bean.getOpen_month()%>">
	<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">신규시험 등록 <span>새 시험을 등록합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 500px;">		

		<div style="display:;" id="id_basics">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01_.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<!--■ 시험 정보 설정-->
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>시험명</td>
					<td colspan="3"><input type="text" class="input" name="title" size="65"></td>
				</tr>
				<tr>
					<td id="left" width="100"><li>강좌코드</td>
					<td width=200><%=id_subject%></td>
					<td id="left" width="100"><li>교육년도/차수</td>
					<td><%=bean.getOpen_year()%>년/<%=bean.getOpen_month()%>차</td>
				</tr>
				<tr>
					<td id="left" width="100"><li>강좌명</td>
					<td colspan="3" ><%=bean.getSubject()%></td>			
				</tr>	
				<% if(bean.getId_category().substring(0,1).equals("E")) { %>
				<tr>
					<td id="left" width="100"><li>평가점수구분</td>
					<td colspan="3"><select name="exam_method">
					<option value="exam1" selected>평가1</option>
					<option value="exam2">평가2</option>
					<option value="exam3">평가3</option>
					<option value="exam4">평가4</option>
					<option value="exam5">평가5</option>
					</select></td>
				</tr>	
				<% } %>		
								
			</table>

			<!--■ 시험일정--><br>
			
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>평가유형</td>
					<td colspan="3"><div style="float: left;"><input type="radio" name="yn_sametime" value="N" onClick="yn_sametimes('N');" >&nbsp;비동시평가&nbsp;<input type="radio" name="yn_sametime" value="Y" onClick="yn_sametimes('Y');" checked>&nbsp;동시평가</div></td>
				</tr>
				<tr>
					<td id="left"><li>입장시작시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="login_start1" size="12" readonly value="<%=login_date%>">
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
					<option value="<%=jj%>" <%if(login_start_hour.equals(jj)) { %> selected <% } %>><%=jj%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="login_start3" size="3" value="<%=login_start_minute%>"> 분&nbsp;<input type="text" class="input" name="login_start4" size="3" value="00"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>입장종료시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="login_end1" size="12" readonly value="<%=login_date%>">
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
					<option value="<%=jj2%>" <%if(login_end_hour.equals(jj2)) { %> selected <% } %>><%=jj2%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="login_end3" size="3" value="<%=login_end_minute%>"> 분&nbsp;<input type="text" class="input" name="login_end4" size="3" value="00"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>시험시작시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="exam_start1" size="12" readonly value="<%=exam_date%>">
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
					<option value="<%=jj3%>" <%if(exam_start_hour.equals(jj3)) { %> selected <% } %>><%=jj3%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="<%=exam_start_minute%>"> 분&nbsp;<input type="text" class="input" name="exam_start4" size="3" value="00"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>시험종료시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="exam_end1" size="12" readonly value="<%=exam_date%>">
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
					<option value="<%=jj4%>" <%if(exam_end_hour.equals(jj4)) { %> selected <% } %>><%=jj4%></option>
					<% } %></select>
					시&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="<%=exam_end_minute%>"> 분&nbsp;<input type="text" class="input" name="exam_end4" size="3" value="00"> 초</div>
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
					<td><div style="float: left;"><input type="radio" name="id_auth_type" value="0" onClick="selects(0);">로그인&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="1" checked onClick="selects(1);">과정&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="2" onClick="selects(2);">접수</div><div id="receipts2" style="float: left; margin-left: 10px;"><input type="button" value="과정대상자확인" onClick="alert('시험인증유형이 과정형일 경우에는 하단에 만들기 버튼을 눌러서 저장 후 대상자 확인이 가능합니다.');" class="form"></div><div id="receipts" style="float: left; margin-left: 10px;"><input type="button" value="접수대상자등록" onClick="alert('시험인증유형이 접수형일 경우에는 하단에 만들기 버튼을 눌러서 저장 후 대상자 등록이 가능합니다.');" class="form"></div></td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>시험비밀번호</td>
					<td><div style="float: left;"><input type="checkbox" name="exam_pwd_yn" value="Y" onClick="pwd_check();" >&nbsp;해당 시험에 비밀번호를 설정함</div><div id="pwd_str" style="float: left; margin-left: 15px;"><b>비밀번호 등록 :</b> <input type="text" name="exam_pwd_str" size="17" maxlength="15" ></div></td>
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
					<td id="left"><li>합격점수</td>
					<td colspan="3"><input type="text" name="success_score" value="" size="5" disabled> 점&nbsp;<input type="checkbox" name="yn_success_score" value="Y" onClick="pass_check();"> 해당 시험에 합격점수를 설정함</td>
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
					<td><div style="float: left;"><input type="text" class="input date_picker" name="stat_start1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
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
					<td><div style="float: left;"><input type="text" class="input date_picker" name="stat_end1" readonly size="12"  value="<%=now.toString().substring(0,10)%>">
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
					<td><input type="checkbox" name="yn_stat" value="Y" > 응시자에게 성적통계 제공</td>
				</tr>				
			</table>
		</div>

		<div style="display:none;" id="id_designs">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04_.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>디자인 선택</td>
					<td style="padding-left: 20px;">
						<input type="radio" name="paper_type" value="11" checked onClick="paper_change(this.value);">&nbsp;시험지디자인 1<br>
						<input type="radio" name="paper_type" value="12" onClick="paper_change(this.value);">&nbsp;시험지디자인 2<br>
						<input type="radio" name="paper_type" value="13" onClick="paper_change(this.value);">&nbsp;시험지디자인 3<br>
						<input type="radio" name="paper_type" value="21" onClick="paper_change(this.value);">&nbsp;시험지디자인 4<br>
						<input type="radio" name="paper_type" value="22" onClick="paper_change(this.value);">&nbsp;시험지디자인 5<br>
						<input type="radio" name="paper_type" value="23" onClick="paper_change(this.value);">&nbsp;시험지디자인 6<br>
					</td>
					<td align="right"><div id="paperImg"></div></td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>보기 표시 유형</td>
					<td width="130"><select name="id_exlabel" onChange="idexlabels(this.value,document.form1.fontname.value,document.form1.fontsize.value);">						
					<% for(int i=0; i<rst2.length;i++) { %>
						<option value="<%=rst2[i].getId_exlabel()%>" <% if(rst2[i].getId_exlabel() == 11) { %> selected <% } %>><%=rst2[i].getExlabel()%></option>
					<% } %>
					</select></td>
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
						<option value="Arial">Arial</option>
						<option value="Courier New">Courier New</option>
						<!--<option value="Times New Roman">Times New Roman</option>-->
						</select>
						&nbsp;
						<select name="fontsize" onChange="idexlabels(document.form1.id_exlabel.value,document.form1.fontname.value,this.value);">
						<option value="10">9</option>
						<option value="10" selected>10</option>
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
					<td><input type="checkbox" name="web_window_mode" value="1" checked>&nbsp;시험지를 전체창으로 표시함<br><input type="checkbox" name="log_option" value="Y">&nbsp;시험지 응시자 상세로그 기능을 사용함<br><input type="checkbox" name="yn_activex" value="Y">&nbsp;시험지에 ACTIVEX 기능 사용함</td>
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
</HTML>
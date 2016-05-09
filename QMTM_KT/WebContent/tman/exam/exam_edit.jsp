<%
//******************************************************************************
//   프로그램 : exam_edit.jsp
//   모 듈 명 : 시험수정
//   설    명 : 시험수정 페이지
//   테 이 블 : exam_m, r_exam_kind, r_exam_kind_sub, r_std_grade, r_std_level
//   자바파일 : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//              qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//              qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//              qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   작 성 일 : 2008-04-17
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*, java.util.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;	
	}

	String userid = (String)session.getAttribute("userid");

	// 시험정보 가지고오기
	ExamCreateBean exams = null;

    try {
	    exams = ExamUtil.getBean(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));		

	    if(true) return;
    }

	// 시험지 생성유무 체크
	int exam_cnt = 0;

	try {
		exam_cnt = ExamUtil.getPaperCnt(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	int id_exam_kinds = exams.getId_exam_kind();

	// 그룹구분목록 가지고오기
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	// 시험지 디자인 가지고오기

	String paper_design = "";

	try {
		paper_design = TreeUtil.getDesign();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String[] paper_types = paper_design.split(",");	

	// 보기표시유형 가지고오기
	RexlabelBean[] rst5 = null;

	try {
		rst5 = RexlabelUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
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
<title>시험수정</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
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

<script language="javascript">	
	
	var ArrId_exam_kind = new Array();
	var ArrId_exam_kind_sub = new Array();
	var ArrExam_kind_sub = new Array();

	// 초기값 셋팅..
	function inits() {
		
		var frm = document.form1;
				
		time_set();
		yn_sametimes("<%=exams.getYn_sametime()%>"); // 초기값은 비동시평가로 셋팅(동시평가로 셋팅시 Y 로 변경) 
		id_randomtypes("<%=exams.getId_randomtype()%>"); // 출제유형 초기값 셋팅 (초기값 : 섞지않음)
		yn_open_qas("<%=exams.getYn_open_qa()%>"); // 성적관련 옵션 초기값 셋팅 (초기값 : 정답 및 해설 공개하지 않음)
		paper_change(<%=exams.getPaper_type()%>); // 시험지 미리보기 이미지 초기값 셋팅 
		idexlabels(<%=exams.getId_exlabel()%>, "<%=exams.getFontname()%>", <%=exams.getFontsize()%>); // 보기표시유형, 글꼴, 글자크기 초기값 셋팅
		selects(<%=exams.getId_auth_type()%>); // 시험인증유형(로그인 : 0, 과정 : 1, 접수 : 2)
		//pwd_check(); // 시험 비밀번호 셋팅
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

		strArea += '<textarea cols=65 rows=5 style="font-family:' + selects2 + ';font-size:' + selects3 + 'pt";>';
		strArea += '1. 다음 중 데이터 베이스 관리 시스템(DBMS)의\n';
		strArea += '기능으로 볼 수 없는 것은?\n\n';
		strArea += arr_data[0] +' 사용자의 질의결과에 대한 보고서를 작성한다.\n';
		strArea += arr_data[1] +' 무결성 검사를 침해하는 접근을 거부한다.\n';
		strArea += arr_data[2] +' 데이터의 조작과 처리가 복잡하다.\n';
		strArea += arr_data[3] +' 데이터 사전기능을 제공한다\n';
		strArea += '\n\n';
		strArea += '2. Jack read a lot of books and magazines\n';
		strArea += '(      ) he was sick.\n\n';
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

	function deletes() {
		var str = confirm("* 주의 해당 시험을 삭제하시겠습니까? \n\n해당 시험을 삭제하면 시험관련정보도 함께 삭제됩니다.\n단 이미 시험에 응시한 응시자가 있을경우에는 삭제할 수 없습니다.\n\n시험을 삭제하시겠습니까?");

		if(str == true) {
			location.href="exam_deletes_ok.jsp?id_exam=<%=id_exam%>&id_course=<%=exams.getId_course()%>";
		}
	}

	function selects(k) {
		if(k == 2) {
			document.all.receipts.style.display = "block";
		} else {
			document.all.receipts.style.display = "none";
		}
	}

	function receipt_inwon() {
		window.open("receipt_inwons.jsp?id_exam=<%=id_exam%>","receipts","width=950, height=680, scorollbars=yes");
	}	

</script>

</head>

<body id="popup2" onload="inits();">

	<form name="form1" action="exam_update.jsp" method="post">
	<input type="hidden" name="userid" value="<%=userid%>">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="id_course" value="<%=exams.getId_course()%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험 편집 <span>선택 시험의 설정을 변경합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 420px;">
		
		<div style="display:;" id="id_basics">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01_.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">

				<tr>
					<td id="left" width="100"><li>시험명</td>
					<td colspan="3"><input type="text" class="input" name="title" size="55" value="<%=exams.getTitle()%>"></td>
				</tr>
				<tr>
					<td id="left"><li>시험구분</td>
					<td colspan="3"><select name="id_exam_kind">
					<% for(int i=0; i<rst.length;i++) { %>
						<option value="<%=rst[i].getId_exam_kind()%>" <% if(exams.getId_exam_kind() == Integer.parseInt(rst[i].getId_exam_kind())) { %> selected <% } %>><%=rst[i].getExam_kind()%></option>
					<% } %>
					</select>
					</td>
				</tr>
			</table>

			<br>
			
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left"  width="100"><li>평가유형</td>
					<td colspan="3"><div style="float: left;"><input type="radio" name="yn_sametime" value="N" onClick="yn_sametimes('N');" <% if(exams.getYn_sametime().equals("N")) { %> checked <% } %>>비동시평가<input type="radio" name="yn_sametime" value="Y" onClick="yn_sametimes('Y');" <% if(exams.getYn_sametime().equals("Y")) { %> checked <% } %>>동시평가</div><div id="time_setting" style="float: left; margin-left: 15px;"><input type="checkbox" name="time_setting2" value="Y" onClick="time_set();" > 자동설정&nbsp;&nbsp;<b>(입장시작시간은 시험시작시간 10분전,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입장종료시간은 시험종료시간과 같게 설정)</b></div></td>
				</tr>
				<tr>
					<td id="left"><li>입장시작시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="login_start1" size="12" readonly value="<%=exams.getLogin_start().toString().substring(0,10)%>">
					<select name="login_start2">
					<% 
						String jj = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj = "0"+String.valueOf(j);
							} else {
								jj = String.valueOf(j);
							}
					%>
					<option value="<%=jj%>" <%if(exams.getLogin_start().toString().substring(11,13).equals(jj)) { %> selected <% } %>><%=jj%></option>
					<% } %></select>
					시<input type="text" class="input" name="login_start3" size="3" value="<%=exams.getLogin_start().toString().substring(14,16)%>"> 분<input type="text" class="input" name="login_start4" size="3" value="<%=exams.getLogin_start().toString().substring(17,19)%>"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>입장종료시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="login_end1" size="12" readonly value="<%=exams.getLogin_end().toString().substring(0,10)%>">
					<select name="login_end2">
					<% 
						String jj2 = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj2 = "0"+String.valueOf(j);
							} else {
								jj2 = String.valueOf(j);
							}
					%>
					<option value="<%=jj2%>" <%if(exams.getLogin_end().toString().substring(11,13).equals(jj2)) { %> selected <% } %>><%=jj2%></option>
					<% } %></select>
					시<input type="text" class="input" name="login_end3" size="3" value="<%=exams.getLogin_end().toString().substring(14,16)%>"> 분<input type="text" class="input" name="login_end4" size="3" value="<%=exams.getLogin_end().toString().substring(17,19)%>"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>시험시작시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="exam_start1" size="12" readonly value="<%=exams.getExam_start1().toString().substring(0,10)%>">
					<select name="exam_start2">
					<% 
						String jj3 = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj3 = "0"+String.valueOf(j);
							} else {
								jj3 = String.valueOf(j);
							}
					%>
					<option value="<%=jj3%>" <%if(exams.getExam_start1().toString().substring(11,13).equals(jj3)) { %> selected <% } %>><%=jj3%></option>
					<% } %></select>
					시<input type="text" class="input" name="exam_start3" size="3" value="<%=exams.getExam_start1().toString().substring(14,16)%>"> 분<input type="text" class="input" name="exam_start4" size="3" value="<%=exams.getExam_start1().toString().substring(17,19)%>"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>시험종료시간</td>
					<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="exam_end1" size="12" readonly value="<%=exams.getExam_end1().toString().substring(0,10)%>">
					<select name="exam_end2">
					<% 
						String jj4 = "";
						for(int j=0; j<=23; j++) { 
							if(j < 10) {
								jj4 = "0"+String.valueOf(j);
							} else {
								jj4 = String.valueOf(j);
							}
					%>
					<option value="<%=jj4%>" <%if(exams.getExam_end1().toString().substring(11,13).equals(jj4)) { %> selected <% } %>><%=jj4%></option>
					<% } %></select>
					시<input type="text" class="input" name="exam_end3" size="3" value="<%=exams.getExam_end1().toString().substring(14,16)%>"> 분<input type="text" class="input" name="exam_end4" size="3" value="<%=exams.getExam_end1().toString().substring(17,19)%>"> 초</div>
					</td>
				</tr>
			</table>

		</div>

		
		<div style="display:none;" id="id_details">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02_.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>


			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>시험유형</td>
					<td><input type="radio" name="id_exam_type" value="0" <% if(exams.getId_exam_type() == 0) { %> checked <% } %>>평가형&nbsp;&nbsp;&nbsp;<input type="radio" name="id_exam_type" value="1" <% if(exams.getId_exam_type() == 1) { %> checked <% } %>>자유모의고사형</td>
				</tr>			
				<tr>
					<td id="left"><li>시험인증유형</td>
					<td><div style="float: left;"><input type="radio" name="id_auth_type" value="0" <% if(exams.getId_auth_type() == 0) { %> checked <% } %> onClick="selects(0);">로그인&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="1" <% if(exams.getId_auth_type() == 1) { %> checked <% } %> onClick="selects(1);">과정&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="2" <% if(exams.getId_auth_type() == 2) { %> checked <% } %> onClick="selects(2);">접수</div><div id="receipts" style="float: left; margin-left: 20px;"><a href="javascript:receipt_inwon();" onfocus="this.blur();"><img src="../../images/bt_receipt_inwon_yj1.gif"></a></div></td>
				</tr>
			</table>
			
			<br>

			

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>제한시간</td>
					<td><input type="text" class="input" name="limittime" size="5" value="<%=exams.getLimittime() / 60%>"> 분</td>
					<td id="left" width="120"><li>배점</td>
					<td><input type="text" class="input" name="allotting" size="5" value="<%=exams.getAllotting()%>" <%if(exam_cnt> 0) {%> readonly <%}%>> 점</td>
				</tr>
				<tr>
					<td id="left"><li>출제할 문제 수</td>
					<td><input type="text" class="input" name="qcount" size="5" value="<%=exams.getQcount()%>" <%if(exam_cnt> 0) {%> readonly <%}%>> 문제</td>
					<td id="left"><li>화면당 문제 수</td>
					<td><input type="text" class="input" name="qcntperpage" size="5"  value="<%=exams.getQcntperpage()%>" <%if(exam_cnt> 0) {%> readonly <%}%>> 문제</td>
				</tr>
				<tr>
					<td id="left"><li>페이지 이동방식</td>
					<td colspan="3"><input type="radio" name="id_movepage" value="F" <% if(exams.getId_movepage().equals("F")) { %> checked <% } %>>이전, 다음 자유이동<input type="radio" name="id_movepage" value="N" <% if(exams.getId_movepage().equals("N")) { %> checked <% } %>>다음만 이동가능</td>
				</tr>
			</table>
			
			<br>


			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				
				<tr>
					<td id="left" width="120"><li>출제유형</td>
					<td style="line-height: 200%;">
						<input type="radio" name="id_randomtype" value="NN" checked onClick="id_randomtypes(this.value)" <% if(exams.getId_randomtype().equals("NN")) { %> checked <% } %> <%if(exam_cnt> 0) {%> readonly <%}%>>섞지않음<br>
						<input type="radio" name="id_randomtype" value="NQ" onClick="id_randomtypes(this.value);" <% if(exams.getId_randomtype().equals("NQ")) { %> checked <% } %> <%if(exam_cnt> 0) {%> readonly <%}%>>문제섞기&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NT" onClick="id_randomtypes(this.value)" <% if(exams.getId_randomtype().equals("NT")) { %> checked <% } %> <%if(exam_cnt> 0) {%> readonly <%}%>>문제 및 보기섞기<br>
						<input type="radio" name="id_randomtype" value="YQ" onClick="id_randomtypes(this.value)" <% if(exams.getId_randomtype().equals("YQ")) { %> checked <% } %> <%if(exam_cnt> 0) {%> readonly <%}%>>문제추출 => 문제섞기&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YT" onClick="id_randomtypes(this.value)" <% if(exams.getId_randomtype().equals("YT")) { %> checked <% } %> <%if(exam_cnt> 0) {%> readonly <%}%>>문제추출 => 문제 및 보기섞기

						<hr>
						&nbsp;<textarea name="configs" cols="70" rows="4" readonly></textarea>
					</td>
				
			</table>

		</div>

		<div style="display:none;" id="id_scores">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03_.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>
		
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="150"><li>득점공개 설정</td>
					<td><input type="checkbox" name="yn_open_score_direct" value="Y" <% if(exams.getYn_open_score_direct().equals("Y")) { %> checked <% } %>>답안제출 직후 웹 시험지에서 득점 바로 공개</td>
				</tr>
				<tr>
					<td id="left"><li>성적공개 옵션</td>
					<td>&nbsp;<select name="yn_open_qa" onChange="yn_open_qas(this.value);">
					<option value="A" <% if(exams.getYn_open_qa().equals("A")) { %> selected <% } %>>정답 및 해설 공개하지 않음</option>
					<option value="B" <% if(exams.getYn_open_qa().equals("B")) { %> selected <% } %>>답안 제출 직후 점수만 공개</option>
					<option value="C" <% if(exams.getYn_open_qa().equals("C")) { %> selected <% } %>>답안 제출 직후 점수 및 정답해설 공개</option>
					<option value="D" <% if(exams.getYn_open_qa().equals("D")) { %> selected <% } %>>성적 조회 기간에 점수만 공개</option>
					<option value="E" <% if(exams.getYn_open_qa().equals("E")) { %> selected <% } %>>성적 조회 기간에 점수 및 정답해설 공개</option>
					</select>
					</td>				
				</tr>
				<tr>
					<td id="left"><li>성적조회 시작시간</td>
					<td><div style="float: left;"><input type="text" class="input date_picker" name="stat_start1" size="12" readonly value="<%=exams.getStat_start().toString().substring(0,10)%>">
					<select name="stat_start2">
					<% 
							String jj5 = "";
							for(int j=0; j<=23; j++) { 
								if(j < 10) {
									jj5 = "0"+String.valueOf(j);
								} else {
									jj5 = String.valueOf(j);
								}
						%>
						<option value="<%=jj5%>" <%if(exams.getStat_start().toString().substring(11,13).equals(jj5)) { %> selected <% } %>><%=jj5%></option>
						<% } %></select>
					시<input type="text" class="input" name="stat_start3" size="3" value="<%=exams.getStat_start().toString().substring(14,16)%>"> 분<input type="text" class="input" name="stat_start4" size="3" value="<%=exams.getStat_start().toString().substring(17,19)%>"> 초</div></td>
				</tr>
				<tr>
					<td id="left"><li>성적조회 종료시간</td>
					<td><div style="float: left;"><input type="text" class="input date_picker" name="stat_end1" size="12" readonly value="<%=exams.getStat_end().toString().substring(0,10)%>">
					<select name="stat_end2">
					<% 
							String jj6 = "";
							for(int j=0; j<=23; j++) { 
								if(j < 10) {
									jj6 = "0"+String.valueOf(j);
								} else {
									jj6 = String.valueOf(j);
								}
						%>
						<option value="<%=jj6%>" <%if(exams.getStat_end().toString().substring(11,13).equals(jj6)) { %> selected <% } %>><%=jj6%></option>
						<% } %></select>
					시<input type="text" class="input" name="stat_end3" size="3" value="<%=exams.getStat_end().toString().substring(14,16)%>"> 분<input type="text" class="input" name="stat_end4" size="3" value="<%=exams.getStat_end().toString().substring(17,19)%>"> 초</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>통계제공 여부</td>
					<td><input type="checkbox" name="yn_stat" value="Y" <% if(exams.getYn_stat().equals("Y")) { %> checked <% } %>>응시자에게 성적통계 제공<!--&nbsp;&nbsp;<input type="checkbox" name="yn_stat_r" value="Y" <% if(exams.getYn_stat_r().equals("Y")) { %> checked <% } %>>단원별 요구수준 사용--></td>
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
						<input type="radio" name="paper_type" value="<%=paper_types[i]%>" <%if(exams.getPaper_type() == Integer.parseInt(paper_types[i])) { %> checked <% } %>  onClick="paper_change(this.value);">&nbsp;시험지디자인 <%=i+1%><br>
						<% } %>
					</td>
					<td align="right"><div id="paperImg"></div></td>
				</tr>
			</table>
			<br>
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>보기 표시 유형</td>
					<td>
						<select name="id_exlabel" onChange="idexlabels(this.value,document.form1.fontname.value,document.form1.fontsize.value);">
						<% for(int i=0; i<rst5.length;i++) { %>
							<option value="<%=rst5[i].getId_exlabel()%>" <% if(rst5[i].getId_exlabel() == exams.getId_exlabel()) { %> selected <% } %>><%=rst5[i].getExlabel()%></option>
						<% } %>
					</td>
					<td id="left" width="120"><li>화면 글꼴 설정</td>
					<td>
						<select name="fontname" onChange="idexlabels(document.form1.id_exlabel.value,this.value,document.form1.fontsize.value);">
							<option value="굴림" <% if(exams.getFontname().equals("굴림")) { %> selected <% } %>>굴림</option>
							<option value="굴림체" <% if(exams.getFontname().equals("굴림체")) { %> selected <% } %>>굴림체</option>
							<option value="궁서" <% if(exams.getFontname().equals("궁서")) { %> selected <% } %>>궁서</option>
							<option value="궁서체" <% if(exams.getFontname().equals("궁서체")) { %> selected <% } %>>궁서체</option>
							<option value="돋움" <% if(exams.getFontname().equals("돋움")) { %> selected <% } %>>돋움</option>
							<option value="돋움체" <% if(exams.getFontname().equals("돋움체")) { %> selected <% } %>>돋움체</option>
							<option value="바탕" <% if(exams.getFontname().equals("바탕")) { %> selected <% } %>>바탕</option>
							<option value="바탕체" <% if(exams.getFontname().equals("바탕체")) { %> selected <% } %>>바탕체</option>
							<option value="Arial" <% if(exams.getFontname().equals("Arial")) { %> selected <% } %>>Arial</option>
							<option value="Courier New" <% if(exams.getFontname().equals("Courier New")) { %> selected <% } %>>Courier New</option>
							<option value="Times New Roman" <% if(exams.getFontname().equals("Times New Roman")) { %> selected <% } %>>Times New Roman</option>
							</select><select name="fontsize" onChange="idexlabels(document.form1.id_exlabel.value,document.form1.fontname.value,this.value);">
							<option value="9" <% if(exams.getFontsize() == 9) { %> selected <% } %>>9</option>
							<option value="10" <% if(exams.getFontsize() == 10) { %> selected <% } %>>10</option>
							<option value="11" <% if(exams.getFontsize() == 11) { %> selected <% } %>>11</option>
							<option value="12" <% if(exams.getFontsize() == 12) { %> selected <% } %>>12</option>
							<option value="13" <% if(exams.getFontsize() == 13) { %> selected <% } %>>13</option>
							<option value="14" <% if(exams.getFontsize() == 14) { %> selected <% } %>>14</option>
						</select>
					</td>
				</tr>
				<tr>
					<td id="left" width="120"><li>글꼴 미리보기</td>
					<td align="left" id="prepares" colspan="3">&nbsp;</td>
				</tr>
			</table>
			<br>
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>기타 설정</td>
					<td><input type="checkbox" name="web_window_mode" value="1" <%if(exams.getWeb_window_mode() == 1) { %> checked <% } %>>&nbsp;시험지를 전체창으로 표시함</td>
				</tr>
			</table>
		
		</div>

		<div style="display:none;" id="id_guides">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05_.gif"></a></div>

			<textarea name="guide" rows="15" cols="120" style="width: 100%;"><%if (exams.getGuide() == null) { %><% } else { %><%=exams.getGuide()%><% } %></textarea>

		</div>
	</div>

	<div id="button">
	<TABLE  border="0" cellpadding ="0" cellspacing="0">
			<TR>
				<TD><img src="../../images/yj1_exam_write_bt1.gif"></TD>
				<TD style="background-image: url(../../images/yj1_exam_write_bt1_2.gif); background-repeat: repeat-x;"><input type="radio" name="yn_enable" value="N" <%if(exams.getYn_enable().equals("N")) { %> checked <% } %>></TD>
				<TD><img src="../../images/yj1_exam_write_bt1_1.gif"></TD>
				<TD><img src="../../images/yj1_exam_write_bt2.gif"></TD>
				<TD style="background-image: url(../../images/yj1_exam_write_bt2_2.gif); background-repeat: repeat-x;"><input type="radio" name="yn_enable" value="Y" <%if(exams.getYn_enable().equals("Y")) { %> checked <% } %>></TD>
				<TD><img src="../../images/yj1_exam_write_bt2_1.gif"></TD>
				<TD><a href="javascript:Send();"><img src="../../images/yj1_exam_write_bt5.gif"></a></TD>
				<TD><a href="javascript:deletes();"><img src="../../images/yj1_exam_write_bt6.gif"></a></TD>
				<TD><a href="javascript:window.close();"><img src="../../images/yj1_exam_write_bt4.gif"></a></TD>
			</TR>
		</TABLE>
			
	</div>				

	</form>
	
 </BODY>
</HTML>
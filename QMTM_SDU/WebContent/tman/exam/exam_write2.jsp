<%
//******************************************************************************
//   프로그램 : exam_write.jsp
//   모 듈 명 : 시험등록
//   설    명 : 시험등록 페이지
//   테 이 블 : exam_m, r_exam_kind, r_exam_kind_sub, r_std_grade, r_std_level
//   자바파일 : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//              qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//              qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//              qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   작 성 일 : 2008-04-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*, java.util.*" %>
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
	
	// 그룹구분목록 가지고오기
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// 시험구분목록 가지고오기
	ExamKindSubBean[] rst2 = null;

	try {
		rst2 = ExamKindSubUtil.getExamBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	int cnts = 0;

	if(rst2 == null) {
		cnts = 0;
	} else {
		cnts = rst2.length;
	}

	// 학년코드목록 가지고오기
	StdGradeBean[] rst3 = null;

	try {
		rst3 = StdGradeUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// 레벨코드목록 가지고오기
	StdLevelBean[] rst4 = null;

	try {
		rst4 = StdLevelUtil.getBeans();
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
<title>시험추가</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">	
	
	var ArrId_exam_kind = new Array();
	var ArrId_exam_kind_sub = new Array();
	var ArrExam_kind_sub = new Array();

	// 초기값 셋팅..
	function inits() {

		var frm = document.form1;
		
		exam_kind_change(1); // 시험구분 목록 초기값...(Admin페이지에서 시험구분목록에 데이타가 입력 후 사용)
		yn_sametimes("N"); // 초기값은 비동시평가로 셋팅(동시평가로 셋팅시 Y 로 변경) 
		id_randomtypes("NN"); // 출제유형 초기값 셋팅 (초기값 : 섞지않음)
		yn_open_qas("A"); // 성적관련 옵션 초기값 셋팅 (초기값 : 정답 및 해설 공개하지 않음)
		paper_change(11); // 시험지 미리보기 이미지 초기값 셋팅 
		idexlabels(11, document.form1.fontname.value, document.form1.fontsize.value); // 보기표시유형, 글꼴, 글자크기 초기값 셋팅
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

		strArea += '&nbsp;&nbsp;<textarea cols=65 rows=5 style="font-family:' + selects2 + ';font-size:' + selects3 + 'pt";>';
		strArea += '1. 다음 중 데이터 베이스 관리 시스템(DBMS)의\n';
		strArea += '&nbsp;&nbsp;&nbsp;기능으로 볼 수 없는 것은?\n\n';
		strArea += arr_data[0] +' 사용자의 질의결과에 대한 보고서를 작성한다.\n';
		strArea += arr_data[1] +' 무결성 검사를 침해하는 접근을 거부한다.\n';
		strArea += arr_data[2] +' 데이터의 조작과 처리가 복잡하다.\n';
		strArea += arr_data[3] +' 데이터 사전기능을 제공한다\n';
		strArea += '\n\n';
		strArea += '2. Jack read a lot of books and magazines\n';
		strArea += '&nbsp;&nbsp;&nbsp;(      ) he was sick.\n\n';
		strArea += arr_data[0] +' for\n';
		strArea += arr_data[1] +' during\n';
		strArea += arr_data[2] +' while\n';
		strArea += arr_data[3] +' at\n';
		strArea += "</textarea>";

		document.all.prepares.innerHTML = strArea;
	}

	function paper_change(checks) {
		strImage = "";

		strImage += "<img src=../paper_img/qmtm_paper"+checks+".jpg width=300 height=180>";

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
			frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에 따라 검색한 문제 그룹에서 문제를 추출해서 각각 다른 시험지 유형을 만듭니다.";
		} else if(types == "YT") {
			frm.configs.value = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에 따라 검색한 문제 그룹에서 문제를 추출해서 각 문제의 보기 순서를 섞어서 각각 다른 시험지 를 만듭니다.";
		} 
	}

	// 그룹구분목록 선택시 시험구분 목록 보여주기...
	function exam_kind_change(selects) {
		var str = "";
		var ArrId_exam_kind = new Array();
		str += "&nbsp;&nbsp;<select name=id_exam_kind_sub>";
		<% for(int i=0; i<cnts; i++) { %>
			
			ArrId_exam_kind[<%=i%>] = <%=rst2[i].getId_exam_kind()%>;
						
			if(ArrId_exam_kind[<%=i%>] == selects) {
				str += "<option value=<%=rst2[i].getId_exam_kind_sub()%>><%=rst2[i].getExam_kind_sub()%></option>";
			}
        <% } %>
			
		str += "</select>";
		document.all.exam_kind_sub.innerHTML = str;		
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

		if(frm.course_no.value.length == 0) {
			alert("시험회차를 입력하세요.!!!");			
			return;
		}

		frm.submit();
	}
</script>

</head>

<body id="popup" onload="inits();">

	<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR id="top">
			<TD id="left"></TD>
			<TD id="right"></TD>
		</TR>
		<TR id="main">
			<TD id="left">

				<div class="title">시험등록</div>
<form name="form1" action="exam_insert.jsp" method="post">
<input type="hidden" name="id_course" value="<%=id_course%>">
<input type="hidden" name="id_subject" value="<%=id_subject%>">

<table border="0" width="100%">
	<tr align="left">

		<td><input type="button" value="시험기본설정" onClick="movieLayout('basic')"><!--<a href="javascript:movieLayout('basic');"><img src="../../../images/bt_exam_w1.gif"></a>&nbsp;&nbsp;--><input type="button" value="시험세부설정" onClick="movieLayout('detail')"><!--<a href="javascript:movieLayout('detail');"><img src="../../../images/bt_exam_w2.gif"></a>&nbsp;&nbsp;--><input type="button" value="성적관련설정" onClick="movieLayout('score')"><!--<a href="javascript:movieLayout('score');"><img src="../../../images/bt_exam_w3.gif"></a>&nbsp;&nbsp;--><input type="button" value="시험디자인" onClick="movieLayout('design')"><!--<a href="javascript:movieLayout('design');"><img src="../../../images/bt_exam_w4.gif"></a>&nbsp;&nbsp;--><input type="button" value="시험안내" onClick="movieLayout('guide')"><!--<a href="javascript:movieLayout('guide');"><img src="../../../images/bt_exam_w5.gif"></a>--></td>
	</tr>
</table>

<br>

<table border="0" width="100%" style="display:block;" id="id_basics" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
		<tr height="30" bgcolor="#FFFFFF">
				<td align="left" colspan="4">■ 시험설정</td>
			</tr>

		<tr  bgcolor="#FFFFFF">
				<td width="20%" align="right">시험명&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="title" size="55"></td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">그룹구분&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<select name="id_exam_kind" onChange="exam_kind_change(this.value);">
				<% for(int i=0; i<rst.length;i++) { %>
					<option value="<%=rst[i].getId_exam_kind()%>"><%=rst[i].getExam_kind()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">시험구분&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3" id="exam_kind_sub">
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">학년구분&nbsp;</td>
				<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="std_grade">
				<% for(int i=0; i<rst3.length;i++) { %>
					<option value="<%=rst3[i].getStd_grade()%>"><%=rst3[i].getGrade_nm()%></option>
				<% } %>
				</select>
				</td>
				<td width="20%" align="right">레벨구분&nbsp;</td>
				<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="std_level">
				<% for(int i=0; i<rst4.length;i++) { %>
					<option value="<%=rst4[i].getStd_level()%>"><%=rst4[i].getLevel_nm()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">시험회차&nbsp;</td>
				<td bgcolor="#FFFFFF" width="30%">&nbsp;&nbsp;<input type="text" class="input" name="course_no" size="7"> 회</td>
				<td width="20%" align="right">통 계&nbsp;</td>
				<td bgcolor="#FFFFFF">&nbsp;&nbsp;상위 <input type="text" class="input" name="u_avg_basis" size="3"> % 평균</td>
			</tr>

			<tr height="30" bgcolor="#FFFFFF">
				<td align="left" colspan="4">■ 시험일정</td>
			</tr>

			<tr  bgcolor="#FFFFFF">
				<td width="20%" align="right">평가유형&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="yn_sametime" value="N" checked onClick="yn_sametimes('N');">&nbsp;비동시평가&nbsp;&nbsp;&nbsp;<input type="radio" name="yn_sametime" value="Y" onClick="yn_sametimes('Y');">&nbsp;동시평가</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">입장시작시간&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="login_start1" size="12"  value="<%=now.toString().substring(0,10)%>">
				&nbsp;&nbsp;&nbsp;<select name="login_start2">
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
				시&nbsp;<input type="text" class="input" name="login_start3" size="3" value="<%=now.toString().substring(14,16)%>"> 분&nbsp;<input type="text" class="input" name="login_start4" size="3" value="00"> 초
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">입장종료시간&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="login_end1" size="12"  value="<%=now.toString().substring(0,10)%>">
				&nbsp;&nbsp;&nbsp;<select name="login_end2">
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
				시&nbsp;<input type="text" class="input" name="login_end3" size="3" value="<%=now.toString().substring(14,16)%>"> 분&nbsp;<input type="text" class="input" name="login_end4" size="3" value="00"> 초
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">시험시작시간&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="exam_start1" size="12"  value="<%=now.toString().substring(0,10)%>">
				&nbsp;&nbsp;&nbsp;<select name="exam_start2">
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
				시&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="<%=now.toString().substring(14,16)%>"> 분&nbsp;<input type="text" class="input" name="exam_start4" size="3" value="00"> 초
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">시험종료시간&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="exam_end1" size="12"  value="<%=now.toString().substring(0,10)%>">
				&nbsp;&nbsp;&nbsp;<select name="exam_end2">
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
				시&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="<%=now.toString().substring(14,16)%>"> 분&nbsp;<input type="text" class="input" name="exam_end4" size="3" value="00"> 초
				</td>
			</tr>
		</table>
		

	<table border="0" width="100%" style="display:none;" id="id_details" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
		<tr  bgcolor="#FFFFFF">
			<td width="20%" align="right">시험유형&nbsp;</td>
			<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_exam_type" value="0" checked>&nbsp;&nbsp;평가형&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="id_exam_type" value="1">&nbsp;&nbsp;자유모의고사형</td>
		</tr>			
		<tr  bgcolor="#FFFFFF">
			<td width="20%" align="right">시험인증유형&nbsp;</td>
			<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="0">&nbsp;&nbsp;로그인&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="1" checked>&nbsp;&nbsp;과정<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="2">&nbsp;&nbsp;접수--></td>
		</tr>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="left" colspan="4">■ 시험세부정보</td>
		</tr>

		<tr height="30" bgcolor="#FFFFFF">
			<td width="20%" align="right">제한시간&nbsp;</td>
			<td bgcolor="#FFFFFF" width="30%">&nbsp;&nbsp;<input type="text" class="input" name="limittime" size="5" value="60"> 분</td>
			<td width="20%" align="right">배점&nbsp;</td>
			<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="allotting" size="5" value="100"> 점</td>
		</tr>
		<tr height="30" bgcolor="#FFFFFF">
			<td width="20%" align="right">출제할 문제 수&nbsp;</td>
			<td bgcolor="#FFFFFF" width="30%">&nbsp;&nbsp;<input type="text" class="input" name="qcount" size="5" value="20"> 문제</td>
			<td width="20%" align="right">화면당 문제 수&nbsp;</td>
			<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="qcntperpage" size="5" value="1"> 문제</td>
		</tr>
		<tr  bgcolor="#FFFFFF">
			<td width="20%" align="right">페이지 이동방식&nbsp;</td>
			<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_movepage" value="F" checked>&nbsp;이전, 다음 자유이동&nbsp;&nbsp;&nbsp;<input type="radio" name="id_movepage" value="N">&nbsp;다음만 이동가능</td>
		</tr>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="left" colspan="4">■ 출제유형</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="65%" align="left" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NN" checked onClick="id_randomtypes(this.value)">&nbsp;&nbsp;섞지않음</td>
			<td width="35%" rowspan="3">&nbsp;<textarea name="configs" cols="30" rows="5" readonly></textarea></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="65%" align="left" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NQ" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;문제섞기&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NT" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;문제 및 보기섞기</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="65%" align="left" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YQ" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;문제추출 => 문제섞기&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YT" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;문제추출 => 문제 및 보기섞기</td>
		</tr>
	</table>
	
	<table border="0" width="100%" style="display:none;" id="id_scores" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF">
			<td bgcolor="#FFFFFF" colspan="2">&nbsp;&nbsp;<input type="checkbox" name="yn_open_score_direct" value="Y" >&nbsp;&nbsp;답안제출 직후 웹 시험지에서 득점 바로 공개</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" colspan="2">&nbsp;&nbsp;&nbsp;<select name="yn_open_qa" onChange="yn_open_qas(this.value);">
			<option value="A">정답 및 해설 공개하지 않음</option>
			<option value="B">답안 제출 직후 점수만 공개</option>
			<option value="C">답안 제출 직후 점수 및 정답해설 공개</option>
			<option value="D">성적 조회 기간에 점수만 공개</option>
			<option value="E">성적 조회 기간에 점수 및 정답해설 공개</option>
			</select>
			</td>				
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" width="27%" align="right">&nbsp;&nbsp;성적조회 시작시간</td>
			<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="stat_start1" size="12"  value="<%=now.toString().substring(0,10)%>">
			&nbsp;&nbsp;&nbsp;<select name="stat_start2">
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
			시&nbsp;<input type="text" class="input" name="stat_start3" size="3" value="<%=now.toString().substring(14,16)%>"> 분&nbsp;<input type="text" class="input" name="stat_start4" size="3" value="00"> 초</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" width="27%" align="right">&nbsp;&nbsp;성적조회 종료시간</td>
			<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="stat_end1" size="12"  value="<%=now.toString().substring(0,10)%>">
			&nbsp;&nbsp;&nbsp;<select name="stat_end2">
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
			시&nbsp;<input type="text" class="input" name="stat_end3" size="3" value="<%=now.toString().substring(14,16)%>"> 분&nbsp;<input type="text" class="input" name="stat_end4" size="3" value="00"> 초</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" colspan="2">&nbsp;&nbsp;<input type="checkbox" name="yn_stat" value="Y" >&nbsp;&nbsp;응시자에게 성적통계 제공</td>
		</tr>
	</table>

	<table border="0" width="100%"  style="display:none;" id="id_designs" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">	
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="40%">
		<% for(int i=0; i<6; i++) { %>
		&nbsp;&nbsp;<input type="radio" name="paper_type" value="<%=paper_types[i]%>" <%if(paper_types[i].equals("11")) { %> checked <% } %> onClick="paper_change(this.value);">&nbsp;시험지디자인 <%=i+1%><br>
		<% } %>
		</td>
		<td bgcolor="#FFFFFF" width="60%" align="center" id="paperImg"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="40%">&nbsp;&nbsp;보기 표시 유형</td>
		<td bgcolor="#FFFFFF" width="60%">&nbsp;&nbsp;화면 글꼴 설정</td>
	</tr>
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="40%">&nbsp;&nbsp;<select name="id_exlabel" onChange="idexlabels(this.value,document.form1.fontname.value,document.form1.fontsize.value);">
		<% for(int i=0; i<rst5.length;i++) { %>
			<option value="<%=rst5[i].getId_exlabel()%>" <% if(rst5[i].getId_exlabel() == 11) { %> selected <% } %>><%=rst5[i].getExlabel()%></option>
		<% } %>
		</td>
		<td bgcolor="#FFFFFF" width="60%">&nbsp;&nbsp;<select name="fontname" onChange="idexlabels(document.form1.id_exlabel.value,this.value,document.form1.fontsize.value);">
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
		</select>&nbsp;&nbsp;<select name="fontsize" onChange="idexlabels(document.form1.id_exlabel.value,document.form1.fontname.value,this.value);">
		<option value="9">9</option>
		<option value="10">10</option>
		<option value="11">11</option>
		<option value="12">12</option>
		<option value="13">13</option>
		<option value="14">14</option>
		</select>
		</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td align="left" colspan="2" id="prepares"></td>
	</tr>

	<tr bgcolor="#FFFFFF" height="30">
		<td align="left" colspan="2">■ 기타</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="68%" align="left" colspan="2">&nbsp;&nbsp;<input type="checkbox" name="web_window_mode" value="1" checked>&nbsp;시험지를 전체창으로 표시함&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="log_option" value="Y">&nbsp;시험지 응시자 상세로그 기능을 사용함</td>
	</tr>
</table>

<table border="0" width="100%"  style="display:none;" id="id_guides" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">	
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="100%">&nbsp;&nbsp;<textarea name="guide" cols="90" rows="10"></textarea></td>
	</tr>
</table>	

	<p>
	<input type="radio" name="yn_enable" value="N" checked> 시험준비&nbsp;&nbsp;<input type="radio" name="yn_enable" value="Y"> 시험가능&nbsp;&nbsp;<input type="button" value="만들기" onClick="Send();">&nbsp;&nbsp;<input type="button" onclick="window.close();" value="창닫기">

	</form>
		</TD>
		<!--/ 우측 버튼 삽입 공간 /-->
		<TD id="right"><img src="../../images/bt_popup_close.gif"></TD>
		</TR>
	</TABLE>
	
 </BODY>
</HTML>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
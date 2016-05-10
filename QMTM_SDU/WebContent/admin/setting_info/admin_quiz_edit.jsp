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
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");	
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
	
</script>

</head>

<body id="popup2">
	
	<form name="form1" action="exam_insert.jsp" method="post">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">관리기능 설정 <span>관리기능을 설정합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 500px;">		

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>성적공개기간설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>공개옵션</td>
				<td width="70%">&nbsp;<select name="SCORE_OPEN_OPTION">
				<option value="A">정답 및 해설 공개하지 않음</option>
				<option value="D">성적 조회 기간에 점수만 공개</option>
				<option value="E">성적 조회 기간에 점수 및 정답해설 공개</option>					
				</select></td>
			</tr>
			<tr>
				<td id="left"><li>공개시작시간</td>
				<td><div style="float: left;"><input type="text" class="input date_picker" name="SCORE_OPEN_SDATE1" size="12" readonly value="">
				&nbsp;<select name="SCORE_OPEN_SDATE2">
				<% 
					String jj = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj = "0"+String.valueOf(j);
						} else {
							jj = String.valueOf(j);
						}
				%>
				<option value="<%=jj%>"><%=jj%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="SCORE_OPEN_SDATE3" size="3" value="00"> 분</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>공개종료시간</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="SCORE_OPEN_EDATE1" size="12" readonly value="">
				&nbsp;<select name="SCORE_OPEN_EDATE2">
				<% 
					String jj2 = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj2 = "0"+String.valueOf(j);
						} else {
							jj2 = String.valueOf(j);
						}
				%>
				<option value="<%=jj2%>" ><%=jj2%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="SCORE_OPEN_EDATE3" size="3" value="00"> 분</div>
				</td>
			</tr>							
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>문항유효기간설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>다운로드방식</td>
				<td width="70%">&nbsp;<input type="radio" value="I" name="DOWNLOAD_ABLE_METHOD" checked> 유효기간내&nbsp;&nbsp;<input type="radio" value="O" name="DOWNLOAD_ABLE_METHOD" checked> 유효기간외</td>				
			</tr>
			<tr>
				<td id="left"><li>유효시작시간</td>
				<td><div style="float: left;"><input type="text" class="input date_picker" name="DOWNLOAD_ABLE_SDATE1" size="12" readonly value="">
				&nbsp;<select name="DOWNLOAD_ABLE_SDATE2">
				<% 
					String jj3 = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj3 = "0"+String.valueOf(j);
						} else {
							jj3 = String.valueOf(j);
						}
				%>
				<option value="<%=jj3%>"><%=jj3%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="DOWNLOAD_ABLE_SDATE3" size="3" value="00"> 분</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>유효종료시간</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="DOWNLOAD_ABLE_SDATE1" size="12" readonly value="">
				&nbsp;<select name="DOWNLOAD_ABLE_SDATE2">
				<% 
					String jj4 = "";
					for(int j=0; j<=23; j++) { 
						if(j < 10) {
							jj4 = "0"+String.valueOf(j);
						} else {
							jj4 = String.valueOf(j);
						}
				%>
				<option value="<%=jj4%>" ><%=jj4%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="DOWNLOAD_ABLE_SDATE3" size="3" value="00"> 분</div>
				</td>
			</tr>							
		</table><br>
		
		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>응시방식설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>응시방식설정</td>
				<td width="70%">&nbsp;<input type="radio" value="A" name="QUIZ_METHOD" checked> 비동시평가방식&nbsp;&nbsp;<input type="radio" value="B" name="QUIZ_METHOD" checked> 비동시+동시평가방식</td>
				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>재시험허용횟수설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>재시험허용횟수</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_RETRY_COUNT" size="3"> 회</td>
	
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>부정행위알림경고횟수설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>부정행위알림경고횟수</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_CHEAT_COUNT" size="3"> 회</td>

			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>종료알림경고시간설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>종료알림경고시간</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_PRE_ETIME" size="3"> 분</td>

			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>평가종료후재입장시부여시간설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="40%"><li>평가종료후재입장시부여시간</td>
				<td width="60%">&nbsp;<input type="text" class="input" name="QUIZ_END_RETRY_TIME" size="3"> 분</td>
				
			</tr>
		</table><br>

		<table border="0" width="100%">
			<tr>
				<td align="left"><li><b>논술답안자동저장시간설정</b></td>
				<td align="right"><input type="button" value="설정하기" class="form"></td>
			</tr>
		</table>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left" width="30%"><li>논술답안자동저장시간</td>
				<td width="70%">&nbsp;<input type="text" class="input" name="QUIZ_AUTOSAVE_TIME" size="3"> 분</td>
				
			</tr>
		</table><br>

	</div>	
	
	</form>
	
 </BODY>
</HTML>
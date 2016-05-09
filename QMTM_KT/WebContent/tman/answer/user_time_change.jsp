<%
//******************************************************************************
//   프로 그램 : user_time_change.jsp
//   모  듈  명 : 시험시간 변경 및 운영일지
//   설       명 : 시험시간 변경 및 운영일지
//   테  이  블 : exam_m
//   자바 파일 : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   작  성  일 : 2008-06-15
//   작  성  자 : 이테스트 석준호
//   수  정  일 : 
//   수  정  자 : 
//	  수정 사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "../../common/calendar.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// 응시자 정보
	UserInfoBean users = null;
	
	try {
		users = UserInfo.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	// 답안지 정보
	PersonalTimeBean ans = null;

	try {
		ans = PersonalTime.getBean(id_exam, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	String yn_sametime = "";
	String login_start = "";
	String login_end = "";
	String exam_start1 = "";
	String exam_end1 = "";
	
	// 개인시간 연장 정보
	PersonalTimeBean ptime = null;

	try {
		ptime = PersonalTime.getTime(id_exam, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if(ptime == null) {

		PersonalTimeBean ptime2 = null;

		try {
			ptime2 = PersonalTime.getTime2(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}	

		yn_sametime = ptime2.getYn_sametime();
		login_start = ptime2.getLogin_start();
		login_end = ptime2.getLogin_end();
		exam_start1 = ptime2.getExam_start1();
		exam_end1 = ptime2.getExam_end1();
	} else {
		yn_sametime = ptime.getYn_sametime();
		login_start = ptime.getLogin_start();
		login_end = ptime.getLogin_end();
		exam_start1 = ptime.getExam_start1();
		exam_end1 = ptime.getExam_end1();
	}

	long limittime = 0;

	try {
		limittime = PersonalTime.getLimittime(id_exam);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}	

	Timestamp now = new Timestamp(System.currentTimeMillis());
%>

<html>
<head>
	<title> :: 시간연장 :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="javascript">
	
	function yn_sametimes(yn_check) {
		
		Show_LayerProgressBar(false);

		var frm = document.form1;

		if(yn_check == "N") {			
			// 입장시작 시간 Disabled
			frm.login_start1.disabled = true;
			frm.login_start2.disabled = true;
			frm.login_start3.disabled = true;

			// 입장종료 시간 Disabled
			frm.login_end1.disabled = true;
			frm.login_end2.disabled = true;
			frm.login_end3.disabled = true;
		} else {
			// 입장시작 시간 Enabled
			frm.login_start1.disabled = false;
			frm.login_start2.disabled = false;
			frm.login_start3.disabled = false;

			// 입장종료 시간 Enabled
			frm.login_end1.disabled = false;
			frm.login_end2.disabled = false;
			frm.login_end3.disabled = false;
		}
	}

	function time_change() {
		var str = confirm("개인시간을 변경하시겠습니까?");

		if(!str) {
			return;
		}

		document.form1.submit();
	}

	function time_extend(extend_time) {
		var name = "<%=users.getName()%>";

		var str = confirm(name + " 님에게 제한시간을 "+extend_time+" 분 연장처리 하시겠습니까?\n\n현재 시험중인 응시자는 새로고침을 해야만 연장된 시간이 반영됩니다.");

		if(!str) {
			return;
		}
		
		if(extend_time == "") {
			alert("연장시간을 입력하세요.");
			return;
		}
		
		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = time_extend_callback;
		qs2.open("POST", "time_extend.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs2.send("id_exam=<%=id_exam%>&userid=<%=userid%>&extend_time="+extend_time);
	}

	function time_extend_callback() {
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				document.form1.limittime.value = parseInt(document.form1.limittime.value) + parseInt(document.form1.limittime2.value);
				Show_LayerProgressBar(false);					
				alert("제한시간 연장처리가 완료되었습니다.");
			}
	    }
	}

	function time_all_extend(extend_time) {
			
		var str = confirm("미완료자들에 대해서 제한시간을 "+extend_time+" 분 연장처리 하시겠습니까?\n\n현재 시험중인 응시자들은 새로고침을 해야만 연장된 시간이 반영됩니다.");

		if(!str) {
			return;
		}
		
		if(extend_time == "") {
			alert("연장시간을 입력하세요.");
			return;
		}
		
		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = time_all_extend_callback;
		qs2.open("POST", "time_all_extend.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=euc-kr");
		qs2.send("id_exam=<%=id_exam%>&extend_time="+extend_time);
	}

	function time_all_extend_callback() {
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				Show_LayerProgressBar(false);					
				alert("미완료자들에 대해서 제한시간 연장처리가 일괄완료되었습니다.");
			}
	    }
	}

	HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
               + '<img src="../../images/loading.gif" style="position:absolute; top:35%; left:35%;"/>' 
               + '</DIV>'; 
  
	document.write(HTML_P); 
	  
	function Show_LayerProgressBar(isView) { 
			
		var obj = document.getElementById("ProgressBar"); 
		if (isView) { 
			obj.style.display = "block"; 
		}else{ 
			obj.style.display = "none"; 
		} 
	}

	function user_time() {
		window.open("user_time_list.jsp?id_exam=<%=id_exam%>", "user_time","width=900, height=500, scrollbars=yes");
	}

	function extend_time() {
		window.open("extend_time_list.jsp?id_exam=<%=id_exam%>", "extend_time","width=700, height=500, scrollbars=yes");
	}
	
	</script>

</head>

<BODY id="popup2" onLoad="yn_sametimes('<%=yn_sametime%>');">

	<form name="form1" action="user_time_change_ok.jsp" method="post">
	<input type="hidden" name="id_exam" value="<%=id_exam%>">
	<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td id="left"></td>
				<Td id="mid"><div class="title">시간연장 등록 <span>응시자별 시험시간연장을 등록할 수 있습니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<div class="location2"> <b>개인 정보</b></div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<tr>
				<td id="left" width="100"><li>아이디</td>
				<td>&nbsp;<%=userid%>&nbsp;</td>
				<td id="left"><li>성명</td>
				<td>&nbsp;<%=users.getName()%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left" width="100"><li>시험시작시간</td>
				<td>&nbsp;<%=ans.getStart_time()%>&nbsp;</td>
				<td id="left"><li>최종답안제출시간</td>
				<td>&nbsp;<%=ans.getEnd_time()%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left" width="100"><li>시험제한시간</td>
				<td>&nbsp;<%=limittime/60%>&nbsp;분</td>
				<td id="left"><li>남은시간</td>
				<td>&nbsp;<input type="text" name="limittime" value="<%=ans.getRemain_time()/60%>" size="4"> 분</td>
			</tr>
		</table>
		<br>
		<div class="location2"> <b>개인별 시험시간설정</b></div>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left"><li>입장시작시간</td>
				<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(login_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="login_start1" size="12" readonly value="<%=login_start.toString().substring(0,10)%>">
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
				<option value="<%=jj%>" <%if(login_start.toString().substring(11,13).equals(jj)) { %> selected <% } %>><%=jj%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="login_start3" size="3" value="<%=login_start.toString().substring(14,16)%>"> 분</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>입장종료시간</td>
				<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(login_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="login_end1" size="12" readonly value="<%=login_end.toString().substring(0,10)%>">
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
				<option value="<%=jj2%>" <%if(login_end.toString().substring(11,13).equals(jj2)) { %> selected <% } %>><%=jj2%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="login_end3" size="3" value="<%=login_end.toString().substring(14,16)%>"> 분</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>시험시작시간</td>
				<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(exam_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="exam_start1" size="12" readonly value="<%=exam_start1.toString().substring(0,10)%>">
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
				<option value="<%=jj3%>" <%if(exam_start1.toString().substring(11,13).equals(jj3)) { %> selected <% } %>><%=jj3%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="<%=exam_start1.toString().substring(14,16)%>"> 분</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>시험종료시간</td>
				<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(exam_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="exam_end1" size="12" readonly value="<%=exam_end1.toString().substring(0,10)%>">
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
				<option value="<%=jj4%>" <%if(exam_end1.toString().substring(11,13).equals(jj4)) { %> selected <% } %>><%=jj4%></option>
				<% } %></select>
				시&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="<%=exam_end1.toString().substring(14,16)%>"> 분</div>
				</td>
			</tr>
			<tr>
				<td id="left" width="100"><li>평가유형</td>
				<td colspan="2" width="250"><input type="radio" name="yn_sametime" value="N" <%if(yn_sametime.equals("N")) { %> checked <% } %> onClick="yn_sametimes('N');">&nbsp;비동시평가&nbsp;<input type="radio" name="yn_sametime" value="Y" <%if(yn_sametime.equals("Y")) { %> checked <% } %> onClick="yn_sametimes('Y');">&nbsp;동시평가</td>
				<td align="right"><input type="button" value="개인시간변경" onClick="time_change();"></td>
			</tr>
		</table>
		<br>
		<div class="location2"> <b>개인별 제한시간 연장 (비동시평가일경우 사용)</b></div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<tr>
				<td id="left" width="100"><li>연장시간</td>
				<td>&nbsp;<input type="text" name="limittime2" size="4" class="input">&nbsp;분&nbsp;&nbsp;<input type="button" value="제한시간연장" onClick="time_extend(document.form1.limittime2.value);"></td>
				<td align="right"><input type=button value="미완료자 제한시간 일괄연장" onClick="time_all_extend(document.form1.limittime2.value);"></td>
			</tr>			
		</table>
		<br>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>				
				<td align="right"><a href="javascript:user_time();">[ 개인시간 변경자 목록 확인]</a>&nbsp;&nbsp;<a href="javascript:extend_time();">[ 제한시간 연장자 목록 확인 ]</a></td>
			</tr>			
		</table>
	</div>
	<div id="button">
		<img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: hand;">
	</div>

	</form>

</body>

</html>

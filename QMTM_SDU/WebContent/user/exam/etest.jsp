<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="qmtm.*, qmtm.tman.answer.*, etest.User_QmTm, etest.exam.User_ExamUnitBean, etest.exam.User_ExamUnit, java.sql.Timestamp"%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = "";
	userid = (String)session.getAttribute("current_userid");

	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String PersonalTimeYN = "N";
	Timestamp exam_starts1 = null;
    Timestamp exam_ends1 = null;
	String yn_sametimes = "N";
	String exam_pwd_yn ="N";
	int web_window_mode = 1;

	PersonalTime2Bean ptb = null;

	try {
	    ptb = PersonalTime2.getTime(id_exam, userid);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "fclose"));

	    if(true) return;
	}

	if(ptb == null) {
	    PersonalTimeYN = "N";
	} else {
        PersonalTimeYN = "Y";
		exam_starts1 = ptb.getExam_start1();
		exam_ends1 = ptb.getExam_end1();
		yn_sametimes = ptb.getYn_sametime();
	}

	User_ExamUnitBean rst = null;

	if (PersonalTimeYN.equals("Y")) { 
		try {
		  rst = User_ExamUnit.getPersonalBean(id_exam, exam_starts1, exam_ends1, yn_sametimes);
		}
		catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	} else {
		try {
		  rst = User_ExamUnit.getBean(id_exam);
		}
		catch (Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "back"));
	
		    if(true) return;
		}
	}

	if (rst == null) {
%>
		<Script type="text/javascript">
			alert("개설되어진 시험지 정보가 없습니다.");
			history.back();
		</Script>
<%
		if(true) return;
	} else {
		exam_pwd_yn = rst.getExam_pwd_yn();
		web_window_mode = rst.getWeb_window_mode();
	}
	

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>eTest</title>
<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="../css/top.css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript">
	var web_window_mode = "<%=web_window_mode%>";
	
	function frameofTest() {
		if(web_window_mode === "0") {
			// window mode
			orgWidth = $(window).width();
			orgHeight = $(window).height();
			window.open("../paper/fraTest.jsp?id_exam=<%=id_exam%>", "exampaper", "width="+orgWidth+", height="+orgHeight+",  scrollbars=yes");
			
		} else {
			// fullsize mode
			window.open("../paper/fraTest.jsp?id_exam=<%= id_exam %>", "exampaper", "fullscreen=yes, scrollbars=yes");
		}
	}
	
<% if(exam_pwd_yn.equals("Y")) { %>

	function startExam()
	{
		$("#examPwdModal").modal('show');
	}

<% } else { %>

	function startExam()
	{
		frameofTest();
	}

<% } %>	

	
	
	function openExamPaper() {
		
	}
	
	function checkwin() {
		var myWin;
		myWin = window.open("ansCheck.jsp?id_exam=<%=id_exam%>", "checkwin", "menubar=no, scrollbars=no, width=300, height=150");
		myWin.focus();
	}	
	
	$(function(){
		
		$("#btn_exam_pwd_confirm").on('click',function(){
			
			var txt_exam_password = $("#txt_exam_password").val();

			if(txt_exam_password === "") {
				return false;
			}

			$.ajax({
				type:"POST",
				url: "check_exam_pwd.jsp",
				data: {
					txt_exam_password:txt_exam_password,
					userid:"<%=userid%>",
					id_exam:"<%=id_exam%>"
				},
				dataType:"json"
			}).done(function(msg){
				if(msg.result){
					if (msg.result === "success") {
						alert("평가비밀번호가 확인되었습니다. 평가에 입장합니다.");
						$("#examPwdModal").modal('hide');
						$("#txt_exam_password").val('');
						frameofTest();
					} else if (msg.result === "fail") {
						alert(msg.error_msg);
						$("#txt_exam_password").val('');
						$("#txt_exam_password").focus();
					}
				}
			});
		});		
	});
</script>

</head>
<BODY>
	<jsp:include page="../include/include_top.jsp" flush="false">
		<jsp:param name="active_menu_item" value="exam" />
    </jsp:include>
    
    <div class="container">
	
		<div class="well well-small">평가응시&nbsp;&nbsp;<font style='font-weight: normal;'>[&nbsp;기간 :&nbsp;
		<%= rst.getExam_start().toString().substring(0,16) %> ~ <%= rst.getExam_end().toString().substring(0,16) %>
		&nbsp;]</font></div>
		
		<!---------- 시험과목 테이블 ----------->
		<table class="table table-hover">
		<thead>
		<tr>
			<th>평가명</th>
			<th>평가시간(분)</th>
			<th>평가응시</th>
			<th>답안제출여부</th>
		</tr>
		</thead>
		<tbody>
		<%
			String yn_end = "";
			String title, id_exam_type, exam_type, yn_sametime;
			Boolean is_started = false;
	
			long limitTime;
			Timestamp now = new Timestamp(System.currentTimeMillis());
			Timestamp exam_start, exam_end;
			boolean hasReqForRetryExamBySuccessScore = User_QmTm.hasReqForRetryExamBySuccessScore(userid, id_exam);
			
			yn_end = User_QmTm.getYn_end(userid, id_exam);
			if (yn_end == null) { 
				yn_end = "N"; 
				is_started = false;
			} else {
				is_started = true;
			}
			
			title = rst.getTitle();
			yn_sametime = rst.getYn_sametime();
			id_exam_type = rst.getId_exam_type();
			
			if (id_exam_type.equals("1")) { 
				exam_type = "자유모의고사<br>반복응시가능"; 
			} else { 
				exam_type = "&nbsp;"; 
			}
			
			exam_start = rst.getExam_start();
			exam_end = rst.getExam_end();
			
			if(yn_sametime.equals("N")) {
				limitTime = rst.getLimitTime();
			} else {
				limitTime = (exam_end.getTime() - exam_start.getTime()) / 1000;
			}
			
			exam_pwd_yn = rst.getExam_pwd_yn();
			
	       %>
			<tr>
				<td><%= title %></td>
				<td><%= limitTime / 60 %> 분</td>
				<td>
				 <% if (exam_end.before(now)) { %>
					평가종료
				 <% } else if (id_exam_type.equals("1")) { %><!-- 자유모의고사, 응시회수 무제한 -->
		            <a class="btn"  href="javascript:startExam();">응시하기</a>
				 <% } else if (yn_end.equals("N")) { %>
					<a class="btn" href="javascript:startExam();">응시하기</a>
		         <% } else if (hasReqForRetryExamBySuccessScore) { %>
		         	<a class="btn" href="javascript:startExam();">응시하기</a>
				 <% } else { %>
		            <span class="label">평가종료</span>
				 <% } %>
				</td>
				<td><a class="btn" href="javascript:checkwin();" onfocus="this.blur();">답안제출확인</a></td>
			</tr>
				
		</table>
	
		<!---------------- 시험 소개---------------->
		<% 
			String guide = rst.getGuide();
			if(!guide.equals("")) {
		%>
		<br><br>
		<div class='sub'>평가소개</div>
		<div class='text'><%= guide %></div>
		<%
			}	
		%>
	</div>

	<!-- 평가 비밀번호 Modal -->
	<div id="examPwdModal" class="modal hide fade" role="dialog">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h3>평가 비밀번호</h3>
		</div>
		<div class="modal-body text-center" >
			<br>
			<h4>평가비밀번호를 입력해주세요.</h4>
			<br>
			<form class="form-inline" >
				<label for="txt_exam_password">평가비밀번호 : </label>&nbsp;&nbsp;&nbsp;<input id="txt_exam_password" class="input-large" type="password" placeholder="평가 비밀번호">
			</form>
		</div>
		<div class="modal-footer">
			<button id="btn_exam_pwd_confirm" class="btn btn-primary">확인</button>
			<a href="#" class="btn" data-dismiss="modal">취소</a>
		</div>
	</div>
	
	<div class="container_bottom"><!--바닥 부분 레이아웃--></div>
	<OBJECT CODEBASE="<%= ComLib.getConfig("ANTICHEATX_CODEBASE") %>" classid="clsid:B74699E0-E14B-464A-A62B-F9FC17A99781" width="0" height="0" id = "AntiCheatX" >	
		<PARAM NAME="WebSandboxMode" VALUE="1">
		<PARAM NAME="ProtectKeyCheat" VALUE="1">
		<PARAM NAME="ProtectKeyList" VALUE="ALT+TAB,ALT+ESC,CTRL,CTRL+ESC,ESC,F1,F2,F3,F6,F7,F8,F9,F10,F11,F12,WIN,PRINT">
		<PARAM NAME="ProtectMouseCheat" VALUE="1">
		<PARAM NAME="ProtectAppCheat" VALUE="1">
		<PARAM NAME="ProtectAppExceptionList" VALUE="eclipse.exe,editplus.exe">
		<PARAM NAME="ProtectExplorerCheat" VALUE="1">
		<PARAM NAME="ProtectExplorerExceptionList" VALUE="<%= ComLib.getConfig("ANTICHEATX_EXPLORER_EXCEPTION_LIST") %>">
		<PARAM NAME="KeepAliveMillisec" VALUE="2000">
		<PARAM NAME="DebugLog" VALUE="1">
		<PARAM NAME="DebugSandbox" VALUE="1">
		<PARAM NAME="AppNotification" VALUE="0">
	</OBJECT>
</body>
</html>
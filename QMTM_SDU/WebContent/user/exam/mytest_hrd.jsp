<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="qmtm.ComLib, etest.User_QmTm, etest.exam.User_ExamListBean, etest.exam.User_ExamList" %>
<%@ page import="etest.LoginManager" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<%!
	LoginManager loginManager = LoginManager.getInstance();
%>
<%	
	//*********************HRD 연동 파라미터 정보 체크시작**********************
	String id_course, id_subject, id_exam_gubun, userid;
	String hrd_exam = (String)session.getAttribute("current_exam");
		
	if(hrd_exam == "" || hrd_exam == null) {
		id_course = request.getParameter("id_course");
		if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }
		id_subject = request.getParameter("id_subject");
		if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }
		userid = request.getParameter("userid");	
		if (userid == null) { userid = ""; } else { userid = userid.trim(); }
		id_exam_gubun = request.getParameter("id_exam_gubun");
		if (id_exam_gubun == null) { id_exam_gubun = ""; } else { id_exam_gubun = id_exam_gubun.trim(); }
	} else {
		id_course = (String)session.getAttribute("current_id_course");
		id_subject = (String)session.getAttribute("current_id_subject");
		userid = (String)session.getAttribute("current_userid");
		id_exam_gubun = (String)session.getAttribute("current_id_exam_gubun");
	}
	if (userid == "" || id_course == "" || id_subject == "") {	
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}
	
	// 과정코드 및 강좌코드를 재정의한다.
	String id_course_re = id_exam_gubun + id_course;
	String id_subject_re = id_exam_gubun + id_subject;
	//*********************HRD 연동 파라미터 정보 체크종료**********************

	String userName = "";
	String pwd = userid;

	if(hrd_exam == "" || hrd_exam == null) {
		// 사용자 인증
		try {
			userName = User_QmTm.getName(userid, pwd);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "close"));
			
		    if(true) return;
	    }
		
		// 세션 정보를 저장한다.
		session.setAttribute("current_userid", userid);
		session.setAttribute("current_username", userName);

		session.setAttribute("current_id_course", id_course);
		session.setAttribute("current_id_subject", id_subject);
		session.setAttribute("current_id_exam_gubun", id_exam_gubun);
		session.setAttribute("current_exam", "exam_hrd");
		session.setMaxInactiveInterval(60*60*4);

		// 이미 접속한 아이디인지 체크한다.
		if(loginManager.isUsing(userid)) {
			// 기존 접속자를 로그아웃 시킨다.
			loginManager.removeSession(userid);
			
			// 새로운 세션을 등록한다. setSession함수를 수행하면 valueBound()함수가 호출된다.
			loginManager.setSession(session, userid);
		} else {
			loginManager.setSession(session, userid);
		}	
		
	}

	User_ExamListBean[] rst = null;

	try {
	  rst = User_ExamList.getBeans(userid, id_course_re, id_subject_re);
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>eTest</title>
	<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="../css/top.css" />
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript">
		function GoTest(id_exam){
			location.href="./etest.jsp?id_exam="+id_exam+"&userid=<%=userid%>";
		}

		function activeXCheck() {
			var ret;
			ret = CheckActiveX("ANTICHEATX.AntiCheatXCtrl.1");
			if(ret)
			{
				return "true";
			}
			else {
				return "false";
			}
		}

		function CheckActiveX(pid) {
			try {
				var axObj;
				axObj = new ActiveXObject(pid);
				return true;
			} 
			catch (e) {
				return false;
			}
		}
		
		function checkIP(strIP) {
			var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
			return expUrl.test(strIP);
		}

		function closeWindow() {
			alert("부정행위방지프로그램 설치를 위해 인터넷익스프롤러를 종료합니다. 다시 인터넷익스프롤러를 실행시켜주시기 바랍니다.");
			top.window.close();
		}
		
		function checkTrustSite() {
			var currentServerNameMethod;
			var isTrustZone;

			var currentServerName = $("#servername").val();

			if(checkIP(currentServerName)) {
				currentServerNameMethod = "IP";
			} else {
				currentServerNameMethod = "DOMAIN";
			}

			var currentServerUrl = "http://" + currentServerName;
	
			if(currentServerNameMethod === "IP") {
				
				isTrustZone = document.AntiCheatX.TrustzoneQueryIP(currentServerUrl);
				
				if(isTrustZone !== 0) {
					window.location.href = "../intro/anticheat_trustzone_check_hrd.jsp";
				}

			} else {
				
				isTrustZone = document.AntiCheatX.TrustzoneQueryDomain(currentServerUrl);
				
				if(isTrustZone !== 0) {
					window.location.href = "../intro/anticheat_trustzone_check_hrd.jsp";
				} 
			}					
		}
		
		$(function(){
			// AntiCheatX 설치여부 확인
			var activeXCheckResult = activeXCheck();
			if(activeXCheckResult == "true") {
				// 신뢰된 사이트 추가여부 확인
				checkTrustSite();
			} else {
				window.location.href="../intro/anticheat_install_guide_hrd.jsp";
			}					
		});
	</script>
</head>
<body>
	<input type="hidden" id="servername" name="servername" value="<%= request.getServerName() %>">

	<a name="top"></a>

	<jsp:include page="../include/include_top.jsp" flush="false">
		<jsp:param name="active_menu_item" value="exam" />
    </jsp:include>
		
	<div class="container">
		<table class="table table-hover">
		<thead>
		<tr>
			<th>과정명</th>
			<th>평가명</th>
			<th>평가기간</th>
		</tr>
		</thead>
		<tbody>
		<% if (rst == null) { %>
		  <tr>
		    <td colspan="3">개설되어진 평가가 없습니다.</td>
		  </tr>
		<%
		   } else {
		        for (int i = 0; i < rst.length; i++) {
		%>
		  <tr>  
		    <td><%= rst[i].getCourse() %></td>
		    <td><a href="javascript:GoTest('<%= rst[i].getId_exam() %>');"><%= rst[i].getTitle() %></a></td>
		    <td><%= rst[i].getExam_start().toString().substring(0,16) %> ~ <%= rst[i].getExam_end().toString().substring(0,16) %></td> 
		  </tr>
		<%
		       }
		   }
		%>		
		</tbody>
		</table>

	</div>

	<div class="container_bottom"><!--바닥 부분 레이아웃--></div>
	<OBJECT CODEBASE="<%= ComLib.getConfig("ANTICHEATX_CODEBASE") %>" classid="clsid:B74699E0-E14B-464A-A62B-F9FC17A99781" width="0" height="0" id = "AntiCheatX" >	
		<PARAM NAME="WebSandboxMode" VALUE="1">
		<PARAM NAME="ProtectKeyCheat" VALUE="1">
		<PARAM NAME="ProtectKeyList" VALUE="ALT+TAB,ALT+ESC,CTRL,F1,F2,F3,F6,F7,F8,F9,F10,F11,F12,WIN,PRINT">
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
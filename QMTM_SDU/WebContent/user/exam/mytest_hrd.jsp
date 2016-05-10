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
	//*********************HRD ���� �Ķ���� ���� üũ����**********************
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
	
	// �����ڵ� �� �����ڵ带 �������Ѵ�.
	String id_course_re = id_exam_gubun + id_course;
	String id_subject_re = id_exam_gubun + id_subject;
	//*********************HRD ���� �Ķ���� ���� üũ����**********************

	String userName = "";
	String pwd = userid;

	if(hrd_exam == "" || hrd_exam == null) {
		// ����� ����
		try {
			userName = User_QmTm.getName(userid, pwd);
	    } catch(Exception ex) {
		    out.println(ComLib.getExceptionMsg(ex, "close"));
			
		    if(true) return;
	    }
		
		// ���� ������ �����Ѵ�.
		session.setAttribute("current_userid", userid);
		session.setAttribute("current_username", userName);

		session.setAttribute("current_id_course", id_course);
		session.setAttribute("current_id_subject", id_subject);
		session.setAttribute("current_id_exam_gubun", id_exam_gubun);
		session.setAttribute("current_exam", "exam_hrd");
		session.setMaxInactiveInterval(60*60*4);

		// �̹� ������ ���̵����� üũ�Ѵ�.
		if(loginManager.isUsing(userid)) {
			// ���� �����ڸ� �α׾ƿ� ��Ų��.
			loginManager.removeSession(userid);
			
			// ���ο� ������ ����Ѵ�. setSession�Լ��� �����ϸ� valueBound()�Լ��� ȣ��ȴ�.
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
			alert("���������������α׷� ��ġ�� ���� ���ͳ��ͽ����ѷ��� �����մϴ�. �ٽ� ���ͳ��ͽ����ѷ��� ��������ֽñ� �ٶ��ϴ�.");
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
			// AntiCheatX ��ġ���� Ȯ��
			var activeXCheckResult = activeXCheck();
			if(activeXCheckResult == "true") {
				// �ŷڵ� ����Ʈ �߰����� Ȯ��
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
			<th>������</th>
			<th>�򰡸�</th>
			<th>�򰡱Ⱓ</th>
		</tr>
		</thead>
		<tbody>
		<% if (rst == null) { %>
		  <tr>
		    <td colspan="3">�����Ǿ��� �򰡰� �����ϴ�.</td>
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

	<div class="container_bottom"><!--�ٴ� �κ� ���̾ƿ�--></div>
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
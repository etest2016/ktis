<%
//******************************************************************************
//   ����  �׷� : user_time_change.jsp
//   ��  ��  �� : ����ð� ���� �� �����
//   ��      �� : ����ð� ���� �� �����
//   ��  ��  �� : personal_time, exam_ans, qt_userid
//   �ڹ�  ���� : qmtm.ComLib, qmtm.tman.UserInfo, qmtm.tman.UserInfoBean, 
//                qmtm.tman.answer.PersonalTimeBean, qmtm.tman.answer.PersonalTime, java.sql.Timestamp
//   ��  ��  �� : 2013-02-15
//   ��  ��  �� : ���׽�Ʈ ����ȣ
//   ��  ��  �� : 
//   ��  ��  �� : 
//	 ����  ���� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.UserInfo, qmtm.tman.UserInfoBean, qmtm.tman.answer.PersonalTimeBean, qmtm.tman.answer.PersonalTime, java.sql.Timestamp" %>
<%@ include file = "../../common/calendar.jsp" %>
<%@ include file = "/common/login_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	// ������ ����
	UserInfoBean users = null;
	
	try {
		users = UserInfo.getBean(userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	// ����� ����
	PersonalTimeBean ans = null;

	try {
		ans = PersonalTime.getBean(id_exam, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	String yn_sametime = "";
	String login_start = "";
	String login_end = "";
	String exam_start1 = "";
	String exam_end1 = "";
	
	// ���νð� ���� ����
	PersonalTimeBean ptime = null;

	try {
		ptime = PersonalTime.getTime(id_exam, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	if(ptime == null) {

		PersonalTimeBean ptime2 = null;

		try {
			ptime2 = PersonalTime.getTime2(id_exam);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

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
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}	

	Timestamp now = new Timestamp(System.currentTimeMillis());
%>

<html>
<head>
	<title> :: �ð����� :: </title>

	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  
  <link rel="stylesheet" href="../../js/jquery-ui-1.10.2/themes/base/jquery-ui.css" />
  <script src="../../js/jquery-ui-1.10.2/ui/jquery-ui.js"></script>
  <script src="../../js/jquery-ui-1.10.2/ui/i18n/jquery.ui.datepicker-ko.js"></script>
  <script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( ".date_picker" ).datepicker();
	});
  </script>

	<script language="javascript">
	
	function yn_sametimes(yn_check) {
		
		Show_LayerProgressBar(false);

		var frm = document.form1;

		if(yn_check == "N") {			
			// ������� �ð� Disabled
			frm.login_start1.disabled = true;
			frm.login_start2.disabled = true;
			frm.login_start3.disabled = true;

			// �������� �ð� Disabled
			frm.login_end1.disabled = true;
			frm.login_end2.disabled = true;
			frm.login_end3.disabled = true;
		} else {
			// ������� �ð� Enabled
			frm.login_start1.disabled = false;
			frm.login_start2.disabled = false;
			frm.login_start3.disabled = false;

			// �������� �ð� Enabled
			frm.login_end1.disabled = false;
			frm.login_end2.disabled = false;
			frm.login_end3.disabled = false;
		}
	}

	function time_change() {
		var str = confirm("���νð��� �����Ͻðڽ��ϱ�?");

		if(!str) {
			return;
		}

		document.form1.submit();
	}

	function time_extend(extend_time) {
		var name = "<%=users.getName()%>";

		var str = confirm(name + " �Կ��� ���ѽð��� "+extend_time+" �� ����ó�� �Ͻðڽ��ϱ�?\n\n���� �������� �����ڴ� ���ΰ�ħ�� �ؾ߸� ����� �ð��� �ݿ��˴ϴ�.");

		if(!str) {
			return;
		}
		
		if(extend_time == "") {
			alert("����ð��� �Է��ϼ���.");
			return;
		}
		
		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = time_extend_callback;
		qs2.open("POST", "time_extend.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=EUC-KR");
		qs2.send("id_exam=<%=id_exam%>&userid=<%=userid%>&extend_time="+extend_time);
	}

	function time_extend_callback() {
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				document.form1.limittime.value = parseInt(document.form1.limittime.value) + parseInt(document.form1.limittime2.value);
				Show_LayerProgressBar(false);					
				alert("���ѽð� ����ó���� �Ϸ�Ǿ����ϴ�.");
			}
	    }
	}

	function time_all_extend(extend_time) {
			
		var str = confirm("�̿Ϸ��ڵ鿡 ���ؼ� ���ѽð��� "+extend_time+" �� ����ó�� �Ͻðڽ��ϱ�?\n\n���� �������� �����ڵ��� ���ΰ�ħ�� �ؾ߸� ����� �ð��� �ݿ��˴ϴ�.");

		if(!str) {
			return;
		}
		
		if(extend_time == "") {
			alert("����ð��� �Է��ϼ���.");
			return;
		}
		
		Show_LayerProgressBar(true);

		qs2 = new ActiveXObject("Microsoft.XMLHTTP");
		qs2.onreadystatechange = time_all_extend_callback;
		qs2.open("POST", "time_all_extend.jsp", true);
		qs2.setRequestheader("Content-Type","application/x-www-form-urlencoded;charset=EUC-KR");
		qs2.send("id_exam=<%=id_exam%>&extend_time="+extend_time);
	}

	function time_all_extend_callback() {
		if(qs2.readyState == 4) {
			if(qs2.status == 200) {
				Show_LayerProgressBar(false);					
				alert("�̿Ϸ��ڵ鿡 ���ؼ� ���ѽð� ����ó���� �ϰ��Ϸ�Ǿ����ϴ�.");
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
		$.posterPopup("user_time_list.jsp?id_exam=<%=id_exam%>", "user_time","width=900, height=500, scrollbars=yes, top="+(screen.height-500)/2+", left="+(screen.width-900)/2);
	}

	function extend_time() {
		$.posterPopup("extend_time_list.jsp?id_exam=<%=id_exam%>", "extend_time","width=700, height=500, scrollbars=yes, top="+(screen.height-500)/2+", left="+(screen.width-700)/2);
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
				<Td id="mid"><div class="title">�ð����� ��� <span>�����ں� ����ð������� ����� �� �ֽ��ϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<div class="location2"> <b>���� ����</b></div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<tr>
				<td id="left" width="100"><li>���̵�</td>
				<td>&nbsp;<%=userid%>&nbsp;</td>
				<td id="left"><li>����</td>
				<td>&nbsp;<%=users.getName()%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left" width="100"><li>������۽ð�</td>
				<td>&nbsp;<%=ans.getStart_time()%>&nbsp;</td>
				<td id="left"><li>�����������ð�</td>
				<td>&nbsp;<%=ans.getEnd_time()%>&nbsp;</td>
			</tr>
			<tr>
				<td id="left" width="100"><li>�������ѽð�</td>
				<td>&nbsp;<%=limittime/60%>&nbsp;��</td>
				<td id="left"><li>�����ð�</td>
				<td>&nbsp;<input type="text" name="limittime" value="<%=ans.getRemain_time()/60%>" size="4"> ��</td>
			</tr>
		</table>
		<br>
		<div class="location2"> <b>���κ� ����ð�����</b></div>
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left"><li>������۽ð�</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="login_start1" size="12" readonly value="<%=login_start.toString().substring(0,10)%>">
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
				��&nbsp;<input type="text" class="input" name="login_start3" size="3" value="<%=login_start.toString().substring(14,16)%>"> ��</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>��������ð�</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="login_end1" size="12" readonly value="<%=login_end.toString().substring(0,10)%>">
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
				��&nbsp;<input type="text" class="input" name="login_end3" size="3" value="<%=login_end.toString().substring(14,16)%>"> ��</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>������۽ð�</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="exam_start1" size="12" readonly value="<%=exam_start1.toString().substring(0,10)%>">
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
				��&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="<%=exam_start1.toString().substring(14,16)%>"> ��</div>
				</td>
			</tr>
			<tr>
				<td id="left"><li>��������ð�</td>
				<td colspan="3"><div style="float: left;"><input type="text" class="input date_picker" name="exam_end1" size="12" readonly value="<%=exam_end1.toString().substring(0,10)%>">
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
				��&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="<%=exam_end1.toString().substring(14,16)%>"> ��</div>
				</td>
			</tr>
			<tr>
				<td id="left" width="100"><li>������</td>
				<td colspan="2" width="250"><input type="radio" name="yn_sametime" value="N" <%if(yn_sametime.equals("N")) { %> checked <% } %> onClick="yn_sametimes('N');">&nbsp;�񵿽���&nbsp;<input type="radio" name="yn_sametime" value="Y" <%if(yn_sametime.equals("Y")) { %> checked <% } %> onClick="yn_sametimes('Y');">&nbsp;������</td>
				<td align="right"><input type="button" value="���νð�����" class="form" onClick="time_change();"></td>
			</tr>
		</table>
		<br>
		<div class="location2"> <b>���κ� ���ѽð� ���� (�񵿽����ϰ�� ���)</b></div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableD">
			<tr>
				<td id="left" width="100"><li>����ð�</td>
				<td>&nbsp;<input type="text" name="limittime2" size="4" class="input">&nbsp;��&nbsp;<input type="button" value="���ѽð�����" class="form"  onClick="time_extend(document.form1.limittime2.value);">&nbsp;&nbsp;<input type=button value="�̿Ϸ��� ���ѽð� �ϰ�����" class="form" onClick="time_all_extend(document.form1.limittime2.value);"></td>
			</tr>			
		</table>
		<br>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>				
				<td align="right"><input type="button" value="���νð� ������ ��� Ȯ��" class="form6" onClick="user_time();">&nbsp;&nbsp;<input type="button" value="���ѽð� ������ ��� Ȯ��" class="form6" onClick="extend_time();"></td>
			</tr>			
		</table>
	</div>
	<div id="button">
		<img src="../../images/bt5_exit_yj1.gif" onclick="window.close();" style="cursor: pointer;">
	</div>

	</form>

</body>

</html>

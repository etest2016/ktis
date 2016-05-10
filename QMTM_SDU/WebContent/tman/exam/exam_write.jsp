<%
//******************************************************************************
//   ���α׷� : exam_write.jsp
//   �� �� �� : ������
//   ��    �� : ������ ������
//   �� �� �� : r_exlabel
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.RexlabelBean, 
//              qmtm.admin.tman.SubjectTmanUtil, qmtm.admin.tman.SubjectTmanBean, 
//              qmtm.tman.exam.ExamUtil, qmtm.tman.exam.RexlabelUtil, java.sql.Timestamp
//   �� �� �� : 2013-02-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
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
	
	// ����ǥ������ ���������
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
<title> :: �űԽ��� ��� :: </title>
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
	
	// �ʱⰪ ����..
	function inits() {

		var frm = document.form1;
		
		yn_sametimes("Y"); // �ʱⰪ�� �����򰡷� ����(�񵿽��򰡷� ���ý� N �� ����) 
		selects(1);
		id_randomtypes("NN"); // �������� �ʱⰪ ���� (�ʱⰪ : ��������)
		yn_open_qas("A"); // �������� �ɼ� �ʱⰪ ���� (�ʱⰪ : ���� �� �ؼ� �������� ����)
		paper_change(11); // ������ �̸����� �̹��� �ʱⰪ ���� 
		idexlabels(11, document.form1.fontname.value, "10"); // ����ǥ������, �۲�, ����ũ�� �ʱⰪ ����
		pwd_check(); // ���� ��й�ȣ ����
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
		strArea += '1. ���� �� ������ ���̽� ���� �ý���(DBMS)��\n';
		strArea += '&nbsp;������� �� �� ���� ����?\n\n';
		strArea += arr_data[0] +' ������� ���ǰ���� ���� ������ �ۼ��Ѵ�.\n';
		strArea += arr_data[1] +' ���Ἲ �˻縦 ħ���ϴ� ������ �ź��Ѵ�.\n';
		strArea += arr_data[2] +' �������� ���۰� ó���� �����ϴ�.\n';
		strArea += arr_data[3] +' ������ ��������� �����Ѵ�\n';
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
			// ������ȸ ���۽ð� Disabled
			frm.stat_start1.disabled = true;
			frm.stat_start2.disabled = true;
			frm.stat_start3.disabled = true;
			frm.stat_start4.disabled = true;

			// ������ȸ ����ð� Disabled
			frm.stat_end1.disabled = true;
			frm.stat_end2.disabled = true;
			frm.stat_end3.disabled = true;
			frm.stat_end4.disabled = true;

			// ������� ���� Disabled
			frm.yn_stat.disabled = true;			
		} else if(checks == "B") {
			// ������ȸ ���۽ð� Disabled
			frm.stat_start1.disabled = true;
			frm.stat_start2.disabled = true;
			frm.stat_start3.disabled = true;
			frm.stat_start4.disabled = true;

			// ������ȸ ����ð� Disabled
			frm.stat_end1.disabled = true;
			frm.stat_end2.disabled = true;
			frm.stat_end3.disabled = true;
			frm.stat_end4.disabled = true;

			// ������� ���� Enabled
			frm.yn_stat.disabled = false;			
		} else if(checks == "C") {
			// ������ȸ ���۽ð� Disabled
			frm.stat_start1.disabled = true;
			frm.stat_start2.disabled = true;
			frm.stat_start3.disabled = true;
			frm.stat_start4.disabled = true;

			// ������ȸ ����ð� Disabled
			frm.stat_end1.disabled = true;
			frm.stat_end2.disabled = true;
			frm.stat_end3.disabled = true;
			frm.stat_end4.disabled = true;

			// ������� ���� Enabled
			frm.yn_stat.disabled = false;			
		} else if(checks == "D") {
			// ������ȸ ���۽ð� Enabled
			frm.stat_start1.disabled = false;
			frm.stat_start2.disabled = false;
			frm.stat_start3.disabled = false;
			frm.stat_start4.disabled = false;

			// ������ȸ ����ð� Enabled
			frm.stat_end1.disabled = false;
			frm.stat_end2.disabled = false;
			frm.stat_end3.disabled = false;
			frm.stat_end4.disabled = false;

			// ������� ���� Enabled
			frm.yn_stat.disabled = false;			
		} else if(checks == "E") {
			// ������ȸ ���۽ð� Enabled
			frm.stat_start1.disabled = false;
			frm.stat_start2.disabled = false;
			frm.stat_start3.disabled = false;
			frm.stat_start4.disabled = false;

			// ������ȸ ����ð� Enabled
			frm.stat_end1.disabled = false;
			frm.stat_end2.disabled = false;
			frm.stat_end3.disabled = false;
			frm.stat_end4.disabled = false;

			// ������� ���� Enabled
			frm.yn_stat.disabled = false;			
		} 
	}

	function time_set() {
		var frm = document.form1;

		// ������� �ð� Disabled
		frm.login_start1.disabled = false;
		frm.login_start2.disabled = false;
		frm.login_start3.disabled = false;
		frm.login_start4.disabled = false;

		// �������� �ð� Disabled
		frm.login_end1.disabled = false;
		frm.login_end2.disabled = false;
		frm.login_end3.disabled = false;
		frm.login_end4.disabled = false;
	}
	
	function yn_sametimes(yn_check) {
		var frm = document.form1;

		if(yn_check == "N") {
			
			// ������� �ð� Disabled
			frm.login_start1.disabled = true;
			frm.login_start2.disabled = true;
			frm.login_start3.disabled = true;
			frm.login_start4.disabled = true;

			// �������� �ð� Disabled
			frm.login_end1.disabled = true;
			frm.login_end2.disabled = true;
			frm.login_end3.disabled = true;
			frm.login_end4.disabled = true;

		} else {

			// ������� �ð� Enabled
			frm.login_start1.disabled = false;
			frm.login_start2.disabled = false;
			frm.login_start3.disabled = false;
			frm.login_start4.disabled = false;

			// �������� �ð� Enabled
			frm.login_end1.disabled = false;
			frm.login_end2.disabled = false;
			frm.login_end3.disabled = false;
			frm.login_end4.disabled = false;

		}
	}

	function id_randomtypes(types) {

		var frm = document.form1;

		if(types == "NN") {
			frm.configs.value = "������ ���� ������ ���� �ʰ� ������ ������ �����մϴ�.";
		} else if(types == "NQ") {
			frm.configs.value = "���� ������ ��� �����ڰ� ������ ����ŭ ���� �ٸ� �������� ����ϴ�.";
		} else if(types == "NT") {
			frm.configs.value = "������ ���� ������ ��� �����ڰ� ������ ����ŭ ���� �ٸ� �������� ����ϴ�.";		
		} else if(types == "YQ") {			
			frm.configs.value = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ�  ���� �˻��� ���� �׷쿡�� ������ �����ؼ�  ���� �ٸ� �������� ����ϴ�.";
		} else if(types == "YT") {			
			frm.configs.value = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ�  ���� �˻��� ���� �׷쿡�� ������ �����ؼ� �� ������ ���� ������ ���  ���� �ٸ� �������� ����ϴ�.";
		} 
	}
	
	// �޴����� ������ �����ֱ�..
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
			alert("������� �Է��ϼ���.!!!");			
			return;
		} else if(frm.exam_pwd_yn.checked) {
			if(frm.exam_pwd_str.value.replace(/\s/g, "")==""){
				alert("���輼�μ������� �����й�ȣ�� �Է��ϼ���.!!!");
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
				<Td id="mid"><div class="title">�űԽ��� ��� <span>�� ������ ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 500px;">		

		<div style="display:;" id="id_basics">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01_.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<!--�� ���� ���� ����-->
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>�����</td>
					<td colspan="3"><input type="text" class="input" name="title" size="65"></td>
				</tr>
				<tr>
					<td id="left" width="100"><li>�����ڵ�</td>
					<td width=200><%=id_subject%></td>
					<td id="left" width="100"><li>�����⵵/����</td>
					<td><%=bean.getOpen_year()%>��/<%=bean.getOpen_month()%>��</td>
				</tr>
				<tr>
					<td id="left" width="100"><li>���¸�</td>
					<td colspan="3" ><%=bean.getSubject()%></td>			
				</tr>	
				<% if(bean.getId_category().substring(0,1).equals("E")) { %>
				<tr>
					<td id="left" width="100"><li>����������</td>
					<td colspan="3"><select name="exam_method">
					<option value="exam1" selected>��1</option>
					<option value="exam2">��2</option>
					<option value="exam3">��3</option>
					<option value="exam4">��4</option>
					<option value="exam5">��5</option>
					</select></td>
				</tr>	
				<% } %>		
								
			</table>

			<!--�� ��������--><br>
			
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>������</td>
					<td colspan="3"><div style="float: left;"><input type="radio" name="yn_sametime" value="N" onClick="yn_sametimes('N');" >&nbsp;�񵿽���&nbsp;<input type="radio" name="yn_sametime" value="Y" onClick="yn_sametimes('Y');" checked>&nbsp;������</div></td>
				</tr>
				<tr>
					<td id="left"><li>������۽ð�</td>
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
					��&nbsp;<input type="text" class="input" name="login_start3" size="3" value="<%=login_start_minute%>"> ��&nbsp;<input type="text" class="input" name="login_start4" size="3" value="00"> ��</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>��������ð�</td>
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
					��&nbsp;<input type="text" class="input" name="login_end3" size="3" value="<%=login_end_minute%>"> ��&nbsp;<input type="text" class="input" name="login_end4" size="3" value="00"> ��</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>������۽ð�</td>
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
					��&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="<%=exam_start_minute%>"> ��&nbsp;<input type="text" class="input" name="exam_start4" size="3" value="00"> ��</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>��������ð�</td>
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
					��&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="<%=exam_end_minute%>"> ��&nbsp;<input type="text" class="input" name="exam_end4" size="3" value="00"> ��</div>
					</td>
				</tr>

			</table>
		</div>
	
		<!--�� ���輼������-->

		<div style="display:none;" id="id_details">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02_.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>


			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>��������</td>
					<td><input type="radio" name="id_exam_type" value="0" checked>����&nbsp;&nbsp;&nbsp;<input type="radio" name="id_exam_type" value="1">�������ǰ����</td>
				</tr>			
				<tr>
					<td id="left"><li>������������</td>
					<td><div style="float: left;"><input type="radio" name="id_auth_type" value="0" onClick="selects(0);">�α���&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="1" checked onClick="selects(1);">����&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="2" onClick="selects(2);">����</div><div id="receipts2" style="float: left; margin-left: 10px;"><input type="button" value="���������Ȯ��" onClick="alert('�������������� �������� ��쿡�� �ϴܿ� ����� ��ư�� ������ ���� �� ����� Ȯ���� �����մϴ�.');" class="form"></div><div id="receipts" style="float: left; margin-left: 10px;"><input type="button" value="��������ڵ��" onClick="alert('�������������� �������� ��쿡�� �ϴܿ� ����� ��ư�� ������ ���� �� ����� ����� �����մϴ�.');" class="form"></div></td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>�����й�ȣ</td>
					<td><div style="float: left;"><input type="checkbox" name="exam_pwd_yn" value="Y" onClick="pwd_check();" >&nbsp;�ش� ���迡 ��й�ȣ�� ������</div><div id="pwd_str" style="float: left; margin-left: 15px;"><b>��й�ȣ ��� :</b> <input type="text" name="exam_pwd_str" size="17" maxlength="15" ></div></td>
				</tr>				
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>���ѽð�</td>
					<td><input type="text" class="input" name="limittime" size="5" value="60"> ��</td>
					<td id="left" width="120"><li>����</td>
					<td><input type="text" class="input" name="allotting" size="5" value="100"> ��</td>
				</tr>
				<tr>
					<td id="left"><li>������ ���� ��</td>
					<td><input type="text" class="input" name="qcount" size="5" value="20"> ����</td>
					<td id="left"><li>ȭ��� ���� ��</td>
					<td><input type="text" class="input" name="qcntperpage" size="5" value="1"> ����</td>
				</tr>
				<tr>
					<td id="left"><li>�հ�����</td>
					<td colspan="3"><input type="text" name="success_score" value="" size="5" disabled> ��&nbsp;<input type="checkbox" name="yn_success_score" value="Y" onClick="pass_check();"> �ش� ���迡 �հ������� ������</td>
				</tr>
				<tr>
					<td id="left"><li>������ �̵����</td>
					<td colspan="3"><input type="radio" name="id_movepage" value="F" checked>&nbsp;����, ���� �����̵�&nbsp;<input type="radio" name="id_movepage" value="N">&nbsp;������ �̵�����</td>
				</tr>
			</table>

			<!--�� ��������--><br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>��������</td>
					<td style="line-height: 200%;">
						<input type="radio" name="id_randomtype" value="NN" checked onClick="id_randomtypes(this.value)">��������<br>
						<input type="radio" name="id_randomtype" value="NQ" onClick="id_randomtypes(this.value)">��������&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NT" onClick="id_randomtypes(this.value)">���� �� ���⼯��<br>
						<input type="radio" name="id_randomtype" value="YQ" onClick="id_randomtypes(this.value)">�������� => ��������&nbsp;&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YT" onClick="id_randomtypes(this.value)">�������� => ���� �� ���⼯��<hr>
						&nbsp;<textarea name="configs" cols="70" rows="4" readonly></textarea>
					</td>
				</tr>				
			</table>
		</div>

		<div style="display:none;" id="id_scores"> 

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03_.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="150"><li>�������� ����</td>
					<td><input type="checkbox" name="yn_open_score_direct" value="Y" >������� ���� �� ���������� ���� �ٷ� ����</td>
				</tr>
				<tr>
					<td id="left"><li>�������� �ɼ�</td>
					<td>&nbsp;<select name="yn_open_qa" onChange="yn_open_qas(this.value);">
					<option value="A">���� �� �ؼ� �������� ����</option>
					<option value="B">��� ���� ���� ������ ����</option>
					<option value="C">��� ���� ���� ���� �� �����ؼ� ����</option>
					<option value="D">���� ��ȸ �Ⱓ�� ������ ����</option>
					<option value="E">���� ��ȸ �Ⱓ�� ���� �� �����ؼ� ����</option>					
					</select>
					</td>
				</tr>
				<tr>
					<td id="left"><li>������ȸ ���۽ð�</td>
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
					��&nbsp;<input type="text" class="input" name="stat_start3" size="3" value="00"> ��&nbsp;<input type="text" class="input" name="stat_start4" size="3" value="00"> ��</div></td>
				</tr>
				<tr>
					<td id="left"><li>������ȸ ����ð�</td>
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
					��&nbsp;<input type="text" class="input" name="stat_end3" size="3" value="00"> ��&nbsp;<input type="text" class="input" name="stat_end4" size="3" value="00"> ��</td>
				</tr>
				<tr>
					<td id="left"><li>������� ����</td>
					<td><input type="checkbox" name="yn_stat" value="Y" > �����ڿ��� ������� ����</td>
				</tr>				
			</table>
		</div>

		<div style="display:none;" id="id_designs">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04_.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>������ ����</td>
					<td style="padding-left: 20px;">
						<input type="radio" name="paper_type" value="11" checked onClick="paper_change(this.value);">&nbsp;������������ 1<br>
						<input type="radio" name="paper_type" value="12" onClick="paper_change(this.value);">&nbsp;������������ 2<br>
						<input type="radio" name="paper_type" value="13" onClick="paper_change(this.value);">&nbsp;������������ 3<br>
						<input type="radio" name="paper_type" value="21" onClick="paper_change(this.value);">&nbsp;������������ 4<br>
						<input type="radio" name="paper_type" value="22" onClick="paper_change(this.value);">&nbsp;������������ 5<br>
						<input type="radio" name="paper_type" value="23" onClick="paper_change(this.value);">&nbsp;������������ 6<br>
					</td>
					<td align="right"><div id="paperImg"></div></td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>���� ǥ�� ����</td>
					<td width="130"><select name="id_exlabel" onChange="idexlabels(this.value,document.form1.fontname.value,document.form1.fontsize.value);">						
					<% for(int i=0; i<rst2.length;i++) { %>
						<option value="<%=rst2[i].getId_exlabel()%>" <% if(rst2[i].getId_exlabel() == 11) { %> selected <% } %>><%=rst2[i].getExlabel()%></option>
					<% } %>
					</select></td>
					<td id="left" width="120"><li>ȭ�� �۲� ����</td>
					<td>
						<select name="fontname" onChange="idexlabels(document.form1.id_exlabel.value,this.value,document.form1.fontsize.value);">
						<option value="����">����</option>
						<option value="����ü">����ü</option>
						<option value="�ü�">�ü�</option>
						<option value="�ü�ü">�ü�ü</option>
						<option value="����">����</option>
						<option value="����ü">����ü</option>
						<option value="����">����</option>
						<option value="����ü">����ü</option>						
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
					<td id="left" width="120"><li>�۲� �̸�����</td>
					<td align="left" id="prepares" colspan="3">&nbsp;</td>
				</tr>
			</table>
			<!--�� ��Ÿ --><br>
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>��Ÿ ����</td>
					<td><input type="checkbox" name="web_window_mode" value="1" checked>&nbsp;�������� ��üâ���� ǥ����<br><input type="checkbox" name="log_option" value="Y">&nbsp;������ ������ �󼼷α� ����� �����<br><input type="checkbox" name="yn_activex" value="Y">&nbsp;�������� ACTIVEX ��� �����</td>
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
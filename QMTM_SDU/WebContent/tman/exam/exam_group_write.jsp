<%
//******************************************************************************
//   ���α׷� : exam_write.jsp
//   �� �� �� : ������
//   ��    �� : ������ ������
//   �� �� �� : exam_m, r_exam_kind, r_exam_kind_sub, r_std_grade, r_std_level
//   �ڹ����� : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//             qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//             qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//             qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   �� �� �� : 2010-06-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*, java.util.*" %>
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
	
	// �׷챸�и�� ���������
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
	
	// ������ ������ ���������
	String paper_design = "";

	try {
		paper_design = TreeUtil.getDesign();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	String[] paper_types = paper_design.split(",");	

	// ����ǥ������ ���������
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
<title> :: �ϰ����� ��� :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">	
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
		
		yn_sametimes("N"); // �ʱⰪ�� �񵿽��򰡷� ����(�����򰡷� ���ý� Y �� ����) 
		id_randomtypes("NN"); // �������� �ʱⰪ ���� (�ʱⰪ : ��������)
		yn_open_qas("A"); // �������� �ɼ� �ʱⰪ ���� (�ʱⰪ : ���� �� �ؼ� �������� ����)
		paper_change(11); // ������ �̸����� �̹��� �ʱⰪ ���� 
		idexlabels(11, document.form1.fontname.value, document.form1.fontsize.value); // ����ǥ������, �۲�, ����ũ�� �ʱⰪ ����
		pwd_check(); // ���� ��й�ȣ ����
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

		strArea += '<textarea cols=80 rows=5 style="font-family:' + selects2 + ';font-size:' + selects3 + 'pt";>';
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

		if(frm.time_setting2.checked == true) {
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
	}
	
	function yn_sametimes(yn_check) {
		var frm = document.form1;

		if(yn_check == "N") {
			
			document.all.time_setting.style.display = "none";
			
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

			document.all.time_setting.style.display = "block";

			if(frm.time_setting2.checked == false) {				
				
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
			} else {

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

			}
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
			frm.configs.value = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ� ���� �˻��� ���� �׷쿡�� ������ �����ؼ� ���� �ٸ� ������ ������ ����ϴ�.";
		} else if(types == "YT") {
			frm.configs.value = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ� ���� �˻��� ���� �׷쿡�� ������ �����ؼ� �� ������ ���� ������ ��� ���� �ٸ� ������ �� ����ϴ�.";
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

		if(frm.title.value.length == 0) {
			alert("������� �Է��ϼ���.!!!");			
			return;
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

</script>

</head>

<body id="popup2" onload="inits();">
	
	<form name="form1" action="exam_group_insert.jsp" method="post">
	<input type="hidden" name="id_course" value="<%=id_course%>">
	<input type="hidden" name="id_subject" value="<%=id_subject%>">
	<input type="hidden" name="userid" value="<%=userid%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�ϰ����� ��� <span>�ϰ��� ������ ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents" style="height: 420px;">

		

		<div style="display:;" id="id_basics">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01_.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<!--�� ���� ���� ����-->
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>�����</td>
					<td colspan="3"><input type="text" class="input" name="title" size="55"></td>
				</tr>
				<tr>
					<td id="left"><li>���豸��</td>
					<td colspan="3"><select name="id_exam_kind" >
					<% for(int i=0; i<rst.length;i++) { %>
						<option value="<%=rst[i].getId_exam_kind()%>"><%=rst[i].getExam_kind()%></option>
					<% } %>
					</select>
					</td>
				</tr>
				
			</table>

			<!--�� ��������--><br>
			
			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="100"><li>������</td>
					<td colspan="3"><div style="float: left;"><input type="radio" name="yn_sametime" value="N" checked onClick="yn_sametimes('N');">&nbsp;�񵿽���&nbsp;<input type="radio" name="yn_sametime" value="Y" onClick="yn_sametimes('Y');">&nbsp;������</div><div id="time_setting" style="float: left; margin-left: 15px;"><input type="checkbox" name="time_setting2" value="Y" onClick="time_set();" checked> �ڵ�����&nbsp;&nbsp;<b>(������۽ð��� ������۽ð� 10����,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������ð��� ��������ð��� ���� ����)</b></div></td>
				</tr>
				<tr>
					<td id="left"><li>������۽ð�</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.login_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="login_start1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
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
					<option value="<%=jj%>" <%if(now.toString().substring(11,13).equals(jj)) { %> selected <% } %>><%=jj%></option>
					<% } %></select>
					��&nbsp;<input type="text" class="input" name="login_start3" size="3" value="00"> ��&nbsp;<input type="text" class="input" name="login_start4" size="3" value="00"> ��</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>��������ð�</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.login_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="login_end1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
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
					<option value="<%=jj2%>" <%if(now.toString().substring(11,13).equals(jj2)) { %> selected <% } %>><%=jj2%></option>
					<% } %></select>
					��&nbsp;<input type="text" class="input" name="login_end3" size="3" value="00"> ��&nbsp;<input type="text" class="input" name="login_end4" size="3" value="00"> ��</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>������۽ð�</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.exam_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="exam_start1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
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
					<option value="<%=jj3%>" <%if(now.toString().substring(11,13).equals(jj3)) { %> selected <% } %>><%=jj3%></option>
					<% } %></select>
					��&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="00"> ��&nbsp;<input type="text" class="input" name="exam_start4" size="3" value="00"> ��</div>
					</td>
				</tr>
				<tr>
					<td id="left"><li>��������ð�</td>
					<td colspan="3"><div style="float: left; margin: 1px 7px 0px 3px;"><a href="javascript:" onClick="MiniCal(document.all.exam_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="exam_end1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
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
					<option value="<%=jj4%>" <%if(now.toString().substring(11,13).equals(jj4)) { %> selected <% } %>><%=jj4%></option>
					<% } %></select>
					��&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="00"> ��&nbsp;<input type="text" class="input" name="exam_end4" size="3" value="00"> ��</div>
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
					<td><input type="radio" name="id_auth_type" value="0" checked>�α���&nbsp;&nbsp;&nbsp;<!--<input type="radio" name="id_auth_type" value="1" checked >����&nbsp;&nbsp;&nbsp;--><input type="radio" name="id_auth_type" value="2" onClick="alert('�������������� �������� ��쿡�� �ϴܿ� ����� ��ư�� ������ ���� �� ������ ����� �����մϴ�.')">����</td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>�����й�ȣ</td>
					<td><div style="float: left;"><input type="checkbox" name="exam_pwd_yn" value="Y" onClick="pwd_check();">&nbsp;�ش� ���迡 ��й�ȣ�� ������</div><div id="pwd_str" style="float: left; margin-left: 15px;"><font color=blue><b>��й�ȣ ��� :</b></font> <input type="text" name="exam_pwd_str" size="17" maxlength="15"></div></td>
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
					<td><div style="float: left; margin: 1px 10px 0px 5px;"><a href="javascript:" onClick="MiniCal(document.all.stat_start1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="stat_start1" size="12" readonly value="<%=now.toString().substring(0,10)%>">
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
					<td><div style="float: left; margin: 1px 10px 0px 5px;"><a href="javascript:" onClick="MiniCal(document.all.stat_end1)"><img src="../../images/icon_cal.gif"></a></div><div style="float: left;"><input type="text" class="input" name="stat_end1" readonly size="12"  value="<%=now.toString().substring(0,10)%>">
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
					<td><input type="checkbox" name="yn_stat" value="Y" >�����ڿ��� ������� ����</td>
				</tr>
			</table>
		</div>

		<div style="display:none;" id="id_designs">

			<div class="tab"><a href="javascript:movieLayout('basic');" onfocus="this.blur();"><img src="../../images/tabA01.gif"></a><a href="javascript:movieLayout('detail');" onfocus="this.blur();"><img src="../../images/tabA02.gif"></a><a href="javascript:movieLayout('score');" onfocus="this.blur();"><img src="../../images/tabA03.gif"></a><a href="javascript:movieLayout('design');" onfocus="this.blur();"><img src="../../images/tabA04_.gif"></a><a href="javascript:movieLayout('guide');" onfocus="this.blur();"><img src="../../images/tabA05.gif"></a></div>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>������ ����</td>
					<td style="padding-left: 20px;">
						<% for(int i=0; i<6; i++) { %>
						<input type="radio" name="paper_type" value="<%=paper_types[i]%>" <%if(paper_types[i].equals("11")) { %> checked <% } %> onClick="paper_change(this.value);">&nbsp;������������ <%=i+1%><br>
						<% } %>
					</td>
					<td align="right"><div id="paperImg"></div></td>
				</tr>
			</table>

			<br>

			<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">
				<tr>
					<td id="left" width="120"><li>���� ǥ�� ����</td>
					<td><select name="id_exlabel" onChange="idexlabels(this.value,document.form1.fontname.value,document.form1.fontsize.value);">
					<% for(int i=0; i<rst5.length;i++) { %>
						<option value="<%=rst5[i].getId_exlabel()%>" <% if(rst5[i].getId_exlabel() == 11) { %> selected <% } %>><%=rst5[i].getExlabel()%></option>
					<% } %>
					</td>
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
						<option value="Nanum Gothic">�������(����Ʈ)</option>
						<option value="Nanum Gothic Coding">��������ڵ�(����Ʈ)</option>
						<option value="Malgun Gothic">�������</option>
						<option value="Arial">Arial</option>
						<option value="Courier New">Courier New</option>
						<option value="Times New Roman">Times New Roman</option>
						</select>
						&nbsp;
						<select name="fontsize" onChange="idexlabels(document.form1.id_exlabel.value,document.form1.fontname.value,this.value);">
						<option value="9">9</option>
						<option value="10">10</option>
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
					<td><input type="checkbox" name="web_window_mode" value="1" checked>&nbsp;�������� ��üâ���� ǥ����<br><input type="checkbox" name="log_option" value="Y">&nbsp;������ ������ �󼼷α� ����� �����</td>
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
</HTML>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
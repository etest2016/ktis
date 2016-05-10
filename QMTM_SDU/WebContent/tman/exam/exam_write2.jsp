<%
//******************************************************************************
//   ���α׷� : exam_write.jsp
//   �� �� �� : ������
//   ��    �� : ������ ������
//   �� �� �� : exam_m, r_exam_kind, r_exam_kind_sub, r_std_grade, r_std_level
//   �ڹ����� : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//              qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//              qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//              qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   �� �� �� : 2008-04-15
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
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
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}
	
	// �׷챸�и�� ���������
	ExamKindBean[] rst = null;

	try {
		rst = ExamKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// ���豸�и�� ���������
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

	// �г��ڵ��� ���������
	StdGradeBean[] rst3 = null;

	try {
		rst3 = StdGradeUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// �����ڵ��� ���������
	StdLevelBean[] rst4 = null;

	try {
		rst4 = StdLevelUtil.getBeans();
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
<title>�����߰�</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">	
	
	var ArrId_exam_kind = new Array();
	var ArrId_exam_kind_sub = new Array();
	var ArrExam_kind_sub = new Array();

	// �ʱⰪ ����..
	function inits() {

		var frm = document.form1;
		
		exam_kind_change(1); // ���豸�� ��� �ʱⰪ...(Admin���������� ���豸�и�Ͽ� ����Ÿ�� �Է� �� ���)
		yn_sametimes("N"); // �ʱⰪ�� �񵿽��򰡷� ����(�����򰡷� ���ý� Y �� ����) 
		id_randomtypes("NN"); // �������� �ʱⰪ ���� (�ʱⰪ : ��������)
		yn_open_qas("A"); // �������� �ɼ� �ʱⰪ ���� (�ʱⰪ : ���� �� �ؼ� �������� ����)
		paper_change(11); // ������ �̸����� �̹��� �ʱⰪ ���� 
		idexlabels(11, document.form1.fontname.value, document.form1.fontsize.value); // ����ǥ������, �۲�, ����ũ�� �ʱⰪ ����
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
		strArea += '1. ���� �� ������ ���̽� ���� �ý���(DBMS)��\n';
		strArea += '&nbsp;&nbsp;&nbsp;������� �� �� ���� ����?\n\n';
		strArea += arr_data[0] +' ������� ���ǰ���� ���� ������ �ۼ��Ѵ�.\n';
		strArea += arr_data[1] +' ���Ἲ �˻縦 ħ���ϴ� ������ �ź��Ѵ�.\n';
		strArea += arr_data[2] +' �������� ���۰� ó���� �����ϴ�.\n';
		strArea += arr_data[3] +' ������ ��������� �����Ѵ�\n';
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
			frm.configs.value = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ� ���� �˻��� ���� �׷쿡�� ������ �����ؼ� ���� �ٸ� ������ ������ ����ϴ�.";
		} else if(types == "YT") {
			frm.configs.value = "�������࿡�� ���� ��� ������ �˻��� �� ������ �ɼǿ� ���� �˻��� ���� �׷쿡�� ������ �����ؼ� �� ������ ���� ������ ��� ���� �ٸ� ������ �� ����ϴ�.";
		} 
	}

	// �׷챸�и�� ���ý� ���豸�� ��� �����ֱ�...
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

		if(frm.course_no.value.length == 0) {
			alert("����ȸ���� �Է��ϼ���.!!!");			
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

				<div class="title">������</div>
<form name="form1" action="exam_insert.jsp" method="post">
<input type="hidden" name="id_course" value="<%=id_course%>">
<input type="hidden" name="id_subject" value="<%=id_subject%>">

<table border="0" width="100%">
	<tr align="left">

		<td><input type="button" value="����⺻����" onClick="movieLayout('basic')"><!--<a href="javascript:movieLayout('basic');"><img src="../../../images/bt_exam_w1.gif"></a>&nbsp;&nbsp;--><input type="button" value="���輼�μ���" onClick="movieLayout('detail')"><!--<a href="javascript:movieLayout('detail');"><img src="../../../images/bt_exam_w2.gif"></a>&nbsp;&nbsp;--><input type="button" value="�������ü���" onClick="movieLayout('score')"><!--<a href="javascript:movieLayout('score');"><img src="../../../images/bt_exam_w3.gif"></a>&nbsp;&nbsp;--><input type="button" value="���������" onClick="movieLayout('design')"><!--<a href="javascript:movieLayout('design');"><img src="../../../images/bt_exam_w4.gif"></a>&nbsp;&nbsp;--><input type="button" value="����ȳ�" onClick="movieLayout('guide')"><!--<a href="javascript:movieLayout('guide');"><img src="../../../images/bt_exam_w5.gif"></a>--></td>
	</tr>
</table>

<br>

<table border="0" width="100%" style="display:block;" id="id_basics" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
		<tr height="30" bgcolor="#FFFFFF">
				<td align="left" colspan="4">�� ���輳��</td>
			</tr>

		<tr  bgcolor="#FFFFFF">
				<td width="20%" align="right">�����&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="text" class="input" name="title" size="55"></td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">�׷챸��&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<select name="id_exam_kind" onChange="exam_kind_change(this.value);">
				<% for(int i=0; i<rst.length;i++) { %>
					<option value="<%=rst[i].getId_exam_kind()%>"><%=rst[i].getExam_kind()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">���豸��&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3" id="exam_kind_sub">
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">�гⱸ��&nbsp;</td>
				<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="std_grade">
				<% for(int i=0; i<rst3.length;i++) { %>
					<option value="<%=rst3[i].getStd_grade()%>"><%=rst3[i].getGrade_nm()%></option>
				<% } %>
				</select>
				</td>
				<td width="20%" align="right">��������&nbsp;</td>
				<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="std_level">
				<% for(int i=0; i<rst4.length;i++) { %>
					<option value="<%=rst4[i].getStd_level()%>"><%=rst4[i].getLevel_nm()%></option>
				<% } %>
				</select>
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">����ȸ��&nbsp;</td>
				<td bgcolor="#FFFFFF" width="30%">&nbsp;&nbsp;<input type="text" class="input" name="course_no" size="7"> ȸ</td>
				<td width="20%" align="right">�� ��&nbsp;</td>
				<td bgcolor="#FFFFFF">&nbsp;&nbsp;���� <input type="text" class="input" name="u_avg_basis" size="3"> % ���</td>
			</tr>

			<tr height="30" bgcolor="#FFFFFF">
				<td align="left" colspan="4">�� ��������</td>
			</tr>

			<tr  bgcolor="#FFFFFF">
				<td width="20%" align="right">������&nbsp;</td>
				<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="yn_sametime" value="N" checked onClick="yn_sametimes('N');">&nbsp;�񵿽���&nbsp;&nbsp;&nbsp;<input type="radio" name="yn_sametime" value="Y" onClick="yn_sametimes('Y');">&nbsp;������</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">������۽ð�&nbsp;</td>
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
				��&nbsp;<input type="text" class="input" name="login_start3" size="3" value="<%=now.toString().substring(14,16)%>"> ��&nbsp;<input type="text" class="input" name="login_start4" size="3" value="00"> ��
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">��������ð�&nbsp;</td>
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
				��&nbsp;<input type="text" class="input" name="login_end3" size="3" value="<%=now.toString().substring(14,16)%>"> ��&nbsp;<input type="text" class="input" name="login_end4" size="3" value="00"> ��
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">������۽ð�&nbsp;</td>
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
				��&nbsp;<input type="text" class="input" name="exam_start3" size="3" value="<%=now.toString().substring(14,16)%>"> ��&nbsp;<input type="text" class="input" name="exam_start4" size="3" value="00"> ��
				</td>
			</tr>
			<tr height="30" bgcolor="#FFFFFF">
				<td width="20%" align="right">��������ð�&nbsp;</td>
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
				��&nbsp;<input type="text" class="input" name="exam_end3" size="3" value="<%=now.toString().substring(14,16)%>"> ��&nbsp;<input type="text" class="input" name="exam_end4" size="3" value="00"> ��
				</td>
			</tr>
		</table>
		

	<table border="0" width="100%" style="display:none;" id="id_details" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
		<tr  bgcolor="#FFFFFF">
			<td width="20%" align="right">��������&nbsp;</td>
			<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_exam_type" value="0" checked>&nbsp;&nbsp;����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="id_exam_type" value="1">&nbsp;&nbsp;�������ǰ����</td>
		</tr>			
		<tr  bgcolor="#FFFFFF">
			<td width="20%" align="right">������������&nbsp;</td>
			<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="0">&nbsp;&nbsp;�α���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="1" checked>&nbsp;&nbsp;����<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="id_auth_type" value="2">&nbsp;&nbsp;����--></td>
		</tr>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="left" colspan="4">�� ���輼������</td>
		</tr>

		<tr height="30" bgcolor="#FFFFFF">
			<td width="20%" align="right">���ѽð�&nbsp;</td>
			<td bgcolor="#FFFFFF" width="30%">&nbsp;&nbsp;<input type="text" class="input" name="limittime" size="5" value="60"> ��</td>
			<td width="20%" align="right">����&nbsp;</td>
			<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="allotting" size="5" value="100"> ��</td>
		</tr>
		<tr height="30" bgcolor="#FFFFFF">
			<td width="20%" align="right">������ ���� ��&nbsp;</td>
			<td bgcolor="#FFFFFF" width="30%">&nbsp;&nbsp;<input type="text" class="input" name="qcount" size="5" value="20"> ����</td>
			<td width="20%" align="right">ȭ��� ���� ��&nbsp;</td>
			<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="qcntperpage" size="5" value="1"> ����</td>
		</tr>
		<tr  bgcolor="#FFFFFF">
			<td width="20%" align="right">������ �̵����&nbsp;</td>
			<td bgcolor="#FFFFFF" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_movepage" value="F" checked>&nbsp;����, ���� �����̵�&nbsp;&nbsp;&nbsp;<input type="radio" name="id_movepage" value="N">&nbsp;������ �̵�����</td>
		</tr>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="left" colspan="4">�� ��������</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="65%" align="left" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NN" checked onClick="id_randomtypes(this.value)">&nbsp;&nbsp;��������</td>
			<td width="35%" rowspan="3">&nbsp;<textarea name="configs" cols="30" rows="5" readonly></textarea></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="65%" align="left" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NQ" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;��������&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="NT" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;���� �� ���⼯��</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="65%" align="left" colspan="3">&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YQ" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;�������� => ��������&nbsp;&nbsp;<input type="radio" name="id_randomtype" value="YT" onClick="id_randomtypes(this.value)">&nbsp;&nbsp;�������� => ���� �� ���⼯��</td>
		</tr>
	</table>
	
	<table border="0" width="100%" style="display:none;" id="id_scores" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
		<tr bgcolor="#FFFFFF">
			<td bgcolor="#FFFFFF" colspan="2">&nbsp;&nbsp;<input type="checkbox" name="yn_open_score_direct" value="Y" >&nbsp;&nbsp;������� ���� �� ���������� ���� �ٷ� ����</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" colspan="2">&nbsp;&nbsp;&nbsp;<select name="yn_open_qa" onChange="yn_open_qas(this.value);">
			<option value="A">���� �� �ؼ� �������� ����</option>
			<option value="B">��� ���� ���� ������ ����</option>
			<option value="C">��� ���� ���� ���� �� �����ؼ� ����</option>
			<option value="D">���� ��ȸ �Ⱓ�� ������ ����</option>
			<option value="E">���� ��ȸ �Ⱓ�� ���� �� �����ؼ� ����</option>
			</select>
			</td>				
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" width="27%" align="right">&nbsp;&nbsp;������ȸ ���۽ð�</td>
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
			��&nbsp;<input type="text" class="input" name="stat_start3" size="3" value="<%=now.toString().substring(14,16)%>"> ��&nbsp;<input type="text" class="input" name="stat_start4" size="3" value="00"> ��</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" width="27%" align="right">&nbsp;&nbsp;������ȸ ����ð�</td>
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
			��&nbsp;<input type="text" class="input" name="stat_end3" size="3" value="<%=now.toString().substring(14,16)%>"> ��&nbsp;<input type="text" class="input" name="stat_end4" size="3" value="00"> ��</td>
		</tr>
		<tr bgcolor="#FFFFFF" height="30">
			<td bgcolor="#FFFFFF" colspan="2">&nbsp;&nbsp;<input type="checkbox" name="yn_stat" value="Y" >&nbsp;&nbsp;�����ڿ��� ������� ����</td>
		</tr>
	</table>

	<table border="0" width="100%"  style="display:none;" id="id_designs" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">	
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="40%">
		<% for(int i=0; i<6; i++) { %>
		&nbsp;&nbsp;<input type="radio" name="paper_type" value="<%=paper_types[i]%>" <%if(paper_types[i].equals("11")) { %> checked <% } %> onClick="paper_change(this.value);">&nbsp;������������ <%=i+1%><br>
		<% } %>
		</td>
		<td bgcolor="#FFFFFF" width="60%" align="center" id="paperImg"></td>
	</tr>
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="40%">&nbsp;&nbsp;���� ǥ�� ����</td>
		<td bgcolor="#FFFFFF" width="60%">&nbsp;&nbsp;ȭ�� �۲� ����</td>
	</tr>
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="40%">&nbsp;&nbsp;<select name="id_exlabel" onChange="idexlabels(this.value,document.form1.fontname.value,document.form1.fontsize.value);">
		<% for(int i=0; i<rst5.length;i++) { %>
			<option value="<%=rst5[i].getId_exlabel()%>" <% if(rst5[i].getId_exlabel() == 11) { %> selected <% } %>><%=rst5[i].getExlabel()%></option>
		<% } %>
		</td>
		<td bgcolor="#FFFFFF" width="60%">&nbsp;&nbsp;<select name="fontname" onChange="idexlabels(document.form1.id_exlabel.value,this.value,document.form1.fontsize.value);">
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
		<td align="left" colspan="2">�� ��Ÿ</td>
	</tr>
	<tr bgcolor="#FFFFFF">
		<td width="68%" align="left" colspan="2">&nbsp;&nbsp;<input type="checkbox" name="web_window_mode" value="1" checked>&nbsp;�������� ��üâ���� ǥ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="log_option" value="Y">&nbsp;������ ������ �󼼷α� ����� �����</td>
	</tr>
</table>

<table border="0" width="100%"  style="display:none;" id="id_guides" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">	
	<tr bgcolor="#FFFFFF" height="30">
		<td bgcolor="#FFFFFF" width="100%">&nbsp;&nbsp;<textarea name="guide" cols="90" rows="10"></textarea></td>
	</tr>
</table>	

	<p>
	<input type="radio" name="yn_enable" value="N" checked> �����غ�&nbsp;&nbsp;<input type="radio" name="yn_enable" value="Y"> ���谡��&nbsp;&nbsp;<input type="button" value="�����" onClick="Send();">&nbsp;&nbsp;<input type="button" onclick="window.close();" value="â�ݱ�">

	</form>
		</TD>
		<!--/ ���� ��ư ���� ���� /-->
		<TD id="right"><img src="../../images/bt_popup_close.gif"></TD>
		</TR>
	</TABLE>
	
 </BODY>
</HTML>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
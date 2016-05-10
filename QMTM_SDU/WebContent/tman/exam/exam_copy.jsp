<%
//******************************************************************************
//   ���� �׷� : exam_copy.jsp
//   �� ��  �� : ���� ����
//   ��     �� : ���� ����
//   �� ��  �� : exam_m
//   �ڹ� ���� : qmtm.ComLib, qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   �� ��  �� : 2013-02-12
//   �� ��  �� : ���׽�Ʈ ����ȣ
//   �� ��  �� : 
//   �� ��  �� : 
//	 ���� ���� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String org_id_course = request.getParameter("org_id_course");
	if (org_id_course == null) { org_id_course = ""; } else { org_id_course = org_id_course.trim(); }	

	String org_id_subject = request.getParameter("org_id_subject");
	if (org_id_subject == null) { org_id_subject = ""; } else { org_id_subject = org_id_subject.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }	
	
	String open_year = request.getParameter("open_year");
	if (open_year == null) { open_year = ""; } else { open_year = open_year.trim(); }

	String open_month = request.getParameter("open_month");
	if (open_month == null) { open_month = ""; } else { open_month = open_month.trim(); }
	
	if (org_id_course.length() == 0 || org_id_subject.length() == 0 || id_category.length() == 0) { 
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = "0"; } else { id_subject = id_subject.trim(); }

	if(id_course.equals("")) {
		id_course = org_id_course;
	}

	if(id_subject.equals("")) {
		id_subject = org_id_subject;
	}

    // ���� �Ʒ� �������� ���������
	ExamListBean[] rst = null;

	if(!id_subject.equals("")) {
		
		try {
			rst = ExamList.getBeans(id_course, id_subject);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}
	}

	// ���� �Ʒ� �������� ���������
	SubjectTmanBean[] rst2 = null;

    try {
	    rst2 = SubjectTmanUtil.getBeans(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	ExamUtilBean[] rst3 = null;

    try {
	    if(chk_userid.equals("qmtm") || chk_usergrade.equals("M")) {
		    rst3 = ExamUtil.getCourseList(id_category);
		} else {
			rst3 = ExamUtil.getCourseList(id_category, chk_userid);
		}
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>

<HTML>
 <HEAD>
  <TITLE> :: ���� ���� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function exam_copy() {

		var frmx = document.form2;
			
		var selectId = "";
		var k = 0;

		if(frmx.id_exam.length == undefined) {
			 if(frmx.id_exam.checked == true) {
				 k = k + 1;
			 }
		} else if(frmx.id_exam.length != undefined) {
			 for (i=0; i<=frmx.id_exam.length -1; i++) {
				 if (frmx.id_exam[i].checked == true) {
					k = k + 1;
				 }
			 }
		}

		if(k == 0) {
			alert("������ ������ �������ּ���.");
		} else {
			
			var str = confirm("üũ�� ���迡 ���ؼ� �ϰ����� �۾��� �����Ͻðڽ��ϱ�?");

			if(str == true) {
				document.form2.submit();
			}
		}
    }

	// �ܿ� 1���� ���������
	function get_cpt1_list(id_course, id_subject) {

		var frm = document.form1;
		
		cpt1 = new ActiveXObject("Microsoft.XMLHTTP");
		cpt1.onreadystatechange = get_cpt1_list_callback;
		cpt1.open("GET", "lecture.jsp?id_course="+id_course+"&id_subject="+id_subject, true);
		cpt1.send();
	}

	function get_cpt1_list_callback() {

		if(cpt1.readyState == 4) {
			if(cpt1.status == 200) {
				if(typeof(document.all.div_cpt1) == "object") {
					document.all.div_cpt1.innerHTML = cpt1.responseText;
				}
			}
		}
	}

	function cat_select(sel) {

		var frm = document.form1;

		frm.submit();
		
	}

 </script>

</HEAD>

<BODY id="popup2" onLoad="get_cpt1_list('<%=id_course%>','<%=id_subject%>');">

	<form name="form1" method="post" action="exam_copy.jsp">
	<input type="hidden" name="id_category" value="<%=id_category%>">
	<input type="hidden" name="org_id_course" value="<%=org_id_course%>">
	<input type="hidden" name="org_id_subject" value="<%=org_id_subject%>">
	<input type="hidden" name="open_year" value="<%=open_year%>">
	<input type="hidden" name="open_month" value="<%=open_month%>">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ����<span>�⺻ ������ �����Ͽ� �� ������ ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="20%"><li>��������</td>
				<td><select name="id_course" style="width:400" onChange="get_cpt1_list(this.value);">
					<% if(rst3 == null) { %>
					<option value="">��ϰ�������</option>
					<% 
						} else { 
							for(int i=0; i<rst3.length; i++) {							
					%>
						<option value="<%=rst3[i].getId_course()%>" <% if(rst3[i].getId_course().equals(id_course)) { %>selected<% } %>><%=rst3[i].getCourse()%></option>
					<% 
							} 
						}
					%>
					</select>
				</td>
			</tr>			
			<tr>
				<td id="left" width="20%"><li>���¼���</td>
				<td><div id="div_cpt1">
						<select name="id_subject" style="width:400" disabled>
							<option value=""></option>
						</select>
					</div>
				</td>
			</tr>	
		</table>		
	</div>	
	<BR>
	</form>

	<form name="form2" method="post" action="exam_copy_ok.jsp">
	<input type="hidden" name="id_course" value="<%=org_id_course%>">
	<input type="hidden" name="id_subject" value="<%=org_id_subject%>">

	<div id="contents">	
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">����</td>
				<td width="35%">��������</td>
				<td width="15%">���谡�ɿ���</td>
				<td width="20%">���������</td>
				<td>����������</td>
			</tr>
		</table>
		
		<% if(!id_subject.equals("")) { %>
		<div style="overflow: auto; width:100%; height:240px; margin-top: 0px;">

			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				<%
					if(rst == null) {
				%>
				<tr>
					<td class="blank" colspan="5">������ ������ �����ϴ�.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {
				%>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" value="<%=rst[i].getId_exam()%>@<%=rst[i].getTitle()%>"></td>
					<td width="35%">&nbsp;<%=rst[i].getTitle()%></td>
					<td width="15%"><%=rst[i].getYn_enable()%></td>
					<td width="20%"><%=rst[i].getExam_start1()%></td>
					<td><%=rst[i].getExam_end1()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		</div>
		<% } %>

		<input type="hidden" name="paper_cnt" value="1">

		</div>

	</div>
	<div id="button">
		<a href="javascript:exam_copy();"><img src="../../images/bt_subj_list_2.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img src="../../images/bt_close_1.gif" align="top"></a></div>
	</div>

	</form>

 </BODY>
</HTML>
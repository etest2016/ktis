<%
//******************************************************************************
//   ���α׷� : course_list.jsp
//   �� �� �� : �����Ʒ� �������
//   ��    �� : ������� Ʈ������ ���� ���ý� �����ִ� ������
//   �� �� �� : exam_m
//   �ڹ����� : qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   �� �� �� : 2008-04-14
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    String course_name = "";

    // ���Ǹ� ���������
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// ���� �Ʒ� �������� ���������
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getBeans(id_course, "-1");
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	String userid = (String)session.getAttribute("userid");
	
	String pt_exam_edit = "";
	String pt_exam_delete = "";
	String pt_answer_edit = "";
	String pt_score_edit = "";
	String pt_static_edit = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getExam_work(id_course, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	pt_exam_edit = bean.getPt_exam_edit();
	pt_exam_delete = bean.getPt_exam_delete();
	pt_answer_edit = bean.getPt_answer_edit();
	pt_score_edit = bean.getPt_score_edit();
	pt_static_edit = bean.getPt_static_edit();
%>

<HTML>
 <HEAD>
  <TITLE> Tman Main </TITLE>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
  <link rel="StyleSheet" href="../css/style.css" type="text/css">

  <script type="text/javascript" src="../js/tablesort.js"></script>

 <script language="JavaScript">
	function insert() {
		window.open("exam/exam_write.jsp?id_course=<%=id_course%>&id_subject=-1","insert","width=750, height=640, scrollbars=no, top=0, left=0");
    }

	function edits(id_exam) {
		window.open("exam/exam_edit.jsp?id_exam="+id_exam,"edit","width=750, height=640, scrollbars=no, top=0, left=0");
    }

	function exam_copy() {
		window.open("exam/exam_copy.jsp?id_course=<%=id_course%>&id_subject=-1","copys","top=0, left=0, width=650, height=450, scrollbars=yes");
    }

	function exam_copy_edit() {
		window.open("exam/exam_copy_edit.jsp?id_course=<%=id_course%>&id_subject=-1","copys","top=0, left=0, width=650, height=450, scrollbars=yes");
    }

	function exam_delete() {
		window.open("exam/exam_deletes.jsp?id_course=<%=id_course%>&id_subject=-1","deletes","width=650, height=450, scrollbars=yes, top=0, left=0");
    }

	function cpt_insert() {
		window.open("subject/subject_insert.jsp?id_course=<%=id_course%>","insert","width=400, height=250, scrollbars=no");
    }

	function exam_down() {
		window.open("exam/exam_data_down.jsp?id_course=<%=id_course%>&id_subject=-1","copys","top=0, left=0, width=1050, height=550, scrollbars=yes");
    }

 </script>

 </HEAD>

 <BODY id="tman">
	<div id="main">

		<div id="mainTop">
			<div class="title"><font class="point_t_n"><%=course_name%></font> ���� ��� <span> ���� ������ ��ϵ� ���� ����Դϴ�.</span></div>
			<div class="location">������� > <span><%=course_name%> </span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
			<tr id="bt"><td align="left"><%if(pt_exam_edit.equals("Y")) { %><img src="../images/bt_subj_list_1.gif" onclick="javascript:insert();" style="cursor: hand;"><% }else { %><img src="../images/bt_subj_list_1.gif"><% } %><%if(pt_exam_edit.equals("Y")) { %><img src="../images/bt_subj_list_2.gif" onclick="javascript:exam_copy();" style="cursor: hand; margin-left: 5px;"><% } else { %><img src="../images/bt_subj_list_2.gif" style="margin-left: 5px;"><% } %></td>
			<td align="right" ><input type="button" value="����ī�װ����" class="form" onClick="cpt_insert();"></td>
			</tr>
		</table>
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" onclick="sortColumn(event)">
			<THEAD>						
			<tr id="tr">
				<td>�������� ���</td>
				<td>���谡�ɿ���</td>
				<td>����Ⱓ ���</td>
				<td>������ȸ�Ⱓ ���</td>
				<td>&nbsp;</td>
			</tr>
			</THEAD>
	<%
		if(rst == null) {
	%>
			<TBODY>
			<tr>
				<td class="blank" colspan="5">��ϵǾ��� ������ �����ϴ�.</td>
			</tr>
			</TBODY>
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {
	%>
			<tr id="td" align="center">
				<td style="padding-left: 20px; text-align: left;"><%=rst[i].getTitle()%></td>				
				<td><% if (rst[i].getYn_enable().equals("Y")){%><img src="../images/icon_y.gif"><%}else{%><img src="../images/icon_n.gif"><%}%></td>
				<td><%=rst[i].getExam_start1()%> ����<br><%=rst[i].getExam_end1()%> ����</td>
				<%if(rst[i].getYn_open_qa().equals("A")) { %>
				<td align="center">�Ⱓ��������</td>
				<% } else { %>
				<td><%=rst[i].getStat_start()%> ����<br><%=rst[i].getStat_end()%> ����</td>
				<% } %>
				<td><%if(pt_exam_edit.equals("Y")) { %><a href="javascript:edits('<%=rst[i].getId_exam()%>');" onfocus="this.blur();"><% } %><img src="../images/bt3_exam_edit.gif"></a>&nbsp;<a href="exam/exam_list.jsp?id_exam=<%=rst[i].getId_exam()%>" onfocus="this.blur();"><img src="../images/bt3_exam_info.gif"></a></td>
			</tr>
	<%
			}
		}
	%>
		</table>

	</div>
	<jsp:include page="../copyright.jsp"/>

 </BODY>
</HTML>
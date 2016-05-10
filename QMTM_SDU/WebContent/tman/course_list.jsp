<%
//******************************************************************************
//   ���α׷� : course_list.jsp
//   �� �� �� : ���¾Ʒ� �������
//   ��    �� : ������� Ʈ������ ���� ���ý� �����ִ� ������
//   �� �� �� : exam_m, t_worker_subj, c_course, c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, 
//              qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil,
//              qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList
//   �� �� �� : 2013-02-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil,qmtm.LoginProcBean, qmtm.LoginProc, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	

	String id_subject = "-1";
	
	if (id_course.length() == 0 || id_subject.length() ==0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	String usergrade = (String)session.getAttribute("usergrade"); // ����

	String course_name = "";

    // ������ ���������
	try {
		course_name = ExamUtil.getCourseName(id_course);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

    // ���� �Ʒ� �������� ���������
	ExamListBean[] rst = null;

    try {
	    rst = ExamList.getBeans(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	String pt_exam_edit = "";
	String pt_exam_delete = "";
	String pt_answer_edit = "";
	String pt_score_edit = "";
	String pt_static_edit = "";

	LoginProcBean bean = null;

	try {
		bean = LoginProc.getExam_work(id_course, userid, usergrade);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

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
  <link rel="StyleSheet" href="../css/style.css" type="text/css">
  <script type="text/javascript" src="../js/jquery.js"></script>
  <script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../js/tablesort.js"></script>

  <script type="text/JavaScript">
	function simpleInsert() {
		$.posterPopup("exam/exam_simple_write.jsp?id_course=<%=id_course%>","SI","width=750, height=750, scrollbars=yes, top="+(screen.height-750)/2+", left="+(screen.width-750)/2);
	}
  
    function insert() {
		$.posterPopup("exam/exam_write.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>","insert","width=750, height=680, scrollbars=no, top="+(screen.height-680)/2+", left="+(screen.width-750)/2);
    }

	function edits(id_exam) {
		$.posterPopup("exam/exam_edit.jsp?id_exam="+id_exam,"edit","width=750, height=680, scrollbars=no, top="+(screen.height-680)/2+", left="+(screen.width-750)/2);
    }
	
 </script>

 </HEAD>

 <BODY id="tman">

	<div id="main">

		<div id="mainTop">
			<div class="title">���� ���� ����Ʈ<span></span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../images/icon_location.gif"> <%=course_name%></div>
		</div>
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" >
			<tr id="bt">
				<td align="left"><%if(pt_exam_edit.equals("Y")) { %><input type="button" value="�����򰡵��" onclick="simpleInsert();" class="form4">&nbsp;&nbsp;<input type="button" value="������ ���������ĵ��" onclick="Insert();" class="form4"><% }else { %><input type="button" value="������ȭ����ϱ�" onclick="alert('������ ��� ������ �����ϴ�.');" class="form4">&nbsp;&nbsp;<input type="button" value="������ ���������ĵ��" onclick="alert('������ ��� ������ �����ϴ�.');" class="form4"><% } %></td>
			</tr>
		</table>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" onclick="sortColumn(event)">
			<THEAD>
			
			<tr id="tr">
				<td>�������� ���</td>
				<td>����ɿ���</td>
				<td>�������ѽð� ���</td>
				<td>�������ñⰣ ���</td>				
				<td>&nbsp;</td>
			</tr>
			</THEAD>
	<%
		if(rst == null) {
	%>
			<TBODY>
			<tr>
				<td class="blank" colspan="5">��ϵǾ��� ��� �����ϴ�.</td>
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
				<td align="center"><%=rst[i].getLimittime()/60%></td>				
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
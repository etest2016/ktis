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
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ExamUtil,qmtm.LoginProcBean, qmtm.LoginProc, qmtm.tman.exam.QuizJuchaBean, qmtm.tman.exam.QuizJucha" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }	

	String term_id = "2016-1"; //(String)session.getAttribute("term_info");
	if (term_id == null) { term_id = ""; } else { term_id = term_id.trim(); }
		
	if (id_course.length() == 0 || term_id.length() == 0) { 
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	String[] arrTerm_id;
	arrTerm_id = term_id.split("-");	
	
	String course_year = arrTerm_id[0];
	String course_no = arrTerm_id[1];	

    // �ش� �⵵ �б� ������ ���� �������� ���������
	QuizJuchaBean[] rst = null;

	try {
		rst = QuizJucha.getJuchaList(id_course, course_year, course_no);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

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
	function simpleInsert(jucha) {
		$.posterPopup("exam/jucha_quiz_write.jsp?id_course=<%=id_course%>&term_id=<%=term_id%>&jucha="+jucha,"SI","width=850, height=400, scrollbars=yes, top="+(screen.height-400)/2+", left="+(screen.width-850)/2);
	}
  
    function bankInsert(jucha) {
		$.posterPopup("exam/jucha_quiz_bank_write.jsp?id_course=<%=id_course%>&term_id=<%=term_id%>&jucha="+jucha,"BI","width=850, height=550, scrollbars=no, top="+(screen.height-550)/2+", left="+(screen.width-850)/2);
    }

	function edits(id_exam) {
		$.posterPopup("exam/exam_edit.jsp?id_exam="+id_exam,"edit","width=750, height=680, scrollbars=no, top="+(screen.height-680)/2+", left="+(screen.width-750)/2);
    }
	
 </script>

 </HEAD>

 <BODY id="tman">

	<div id="main">

		<div id="mainTop">
			<div class="title"><%=course_name%> ���� ���� ����Ʈ<span></span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../images/icon_location.gif"> <%=course_name%></div>
		</div>
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		
			<tr id="tr">
				<td>����</td>
				<td>�������ñⰣ</td>
				<td>�����</td>				
				<td>��������</td>
				<td>����</td>
				<td>���ѽð�</td>				
				<td>����</td>
			</tr>

	<%
		if(rst == null) {
	%>
	
			<tr>
				<td class="blank" colspan="7">��ϵǾ��� ���������� �����ϴ�.</td>
			</tr>
		
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {
				if(i == 1) {
	%>
					<tr id="td" align="center">
					<td><%=rst[i].getJucha()%></td>
					<td><%=rst[i].getQuiz_start()%> ~ <%=rst[i].getQuiz_end()%></td>
					<td>1���� ����</td>
					<td>4 ����</td>
					<td>40 ��</td>
					<td>20 ��</td>
					<td><input type="button" value="�����򰡼���" onclick="edits(<%=rst[i].getJucha()%>);" class="form">&nbsp;&nbsp;<input type="button" value="��������Ȯ��" class="form">&nbsp;&nbsp;<input type="button" value="������Ȳ����" class="form"></td>																	
				</tr>
	<%				
				} else {
	%>
			<tr id="td" align="center">
				<td><%=rst[i].getJucha()%></td>
				<td><%=rst[i].getQuiz_start()%> ~ <%=rst[i].getQuiz_end()%></td>
				<% if(rst[i].getId_exam().equals("")) { %>
					<td colspan="4">������ �̵�� <font color="red"><strong>(�������ɹ��� : <%=rst[i].getJucha_cnt()%>&nbsp;&nbsp;���� :<%=rst[i].getJucha_allotting()%>)</strong></font></td>
					<td><%if(pt_exam_edit.equals("Y")) { %><input type="button" value="�����򰡵��" onclick="simpleInsert(<%=rst[i].getJucha()%>);" class="form4">&nbsp;&nbsp;<input type="button" value="������ ���������ĵ��" onclick="bankInsert(<%=rst[i].getJucha()%>);" class="form4"><% }else { %><input type="button" value="������ȭ����ϱ�" onclick="alert('������ ��� ������ �����ϴ�.');" class="form4">&nbsp;&nbsp;<input type="button" value="������ ���������ĵ��" onclick="alert('������ ��� ������ �����ϴ�.');" class="form4"><% } %></td>
				<% } else { %>
					<td><%=rst[i].getTitle()%></td>
					<td><%=rst[i].getQcount()%></td>
					<td><%=rst[i].getAllotting()%></td>
					<td><%=rst[i].getLimittime()/60%></td>
					<td><%if(pt_exam_edit.equals("Y")) { %><input type="button" value="�����򰡼���" onclick="edits(<%=rst[i].getJucha()%>);" class="form4"><% } %>&nbsp;<a href="exam/exam_list.jsp?id_exam=<%=rst[i].getId_exam()%>" onfocus="this.blur();"><img src="../images/bt3_exam_info.gif"></a></td>
				<% } %>												
			</tr>
	<%
				}
			}
		}
	%>
		</table>

	</div>
	<jsp:include page="../copyright.jsp"/>

 </BODY>
</HTML>
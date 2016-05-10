<%
//******************************************************************************
//   프로그램 : course_list.jsp
//   모 듈 명 : 강좌아래 시험관리
//   설    명 : 퀴즈관리 트리에서 과정 선택시 보여주는 페이지
//   테 이 블 : exam_m, t_worker_subj, c_course, c_subject
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.LoginProcBean, qmtm.LoginProc, 
//              qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil,
//              qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList
//   작 성 일 : 2013-02-12
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
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

    // 해당 년도 학기 과정별 주차 퀴즈정보 가지고오기
	QuizJuchaBean[] rst = null;

	try {
		rst = QuizJucha.getJuchaList(id_course, course_year, course_no);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	String usergrade = (String)session.getAttribute("usergrade"); // 권한

	String course_name = "";

    // 과정명 가지고오기
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
			<div class="title"><%=course_name%> 퀴즈 개설 리스트<span></span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../images/icon_location.gif"> <%=course_name%></div>
		</div>
		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		
			<tr id="tr">
				<td>주차</td>
				<td>퀴즈응시기간</td>
				<td>퀴즈명</td>				
				<td>출제문항</td>
				<td>배점</td>
				<td>제한시간</td>				
				<td>관리</td>
			</tr>

	<%
		if(rst == null) {
	%>
	
			<tr>
				<td class="blank" colspan="7">등록되어진 퀴즈정보가 없습니다.</td>
			</tr>
		
	<%
		} else {
			for(int i = 0; i < rst.length; i++) {
				if(i == 1) {
	%>
					<tr id="td" align="center">
					<td><%=rst[i].getJucha()%></td>
					<td><%=rst[i].getQuiz_start()%> ~ <%=rst[i].getQuiz_end()%></td>
					<td>1주차 퀴즈</td>
					<td>4 문항</td>
					<td>40 점</td>
					<td>20 분</td>
					<td><input type="button" value="퀴즈평가수정" onclick="edits(<%=rst[i].getJucha()%>);" class="form">&nbsp;&nbsp;<input type="button" value="출제문항확인" class="form">&nbsp;&nbsp;<input type="button" value="응시현황관리" class="form"></td>																	
				</tr>
	<%				
				} else {
	%>
			<tr id="td" align="center">
				<td><%=rst[i].getJucha()%></td>
				<td><%=rst[i].getQuiz_start()%> ~ <%=rst[i].getQuiz_end()%></td>
				<% if(rst[i].getId_exam().equals("")) { %>
					<td colspan="4">퀴즈평가 미등록 <font color="red"><strong>(출제가능문항 : <%=rst[i].getJucha_cnt()%>&nbsp;&nbsp;배점 :<%=rst[i].getJucha_allotting()%>)</strong></font></td>
					<td><%if(pt_exam_edit.equals("Y")) { %><input type="button" value="퀴즈평가등록" onclick="simpleInsert(<%=rst[i].getJucha()%>);" class="form4">&nbsp;&nbsp;<input type="button" value="퀴즈평가 문제은행방식등록" onclick="bankInsert(<%=rst[i].getJucha()%>);" class="form4"><% }else { %><input type="button" value="퀴즈평가화등록하기" onclick="alert('퀴즈평가 등록 권한이 없습니다.');" class="form4">&nbsp;&nbsp;<input type="button" value="퀴즈평가 문제은행방식등록" onclick="alert('퀴즈평가 등록 권한이 없습니다.');" class="form4"><% } %></td>
				<% } else { %>
					<td><%=rst[i].getTitle()%></td>
					<td><%=rst[i].getQcount()%></td>
					<td><%=rst[i].getAllotting()%></td>
					<td><%=rst[i].getLimittime()/60%></td>
					<td><%if(pt_exam_edit.equals("Y")) { %><input type="button" value="퀴즈평가수정" onclick="edits(<%=rst[i].getJucha()%>);" class="form4"><% } %>&nbsp;<a href="exam/exam_list.jsp?id_exam=<%=rst[i].getId_exam()%>" onfocus="this.blur();"><img src="../images/bt3_exam_info.gif"></a></td>
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
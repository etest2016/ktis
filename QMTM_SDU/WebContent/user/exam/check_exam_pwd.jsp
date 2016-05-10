<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.*, etest.*, etest.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String RESULT_SUCCESS = "{\"result\":\"success\"}";
	String RESULT_FAIL = "{\"result\":\"fail\",\"error_msg\":\"평가비밀번호 확인중 오류가 발생하였습니다. 새로고침후 다시 시도해주세요.\"}";
	String RESULT_FAIL_WRONG_CONFIRM_CODE = "{\"result\":\"fail\",\"error_msg\":\"평가비밀번호가 맞지 않습니다. 다시 입력해주시기 바랍니다.\"}";
	
	String userid = request.getParameter("userid");
	if (userid == null | userid == "") { 
		out.println(RESULT_FAIL);
		if(true) return;
	} else { userid = userid.trim(); }
		
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null | id_exam == "") { 		
		out.println(RESULT_FAIL);
		if(true) return; 
	} else { id_exam = id_exam.trim(); }
	
	String exam_password = request.getParameter("txt_exam_password");
	if (exam_password == null | exam_password == "") { 
		out.println(RESULT_FAIL);
		if(true) return; 
	} else { exam_password = exam_password.trim(); }

	String manager_confirm_ip = request.getRemoteAddr();

	Timestamp manager_confirm_date = new Timestamp(System.currentTimeMillis());

	
	// 입력받은 userid, id_exam, exam_password으로 평가비밀번호와 비교함.
	String isCorrectExamPasswrod = User_ExamInfo.isCorrectExamPassword(id_exam, exam_password);

	if (isCorrectExamPasswrod == null){
		out.println(RESULT_FAIL);
		if(true) return;
	} else if (isCorrectExamPasswrod.equals("FALSE"))	{
		out.println(RESULT_FAIL_WRONG_CONFIRM_CODE);
		if(true) return;
	}

	out.println(RESULT_SUCCESS);
%>

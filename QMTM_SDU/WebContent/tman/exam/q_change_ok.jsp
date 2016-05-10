<%
//******************************************************************************
//   프로그램 : q_change_ok.jsp
//   모 듈 명 : 문제교체 처리
//   설    명 : 문제교체 처리 페이지
//   테 이 블 : 
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.QmTm, qmtm.tman.exam.QunitBean, 
//              qmtm.tman.exam.Qunit, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean,
//              qmtm.qman.question.QListBean, qmtm.qman.question.QListUtil
//   작 성 일 : 2013-02-19
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.common.*, qmtm.CommonUtil, qmtm.QmTm, qmtm.tman.exam.ExamCreateBean, qmtm.tman.exam.QunitBean, qmtm.tman.exam.Qunit, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.QchangeUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	String org_id_q = request.getParameter("org_id_q");
	if (org_id_q == null) { org_id_q = ""; } else { org_id_q = org_id_q.trim(); }

	String new_id_q = request.getParameter("new_id_q");
	if (new_id_q == null) { new_id_q = ""; } else { new_id_q = new_id_q.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String qtypes = request.getParameter("qtypes");
	if (qtypes == null) { qtypes = ""; } else { qtypes = qtypes.trim(); }

	String excount = request.getParameter("excount");
	if (excount == null) { excount = ""; } else { excount = excount.trim(); }
	
	if (org_id_q.length() == 0 || new_id_q.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// 출제유형 확인
	ExamCreateBean rst = null;

    try {
	    rst = ExamUtil.getAllotBean(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
	
	String randomtypes = rst.getId_randomtype();
	
	// 선다형 또는 복수답안형일경우 보기섞기 여부 체크
	QunitBean qs = null;

	try {
		qs = Qunit.getQBean(Long.parseLong(new_id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
	String ex_order = "";

	if(qtypes.equals("1")) {		
		ex_order = "1,2";
	} else if(qtypes.equals("2") || qtypes.equals("3")) {
		ex_order = QmTm.ExRandom(Integer.parseInt(excount), randomtypes);
	} else {
		ex_order = "";
	}

	try {
		QchangeUtil.qChange(id_exam, Long.parseLong(org_id_q), Long.parseLong(new_id_q), ex_order);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	StringBuffer bigos = new StringBuffer();

	bigos.append("원본문제코드 : ");
	bigos.append(org_id_q);

	bigos.append(", 복사문제코드 : ");
	bigos.append(new_id_q);
	
	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);
	logbean.setUserid(userid);
	logbean.setGubun("문제교체");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<Script language="JavaScript">
	alert("문제교체가 완료되었습니다.");
	opener.location.reload();
	window.close();
</Script>
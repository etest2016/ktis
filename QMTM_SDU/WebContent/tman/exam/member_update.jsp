<%
//******************************************************************************
//   프로그램 : member_update.jsp
//   모 듈 명 : 대상자 개별수정
//   설    명 : 대상자 개별수정
//   테 이 블 : qt_userid
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ReceiptBean, qmtm.tman.exam.ReceiptUtil
//   작 성 일 : 2013-02-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.tman.exam.ReceiptBean, qmtm.tman.exam.ReceiptUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }
	
	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String password = request.getParameter("userid");
	String name = request.getParameter("name");
	String sosok1 = request.getParameter("sosok1");
	String sosok2 = request.getParameter("sosok2");
	String home_phone = request.getParameter("home_phone");
	String mobile_phone = request.getParameter("mobile_phone");
	String level = request.getParameter("level");
	String email = request.getParameter("email");

	ReceiptBean bean = new ReceiptBean();

	bean.setUserid(userid);
	bean.setPassword(password);
	bean.setName(name);
	bean.setSosok1(sosok1);
	bean.setSosok2(sosok2);
	bean.setHome_phone(home_phone);
	bean.setMobile_phone(mobile_phone);
	bean.setLevel(level);
	bean.setEmail(email);
		
	// 대상자 수정
	try {
		ReceiptUtil.getMCnt(id_exam, userid, bean);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
%>

	<script language="javascript">
		alert("정상적으로 수정되었습니다.");
		window.opener.location.reload();
		window.close();
	</script>
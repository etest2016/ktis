<%
//******************************************************************************
//   프로그램 : q_use_insert_ok.jsp
//   모 듈 명 : 문제용도 등록
//   설    명 : 문제용도 등록하기
//   테 이 블 : r_q_use
//   자바파일 : qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil
//   작 성 일 : 2008-04-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.QuseBean, qmtm.admin.etc.QuseUtil, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_q_use = request.getParameter("id_q_use");
	if (id_q_use == null) { id_q_use= ""; } else { id_q_use = id_q_use.trim(); }

	if (id_q_use.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String q_use = request.getParameter("q_use");
	String rmk = request.getParameter("rmk");

	QuseBean bean = new QuseBean();

	bean.setId_q_use(id_q_use);
	bean.setQ_use(q_use);
	bean.setRmk(rmk);

    // 문제용도등록
	try {
	    QuseUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
	alert("정상적으로 등록되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
<%
//******************************************************************************
//   프로그램 : admin_update2.jsp
//   모 듈 명 : 관리자 수정
//   설    명 : 관리자 수정하기
//   테 이 블 : qt_adminid
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil,
//              qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean
//   작 성 일 : 2013-03-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.admin.AdminBean, qmtm.admin.admin.AdminUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

    String password = request.getParameter("password");
	
	String name = request.getParameter("name");
	String rmk = request.getParameter("rmk");
	String yn_valid = "Y";

	String email = request.getParameter("email");
	String hp = request.getParameter("hp");

	AdminBean bean = new AdminBean();

	bean.setUserid(userid);
	bean.setPassword(password);
	bean.setName(name);
	bean.setContent1(rmk);
	bean.setYn_valid(yn_valid);
	bean.setEmail(email);
	bean.setHp(hp);
	
    // 관리자 수정
	try {
	    AdminUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));
		
	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("관리자아이디 : ");
	bigos.append(userid);
	bigos.append(", 관리자성명 : ");
	bigos.append(name);
	bigos.append(", 관리자이메일주소 : ");
	bigos.append(email);
	bigos.append(", 관리자연락처 : ");
	bigos.append(hp);
	bigos.append(", 관리자소속정보 : ");
	bigos.append(rmk);
	bigos.append(", 계정사용여부 : ");
	bigos.append(yn_valid);
		
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("관리자정보수정");
	logbean.setBigo(bigos.toString());

	try {
		WorkAdminLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<script language="javascript">
	alert("정상적으로 수정되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
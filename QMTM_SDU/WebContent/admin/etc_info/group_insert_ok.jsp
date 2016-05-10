<%
//******************************************************************************
//   프로그램 : group_insert_ok.jsp
//   모 듈 명 : 대영역구분 등록완료
//   설    명 : 대영역구분 등록완료 페이지
//   테 이 블 : c_cateogry
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil
//   작 성 일 : 2013-01-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = ComLib.toParamChk(request.getParameter("id_category"));
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	String category = ComLib.toParamChk(request.getParameter("category"));
	if (category == null) { category = ""; } else { category = category.trim(); }

	if (id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
	CategoryBean bean = new CategoryBean();

	bean.setId_category(id_category);
	bean.setCategory(category);

    // 대영역등록
	try {
	    CategoryUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("대영역코드 : ");
	bigos.append(id_category);
	bigos.append(", 대영역명 : ");
	bigos.append(category);
	bigos.append(", 공개여부 : ");
	bigos.append("Y");
			
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("대영역등록");
	logbean.setBigo(bigos.toString());

	try {
		WorkAdminLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
%>

<script language="javascript">
	alert("정상적으로 등록되었습니다.");
	window.opener.location.reload();
	window.close();
</script>
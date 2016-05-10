<%
//******************************************************************************
//   프로그램 : group_insert_ok2.jsp
//   모 듈 명 : 소영역구분 등록완료
//   설    명 : 소영역구분 등록완료 페이지
//   테 이 블 : c_midcateogry
//   자바파일 : qmtm.ComLib, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil
//   작 성 일 : 2013-01-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkAdminLog, qmtm.common.WorkAdminLogBean, qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_category = ComLib.toParamChk(request.getParameter("id_category"));
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	String id_midcategory = ComLib.toParamChk(request.getParameter("id_midcategory"));
	if (id_midcategory == null) { id_midcategory= ""; } else { id_midcategory = id_midcategory.trim(); }

	String midcategory = ComLib.toParamChk(request.getParameter("midcategory"));
	if (midcategory == null) { midcategory = ""; } else { midcategory = midcategory.trim(); }

	if (id_category.length() == 0 || id_midcategory.length() == 0 || midcategory.length() == 0) {
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
		
	String order_param = ComLib.toParamChk(request.getParameter("orders"));

	int orders = Integer.parseInt(order_param);
	
	MidCategoryBean bean = new MidCategoryBean();

	bean.setId_category(id_category);
	bean.setId_midcategory(id_midcategory);
	bean.setMidcategory(midcategory);
	bean.setOrders(orders);

    // 소영역등록
	try {
	    MidCategoryUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("대영역코드 : ");
	bigos.append(id_category);
	bigos.append(", 소영역코드 : ");
	bigos.append(id_midcategory);
	bigos.append(", 소영역명 : ");
	bigos.append(midcategory);
	bigos.append(", 정렬순서 : ");
	bigos.append(order_param);
	bigos.append(", 공개여부 : ");
	bigos.append("Y");
			
	WorkAdminLogBean logbean = new WorkAdminLogBean();

	logbean.setUserid(adm_userid);
	logbean.setGubun("소영역등록");
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
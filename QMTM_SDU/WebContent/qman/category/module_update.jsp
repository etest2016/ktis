<%
//******************************************************************************
//   프로그램 : module_update.jsp
//   모 듈 명 : 모듈 수정완료
//   설    명 : 모듈 수정완료 페이지
//   테 이 블 : q_chapter
//   자바파일 : qmtm.ComLib, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }
	
	String id_module = request.getParameter("id_module"); // 모듈 코드
	if (id_module == null) { id_module= ""; } else { id_module = id_module.trim(); }

	if (id_subject.length() == 0 || id_module.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

    String module = request.getParameter("q_module"); // 모듈명
	String yn_valid = request.getParameter("yn_valid"); 
	String module_order = request.getParameter("module_order"); // 정렬순서

	ModuleBean bean = new ModuleBean();

	bean.setId_chapter(id_module);
	bean.setChapter(module);
	bean.setYn_valid(yn_valid);
	bean.setChapter_order(Integer.parseInt(module_order));
	
	// 모듈 수정
    try {
	    ModuleUtil.update(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));		

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();
	
	bigos.append("과목코드 : ");
	bigos.append(id_subject);

	bigos.append(", 단원코드 : ");
	bigos.append(id_module);

	bigos.append(", 단원명 : ");
	bigos.append(module);
	
	bigos.append(", 공개여부 : ");
	if(yn_valid.equals("Y")) {
		bigos.append("공개");
	} else {
		bigos.append("비공개");
	}

	bigos.append(", 정렬순서 : ");
	bigos.append(module_order);

	// 로그정보 등록 시작
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_module);
	logbean.setId_chapter2("-1");
	logbean.setId_chapter3("-1");
	logbean.setId_chapter4("-1");
	logbean.setUserid(userid);
	logbean.setGubun("단원수정");
	logbean.setId_q("");
	logbean.setBigo(bigos.toString());

	try {
		WorkQLog.insert(logbean);
	} catch(Exception ex) {
		out.println(ex.getMessage());

		if(true) return;
	}
	// 로그정보 등록 종료
%>

<script language="javascript">
	alert("정상적으로 수정되었습니다.");
	opener.parent.fraLeft.location.reload(); 
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>
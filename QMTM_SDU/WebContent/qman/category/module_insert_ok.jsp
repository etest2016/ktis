<%
//******************************************************************************
//   프로그램 : module_insert_ok.jsp
//   모 듈 명 : 과목 등록
//   설    명 : 문제은행 과목 등록하기
//   테 이 블 : q_chapter
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil
//   작 성 일 : 2013-02-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.CommonUtil, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");
    
	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String module = request.getParameter("q_module");
	if (module == null) { module= ""; } else { module = module.trim(); }

	if (module.length() == 0 || id_subject.length() == 0) { 
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

	String module_order = request.getParameter("module_order");
	if (module_order == null) { module_order = ""; } else { module_order = module_order.trim(); }

	String id_module = CommonUtil.getMakeID("U1");

	ModuleBean bean = new ModuleBean();

	bean.setId_subject(id_subject);
	bean.setId_chapter(id_module);
	bean.setChapter(module);
	bean.setChapter_order(Integer.parseInt(module_order));

    // 모듈등록
	try {
	    ModuleUtil.insert(bean);
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
	bigos.append("공개");
	
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
	logbean.setGubun("단원등록");
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
	alert("정상적으로 등록되었습니다.");
	opener.parent.fraLeft.location.reload(); 
	opener.parent.fraMain.location.reload(); 
	window.close();
</script>
<%
//******************************************************************************
//   프로그램 : module_delete.jsp
//   모 듈 명 : 모듈 삭제
//   설    명 : 모듈 삭제하기
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

	String id_module = request.getParameter("id_module");
	if (id_module == null) { id_module= ""; } else { id_module = id_module.trim(); }

	if (id_subject.length() == 0 || id_module.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

	// 등록된 문제가 있는지 확인 후 문제 삭제 후 진행.
	int cnts = 0;

	try {
		cnts = ModuleUtil.getCnt(id_module);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	if(cnts > 0) {
%>
		<script language="javascript">
			alert("등록되어진 문제가 있어서 삭제할 수 없습니다.\n\n문제 삭제 후 진행하시기 바랍니다.");
			window.close();
		</script>
<%
		if(true) return;
	} else {
	
		// 모듈 정보 삭제
		try {
			ModuleUtil.delete(id_module);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		StringBuffer bigos = new StringBuffer();
	
		bigos.append("과목코드 : ");
		bigos.append(id_subject);

		bigos.append(", 단원코드 : ");
		bigos.append(id_module);
		
		// 로그정보 등록 시작
		WorkQLogBean logbean = new WorkQLogBean();

		logbean.setId_subject(id_subject);
		logbean.setId_chapter(id_module);
		logbean.setId_chapter2("-1");
		logbean.setId_chapter3("-1");
		logbean.setId_chapter4("-1");
		logbean.setUserid(userid);
		logbean.setGubun("단원삭제");
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
			alert("정상적으로 삭제되었습니다.");
			opener.parent.fraLeft.location.reload(); 
			opener.parent.fraMain.location.reload(); 
			window.close();
		</script>
<%
	}
%>
<%
//******************************************************************************
//   프로그램 : subject_delete.jsp
//   모 듈 명 : 과목 삭제
//   설    명 : 과목 삭제하기
//   테 이 블 : q_subject
//   자바파일 : qmtm.ComLib, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject= ""; } else { id_subject = id_subject.trim(); }

	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	
	// 모듈이 있는지 확인 후 모듈 삭제 후 진행.

	int cnts = 0;

	try {
		cnts = SubjectUtil.getCnt(id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	if(cnts > 0) {
%>
		<script language="javascript">
			alert("등록되어진 단원이 있어서 삭제할 수 없습니다.\n\n모듈 삭제 후 진행하시기 바랍니다.");
			window.close();
		</script>
<%
		if(true) return;
	} else {
	
		// 과목 정보 삭제
		try {
			SubjectUtil.delete(id_subject);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		StringBuffer bigos = new StringBuffer();

		bigos.append("과목코드 : ");
		bigos.append(id_subject);

		// 로그정보 등록 시작
		WorkQLogBean logbean = new WorkQLogBean();

		logbean.setId_subject(id_subject);
		logbean.setId_chapter("0");
		logbean.setId_chapter2("-1");
		logbean.setId_chapter3("-1");
		logbean.setId_chapter4("-1");
		logbean.setUserid(userid);
		logbean.setGubun("과목삭제");
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
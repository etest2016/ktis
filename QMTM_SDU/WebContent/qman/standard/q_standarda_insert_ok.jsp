<%
//******************************************************************************
//   프로그램 : q_standarda_insert_ok.jsp
//   모 듈 명 : 대분류구분 등록완료
//   설    명 : 대분류구분 등록완료 페이지
//   테 이 블 : q_standard_a
//   자바파일 : qmtm.ComLib, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil, qmtm.qman.standard.QstandardABean, qmtm.qman.standard.QstandardAUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_standarda = ComLib.getMakeID("A");
	if (id_standarda == null) { id_standarda= ""; } else { id_standarda = id_standarda.trim(); }

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	
	
	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }

	String standarda = ComLib.toParamChk(request.getParameter("standarda"));
	if (standarda == null) { standarda = ""; } else { standarda = standarda.trim(); }

	if (id_subject.length() == 0 || id_standarda.length() == 0 || id_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");
	
	QstandardABean bean = new QstandardABean();

	bean.setId_standarda(id_standarda);
	bean.setStandarda(standarda);
	bean.setId_chapter(id_chapter);

    // 대분류등록
	try {
	    QstandardAUtil.insert(bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();
	
	bigos.append("과목코드 : ");
	bigos.append(id_subject);

	bigos.append(", 단원코드 : ");
	bigos.append(id_chapter);

	bigos.append(", 대분류코드 : ");
	bigos.append(id_standarda);

	bigos.append(", 대분류명 : ");
	bigos.append(standarda);

	bigos.append(", 공개여부 : ");
	bigos.append("공개");
		
	// 로그정보 등록 시작
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_chapter);
	logbean.setId_chapter2("-1");
	logbean.setId_chapter3("-1");
	logbean.setId_chapter4("-1");
	logbean.setUserid(userid);
	logbean.setGubun("대분류등록");
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
	window.opener.location.reload();
	window.close();
</script>
<%
//******************************************************************************
//   프로그램 : q_info_update.jsp
//   모 듈 명 : 문제정보일괄변경 페이지
//   설    명 : 문제정보일괄변경 페이지
//   테 이 블 : q
//   자바파일 : qmtm.ComLib, qmtm.qman.question.QinfoBean, qmtm.qman.question.Qinfo
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.WorkQLog, qmtm.common.WorkQLogBean, qmtm.qman.question.QinfoBean, qmtm.qman.question.Qinfo" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String userid = (String)session.getAttribute("userid");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = "-1"; } else { id_subject = id_subject.trim(); }

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = "-1"; } else { id_chapter = id_chapter.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2");
	if (id_chapter2 == null) { id_chapter2 = "-1"; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("id_chapter3");
	if (id_chapter3 == null) { id_chapter3 = "-1"; } else { id_chapter3 = id_chapter3.trim(); }

	String id_chapter4 = request.getParameter("id_chapter4");
	if (id_chapter4 == null) { id_chapter4 = "-1"; } else { id_chapter4 = id_chapter4.trim(); }

	String q_allot = request.getParameter("q_allott");
	String q_allots = request.getParameter("q_allotts");
	
	String q_diff = request.getParameter("q_diff");
	String q_diffs = request.getParameter("q_diffs");

	String q_pub_comp = request.getParameter("q_pub_comp");
	String q_pub_comps = request.getParameter("q_pub_comps");

	String q_etc = request.getParameter("q_etc");
	String q_etcs = request.getParameter("q_etcs");

	String q_kwd = request.getParameter("q_kwd");
	String q_kwds = request.getParameter("q_kwds");

	String q_use = request.getParameter("q_use");
	String q_uses = request.getParameter("q_uses");

	QinfoBean bean = new QinfoBean();
	
	bean.setQ_allot(q_allot);
	bean.setQ_allots(q_allots);
	bean.setQ_diff(q_diff);
	bean.setQ_diffs(q_diffs);
	bean.setQ_pub_comp(q_pub_comp);
	bean.setQ_pub_comps(q_pub_comps);
	bean.setQ_etc(q_etc);
	bean.setQ_etcs(q_etcs);
	bean.setQ_kwd(q_kwd);
	bean.setQ_kwds(q_kwds);
	bean.setQ_use(q_use);
	bean.setQ_uses(q_uses);
	
	// 문제정보 변경	
	try {
	    Qinfo.Q_updates(id_qs, bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }

	StringBuffer bigos = new StringBuffer();

	bigos.append("문제정보변경 문제코드 : ");
	bigos.append(id_qs);

	if(q_allot != null) {
		bigos.append(", 배점 : ");
		bigos.append(q_allots);
	}
	
	if(q_diff != null) {
		bigos.append(", 난이도 : ");
		
		if(q_diffs.equals("0")) {
			bigos.append("없음");
		} else if(q_diffs.equals("1")) {
			bigos.append("최상");
		} else if(q_diffs.equals("2")) {
			bigos.append("상");
		} else if(q_diffs.equals("3")) {
			bigos.append("중");
		} else if(q_diffs.equals("4")) {
			bigos.append("하");
		} else if(q_diffs.equals("5")) {
			bigos.append("최하");
		}
	}

	if(q_pub_comp != null) {
		bigos.append(", 출처 : ");
		bigos.append(q_pub_comps);
	}

	if(q_etc != null) {
		bigos.append(", 비고 : ");
		bigos.append(q_etcs);
	}

	if(q_kwd != null) {
		bigos.append(", 검색키워드 : ");
		bigos.append(q_kwds);
	}
	
	// 로그정보 등록 시작
	WorkQLogBean logbean = new WorkQLogBean();

	logbean.setId_subject(id_subject);
	logbean.setId_chapter(id_chapter);
	logbean.setId_chapter2(id_chapter2);
	logbean.setId_chapter3(id_chapter3);
	logbean.setId_chapter4(id_chapter4);
	logbean.setUserid(userid);
	logbean.setGubun("문제정보변경");
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

<script language="JavaScript">
	alert("문제정보가 변경되었습니다.");
	window.close();
</script>
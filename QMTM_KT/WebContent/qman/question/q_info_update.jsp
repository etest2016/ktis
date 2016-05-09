<%
//******************************************************************************
//   프로그램 : q_info_update.jsp
//   모 듈 명 : 문제정보일괄변경 페이지
//   설    명 : 문제정보일괄변경 페이지
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.tman.exam.*
//   작 성 일 : 2010-06-14
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String q_allot = request.getParameter("q_allott");
	String q_allots = request.getParameter("q_allotts");

	String q_time = request.getParameter("q_time");
	String q_times = request.getParameter("q_times");

	String q_diff = request.getParameter("q_diff");
	String q_diffs = request.getParameter("q_diffs");

	String q_book = request.getParameter("q_book");
	String q_books = request.getParameter("q_books");

	String q_author = request.getParameter("q_author");
	String q_authors = request.getParameter("q_authors");

	String q_page = request.getParameter("q_page");
	String q_pages = request.getParameter("q_pages");

	String q_pub_comp = request.getParameter("q_pub_comp");
	String q_pub_comps = request.getParameter("q_pub_comps");

	String q_pub_year = request.getParameter("q_pub_year");
	String q_pub_years = request.getParameter("q_pub_years");

	String q_etc = request.getParameter("q_etc");
	String q_etcs = request.getParameter("q_etcs");

	String q_kwd = request.getParameter("q_kwd");
	String q_kwds = request.getParameter("q_kwds");

	String q_use = request.getParameter("q_use");
	String q_uses = request.getParameter("q_uses");

	QinfoBean bean = new QinfoBean();
	
	bean.setQ_allot(q_allot);
	bean.setQ_allots(q_allots);
	bean.setQ_time(q_time);
	bean.setQ_times(q_times);
	bean.setQ_diff(q_diff);
	bean.setQ_diffs(q_diffs);
	bean.setQ_book(q_book);
	bean.setQ_books(q_books);
	bean.setQ_author(q_author);
	bean.setQ_authors(q_authors);
	bean.setQ_page(q_page);
	bean.setQ_pages(q_pages);
	bean.setQ_pub_comp(q_pub_comp);
	bean.setQ_pub_comps(q_pub_comps);
	bean.setQ_pub_year(q_pub_year);
	bean.setQ_pub_years(q_pub_years);
	bean.setQ_etc(q_etc);
	bean.setQ_etcs(q_etcs);
	bean.setQ_kwd(q_kwd);
	bean.setQ_kwds(q_kwds);
	bean.setQ_use(q_use);
	bean.setQ_uses(q_uses);

	// 문항정보 변경	
	try {
	    Qinfo.Q_updates(id_qs, bean);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="JavaScript">
	alert("문항정보가 변경되었습니다.");
	window.close();
</script>
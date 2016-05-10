<%
//******************************************************************************
//   프로그램 : q_search_ok.jsp
//   모 듈 명 : 문제 검색 페이지
//   설    명 : 검색되어진 문제 가지고 오기
//   테 이 블 : q, r_qtype, r_difficulty
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.QmTm, qmtm.tman.exam.ExamSearchBean, qmtm.tman.exam.ExamSearchResBean, qmtm.tman.exam.ExamUtil
//   작 성 일 : 2013-02-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils, qmtm.ComLib, qmtm.CommonUtil, qmtm.QmTm, qmtm.tman.exam.ExamSearchBean, qmtm.tman.exam.ExamSearchResBean, qmtm.tman.exam.ExamUtil" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String prof_userid = (String)session.getAttribute("userid");    
	if (prof_userid == null) { prof_userid= ""; } else { prof_userid = prof_userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_course = request.getParameter("id_course");
	String id_subject = request.getParameter("id_subject");

	String cpt1 = request.getParameter("cpt1");
	String chapter1 = request.getParameter("chapter1");	
	
	String qte = request.getParameter("qte");
	String qtype = request.getParameter("qtype");

	String diff = request.getParameter("diff");
	String difficulty = request.getParameter("difficulty");
			
	String regdate = request.getParameter("regdate");
	String regdate1 = request.getParameter("regdate1");
	String regdate2 = request.getParameter("regdate2");

	String updates = request.getParameter("updates");
	String updates1 = request.getParameter("updates1");
	String updates2 = request.getParameter("updates2");

	String q_cnt = request.getParameter("q_cnt");
	String q_cnt1 = request.getParameter("q_cnt1");
	String q_cnt2 = request.getParameter("q_cnt2");

	String q_use = request.getParameter("q_use");	
	String q_uses = request.getParameter("q_uses");

	String explains = request.getParameter("explains");	
	String explain1 = request.getParameter("explain1");

	String find_kwds = request.getParameter("find_kwds");	
	String find_kwd1 = request.getParameter("find_kwd1");
	
	ExamSearchBean bean = new ExamSearchBean();
	
	bean.setId_course(id_course);
	bean.setId_subject(id_subject);
	bean.setCpt1(cpt1);
	bean.setChapter1(chapter1);

	bean.setQte(qte);
	bean.setQtype(qtype);

	bean.setDiff(diff);
	bean.setDifficulty(difficulty);

	bean.setRegdate(regdate);
	bean.setRegdate1(regdate1);
	bean.setRegdate2(regdate2);

	bean.setUpdates(updates);
	bean.setUpdates1(updates1);
	bean.setUpdates2(updates2);

	bean.setQ_cnt(q_cnt);
	bean.setQ_cnt1(q_cnt1);
	bean.setQ_cnt2(q_cnt2);

	bean.setQ_use(q_use);
	bean.setQ_uses(q_uses);

	bean.setExplains(explains);
	bean.setExplain1(explain1);

	bean.setFind_kwds(find_kwds);
	bean.setFind_kwd1(find_kwd1);
	
	// 문제 검색
	ExamSearchResBean[] rst = null;
	try {
	    rst = ExamUtil.getSearchBeans(bean, prof_userid);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	if(rst == null) {
%>
	<Script language="JavaScript">
		alert("등록되어진 문제 없습니다.");
		location.href="q_search.jsp?id_exam=<%=id_exam%>";
	</Script>
<%
		if(true) return;

	} else {
		String idqs = "";
		String qtypes = "";
		String diffs = "";
		String id_refs = "";

		int lngcnt = rst.length;
	
		String[] arrId_qs = new String[lngcnt];
		String[] arrQs = new String[lngcnt];
		int[] arrId_qtypes = new int[lngcnt];
		int[] arrId_difficultys = new int[lngcnt];
		String[] arrDiffs = new String[lngcnt];
		String[] arrQtypes = new String[lngcnt];
		String[] arrId_refs = new String[lngcnt];
		String[] arrRefs = new String[lngcnt];
		double[] arrAllottings = new double[lngcnt]; 
		String[] arrQ = new String[lngcnt];
		String[] arrQ1 = new String[lngcnt];
		String[] arrId_subject = new String[lngcnt];
		String[] arrMake_cnt = new String[lngcnt];
		String[] arrYn_practice = new String[lngcnt];

		for(int k=0; k<lngcnt; k++) {
			arrId_qs[k] = String.valueOf(rst[k].getId_q());
			arrId_qtypes[k] = rst[k].getId_qtype();
			arrId_difficultys[k] = rst[k].getId_difficulty1();
			arrId_refs[k] = rst[k].getId_ref();
			arrAllottings[k] = rst[k].getAllotting();
			arrQ[k] = rst[k].getQ();
			arrQ[k] = arrQ[k].replace("&lt;","<");
			arrQ[k] = arrQ[k].replace("&gt;",">");
			arrQ[k] = arrQ[k].replace("&nbsp;","");
			arrQ[k] = arrQ[k].replace("(","");
			arrQ[k] = arrQ[k].replace(")","");
			arrQ[k] = arrQ[k].replace("'","");
			arrQ[k] = arrQ[k].replace("\r", "");
			arrQ[k] = arrQ[k].replace("\n", "");
			arrQ[k] = arrQ[k].replace("<BR>", "");
			arrQ[k] = arrQ[k].replace("&nbsp;", "");
			arrId_subject[k] = rst[k].getId_subject();
			arrMake_cnt[k] = String.valueOf(rst[k].getMake_cnt());
			arrYn_practice[k] = rst[k].getYn_practice(); 
		}
%>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script language="JavaScript">

	var firstWin = window.opener;
	//firstWin.document.form1.qcnts.value = "    검색된 문제 수 : " + <%=rst.length%> + " 문제";
	firstWin.document.form1.qcnts.value = <%=lngcnt%>;
	var temp_qlist_json = {};
	temp_qlist_json.rows = [];
	var temp_qlist_js_obj = {};
	var temp_qlist_id_array = [];
	var temp_qlist_data_array = [];
	
	<% 
		for(int i=0; i<lngcnt; i++) { 

			arrQs[i] = arrId_qs[i] + "";
			
			if(arrId_qtypes[i] == 1) {
				arrQtypes[i] = "OX형";
			} else if(arrId_qtypes[i] == 2) {
				arrQtypes[i] = "선다형";
			} else if(arrId_qtypes[i] == 3) {
				arrQtypes[i] = "복수답안형";
			} else if(arrId_qtypes[i] == 4) {
				arrQtypes[i] = "단답형";
			} else if(arrId_qtypes[i] == 5) {				
				arrQtypes[i] = "논술형";				
			} 

			if(arrId_difficultys[i] == 0) {
				arrDiffs[i] = "없음";
			} else if(arrId_difficultys[i] == 1) {
				arrDiffs[i] = "최상";
			} else if(arrId_difficultys[i] == 2) {
				arrDiffs[i] = "상";
			} else if(arrId_difficultys[i] == 3) {
				arrDiffs[i] = "중";
			} else if(arrId_difficultys[i] == 4) {
				arrDiffs[i] = "하";
			} else if(arrId_difficultys[i] == 5) {
				arrDiffs[i] = "최하";
			} 

			arrRefs[i] = arrId_refs[i];
			
			if(arrQ[i].length() > 50) {
				arrQ[i] = arrQ[i].substring(0,50); 
			} else {
				arrQ[i] = arrQ[i];
			}

			arrQ1[i] = StringEscapeUtils.escapeXml(ComLib.removeNBSP(ComLib.htmlDel(arrQ[i])));
							
	%>	
		temp_qlist_id_array.push("<%=arrQs[i]%>");
		temp_qlist_data_array.push(new Array("<%=arrQs[i]%>","<%=arrQtypes[i]%>","<%=arrDiffs[i]%>","<%=arrAllottings[i]%>","<%=arrMake_cnt[i]%>","<%=QmTm.changeTag(QmTm.changeChar(arrQ1[i].trim()))%>"));

	<% } %>	
	opener.temp_qlist_js_array[0] = temp_qlist_id_array;
	opener.temp_qlist_js_array[1] = temp_qlist_data_array;
	opener.qlist1_data_save();
	opener.qlist1_reload();
	window.close(this);
</script>

<% } %>
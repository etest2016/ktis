<%@ page contentType="text/xml; charset=EUC-KR" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.apache.commons.lang3.StringEscapeUtils, qmtm.DBPool, qmtm.ComLib, qmtm.QmTmException, qmtm.qman.question.QSearchGridBean, qmtm.qman.question.QSearch, qmtm.qman.question.QSearchBean" %>

<?xml version="1.0" encoding="EUC-KR"?>
<% 	
	String chk_userid = "";
	
	String subjects = "";
	
	String cpt1 = "";
	String chapter1 = "";		
	String qtes = "";
	String qtype = "";
	String diff = "";
	String difficultys = "";
	String cnts = "";
	String cnt1 = "";
	String cnt2 = "";
	String id_qs = "";
	String id_qs1 = "";
	String incorrects = "";
	String incorrect1 = "";
	String src_pub_comps = "";
	String src_pub_comp1 = "";
	String correct_pcts = "";
	String correct_pct1 = "";
	String gubuns = "";
	String qs_chk = "";
	String qs = "";

	String quses = "";
	String quse1 = "";
	
	String explains = "";
	String explain1 = "";

	String find_kwds = "";
	String find_kwd1 = "";

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }	

	subjects = request.getParameter("subjects");
	if (subjects == null) { subjects = ""; } else { subjects = subjects.trim(); }

	cpt1 = request.getParameter("cpt1");
	if (cpt1 == null) { cpt1 = ""; } else { cpt1 = cpt1.trim(); }
	chapter1 = request.getParameter("chapter1");
	if (chapter1 == null) { chapter1 = ""; } else { chapter1 = chapter1.trim(); }
			
	qtes = request.getParameter("qte");
	if (qtes == null) { qtes = ""; } else { qtes = qtes.trim(); }
	qtype = request.getParameter("qtype");
	if (qtype == null) { qtype = ""; } else { qtype = qtype.trim(); }

	diff = request.getParameter("diff");
	if (diff == null) { diff = ""; } else { diff = diff.trim(); }
	difficultys = request.getParameter("difficulty");
	if (difficultys == null) { difficultys = ""; } else { difficultys = difficultys.trim(); }

	cnts = request.getParameter("cnts");
	if (cnts == null) { cnts = ""; } else { cnts = cnts.trim(); }
	cnt1 = request.getParameter("cnt1");
	if (cnt1 == null) { cnt1 = ""; } else { cnt1 = cnt1.trim(); }
	cnt2 = request.getParameter("cnt2");
	if (cnt2 == null) { cnt2 = ""; } else { cnt2 = cnt2.trim(); }
		
	id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	id_qs1 = request.getParameter("id_qs1");
	if (id_qs1 == null) { id_qs1 = ""; } else { id_qs1 = id_qs1.trim(); }

	incorrects = request.getParameter("incorrects");
	if (incorrects == null) { incorrects = ""; } else { incorrects = incorrects.trim(); }
	incorrect1 = request.getParameter("incorrect1");
	if (incorrect1 == null) { incorrect1 = ""; } else { incorrect1 = incorrect1.trim(); }

	src_pub_comps = request.getParameter("src_pub_comps");
	if (src_pub_comps == null) { src_pub_comps = ""; } else { src_pub_comps = src_pub_comps.trim(); }
	src_pub_comp1 = request.getParameter("src_pub_comp1");
	if (src_pub_comp1 == null) { src_pub_comp1 = ""; } else { src_pub_comp1 = src_pub_comp1.trim(); }

	correct_pcts = request.getParameter("correct_pcts");
	if (correct_pcts == null) { correct_pcts = ""; } else { correct_pcts = correct_pcts.trim(); }
	correct_pct1 = request.getParameter("correct_pct1");
	if (correct_pct1 == null) { correct_pct1 = ""; } else { correct_pct1 = correct_pct1.trim(); }
	gubuns = request.getParameter("gubuns");
	if (gubuns == null) { gubuns = ""; } else { gubuns = gubuns.trim(); }
		
	qs_chk = request.getParameter("qs_chk");
	if (qs_chk == null) { qs_chk = ""; } else { qs_chk = qs_chk.trim(); }
	
	qs = request.getParameter("qs");
	if (qs == null) { qs = ""; } else { qs = qs.trim(); }

	quses = request.getParameter("quses");
	if (quses == null) { quses = ""; } else { quses = quses.trim(); }
	quse1 = request.getParameter("quse1");
	if (quse1 == null) { quse1 = ""; } else { quse1 = quse1.trim(); }
		
	explains = request.getParameter("explains");
	if (explains == null) { explains = ""; } else { explains = explains.trim(); }
	explain1 = request.getParameter("explain1");
	if (explain1 == null) { explain1 = ""; } else { explain1 = explain1.trim(); }

	find_kwds = request.getParameter("find_kwds");
	if (find_kwds == null) { find_kwds = ""; } else { find_kwds = find_kwds.trim(); }
	find_kwd1 = request.getParameter("find_kwd1");
	if (find_kwd1 == null) { find_kwd1 = ""; } else { find_kwd1 = find_kwd1.trim(); }

	QSearchBean bean = new QSearchBean();

	bean.setSubjects(subjects);
	bean.setId_subject(id_subject);
	bean.setCpt1(cpt1);
	bean.setChapter1(chapter1);
	
	bean.setQtes(qtes);
	bean.setQtypes(qtype);
	bean.setDiffs(diff);
	bean.setDifficultys(difficultys);
	bean.setCnts(cnts);
	bean.setCnt1(cnt1);
	bean.setCnt2(cnt2);
	bean.setId_qs(id_qs);
	bean.setId_qs1(id_qs1);
	bean.setIncorrects(incorrects);
	bean.setIncorrect1(incorrect1);
	
	bean.setSrc_pub_comps(src_pub_comps);
	bean.setSrc_pub_comp1(src_pub_comp1);
	bean.setCorrect_pcts(correct_pcts);
	bean.setCorrect_pct1(correct_pct1);
	bean.setGubuns(gubuns);

	bean.setQs(qs_chk);
	bean.setQs1(qs);

	bean.setQuses(quses);
	bean.setQuse1(quse1);

	bean.setExplains(explains);
	bean.setExplain1(explain1);
	
	bean.setFind_kwds(find_kwds);
	bean.setFind_kwd1(find_kwd1);
	
	// define variables from incoming values
    String posStart = ""; // 시작지점
    if (request.getParameter("posStart") != null){
        posStart = request.getParameter("posStart");
    }else{
        posStart = "0";
    }   

    String count = "1000"; // 가져올 갯수
    
    String totalCount = "";
    
	totalCount = "";
	if (posStart.equals("0")){
	        
		try {
			totalCount = String.valueOf(QSearch.getCnt(bean, id_subject, id_chapter, chk_userid));
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

	} else {
	   	totalCount = "";
	}

	// 문제 검색
	QSearchGridBean[] rst = null;

	try {
		rst = QSearch.getSearchBeans(bean, id_subject, id_chapter, chk_userid, Integer.parseInt(posStart), Integer.parseInt(count));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

    if(rst == null) {
		out.println("<rows total_count='" + totalCount + "' pos='" + posStart + "'>");

	} else {

     	out.println("<rows total_count='" + totalCount + "' pos='" + posStart + "'>");
		// output data in XML format  
	    for(int i=0; i<rst.length; i++) 
		{
				
			out.println("<row id=\"" + StringEscapeUtils.escapeXml(rst[i].getRownum()) + "\">");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getId_q()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getCnt()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(rst[i].getQ())))) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getQtype()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getDifficulty()) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(ComLib.nullChk2(rst[i].getCa())) + "</cell>");
			out.println("<cell>" + StringEscapeUtils.escapeXml(ComLib.nullChk2(rst[i].getCorrect_pct())) + "</cell>");					
			out.println("<cell>" + StringEscapeUtils.escapeXml(rst[i].getRegdate()) + "</cell>");
			out.println("</row>");
		}
		
	}
	
%>
</rows>

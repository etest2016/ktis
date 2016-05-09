<%
//******************************************************************************
//   프로그램 : q_search_res.jsp
//   모 듈 명 : 문제 검색 결과
//   설    명 : 문제 검색 결과를 보여준다.
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-04-16
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 2008-07-02
//   수 정 자 : 이테스트 석준호
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("UTF-8");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }	

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }	

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = ""; } else { id_chapter = id_chapter.trim(); }	

	if (userid.length() == 0 || id_subject.length() == 0 || id_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String qtes = request.getParameter("qte");
	String qtype = request.getParameter("qtype");

	String diff = request.getParameter("diff");
	String difficultys = request.getParameter("difficulty");

	String cnts = request.getParameter("cnts");
	String cnt1 = request.getParameter("cnt1");
	String cnt2 = request.getParameter("cnt2");
	
	String id_qs = request.getParameter("id_qs");
	String id_qs1 = request.getParameter("id_qs1");

	String incorrects = request.getParameter("incorrects");
	String incorrect1 = request.getParameter("incorrect1");

	QSearchBean bean = new QSearchBean();

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

	// 문제 검색
	QSearchListBean[] rst = null;

	try {
		rst = QSearch.getSearchBeans(bean, id_subject, id_chapter, userid);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

	<table border="0" width="100%" cellpadding="0" cellspacing="0" id="tableA">
		<tr id="tr3">			
			<td width="90">문제코드</td>
			<td width="90">문제유형</td>
			<td width="90">난이도</td>
			<td width="90">출제횟수</td>
			<td>문제</td>
		</tr>
		<% if(rst == null) { %>
		<tr bgcolor="#FFFFFF" height="40">
			<td colspan="5" align="center"  class="blank">검색되어진 문항이 없습니다.</td>
		</tr>
		<%
			} else {
				for(int i=0; i<rst.length; i++) {
					
		%>

		<tr id="td" onClick="dbl_selects('<%=rst[i].getId_qs()%>', '<%=rst[i].getId_subject()%>');">
			<td align="center"><%=rst[i].getId_qs()%></td>
			<td align="center"><%=rst[i].getQtypes()%></td>
			<td align="center"><%=rst[i].getDifficulty()%></td>			
			<td align="center"><%=rst[i].getMake_cnt()%></td>
			<td id="q_view"><%=rst[i].getQs()%></td>
		</tr>
		<%
				}
			}
		%>
	</table>
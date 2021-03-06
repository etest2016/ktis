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

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.tman.exam.*, qmtm.admin.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }	
			
	if (userid.length() == 0 ) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String term_id = CommonUtil.get_Cookie(request, "term_id");

	String qtes = request.getParameter("qte");
	if (qtes == null) { qtes = "N"; } else { qtes = qtes.trim(); }	
	String qtype = request.getParameter("qtype");

	String diff = request.getParameter("diff");
	if (diff == null) { diff = "N"; } else { diff = diff.trim(); }	
	String difficultys = request.getParameter("difficulty");

	String cnts = request.getParameter("cnts");
	if (cnts == null) { cnts = "N"; } else { cnts = cnts.trim(); }	
	String cnt1 = request.getParameter("cnt1");
	
	
	
	String cnt2 = request.getParameter("cnt2");
	
	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = "N"; } else { id_qs = id_qs.trim(); }	
	String id_qs1 = request.getParameter("id_qs1");

	String incorrects = request.getParameter("incorrects");
	if (incorrects == null) { incorrects = "N"; } else { incorrects = incorrects.trim(); }	
	String incorrect1 = request.getParameter("incorrect1");

	String qs0 = request.getParameter("qs0");
	if (qs0 == null) { qs0 = "N"; } else { qs0 = qs0.trim(); }	
	String qs1 = request.getParameter("qs1");

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
	bean.setQs(qs0);
	bean.setQs1(qs1);

	// 문제 검색
	QSearchListBean[] rst = null;

	try {
		rst = QSearch.getSearchBeans2(bean, userid);
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
%>

	<table border="0" width="100%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
		<tr bgcolor="#D8D8D8" align="center" height="30">
			<td width="120">과목명</td>
			<td width="120">단원명</td>
			<td width="60">문제코드</td>
			<td width="70">문제유형</td>
			<td width="60">난이도</td>
			<td width="60">출제횟수</td>
			<td>문제</td>
		</tr>
		<% if(rst == null) { %>
		<tr bgcolor="#FFFFFF" height="40">
			<td colspan="7" align="center"  class="blank">검색되어진 문제가 없습니다.</td>
		</tr>
		<%
			} else {
				for(int i=0; i<rst.length; i++) {
		%>

		<tr bgcolor="#FFFFFF"  height="25">
			<td align="center"><%=rst[i].getSubject()%></td>
			<td align="center"><%=rst[i].getChapter()%></td>
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
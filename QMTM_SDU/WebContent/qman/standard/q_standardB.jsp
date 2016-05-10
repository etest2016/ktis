<%
//******************************************************************************
//   프로그램 : q_standardB.jsp
//   모 듈 명 : 소분류 관리
//   설    명 : 소분류 목록 및 추가,수정,삭제
//   테 이 블 : q_standard_b, t_worker_subj
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 :
//   수 정 자 :
//	 수정사항 :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.qman.standard.QstandardBBean, qmtm.qman.standard.QstandardBUtil" %>
<%@ include file = "/common/login_chk.jsp" %>     
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	String usergrade = (String)session.getAttribute("usergrade"); // 권한

	String id_standarda = request.getParameter("id_standarda");
	if (id_standarda == null) { id_standarda = ""; } else { id_standarda = id_standarda.trim(); }	

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_standarda.length() == 0 || id_q_subject.length() == 0 || id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	    
	// 소분류 리스트 가져오기

	QstandardBBean[] rst = null;

    try {
	    rst = QstandardBUtil.getBeans(id_standarda);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<HTML>
 <HEAD>
  <TITLE> QMAN 과목 문제 관리 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>

  <script language="JavaScript">

	function insert() {
		$.posterPopup("q_standardb_insert.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda=<%=id_standarda%>","insert","width=400, height=200, scrollbars=no, top="+(screen.height-200)/2+", left="+(screen.width-400)/2);
    }

	function edits(id_standardb) {
		$.posterPopup("q_standardb_edit.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda=<%=id_standarda%>&id_standardb="+id_standardb,"edits","width=400, height=240, scrollbars=no, top="+(screen.height-240)/2+", left="+(screen.width-400)/2);
    }

	function dels(id_standardb) {
		var str = confirm("**********************주의**********************\n\n소분류 기준코드를 정말 삭제하시겠습니까?");

		if(str) {
			$.posterPopup("q_standardb_delete.jsp?id_subject=<%=id_q_subject%>&id_chapter=<%=id_q_chapter%>&id_standarda=<%=id_standarda%>&id_standardb="+id_standardb,"dels","width=1, height=1, scrollbars=no, top="+(screen.height-1)/2+", left="+(screen.width-1)/2);
		}
    }

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div id="mainTop">
			<div class="title">출제기준 관리<span>: 대분류, 소분류 기준코드 등록관리</span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><Td colspan="7"><input type="button" value="소분류 기준등록" class="form6" onClick="insert();"></td></tr>
			<tr id="tr">
				<td width="5%">NO</td>
				<td width="12%">대분류코드</td>
				<td width="12%">소분류코드</td>
				<td>소분류명</td>
				<td width="15%">공개여부</td>
				<td width="15%">등록일자</td>
				<td width="15%">관리</td>
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="7">등록되어진 소분류 기준이 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
					   String yn_use = rst[i].getYn_valid();

					   if(yn_use.equalsIgnoreCase("Y")) {
						   yn_use = "공개";
					   } else {
						   yn_use = "비공개";
					   }
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<td><%=id_standarda%></td>
				<td><%=rst[i].getId_standardb()%></td>
				<td><%=rst[i].getStandardb()%></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getRegdate()%></td>
				<td><input type="button" value="수정하기" class="form" onClick="edits('<%=rst[i].getId_standardb()%>');">&nbsp;&nbsp;<input type="button" value="삭제하기" class="form" onClick="dels('<%=rst[i].getId_standardb()%>');"></td>
			</tr>
			<%
				   }
				}
			%>
		</table>

	</div>

	<jsp:include page="../../copyright.jsp"/>

		
 </BODY>
</HTML>
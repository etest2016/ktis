<%
//******************************************************************************
//   프로그램 : module_list.jsp
//   모 듈 명 : 모듈 목록
//   설    명 : 모듈 목록 및 추가,수정,삭제
//   테 이 블 : q_module, t_worker_subj
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, qmtm.common.NameBean,
//              qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 :
//   수 정 자 :
//	 수정사항 :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, qmtm.common.NameBean, qmtm.qman.category.ModuleBean, qmtm.qman.category.ModuleUtil" %>
<%@ include file = "/common/login_chk.jsp" %>     
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");

	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// 상위 Depth 가져오기
	NameBean names = null;

	try {
		names = NameUtil.getModule(id_subject);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	   
	// 모듈 리스트 가져오기
	ModuleBean[] rst = null;

    try {
	    rst = ModuleUtil.getBeans(id_subject);
    } catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<HTML>
 <HEAD>
  <TITLE> QMAN 단원 문제 관리 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script type="text/javascript" src="../../js/tablesort.js"></script>
  <SCRIPT LANGUAGE="JavaScript" src="../../js/Script.js"></Script>

  <script language="JavaScript">

	function insert() {
		$.posterPopup('module_insert.jsp?id_subject=<%=id_subject%>','insert','width=350, height=250, scrollbars=no, top='+(screen.height-250)/2+', left='+(screen.width-350)/2);
    }

	function edits(id_module) {
		$.posterPopup('module_edit.jsp?id_subject=<%=id_subject%>&id_module='+id_module,'edits','width=350, height=280, scrollbars=no, top='+(screen.height-280)/2+', left='+(screen.width-350)/2);
    }

	function dels(id_module) {
		var str = confirm("**********************주의**********************\n\n단원 정보를 정말 삭제하시겠습니까?");

		if(str) {
			$.posterPopup('module_delete.jsp?id_subject=<%=id_subject%>&id_module='+id_module,'dels','width=1, height=1, scrollbars=no, top='+(screen.height-1)/2+', left='+(screen.width-1)/2);
		}
    }

	function q_search() {
	   location.href = "../question/q_c_list.jsp?id_q_subject=<%=names.getId_course()%>&id_q_chapter=0";
    }

	function q_standard() {
	   location.href = "subject_list.jsp?id_course=<%=names.getId_course()%>";
    }

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div class="tab"><a href="javascript:q_search();" onfocus="this.blur();"><img src="../../images/tabqA01.gif"></a><a href="javascript:q_standard();" onfocus="this.blur();"><img src="../../images/tabqA02_.gif"></a></div>
		
		<div id="mainTop">
			<div class="title">단원 관리<span>: 단원을 등록 및 수정 관리 할 수 있습니다.</span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../../images/icon_location.gif"> <%=names.getCourse()%> > <%=names.getSubject()%></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">			
			<tr id="tr">
				<td width="3%">NO</td>
				<td width="12%">단원코드</td>
				<td>단원명</td>
				<td width="12%">등록문항수</td>
				<td width="12%">중복문항수</td>
				<td width="12%">오류문항수</td>
				<td width="12%">검수상태</td>
				<td width="12%">문제복사</td>
				<td width="12%">문제다운로드</td>								
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="9">등록되어진 단원 리스트가 없습니다.</td>
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
				<td><%=rst[i].getId_chapter()%></td>
				<td><a href="../question/q_list1.jsp?id_q_subject=<%=id_subject%>&id_q_chapter=<%=rst[i].getId_chapter()%>"><%=rst[i].getChapter()%></a></td>
				<td>12문항</td>
				<td>1문항</td>
				<td>1문항</td>
				<td><strong>미검수</strong></td>
				<td><input type="button" value="문제복사" class="form"></td>
				<td><input type="button" value="다운로드" class="form"></td>				
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
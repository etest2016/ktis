<%
//******************************************************************************
//   프로그램 : subject_list.jsp
//   모 듈 명 : 과목 목록
//   설    명 : 과목 목록 및 추가,수정,삭제
//   테 이 블 : q_subject, t_worker_subj
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, 
//              qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil
//   작 성 일 : 2013-02-04
//   작 성 자 : 이테스트 석준호
//   수 정 일 :
//   수 정 자 :
//	 수정사항 :
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.common.NameUtil, qmtm.qman.category.SubjectBean, qmtm.qman.category.SubjectUtil" %>
<%@ include file = "/common/login_chk.jsp" %>     
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// 과정명
	String course = "";

	try {
		course = NameUtil.getCourse(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	   
	// 과목 리스트 가져오기
	SubjectBean[] rst = null;

    try {
	    rst = SubjectUtil.getBeans(id_course);
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

  <script type="text/javascript">

	function insert() {
		$.posterPopup('subject_insert.jsp?id_course=<%=id_course%>','insert','width=350, height=250, scrollbars=no, top='+(screen.height-250)/2+', left='+(screen.width-350)/2);
    }

	function edits(id_subject) {
		$.posterPopup('subject_edit.jsp?id_subject='+id_subject,'edits','width=350, height=280, scrollbars=no, top='+(screen.height-280)/2+', left='+(screen.width-350)/2);
    }

	function dels(id_subject) {
		var str = confirm("**********************주의**********************\n\n과목 정보를 정말 삭제하시겠습니까?");

		if(str) {
			$.posterPopup('subject_delete.jsp?id_subject='+id_subject,'dels','width=1, height=1, scrollbars=no, top='+(screen.height-1)/2+', left='+(screen.width-1)/2);
		}
    }

	function q_search() {
	   location.href = "../question/q_c_list.jsp?id_q_subject=<%=id_course%>&id_q_chapter=0";
    }

	function q_standard() {
	   location.href = "subject_list.jsp?id_course=<%=id_course%>";
    }

 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		
		<div class="tab"><a href="javascript:q_search();" onfocus="this.blur();"><img src="../../images/tabqA01.gif"></a><a href="javascript:q_standard();" onfocus="this.blur();"><img src="../../images/tabqA02_.gif"></a></div>
		
		<div id="mainTop">
			<div class="title">과목 관리<span>: 과목을 등록 및 수정 관리 할 수 있습니다.</span></div><div align="right" style="font: bold 14px dotum; color: #000;"><img src="../../images/icon_location.gif"> 과정명 : <%=course%></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">			
			<!-- <tr id="bt"><Td colspan="7"><input type="button" value="과목등록" class="form6" onClick="insert();">&nbsp;&nbsp;<b>과목명을 클릭하면 단원을 등록할 수 있습니다.</b></td></tr>-->
			<tr id="tr">
				<td width="4%">NO</td>
				<td width="15%">과목코드</td>
				<td>과목명</td>
				<td width="12%">공개여부</td>
				<td width="12%">정렬순서</td>
				<td width="12%">등록일자</td>				
			</tr>
			<% if(rst == null) { %>
			<tr>
				<td class="blank" colspan="6">등록되어진 과목 리스트가 없습니다.</td>
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
				<td><%=rst[i].getId_subject()%></td>
				<td><a href="module_list.jsp?id_subject=<%=rst[i].getId_subject()%>"><%=rst[i].getSubject()%></a></td>
				<td><%=yn_use%></td>
				<td><%=rst[i].getSubject_order()%></td>
				<td><%=rst[i].getRegdate()%></td>				
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
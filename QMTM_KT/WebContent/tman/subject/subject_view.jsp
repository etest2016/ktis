<%
//******************************************************************************
//   프로그램 : subject_view.jsp
//   모 듈 명 : 과목확인
//   설    명 : 시험관리 과목확인 팝업 페이지
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2010-06-09
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course"); // 과정 ID
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }
	
	String id_subject = request.getParameter("id_subject"); // 과목 ID
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	if (id_course.length() == 0 || id_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// 과목정보 가지고오기
	SubjectTmanBean rst = null;

    try {
	    rst = SubjectTmanUtil.getBean(id_course, id_subject);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

	String yn_valid = "";
	if(rst.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "공개";
	} else {
		yn_valid = "비공개";
	}
%>

<script language="javascript">
    // 과목 수정
	function cpt_edit() {
		location.href="subject_edit.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>";
	}
	
	//--  과목 삭제체크
    function cpt_delete()  {
       var st = confirm("*주의* 단원정보를 삭제하시겠습니까? \n\n삭제 전 하위 시험을 먼저 삭제하셔야 합니다." );
       if (st == true) {
           document.location = "subject_delete.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>";
       }
    }
</script>
<HTML>
<HEAD>
<TITLE> 단원정보 확인 </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">


<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">단원정보 확인 <span>단원확인 및 수정,삭제</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">단원명</td>
				<td width="200"><%=rst.getSubject()%></td>
			</tr>
			<tr>
				<td id="left">공개여부</td>
				<td><%=yn_valid%></td>
			</tr>	
			<tr>
				<td id="left">등록일자</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
		</table>
		</div>


<div id="button">
<a href="javascript:cpt_edit();"><img border="0" src="../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<a href="javascript:cpt_delete();"><img border="0" src="../../images/bt5_delete_yj_1.gif"></a>&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../images/bt5_exit_yj1.gif"></a>
</div>

	</form>

</BODY>
</HTML>
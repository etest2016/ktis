<%
//******************************************************************************
//   프로그램 : subject_list.jsp
//   모 듈 명 : 과목관리
//   설    명 : 시험관리 트리에서 과목 선택시 보여주는 페이지
//   테 이 블 : c_subject
//   자바파일 : qmtm.ComLib, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil
//   작 성 일 : 2010-06-11
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
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_edit() {
		window.open("subject_edit.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  과목 삭제체크
    function sub_delete()  {
       var st = confirm("*주의* 과목정보를 삭제하시겠습니까? \n\n삭제 전 하위 시험을 먼저 삭제하셔야 합니다.");
	   if (st == true) {
           window.open("subject_delete.jsp?id_course=<%=id_course%>&id_subject=<%=id_subject%>&bigo=Y","edit","width=400, height=250, scrollbars=no");
       }
    }	
 </script>

 </HEAD>

 <BODY id="admin">	

    <div id="main">
		<div id="mainTop">
			<div class="title">과목정보[<%=rst.getSubject()%>]</div>
		<div class="location"> 관리자 > <span><%=rst.getSubject()%></span></div>
	</div>

	<TABLE cellpadding="0" cellspacing="0" border="0" id="tableC" width="100%">
		<TR id="top">
			<TD id="left"></TD>
			<TD id="center"></TD>
			<TD id="right"></TD>
		</TR>
		<TR id="middle">
			<TD id="left"></TD>
			<TD id="center">

				<table id="tableA" cellpadding="0" cellspacing="0" border="0">
					<tr id="tr2" height="30" bgcolor="#DBDBDB"  align="center">
						<td bgcolor="#DBDBDB" align="center">과목코드</td>
						<td bgcolor="#DBDBDB">과목명</td>
						<td bgcolor="#DBDBDB">등록일자</td>
						<td bgcolor="#DBDBDB">수정하기</td>
						<td bgcolor="#DBDBDB">삭제하기</td>
					</tr>
					<tr id="td" height="30" bgcolor="#FFFFFF">
						<td align="center"><%=id_subject%></td>
						<td align="center"><%=rst.getSubject()%></td>
						<td align="center"><%=rst.getRegdate()%></td>
						<td align="center"><a href="javascript:sub_edit();"><img src="../../../images/bt5_edit.gif"></a></td>
						<td align="center"><a href="javascript:sub_delete();"><img src="../../../images/bt5_delete.gif"></a></td>
					</tr>		
				</table>
			</TD>
			<TD id="right"></TD>
		</TR>
		<TR id="bottom">
			<TD id="left"></TD>
			<TD id="center"></TD>
			<TD id="right"></TD>
		</TR>
		</TABLE>
		
		</div>
		<jsp:include page="../../../copyright.jsp"/>
	
	
 </BODY>
</HTML>
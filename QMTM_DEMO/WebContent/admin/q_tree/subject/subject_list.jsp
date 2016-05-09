<%
//******************************************************************************
//   프로그램 : subject_list.jsp
//   모 듈 명 : 과목관리
//   설    명 : 문제은행 트리에서 과목 선택시 보여주는 페이지
//   테 이 블 : q_subject, q_chapter
//   자바파일 : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree, 
//             qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree, qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil" %>

<%
	response.setDateHeader("Expires", 0);   
	request.setCharacterEncoding("EUC-KR");   

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0 || id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
     
    // 과목정보 가지고오기
	QmanTreeBean rst = null;

    try {
	    rst = QmanTree.getBean_2(id_q_subject);
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
		window.open("subject_edit.jsp?id_q_subject=<%=id_q_subject%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  과목 삭제체크
    function sub_delete()  {
       var st = confirm("*주의* 과목정보를 삭제하시겠습니까? \n\n삭제 전 하위단원을 먼저 삭제하셔야 합니다." );
       if (st == true) {
           window.open("subject_delete.jsp?id_q_subject=<%=id_q_subject%>","edit","width=400, height=250, scrollbars=no");
       }
    }
		
 </script>

 </HEAD>
	
 <BODY id="admin">	

	<div id="main">

		<div id="mainTop">
			<div class="title">과목정보</div>
			<div class="location">카테고리관리 > <%=rst.getCategory()%> > <span><%=rst.getQ_subject()%></span></div>
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
					<!--tr id="sub_title"><td colspan="5">과목정보</td></tr-->
					<tr id="tr2">
						<td>과목코드</td>
						<td>과목명</td>
						<td>등록일자</td>
						<td>수정하기</td>
						<td>삭제하기</td>
					</tr>
					<tr id="td" align="center" height="40">
						<td><%=id_q_subject%></td>
						<td><%=rst.getQ_subject()%></td>
						<td><%=rst.getRegdate()%></td>
						<td><a href="javascript:sub_edit();" onfocus="this.blur();"><img src="../../../images/bt5_edit.gif"></a></td>
						<td><a href="javascript:sub_delete();" onfocus="this.blur();"><img src="../../../images/bt5_delete.gif"></a></td>
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
	
	<jsp:include page="../../../copyright.jsp"/>
	
 </BODY>
</HTML>
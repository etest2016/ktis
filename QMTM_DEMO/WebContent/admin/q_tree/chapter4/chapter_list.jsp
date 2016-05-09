<%
//******************************************************************************
//   프로그램 : chapter_list.jsp
//   모 듈 명 : 네번째 단원관리
//   설    명 : 문제은행 트리에서 네번째 단원 선택시 보여주는 페이지
//   테 이 블 : q_chapter4  
//   자바파일 : qmtm.admin.Chapter4QmanBean, qmtm.admin.Chapter4QmanUtil
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.*, qmtm.admin.qman.*" %>

<%
	response.setDateHeader("Expires", 0);   
	request.setCharacterEncoding("EUC-KR");

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    // 단원4 정보 가지고오기
	Chapter4QmanBean rst = null;

    try {
	    rst = Chapter4QmanUtil.getBean(id_q_chapter);
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
		window.open("chapter_edit.jsp?id_subject=<%=rst.getId_q_subject()%>&id_chapter1=<%=rst.getId_q_chapter()%>&id_chapter2=<%=rst.getId_q_chapter2()%>&id_chapter3=<%=rst.getId_q_chapter3()%>&id_q_chapter=<%=id_q_chapter%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  단원 삭제체크
    function sub_delete()  {
       var st = confirm("*주의* 단원정보를 삭제하시겠습니까? \n\n삭제 전 하위단원을 먼저 삭제하셔야 합니다." );
       if (st == true) {
           window.open("chapter_delete.jsp?id_subject=<%=rst.getId_q_subject()%>&id_chapter1=<%=rst.getId_q_chapter()%>&id_chapter2=<%=rst.getId_q_chapter2()%>&id_chapter3=<%=rst.getId_q_chapter3()%>&id_q_chapter=<%=id_q_chapter%>&bigos=Y","edit","width=400, height=250, scrollbars=no");
       }
    }	
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">

		<div id="mainTop">
			<div class="title">선택 단원4 정보 <span>선택한 단원3의 상세정보 및 그 하위 단원을 조회 및 수정, 삭제 할 수 있습니다</span></div>
			<div class="location"> 관리자 > 문제은행관리 > <span><%=rst.getChapter()%></span></div>
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
	
	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="tr2">
				<td>단원4코드</td>
				<td>단원4명</td>
				<td>등록일자</td>
				<td>수정하기</td>
				<td>삭제하기</td>
			</tr>
			<tr id="td" align="center">
				<td><%=id_q_chapter%></td>
				<td><%=rst.getChapter()%></td>
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
	
	</div>
	<jsp:include page="../../../copyright.jsp"/>
 </BODY>
</HTML>
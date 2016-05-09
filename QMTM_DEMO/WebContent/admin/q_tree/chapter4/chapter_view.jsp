<%
//******************************************************************************
//   프로그램 : chapter_view.jsp
//   모 듈 명 : 네번째 단원확인
//   설    명 : 문제은행 네번째 단원확인 팝업 페이지
//   테 이 블 : q_chapter4
//   자바파일 : qmtm.admin.qman.Chapter4QmanBean, qmtm.admin.qman.Chapter4QmanUtil
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.admin.qman.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_subject = request.getParameter("id_subject"); 
	if (id_subject == null) { id_subject = ""; } else { id_subject = id_subject.trim(); }

	String id_chapter1 = request.getParameter("id_chapter1"); 
	if (id_chapter1 == null) { id_chapter1 = ""; } else { id_chapter1 = id_chapter1.trim(); }

	String id_chapter2 = request.getParameter("id_chapter2"); 
	if (id_chapter2 == null) { id_chapter2 = ""; } else { id_chapter2 = id_chapter2.trim(); }

	String id_chapter3 = request.getParameter("id_chapter3"); 
	if (id_chapter3 == null) { id_chapter3 = ""; } else { id_chapter3 = id_chapter3.trim(); }
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_subject.length() == 0 || id_chapter1.length() == 0 || id_chapter2.length() == 0 || id_chapter3.length() == 0 || id_q_chapter.length() == 0) { 
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	// 단원정보 가지고오기
	Chapter4QmanBean rst = null;

    try {
	    rst = Chapter4QmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
%>

<script language="javascript">
    // 단원 수정
	function cpt_edit() {
		location.href="chapter_edit.jsp?id_subject=<%=id_subject%>&id_chapter1=<%=id_chapter1%>&id_chapter2=<%=id_chapter2%>&id_chapter3=<%=id_chapter3%>&id_q_chapter=<%=id_q_chapter%>";
	}
	
	//--  단원 삭제체크
    function cpt_delete()  {
       var st = confirm("*주의* 단원정보를 삭제하시겠습니까? \n\n삭제 전 해당 단원에 포함된 문항을 먼저 삭제하셔야 합니다." );
       if (st == true) {
           document.location = "chapter_delete.jsp?id_subject=<%=id_subject%>&id_chapter1=<%=id_chapter1%>&id_chapter2=<%=id_chapter2%>&id_chapter3=<%=id_chapter3%>&id_q_chapter=<%=id_q_chapter%>";
       }
    }
</script>

<TITLE> :: 단원 확인 :: </TITLE>
<link rel="StyleSheet" href="../../../css/style.css" type="text/css">
</head>

<BODY id="popup2">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">단원 확인 <span>단원정보를 확인합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">단원명&nbsp;</td>
				<td width="220">&nbsp;&nbsp;<%=rst.getChapter()%></td>
			</tr>
			<tr>
				<td id="left">정렬순서&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rst.getChapter_order()%></td>
			<tr>
				<td id="left">등록일자&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rst.getRegdate()%></td>
			</tr>
	</table>
</div>

<div id="button">
<!--<input type="button" value="수정하기" onClick="cpt_edit();">--><a href="javascript:cpt_edit();"><img border="0" src="../../../images/bt5_edit_yj1.gif"></a>&nbsp;&nbsp;<!--<input type="button" value="삭제하기" onClick="cpt_delete();">--><a href="javascript:cpt_delete();"><img border="0" src="../../../images/bt5_delete_yj_1.gif"></a>
</div>
	
	
	</form>

</body>
</HTML>
<%
//******************************************************************************
//   프로그램 : chapter_list.jsp
//   모 듈 명 : 두번째 단원관리
//   설    명 : 문제은행 트리에서 두번째 단원 선택시 보여주는 페이지
//   테 이 블 : q_chapter, q_chapter
//   자바파일 : qmtm.admin.ChapterQmanBean, qmtm.admin.ChapterQmanUtil
//              qmtm.admin.Chapter2QmanBean, qmtm.admin.Chapter2QmanUtil 
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

    // 단원2 정보 가지고오기
	Chapter2QmanBean rst = null;

    try {
	    rst = Chapter2QmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// 단원목록 가지고오기
	Chapter3QmanBean[] rst2 = null; 

	try {
		rst2 = Chapter3QmanUtil.getBeans(id_q_chapter);
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
		window.open("chapter_edit.jsp?id_subject=<%=rst.getId_q_subject()%>&id_q_subject=<%=rst.getId_q_chapter()%>&id_q_chapter=<%=id_q_chapter%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  단원 삭제체크
    function sub_delete()  {
       var st = confirm("*주의* 단원정보를 삭제하시겠습니까? \n\n삭제 전 하위단원을 먼저 삭제하셔야 합니다." );
       if (st == true) {
           window.open("chapter_delete.jsp?id_subject=<%=rst.getId_q_subject()%>&id_q_subject=<%=rst.getId_q_chapter()%>&id_q_chapter=<%=id_q_chapter%>&bigos=Y","edit","width=400, height=250, scrollbars=no");
       }
    }
	
	function cpt_insert() {
		window.open("../chapter3/chapter_insert.jsp?id_q_chapter=<%=id_q_chapter%>","insert","width=400, height=250, scrollbars=no");
    }

	function cpt_view(id_q_chapter) {
		
		window.open("../chapter3/chapter_view.jsp?id_q_chapter="+id_q_chapter,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
    <div id="main">

		<div id="mainTop">
			<div class="title">선택 단원2 정보 <span>선택한 단원2의 상세정보 및 그 하위 단원을 조회 및 수정, 삭제 할 수 있습니다</span></div>
			<div class="location">관리자 > 문제은행관리 > <span>[<%=rst.getChapter()%>] </span></div>
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
							<td bgcolor="#DBDBDB" align="center">단원2코드</td>
							<td bgcolor="#DBDBDB">단원2명</td>
							<td bgcolor="#DBDBDB">등록일자</td>
							<td bgcolor="#DBDBDB">수정하기</td>
							<td bgcolor="#DBDBDB">삭제하기</td>
						</tr>
						<tr id="td" align="center">
							<td align="center"><%=id_q_chapter%></td>
							<td align="center"><%=rst.getChapter()%></td>
							<td align="center"><%=rst.getRegdate()%></td>
							<td align="center"><a href="javascript:sub_edit();" onfocus="this.blur();"><img src="../../../images/bt5_edit.gif"></a></td>
							<td align="center"><a href="javascript:sub_delete();" onfocus="this.blur();"><img src="../../../images/bt5_delete.gif"></a></td>
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
	
		<div class="title">단원3 리스트</span></div>
			
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">	
			<tr id="bt"><td colspan="4"><a href="javascript:cpt_insert();"><img src="../../../images/bt_a_q_newc3.gif"></a></TD>
			</TR>

			<tr id="tr">
				<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
				<td bgcolor="#DBDBDB" align="center">단원3코드</td>
				<td bgcolor="#DBDBDB" style="text-align: left;">단원3명</td>
				<td bgcolor="#DBDBDB">등록일자</td>
			</tr>
			<% if(rst2 == null) { %>
			<tr>
				<td colspan="4" class="blank">등록되어진 단원3이 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst2.length; i++) {
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<!--td><a href="javascript:cpt_view('<%=rst2[i].getId_q_chapter3()%>');"><%=rst2[i].getId_q_chapter3()%></a></td-->
				<td><%=rst2[i].getId_q_chapter3()%></td>
				<td style="text-align: left;"><div style="float: left;"><a href="../chapter3/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter3()%>" onfocus="this.blur();"><%=rst2[i].getChapter()%></a> </div> <div style="float: left; padding-top: 1px; padding-left: 6px;"><a href="../chapter3/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter3()%>" onfocus="this.blur();"><img src="../../../images/info2.gif"></a></div></td>
				<td><%=rst2[i].getRegdate()%></td>
			</tr>
			<%
				   }
				}
			%>
		</table>

	</div>
	<jsp:include page="../../../copyright.jsp"/>
	
 </BODY>
</HTML>
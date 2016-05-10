<%
//******************************************************************************
//   프로그램 : course_list.jsp
//   모 듈 명 : 과정관리
//   설    명 : 시험관리 트리에서 과정 선택시 보여주는 페이지
//   테 이 블 : c_course, c_subject
//   자바파일 : qmtm_ComLib, qmtm.admin.TmanTreeBean, qmtm.admin.TmanTree
//              qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil 
//   작 성 일 : 2008-04-11
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.TmanTreeBean, qmtm.admin.TmanTree, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    // 과정정보 가지고오기
	TmanTreeBean rst = null;

    try {
	    rst = TmanTree.getBean(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// 과목목록 가지고오기
	SubjectTmanBean[] rst2 = null; 

	try {
		rst2 = SubjectTmanUtil.getBeans(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../../js/jquery.js"></script>
   <script type="text/javascript" src="../../../js/jquery.etest.poster.js"></script> 
 <script language="JavaScript">
	function sub_edit() {
		$.posterPopup("course_edit.jsp?id_course=<%=id_course%>","edit","width=400, height=250, scrollbars=no");
	}

	function sub_group_insert() {
		$.posterPopup("../sub_group_insert.jsp?id_course=<%=id_course%>","ginsert","width=550, height=550, scrollbars=yes");
    }
	
	//--  과정 삭제체크
    function sub_delete()  {
       var st = confirm("*주의* 과정정보를 삭제하시겠습니까? \n\n삭제 전 하위과목을 먼저 삭제하셔야 합니다." );
       if (st == true) {
           $.posterPopup("course_delete.jsp?id_course=<%=id_course%>","edit","width=400, height=250, scrollbars=no");
       }
    }
	
	function cpt_insert() {
		$.posterPopup("../subject/subject_insert.jsp?id_course=<%=id_course%>","insert","width=400, height=250, scrollbars=no");
    }

	function cpt_view(id_subject) {
		
		$.posterPopup("../subject/subject_view.jsp?id_course=<%=id_course%>&id_subject="+id_subject,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
	<div id="main">

		<div id="mainTop">
			<div class="title">과정정보[<%=rst.getCourse()%>]</div>
		<div class="location"> > <span><%=rst.getCourse()%></span></div>
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
			<td bgcolor="#DBDBDB" align="center">과정코드</td>
			<td bgcolor="#DBDBDB">과정명</td>
			<td bgcolor="#DBDBDB">등록일자</td>
			<td bgcolor="#DBDBDB">수정하기</td>
			<td bgcolor="#DBDBDB">삭제하기</td>
			<!--<td bgcolor="#DBDBDB">과목등록</td>-->
		</tr>
		<tr id="td" height="30" bgcolor="#FFFFFF">
			<td align="center"><%=id_course%></td>
			<td align="center"><%=rst.getCourse()%></td>
			<td align="center"><%=rst.getRegdate()%></td>
			<td align="center"><a href="javascript:sub_edit();"><img src="../../../images/bt5_edit.gif"></a></td>
			<td align="center"><a href="javascript:sub_delete();"><img src="../../../images/bt5_delete.gif"></a></td>
			<!--<td align="center"><a href="javascript:sub_group_insert();"><img src="../../../images/bt5_submit.gif"></a></td>-->
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
	
	<div class="title">과목 리스트</div>

		<table id="tableA" cellpadding="0" cellspacing="0" border="0">
			<tr id="bt"><TD colspan="4"><a href="javascript:cpt_insert();"><img src="../../../images/bt_course.gif"></a></TD>
		</TR>
	
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB" align="center">과목코드</td>
			<td bgcolor="#DBDBDB">과목명</td>
			<td bgcolor="#DBDBDB">등록일자</td>
		</tr>
		<% if(rst2 == null) { %>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" colspan="4">등록되어진 과목이 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst2.length; i++) {
		%>
		<tr id="td" height="30" bgcolor="#FFFFFF">
			<td align="center"><%=i+1%></td>
			<td align="center"><a href="javascript:cpt_view('<%=rst2[i].getId_subject()%>');"><%=rst2[i].getId_subject()%></a></td>
			<td align="center"><a href="../subject/subject_list.jsp?id_course=<%=id_course%>&id_subject=<%=rst2[i].getId_subject()%>"><%=rst2[i].getSubject()%></a></td>
			<td align="center"><%=rst2[i].getRegdate()%></td>
		</tr>
		<%
			   }
			}
		%>
	</table>
	<jsp:include page="../../../copyright.jsp"/>
</div>
 </BODY>
</HTML>
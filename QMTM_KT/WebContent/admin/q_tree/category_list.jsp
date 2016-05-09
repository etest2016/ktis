<%
//******************************************************************************
//   프로그램 : f_main.jsp
//   모 듈 명 : 과목관리
//   설    명 : 과목관리 페이지
//   테 이 블 : q_subject
//   자바파일 : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree
//   작 성 일 : 2008-04-03
//   작 성 자 : 이테스트 석준호
//   수 정 일 :    
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>
 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }	

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (userid.length() == 0 || id_course.length() == 0) {
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}
	
    // 과목목록 가지고오기
	QmanTreeBean[] rst = null; 

	try {
		rst = QmanTree.getBeans(id_course);   
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	GroupKindBean rst2 = null;

    try {
	    rst2 = GroupKindUtil.getBean2(id_course);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }

%>
<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_insert() {
		window.open("subject_insert.jsp?id_category=<%=rst2.getId_category()%>&id_course=<%=id_course%>","insert","top=0, left=0, width=400, height=255, scrollbars=no");
    }

	function sub_view(id_q_subject) {
		
		window.open("subject/subject_view.jsp?id_q_subject="+id_q_subject,"view","top=0, left=0, width=400, height=255, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		<div id="mainTop">
			<div class="title">카테고리 관리<span>: 카테고리 리스트</span></div>
			<div class="location">카테고리 관리 > <%=rst2.getCategory()%> > <span><%=rst2.getCourse()%></span></div>
		</div>
		<table border="0" cellpadding ="0" cellspacing="0" id="tablea">
			<tr id="bt">
				<td colspan="5"><a href="javascript:sub_insert();" onfocus="this.blur();"><img src="../../images/bt_a_news.gif"></a></td>
			</tr>
			<tr id="tr">
				<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
				<td bgcolor="#DBDBDB" align="center">개설년도</td>
				<td bgcolor="#DBDBDB" align="center">과목코드</td>
				<td bgcolor="#DBDBDB" style="text-align: left;">과목명</td>
				<td bgcolor="#DBDBDB">등록일자</td>
				<!--<td bgcolor="#DBDBDB">담당자확인</td>-->
			</tr>
			<% if(rst == null) { %>
			<tr> 
				<td class="blank" colspan="5">등록되어진 과목이 없습니다.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>
			<tr id="td" align="center" <% if((i%2)==1){%>bgcolor="#fafaf5"<%}else{%>bgcolor="#ffffff"<%}%>>
				<td><%=i+1%></td>
				<td><%=rst[i].getYears()%>년</td>
				<!--td><a href="javascript:sub_view('<%=rst[i].getId_q_subject()%>');" onfocus="this.blur();"><%=rst[i].getId_q_subject()%></a></td-->
				<td><%=rst[i].getId_q_subject()%></td>
				<td style="text-align: left;"><div style="float: left; cursor: hand;"><a href="subject/subject_list.jsp?id_q_subject=<%=rst[i].getId_q_subject()%>" onfocus="this.blur();"><%=rst[i].getQ_subject()%></a></div> <div style="float: left; padding-top: 1px; padding-left: 6px; cursor: hand;"><a href="subject/subject_list.jsp?id_q_subject=<%=rst[i].getId_q_subject()%>" onfocus="this.blur();"><img src="../../images/info2.gif"></a></div></td>
				<td><%=rst[i].getRegdate()%></td>
				<!--<td align="center">[담당자 확인]</td>-->
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
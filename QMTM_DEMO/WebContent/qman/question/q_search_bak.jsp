<%
//******************************************************************************
//   프로그램 : q_search.jsp
//   모 듈 명 : 문제 검색
//   설    명 : 조건을 주어 문제를 검색한다.
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-04-16
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 2008-07-02
//   수 정 자 : 이테스트 석준호
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	if (id_q_subject.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	String qtype = request.getParameter("qtype");
	if (qtype == null) { qtype = ""; } else { qtype = qtype.trim(); }


	/* 개설된 과목 리스트 */
	QmanTreeBean[] rst = null;

	try {
		rst = QmanTree.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	/* 개설된 단원 리스트 */
	QmanTreeBean[] rst2 = null;

	try {
		rst2 = QmanTree.getBeans2(id_q_subject);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<HTML>
 <HEAD>
  <TITLE>문제 검색</TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--
	
	function FrmCheck(){

		document.frmdata.action = "q_search.jsp";
		document.frmdata.submit();
	}


  //-->
  </SCRIPT>
 </HEAD>

 <BODY>
 <FORM name="frmdata" method="post" action="../editor/q_write.jsp">
	
	<INPUT TYPE="hidden" NAME="" value="<%=id_q_subject%>">
	<INPUT TYPE="hidden" NAME="" value="<%=id_q_chapter%>">

    <TABLE width="100%" border="0">
	<tr>
	<td align="left">
	
	

	<div style="padding: 2px 0px 5px 22px; background-image: url(../../../images/title_list_yj_1.gif); background-repeat: no-repeat; font: bold 14px dotum; color: #000;"> 문제 검색</div>

	<TABLE width="100%" border="0" cellpadding ="5" cellspacing="1" bgcolor="#CCCCCC" style="width: 100%; margin-bottom: 20px; margin-top: 10px; border-top: 1px; solid #ffffff; font-size: 9pt;">
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME="OP1"></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;">과목</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">
			<SELECT NAME="id_q_subject" onchange="FrmCheck();">
			<% if(rst == null) { %>
			<OPTION VALUE="" SELECTED>개설된 과목이 없습니다.
			<% 
				} else { 
					for(int i = 0; i < rst.length; i++) {
						
			%>
					<OPTION VALUE="<%=rst[i].getId_q_subject()%>" <%if(id_q_subject.equals(rst[i].getId_q_subject())){%>selected<%}%>><%=rst[i].getQ_subject()%>
			<%
					}
				}
			%>
		</SELECT>
		</TD>
	</TR>
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">단원</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">
			<SELECT NAME="id_q_chapter" onchange="FrmCheck();">
				<% if(rst2 == null) { %>
				<OPTION VALUE="" SELECTED>선택 과목에 개설된 단원이 없습니다.
				<% } else { 
				%>
					<OPTION VALUE="" <%if(id_q_chapter.equals("")){%>selected<%}%>>단원 구분 없음
				<%
						for(int j = 0; j < rst2.length; j++) {
				%>
					<OPTION VALUE="<%=rst2[j].getId_q_chapter()%>" <%if(id_q_chapter.equals(rst2[j].getId_q_chapter())){%>selected<%}%>><%=rst2[j].getChapter()%>
				<% }}%>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">문제코드</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><input type="text" class="input" NAME=""></TD>
	</TR>
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">문제 유형</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="1" <%if(qtype.equals("1")||qtype==null||qtype==""){%>CHECKED<%}%>>OX형
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="2" <%if(qtype.equals("2")){%>CHECKED<%}%>>선다형
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="3" <%if(qtype.equals("3")){%>CHECKED<%}%>>복수답안형
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="4" <%if(qtype.equals("4")){%>CHECKED<%}%>>단답형
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="5" <%if(qtype.equals("5")){%>CHECKED<%}%>>논술형
		</TD>
	</TR>
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">난이도</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">출제횟수</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">출제자</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">문제,보기,해설</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">수정일</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">오류문제여부</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	</TABLE>
	<BR>

	<DIV align="center"><INPUT TYPE="image" value="검색" name="submit" src="../../../images/bt_qsearch_yj1.gif">&nbsp;&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt_qtype_yj2.gif"></DIV>



	</td>
	</tr>
	</table>
	
 </FORM>
 </BODY>
</HTML>
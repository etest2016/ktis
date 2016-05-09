<%
//******************************************************************************
//   프로그램 : exams1.jsp
//   모 듈 명 : 수동출제
//   설    명 : 문제관리 > 수동출제
//   테 이 블 : q
//   자바파일 : 
//   작 성 일 : 2008-12-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.*, qmtm.qman.question.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    // 신규 등록 문제 가져오기
	QListBean[] rst = null; 

	try {
		rst = QListUtil.getNewQ(userid);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> 수동출제 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--
		
		function errorQ(id_q){
		
			window.open('exams2.jsp','exams2','width=640,height=500');
		}

  //-->
  </SCRIPT>
 </HEAD>

 <BODY>
 
	<div id="main">	
	
			<div id="mainTop">
				<div class="title">수동출제 <span>시험문제를 사용자가 선택하여 출제합니다</span></div>
				<div class="location">Question Manager > <span>수동출제</span></div>
			</div>

			
			<div class="box" style="margin-bottom: 10px;">
				<TABLE width="100%">
					<TR>
						<TD valign="top"><img src="../images/img_exams1.gif"></TD>
						<TD>
							<TABLE border="0" cellpadding="1" cellspacing="0">
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">문제유형</TD>
									<TD>
										&nbsp;&nbsp;&nbsp;
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>유형선택
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD width="50"></TD>
									<TD><INPUT TYPE="checkbox" NAME="">난이도</TD>
									<TD>
										&nbsp;&nbsp;&nbsp;
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>난이도선택
											<OPTION VALUE="">
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD colspan="5" align="right"><img src="../images/bt3_search_d.gif"></TD>
								</TR>
							</TABLE>
							<hr>
							<TABLE border="0" cellpadding="0" cellspacing="0">
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">출처</TD>
									<TD>
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>도서
											<OPTION VALUE="">
										</SELECT>

										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD width="50"></TD>
									<TD><INPUT TYPE="checkbox" NAME="">하위 단원 문항 포함</TD>
								</TR>
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">용도</TD>
									<TD>
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>도서
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD></TD>
									<TD><INPUT TYPE="checkbox" NAME="">해설이 있는 문항만 보기</TD>
								</TR>
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">검색어</TD>
									<TD>
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>도서
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD></TD>
									<TD><INPUT TYPE="checkbox" NAME="">그룹지문이 있는 문항만 보기</TD>
								</TR>
							</TABLE>

						</TD>
						<TD align="right" valign="top"><img src="../images/bt5_qI_4.gif"></TD>
					</TR>
				</TABLE>

				
				

			</div>
			

			<div class="box2">
			<span class="subtitle">검색된 문항</span>
			<TABLE width="100%">
				<TR>
					<TD>검색된 문항 수: (<B>30</B>)문항</TD>
					<TD align="right"><img src="../images/bt1_a.gif">&nbsp;<img src="../images/bt1_b.gif"> <a href="exams3.jsp" target="fraMain">다음</a></TD>
				</TR>
			</TABLE>



			<% 
				if(rst != null){ 
					for(int i = 0; i < rst.length; i++){
			%>

			<div class="box3">
				[문제코드: <%=rst[i].getId_q()%>]&nbsp;&nbsp;[단원: <%=rst[i].getQ_subject()%>]&nbsp;&nbsp;[문제유형: <%=rst[i].getQtype()%><!--1:ox형, 2:선다형, 3:복수답안형, 4:단답형, 5:논술형-->]&nbsp;&nbsp;[지문유무: <%=rst[i].getRefs()%>]&nbsp;&nbsp;[난이도: ]&nbsp;&nbsp;[용도: ]&nbsp;&nbsp;[검색어: ]
			</div>

			<TABLE width="97%" align="center" cellpadding="2" cellspacing="0">
				<TR>
					<TD rowspan="4" style="vertical-align: top;" width="20"><INPUT TYPE="checkbox" NAME=""></TD>
					<TD><%=rst[i].getQ()%></TD>
				</TR>
				<!--정답-->
				<TR>
					<TD>(정답)</TD>
				</TR>
				<!--해설-->
				<TR>
					<TD>(해설)</TD>
				</TR>
				<!--오답신고-->
				<TR>
					<TD align="right"><a href="Javascript:errorQ('<%=rst[i].getId_q()%>');">오류문항신고</a></TD>
				</TR>
			</TABLE>

			<% }} %>


			</div>



			
	<jsp:include page="../copyright.jsp"/>

</BODY>
</HTML>
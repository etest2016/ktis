<%
//******************************************************************************
//   프로그램 : exams3.jsp
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


%>

<HTML>
 <HEAD>
  <TITLE> 수동출제 </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--
		function SaveQ(){
			
			window.open('exams5.jsp','exams5','width=700,height=500');
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

			
			※  출력할 시험지의 서식과 옵션을 지정 후 [시험지 저장]버튼을 클릭 하십시오.

			<TABLE width="100%">
				<TR>
					<TD>시험지 서식 선택</TD>
					<TD align="right"><a href="exams1.jsp" target="fraMain">이전,</a> <a href="javascript: SaveQ();">시험지 저장</a>, 파일로 보기</TD>
				</TR>
			</TABLE>
			<div class="box">
				<TABLE>
					<TR>
						<TD align="center">
							<INPUT TYPE="radio" NAME="">세로2단<br>
							<img src="../images/layoutA.gif"><br>
							<img src="../images/bt3_zoomin.gif">
						</TD>
						<TD align="center">
							<INPUT TYPE="radio" NAME="">세로1단(TypeA)<br>
							<img src="../images/layoutB.gif"><br>
							<img src="../images/bt3_zoomin.gif">
						</TD>
						<TD align="center">
							<INPUT TYPE="radio" NAME="">세로1단(TypeB)<br>
							<img src="../images/layoutC.gif"><br>
							<img src="../images/bt3_zoomin.gif">
						</TD>
					</TR>
				</TABLE>
			</div>

			<TABLE width="100%">
				<TR>
					<TD>시험지 옵션 설정</TD>
					<TD align="right">
						공개여부 : 
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>비공개
							<OPTION VALUE="">공개
						</SELECT>
					</TD>
				</TR>
			</TABLE>

			<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
				<tr>
					<td id="left" width="20%">학년</td>
					<td>
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>학년 선택
							<OPTION VALUE="">
						</SELECT>
						*필수사항
					</td>
				</tr>
				<tr>
					<td id="left">과목명</td>
					<td>
						<INPUT TYPE="text" NAME="">
						*필수사항(한글/영문 포함 최대 10자 까지 입력 가능)
					</td>
				</tr>
				<tr>
					<td id="left">단원명</td>
					<td>
						<INPUT TYPE="text" NAME="">
						선택사항(한글/영문 포함 최대 30자 까지 입력 가능)
					</td>
				</tr>
				<tr>
					<td id="left">교과서/출판사</td>
					<td>
						<INPUT TYPE="text" NAME="">
						선택사항(한글/영문 포함 최대 10자 까지 입력 가능)
					</td>
				</tr>
				<tr>
					<td id="left">로고</td>
					<td>
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>High Mentor로고
							<OPTION VALUE="">
						</SELECT>
						*필수사항
					</td>
				</tr>
				<tr>
					<td id="left">보관함</td>
					<td>
						<INPUT TYPE="text" NAME=""> [보관함저장]
						*필수사항
					</td>
				</tr>
				<tr>
					<td id="left">시험명</td>
					<td>
						<INPUT TYPE="text" NAME="">
						*필수사항(한글/영문 포함 최대 20자 까지 입력 가능)
					</td>
				</tr>
				<tr>
					<td id="left">출제의도</td>
					<td>
						<INPUT TYPE="text" NAME="">
						선택사항
					</td>
				</tr>
				<tr>
					<td id="left">기타옵션</td>
					<td>
						문장사이 간격
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED> 3줄
							<OPTION VALUE="">2줄
							<OPTION VALUE="">1줄
						</SELECT>
						<br>
						<INPUT TYPE="checkbox" NAME=""> 문제 다음에 해설 표시<br>
						<INPUT TYPE="checkbox" NAME=""> 문제 다음에 정답 표시
					</td>
				</tr>
			</table>

			
	<jsp:include page="../copyright.jsp"/>

</BODY>
</HTML>
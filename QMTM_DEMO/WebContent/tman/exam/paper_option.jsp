<%
//******************************************************************************
//   프로그램 : paper_option.jsp
//   모 듈 명 : 시험출제옵션 정보
//   설    명 : 시험출제옵션 정보
//   테 이 블 : exam_m, q_chapter
//   자바파일 : qmtm.tman.exam.ExamPaperGuide, ExamPaperGuideBean
//   작 성 일 : 2008-05-15
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.paper.*, qmtm.tman.exam.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		window.close();
	</script>
<%	
	}

	// 시험지 갯수를 가지고온다.
	int papercnt = 0;

	try {
		papercnt = ExamUtil.getPaperCnt(id_exam);
	}
	catch (Exception ex) {
		out.println(ex.getMessage());
	}
	
	// 해당 시험출제 정보를 가지고온다.
	ExamPaperOptionBean rst = null;
	
	try {
		rst = ExamPaperOption.getBean(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	String randomtype = "";
	String type_msg = "";

	if(rst.getId_randomtype().equals("NN")) {
		randomtype = "섞지않음";
		type_msg = "문제와 보기 순서를 섞지 않고 지정한 순서로 출제합니다.";
	} else if(rst.getId_randomtype().equals("NQ")) {
		randomtype = "문제 섞기";
		type_msg = "문제 순서를 섞어서 출제자가 지정한 수만큼 각각 다른 시험지를 만듭니다.";
	} else if(rst.getId_randomtype().equals("NT")) {
		randomtype = "문제 및 보기 섞기";
		type_msg = "문제와 보기 순서를 섞어서 출제자가 지정한 수만큼 각각 다른 시험지를 만듭니다.";
	} else if(rst.getId_randomtype().equals("YQ")) {
		randomtype = "문제추출 => 문제섞기";
		type_msg = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에 따라 검색한 문제 그룹에서 문제를 추출해서 각각 다른 시험지 유형을 만듭니다.";
	} else if(rst.getId_randomtype().equals("YT")) {
		randomtype = "문제추출 => 문제 및 보기섞기";
		type_msg = "문제은행에서 출제 대상 문제를 검색한 후 설정한 옵션에 따라 검색한 문제 그룹에서 문제를 추출해서 각 문제의 보기 순서를 섞어서 각각 다른 시험지 를 만듭니다.";
	}

	// 문제유형별 정보를 가지고온다.
	ExamPaperOptionBean[] rst2 = null;
	
	try {
		rst2 = ExamPaperOption.getBeans(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	// 단원별 정보를 가지고온다.
	ExamPaperOptionBean[] rst3 = null;
	
	try {
		rst3 = ExamPaperOption.getBeans2(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<HTML>
 <HEAD>
  <TITLE> 시험 출제옵션 </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
 <link rel="StyleSheet" href="../../css/style.css" type="text/css">

 <script language="JavaScript" type="text/javascript">
    <!--
    function SetScrollPos_Sample(tagDIV)
    {
        var positionTop = 0;
        if (tagDIV != null)
        {
            positionTop = parseInt(tagDIV.scrollTop, 10);
            document.getElementById("SAMPLE_TABLE").style.top = positionTop;
        }
    }

	function guide_write() {
		window.open("paper_guide_write.jsp?id_exam=<%=id_exam%>","guide_write","width=350, height=250, scrollbars=no");
	}

	function guide_view(nr_q) {
		window.open("paper_guide_view.jsp?id_exam=<%=id_exam%>&nr_q="+nr_q,"guide_view","width=350, height=250, scrollbars=no");
	}

	//-->

</script>

 </HEAD>

<BODY id="popup2">
   
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">시험 출제 옵션 및 출제현황 확인</div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		
		<div class="subtitle">시험 출제 옵션</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableD" width="100%">
			<tr>
				<td id="left" width="20%"><li>시험명</td>
				<td width="37%"><%=rst.getTitle()%></td>
				<td id="left" width="23%"><li>시험코드</td>
				<td width="20%"><%=rst.getId_exam()%></td>
			</tr>
			<tr>
				<td id="left"><li>전체 문항수</td>
				<td><%=rst.getQcount()%> 문항</td>
				<td id="left"><li>1페이지당 문항수</td>
				<td><%=rst.getQcntperpage()%> 문항</td>
			</tr>
			<tr>
				<td id="left"><li>총점</td>
				<td><%=rst.getAllotting()%> 점</td>
				<td id="left"><li>제한시간</td>
				<td><%=rst.getLimittime()/60%> 분</td>
			</tr>
			<tr>
				<td id="left"><li>문제출제유형</td>
				<td><%=randomtype%></td>
				<td id="left"><li>시험지 갯수</td>
				<td><%=papercnt%> 개</td>
			</tr>
			
		</table>
			
		<br>

		<div class="subtitle">문제유형별 출제 현황</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%">
			<tr id="tr">
				<td width='33%'>문제유형</td>
				<td width='33%'>문제수</td>
				<td>배점</td>
			</tr>
			<% 
				if(rst2 == null) {
			%>
			<tr height="45">
				<td class="blank" colspan="3">시험지 생성후 확인가능합니다.</td>
			</tr>
			<%
				} else {
					for(int i=0; i<rst2.length; i++) { 
			%>
			<tr id="td" align="center">
				<td><%=rst2[i].getId_qtype()%></td>
				<td><%=rst2[i].getQtype_cnt()%> 문항</td>
				<td><%=rst2[i].getAllotting2()%> 점</td>
			</tr>
			<% 
					} 
				}
			%>
		</table>
	
		<div class="subtitle">단원별 출제 현황</div>
		<TABLE border="0" cellpadding="0" cellspacing="0" id="tableA" width="100%">
			
			<tr id="tr">
				<td width='25%'>단원</td>
				<td width='25%'>문제유형</td>
				<td width='25%'>문제수</td>
				<td width='25%'>배점</td>
			</tr>
			<% 
				if(rst3 == null) {
			%>
			<tr height="45">
				<td class="blank" colspan="4">만들어진 시험지가 없거나 출제된 문항들이 단원이 없는 문제 입니다.</td>
			</tr>
				<%
					} else {
						for(int i=0; i<rst3.length; i++) { 
				%>
			<tr id="td" align="center">
				<td><%=rst3[i].getChapter()%></td>
				<td><%=rst3[i].getId_qtype2()%></td>
				<td><%=rst3[i].getQtype_cnt2()%> 문항</td>
				<td><%=rst3[i].getAllotting3()%> 점</td>
			</tr>
			<% 
					} 
				}
			%>
		</table>
	</div>

	<div id="button">
		<img src="../../images/bt5_exit_yj1_11.gif" onclick="javascript:window.close();" onfocus="this.blur();" style="cursor: hand;">
	</div>

	</form>

</BODY>
</HTML>
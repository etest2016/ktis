<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	//페이징 처리
	String sPg = request.getParameter("Page");
	if (sPg == null || sPg == "" || sPg == "0") {
		sPg = "1";
	}
	int iPage = Integer.parseInt(sPg);

	int TotRecord = 0;
	int TotPage = 0;
	int pgSize = 10;
	int segment = 0;

	Score_EquallistBean3 mBean = null;

	try {
		mBean = Score_Equallist.getQ(id_exam, Integer.parseInt(id_q));
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());

		if(true) return;
	}

	double allotting = mBean.getAllotting();
	String q = mBean.getQ();

	q = q.replace("<BR>", "");
	q = q.replace("</BR>", "");
	q = q.replace("<P>", "");
	q = q.replace("</P>", "");

	try {
		TotRecord = Score_Equallist.getResultCount(id_exam, Integer.parseInt(id_q), "Y");
		segment = TotRecord % pgSize;
		if (segment > 0) {
			TotPage = (TotRecord - segment) / pgSize + 1;
		} else {
			TotPage = TotRecord / pgSize;
		}
	} catch(Exception ex) {
		out.println("getCount" + ex.getMessage());
		if(true) return;
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
	}

%>

<html>
<head>
<title>모사 답안 실행결과</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.etest.poster.js"></script>
<script language="JavaScript">
	function equal_cancel(userid) {
		var st = confirm("모사로 판정 된 답안에 대해 모사 판정을 취소하시겠습니까?" );
		if (st == true) {
			document.location = "equal_ans_back.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+userid;			
	    } 
	}

	function equal_ans_comp(userid2) {
		var equalansComp;
		equalansComp = $.posterPopup("exam_ans_non_frm2.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>&userid="+userid2, "compwin", "menubar=no, scrollbars=yes, width=1000, height=700, top=0, left=0");
		equalansComp.focus();
	}

</script>
</head>


<BODY Style="margin:0px;">

	<!-- 타이틀 디자인 -->
	<div style="width: 100%; height: 70px; background-image: url(../images/bg_mark_top.gif); text-align: right;"><img src="../images/bt_re.gif" onclick="location.href='ans_equal_result.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>';" style="cursor: pointer;"><img src="../images/bt_out.gif" style="cursor: pointer;" onclick="javascript:window.close();"></div>
	<!-- 단답형 문제 웹채점 -->
	<div style="width: 100%; margin: 0px 30px 10px 30px;">
		<!--img src="../images/title_ad_webscore4.gif"-->
	</div>

	
	<table border="0" width="100%" cellpadding="5">
		<tr>
			<td align="center" style="padding-left: 30px; padding-right: 30px;">

				<div class="title">논술형 문제 정보</div>

				
			
				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="TableD">
					<tr height="30">    
						<td width="15%" align="center" id="left"><B>문제번호</B></td>  
						<td bgcolor="#FFFFFF">&nbsp;<%=id_q%></td>
						<td width="15%" align="center" id="left"><B>배점</B></td> 
						<td bgcolor="#FFFFFF">&nbsp;<%=allotting%> 점</td>	
					</tr>

					<tr height="30">    
						<td width="15%" align="center" id="left"><B>문제</B></td>  
						<td height="30" bgcolor="#FFFFFF" colspan="3">&nbsp;<%=q%></td>
					</tr>
				</table>

				<%
					Score_EqualUserBean[] rst = null;

					try {
						rst = Score_Equallist.getResult2(id_exam, Integer.parseInt(id_q), iPage, pgSize);
					} catch(Exception ex) {
						//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
						out.println(ex.getMessage());

						if(true) return;
					}
				%>

				<hr size="1" width="90%" bgcolor="#FFFFFF">

				<div class="title">모사답안 비교 결과 리스트</div>

				<table border='0' width='100%'>
					<tr>	
						<td align="left">
							<div style="float: left; padding-top: 3px;">
							총 <font color='red'><b><%=TotRecord%></b></font> 명&nbsp;&nbsp;&nbsp;</div>
							<div style="float: left;"><a href="ans_equal_result.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>"><img src="../images/bt8_f.gif"></a></div>
						</td>			
					</tr>
				</table>

				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="TableD">
					<tr align="center" bgcolor='#95DB95' height="30" id="tr">    	
						<td width="5%"><B>NO</B></td>
						<td width="20%"><B>응시자</B></td>
						<td ><B>모사답안 판정사유</B></td>    	
						<td width="10%"><B>점수</B></td>    
						<td width="15%"><B>모사취소</B></td>    
					</tr>
	 
					<%
						if (rst == null) {
					%>

					<tr bgcolor="#FFFFFF">
						<td colspan="5" class="blank" height="100">모사답안으로 판정된 답안 응시자가 없습니다.</td>
					</tr>	

					<%
						} else {
							int i = 0;
							int newno = TotRecord;
							newno = newno - (pgSize * (iPage-1));

							for(i=0; i<rst.length; i++) {
					%>

					<tr align="center" bgcolor='#FFFFFF' height="30">    
						<td><%=newno%></td>
						<td ><a href="javascript:" onClick="equal_ans_comp('<%= rst[i].getO_userid() %>')"><%= rst[i].getO_userid() %></a></td>
						<td height="30">
							<table border='0' cellspacing='1' cellpadding='3' width='95%' bgcolor='#EEEEEE'>
								<tr>
									<td bgcolor='#FFFFFF'><%= rst[i].getEqual_reason() %></td>
								</tr>
							</table>
						</td>    
						<td><%= rst[i].getScore() %> 점</td>    
						<td ><a href="equal_ans_back.jsp?id_exam=<%= id_exam %>&id_q=<%= id_q %>&userid=<%= rst[i].getO_userid() %>">취소하기</a></td>    
					</tr>

					<tr bgcolor="#DBDBDB">
						<td colspan="5"></td>
					</tr>	
	<%
				newno--;
			}
		}
	%>

				</table>


				<!-- 페이징 처리 부분... -->
				<table width="90%" cellpadding="2" cellspacing="0" border="0" style="margin-top: 10px;">
					<tr>
						<td colspan='6' height="10" align="right">
						<font color='red'><b><%= iPage %></b></font> / <b><%=TotPage%></b> page&nbsp;&nbsp;&nbsp;
						 <!-- 페이징 처리하는 부분-->
						<%

							int GSize = 10;
							int PreGNum = (iPage - 1) / GSize;
							int EndPNum = PreGNum * GSize;
							int k = 0;
							String Tar = "";
							
							Tar = "Page=" + EndPNum;
							Tar = Tar + "&id_exam=" + id_exam;
							Tar = Tar + "&id_q=" + id_q;

							//이전그룹시작---------------
							//이전그룹이 있다면 출력한다
							if (EndPNum > 0){

						%>
							[<a href="ans_equal_result2.jsp?<%=Tar%>">이 전</a>]
						<% 
							}
							//이전그룹 끝---------------

							//현재그룹시작---------------
							//현재그룹을 출력한다 (Gsize만큼)

							int LCount = GSize;
							int intI = EndPNum + 1;

							//for (int i=0; i<=TotPage; i++) {
							for (intI=EndPNum + 1; intI<=TotPage; intI++) {
								Tar = "";
								Tar = Tar + "Page=" + intI;
								Tar = Tar + "&id_exam=" + id_exam;
								Tar = Tar + "&id_q=" + id_q;
							
						%>
							[<a href="ans_equal_result2.jsp?<%=Tar%>"><%=intI%></a>]
						<%
								LCount = LCount -1;
								if (LCount == 0) {
									break;
								}

							}

							//현재그룹 끝--------------- 

							//다음그룹시작---------------
							intI = EndPNum + (GSize + 1);
							
							Tar = "";
							Tar = Tar + "Page=" + intI;
							Tar = Tar + "&id_exam=" + id_exam;
							Tar = Tar + "&id_q=" + id_q;

							//다음그룹이 있다면 출력한다
							if (intI <= TotPage ) {
							
						%>
							[<a href="ans_equal_result2.jsp?<%=Tar%>">다음</a>]
						<% 
							//다음그룹 끝---------------
							
							}

						%>
						</td>
					</tr> 
				</table>
			</td>
		</tr>
	</table>
	
</body>
</html>
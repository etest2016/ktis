<%
//******************************************************************************
//   프로그램 : ans_mark_dan2.jsp
//   모 듈 명 : 단답형 수동채점
//   설    명 : 단답형 수동채점(채점완료자 리스트)
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.AnswerMark, qmtm.tman.answer.AnswerMarkBean
//   작 성 일 : 2008-06-05
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

    int i_tot_cnt  = 0;

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }
	
	if (id_exam.length() == 0 || id_q.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	AnswerMarkDanBean[] beans = null;

	try {
		beans = AnswerMarkDan.getBeans(id_exam, Long.parseLong(id_q));
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if(beans == null || beans.length == 0) {
		i_tot_cnt = 0;
	} else {
		i_tot_cnt = beans.length;
	}

	if (i_tot_cnt < 1) {
           out.println("<script>");
           out.println("alert('채점이 되지 않았습니다. 채점 처리를 하여야 수동채점이 가능 합니다.');");
           out.println("window.close();");
           out.println("</script>");
		   out.flush();
    } else {
		String strQuestion = beans[0].getQ();
        String strCa = beans[0].getCa();
        double lngAllotting = beans[0].getAllotting();

       	String[] ArrUserid = new String[i_tot_cnt];
        String[] ArrAnswer = new String[i_tot_cnt];
		//String[] ArrName = new String[i_tot_cnt];
		String[] tmpOX = new String[i_tot_cnt];
		String[] pointsTmp = new String[i_tot_cnt];
		String[] tmpAns = new String[i_tot_cnt];
		String strTemp = "";
		int qindex = 0;
		String YN_Points;
		String tmpPoints;

	    //시험지 마다 같은 문제의 배점을 달리 할 수 있으므로 배점을 가지고 다녀야 한다
	    //현재는 고려하지 않도록 코딩한다
	    Double[] ArrAllotting = new Double[i_tot_cnt];

		for (int i = 0; i < i_tot_cnt; i++) {

			if(beans[i].getOxs() == null || beans[i].getOxs().equals("")) {
				out.println("<br>&nbsp;&nbsp;&nbsp;&nbsp;<b><font color=blue>" + beans[i].getUserid() + ") 응시자가 채점이 되지 않았습니다. 채점 처리를 하여야 수동채점이 가능 합니다</font></b>");
		        ArrUserid[i] = "";
	        } else{
			      qindex = beans[i].getNr_q()-1;
			      tmpOX = beans[i].getOxs().split(QmTm.Q_GUBUN_re,-1);
				  YN_Points = "N";
			      tmpPoints = beans[i].getPoints();
		   
			      if(tmpPoints != null) {
					  pointsTmp = tmpPoints.split(QmTm.Q_GUBUN_re,-1);
		   
					  if(!pointsTmp[qindex].equals("")) {
						  YN_Points = "Y";
					  }			
				  }

				  if(YN_Points == "N") {
					  ArrUserid[i] = "";
				  } else {
					  ArrUserid[i] = beans[i].getUserid();   

					  if(beans[i].getAnswers()!= "") {
						 tmpAns = beans[i].getAnswers().split(QmTm.Q_GUBUN_re, -1);
						 ArrAnswer[i] = tmpAns[qindex];
					  } else {
						 ArrAnswer[i] = "";
					  }

					//ArrName[i] = ComLib.nullChk(rcvset.getString(nacf_fdl.STR109,i));
				    //ArrAllotting[i] = Double.parseDouble(ComLib.nullChk(rcvset.getString(nacf_fdl.STR102,i)));
				 }			
			}                	    	
		} // for 문 종료
%>

<html>
<head>
<title> :: 단답형문제 채점 :: </title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<script language="javascript">
	function ftnscore() {
		var resultwin;
		var flag = "N";
		
		if (document.frmData.allscore.value == "") {
			alert("점수를 입력하지 않았습니다");
			document.frmData.allscore.focus();
			return;
		}

		if (document.frmData.selectid.length) {
			for (i=0; i <= document.frmData.selectid.length -1; i++) {
				if (document.frmData.selectid[i].checked == true) {
					flag = "Y";
					break;
				}
			}
			
			if (flag == "N") {
				alert("선택된 응시자가 없습니다");
				return;
			}
		}
		else {
			if (document.frmData.selectid.checked == false) {
				alert("선택된 응시자가 없습니다");
				return;
			}
		}

		if (document.frmData.allscore.value > <%= lngAllotting %>) {
			alert("문제의 배점은 " + <%= lngAllotting %> + "점 입니다\n배점보다 점수를 높게 입력할 수 없습니다");
			return;
		}
		
		if (confirm("선택한 응시자에게 점수를 주시겠습니까?") == true) {
			resultwin = window.open("", "markresult", "width=300, height=200, scrollbars=no,resizable=yes");
			resultwin.focus();
			
			document.frmData.target = "markresult";
			document.frmData.action = "ans_mark_dan_ok.jsp";
			document.frmData.submit();
		}
	}
</script>
</head>

<body>



	<table width="70%" cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
			<td colspan="2" align="right" height="40px;" valign="top"><img src="../../images/bt2_close.gif" style="cursor: pointer;" onclick="window.close();"></td>
		</tr>
		<tr>
			<td colspan="2" class="f1">■ 단답형 채점확인 및 수정</td>
			<!--<td align="right"><b><a href="profq1.htm" target="_self"><font color="03601F">문제목록으로 돌아가기→</font></a></b></td>-->
		</tr>
		<tr>
			<td colspan="2" valign="top">

				<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" id="tableD" style="margin-top: 5px; margin-bottom: 20px;">
					<tr> 
						<td id="left" width="12%"><li>문제코드</td>
						<td width="14%"><%= id_q %></td>
						<td id="left" width="12%"><li>정답</td>
						<td width="40%">
							"☞" <%= strCa.replaceAll(QmTm.LIKE_GUBUN_re, " 또는 ").replaceAll(QmTm.OR_GUBUN_re, " , ") %>
						</td>
						<td id="left"  width="12%"><li>배점</td>
						<td width="10%"><font color="red"><b><%= lngAllotting %></b></font> 점</td>
					</tr>
					<tr> 
						<td id="left"><li>문제</td>
						<td colspan="5"><%= strQuestion %></td>
					</tr>
					
					
				</table>

			</td>
		</tr>
		<tr>
			<td class="f1">
				▣ 채점 완료자 리스트
			</td>
			<td align="right">
				<font color="blue"><b><a href="ans_mark_dan.jsp?id_exam=<%= id_exam %>&id_q=<%= id_q %>" onFocus="this.blur()">[미 채점자 리스트로 이동]</a></b></font>
			</td>
		</tr>
	
		<tr>
			<td colspan="2">

				<form name="frmData" method="post">
				<input type="hidden" name="id_exam" value="<%= id_exam %>">
				<input type="hidden" name="id_q" value="<%= id_q %>">

				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tableA" style="margin-top: 5px;">
					<tr id="sub_title">
						<td colspan="4">
							* 선택한 응시자 점수주기 : <input type="text" class="input" name="allscore" maxlength="5" size="4" style="text-align:right">점 <input type="image" value="확인" name="button" onclick="javascript:ftnscore();" src="../../images/bt_get_statics1_yj1.gif" align="absmiddle">
							<!--<b><font color="004FA0">☞ 전체목록으로 보기</font></b>-->
						</td>
					</tr>
					<tr id="tr" align="center">
						<td width="50"><b>선택</b></td>
						<td width="100"><b>아이디</b></td>
						<td width="100"><b>점수</b></td>
						<td width="*" bgcolor="#EEEEEE"><b>제출한 답</b></td>
					</tr>

					<% 
						int i = 0;
						for (int a = 0; a < ArrUserid.length; a++) {
							if(ArrUserid[a] != "") {
								i = i + 1;
								int nr_q = beans[a].getNr_q();
								String answers = beans[a].getAnswers();
								String points = beans[a].getPoints();        

								String[] ArrAnswers = answers.split(QmTm.Q_GUBUN_re, -1);      
								String[] ArrPoints = points.split(QmTm.Q_GUBUN_re, -1); 
					%>
						<tr id="td2" align="center" <% if(i%2==0){%>bgcolor="#fafafa"<%}%>> 
						  <td width="50"><input type="checkbox" name="selectid" value="<%= ArrUserid[a] %>"></td>
						  <td width="100">&nbsp;<%= ArrUserid[a] %>&nbsp;</td>
						  <td width="100">&nbsp;<%= ArrPoints[nr_q-1] %>&nbsp;</td>
						  <td width="*">&nbsp;<%= ArrAnswers[nr_q-1]%>&nbsp;</td>
						</tr>
					<% 
							}
						}
					%>
				</table>

				</form>

			</td>
		</tr>		
	</table>  
</body>
</html>

<%
    } 
%>
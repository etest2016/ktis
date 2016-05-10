<%
//******************************************************************************
//   프로그램 : ans_insert_operate_html.jsp
//   모 듈 명 : 답안지 추가 HTML 저장
//   설    명 : 답안지 추가 HTML 저장
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamUtil
//   작 성 일 : 2008-06-19
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	response.setHeader("Content-Disposition", "attachment; filename=ExamPaperAdd.htm"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String yn_end = request.getParameter("yn_end");
	if (yn_end == null) { yn_end = ""; } else { yn_end = yn_end.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0 || yn_end.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }

	ExamInfoBean info = null;
	
	try {
		info = ExamInfo.getBean(id_exam);
	}
    catch (Exception ex) {
        out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	String title = info.getTitle();
	double totalAllot = info.getAllotting();
	int qcount = info.getQcount();

	// 시험정보를 읽어온다.
	ExamPaperBean[] qs = null;

	try {
		qs = ExamPaper.getBeans(id_exam, Integer.parseInt(nr_set));
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if (qs == null) {
%>
	<script language="JavaScript">
		alert("해당하는 문제정보가 없습니다");
	</script>
<%
		if(true) return;
	}
	if (qs.length != qcount) {
%>
	<script language="JavaScript">
		alert("시험정보의 문제수와 문제지의 문제수가 다릅니다");
	</script>
<%
		if(true) return;
	}

	String[] arrExlabel = info.getExlabel().split(",");
%>

<%
	// 문제별 표시를 위한 데이터

	int[] arrId_qtype = new int[qcount];
	long[] arrId_q = new long[qcount];
	String[] arrDifficulty1 = new String[qcount];

	int[] arrQuestionNo = new int[qcount];     // 문제번호
	String[] arrQuestion = new String[qcount]; // 문제내용
	String[] arrOPX_img = new String[qcount];  // 문제번호의 배경이미지 (OX 관련)

	boolean[] arrHasEx = new boolean[qcount];  // 보기유무
	int[] arrExcount = new int[qcount];        // 보기 개수
	String[][] arrEx = new String[qcount][5];  // 보기라벨 + 보기내용

	double[] arrAllot = new double[qcount];    // 배점
	String[] arrCA = new String[qcount];       // 정답표시
	
	String[] arrExplain = new String[qcount];      // 해설

	String[] arrQtype = new String[qcount]; // 문제유형

	String[] ex_order = new String[qcount];

	int[] arrCacount = new int[qcount]; // 정답 갯수

	String[] arrYn_caorder = new String[qcount];
	String[] arrYn_case = new String[qcount];
	String[] arrYn_blank = new String[qcount];

	// 초기화
	String strChk = "";

	// looping

	for (int i = 0; i < qcount; i++)
	{
		arrId_qtype[i] = qs[i].getId_qtype();
	    int id_valid_type = qs[i].getId_valid_type();
	    arrCacount[i] = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		String correctAnswer = qs[i].getCa();

		arrYn_caorder[i] = qs[i].getYn_caorder();
		arrYn_case[i] = qs[i].getYn_case();
		arrYn_blank[i] = qs[i].getYn_blank();

		arrId_q[i] = qs[i].getId_q();
		ex_order[i] = qs[i].getEx_order();

		if(arrId_qtype[i] == 1) {
			arrQtype[i] = "OX형";
		} else if(arrId_qtype[i] == 2) {
			arrQtype[i] = "선다형";
		} else if(arrId_qtype[i] == 3) {
			arrQtype[i] = "복수 답안형";
		} else if(arrId_qtype[i] == 4) {
			arrQtype[i] = "단답형";
		} else if(arrId_qtype[i] == 5) {
			arrQtype[i] = "논술형";
		}
		
		if (qs[i].getId_difficulty1() == 0) {
			arrDifficulty1[i] = "없음";
		} else if (qs[i].getId_difficulty1() == 1) {
			arrDifficulty1[i] = "최상";
		} else if (qs[i].getId_difficulty1() == 2) {
			arrDifficulty1[i] = "상";
		} else if (qs[i].getId_difficulty1() == 3) {
			arrDifficulty1[i] = "중";
		} else if (qs[i].getId_difficulty1() == 4) {
			arrDifficulty1[i] = "하";
		} else if (qs[i].getId_difficulty1() == 5) {
			arrDifficulty1[i] = "최하";
		} 

		arrCA[i] = ExamPaper.getAnswerDisplay(id_valid_type, arrId_qtype[i], arrCacount[i], arrEx_order, correctAnswer, arrExlabel);

		if (arrId_qtype[i] == 5) {
			arrCA[i] = "";
		}

	  // 문제표시
	  arrQuestionNo[i] = qs[i].getNr_q();
	  arrQuestion[i] = qs[i].getQ();

	  // 보기표시
	  if (arrId_qtype[i] <= 3) {
		arrHasEx[i] = true;
	  } else {
		arrHasEx[i] = false;
	  }
	  arrExcount[i] = qs[i].getExcount();
	  for (int j = 0; j < arrExcount[i]; j++) {
		arrEx[i][j] = arrExlabel[j] + " " + QmTm.delTag(qs[i].getArrEx()[j]);
	  }

	  // 배점
	  arrAllot[i] = qs[i].getAllotting();

	  // 해설관련
	  if (qs[i].getExplain().length() > 0) {
		arrExplain[i] = qs[i].getExplain();
	  } else {
		arrExplain[i] = "";
	  }
	}
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

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
	
    //-->
</script>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<BODY id="tman">


<table border="0" width="950" >
	<tr height="20">
		<td align="left">&nbsp;* 시험명 : <%=title%></td>
	</tr>
	<tr height="20">
		<td align="left">&nbsp;* 시험지 번호 : <%=nr_set%></td>
	</tr>
	<tr height="20">
		<td align="left">&nbsp;* 문제수 : <%=qcount%> 문제</td>
	</tr>
	<tr height="20">
		<td align="left">&nbsp;* 배점 : <%=totalAllot%> 점</td>
	</tr>
</table>

<div id="SAMPLE_DIV" style="width: 950px; height: 500px; overflow-y: auto;" onScroll="SetScrollPos_Sample(this);">

<table cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" id="SAMPLE_TABLE" border=0 style="position: absolute; left: 0px; top: 0px; z-index: 0;" width='950'>
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" width="5%">번호</td>
		<td align="center" width="23%">정답</td>
		<td align="center" width="26%">답안</td>
		<td align="center" width="5%">문제</td>
		<td align="center" width="10%">문제유형</td>
		<td align="center" width="8%">난이도</td>
		<td align="center" width="8%">문제코드</td>
		<td align="center" width="10%">보기배열</td>
		<td align="center" width="5%">배점</td>
	</tr>
</table>

<table cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" border=0 width='950'>
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" width="5%">번호</td>
		<td align="center" width="23%">정답</td>
		<td align="center" width="26%">답안</td>
		<td align="center" width="5%">문제</td>
		<td align="center" width="10%">문제유형</td>
		<td align="center" width="8%">난이도</td>
		<td align="center" width="8%">문제코드</td>
		<td align="center" width="10%">보기배열</td>
		<td align="center" width="5%">배점</td>
	</tr>

	<% for(int i = 0; i < qcount; i++) { %>
	<tr bgcolor="#FFFFFF">
		<td align="center"><%=arrQuestionNo[i]%></td>
		<td valign="top">
		<%
			strChk = "";
			if(arrId_qtype[i] <= 3) {
				for (int j = 0; j < arrExcount[i]; j++) {
					if(arrCacount[i] > 1) {
						for(int k = 0; k < arrCacount[i]; k++) {
							if(arrCA[i].substring(k,k+1).equals(arrExlabel[j])) {
								strChk = "checked";
							}
						}
		%>
			<input type="checkbox" <%=strChk%> disabled>
		<%
					strChk = "";
					} else {
		%>
			<input type="radio" <% if(arrCA[i].equals(arrExlabel[j])) { %> checked <% } %> disabled >
		<%
					}
				}
			} else if(arrId_qtype[i] == 4) {
		%>
			<%= arrCA[i] %><br><br><%if(arrCacount[i] > 1) {%>* 정답순서 구별 : <%=arrYn_caorder[i]%><br><% } %>* 대소문자 구별 : <%=arrYn_case[i]%><br>* 빈칸 체크 : <%=arrYn_blank[i]%><br>
		<%
			} else if(arrId_qtype[i] == 5) {
		%>
			논술형
		<%
			} 
		%>
		</td>
		<td valign="top">
		<% 
			if(arrId_qtype[i] <= 3) {
				for (int j = 0; j < arrExcount[i]; j++) {
					if(arrCacount[i] > 1) {
						for(int k = 0; k < arrCacount[i]; k++) {
							if(arrCA[i].substring(k,k+1).equals(arrExlabel[j])) {
								strChk = "checked";
							}
						}
		%>
			<input type="checkbox" <%=strChk%> name="ans<%=i%>" value="<%=j+1%>">
		<%
					strChk = "";
					} else {
		%>
			<input type="radio" <% if(arrCA[i].equals(arrExlabel[j])) { %> checked <% } %> name="ans<%=i%>" value="<%=j+1%>">
		<%
					}
				}
			} else if(arrId_qtype[i] == 4) {
				String answer = "";
				if(arrCacount[i] == 1) {
		%>
			<input type="text" class="input" value="<%= arrCA[i] %>" name="ans<%=i%>">
		<%
				
				} else {
					answer = arrCA[i].replace("☞","");
					String[] arrCas = answer.split("<br>", -1);

					for(int k = 0; k < arrCas.length-1; k++) {
		%>
			<input type="text" class="input" value="<%= arrCas[k] %>" name="ans<%=i%>"><br>
		<%
					}
				}
			} else if(arrId_qtype[i] == 5) {
		%>
			<textarea name="ans<%=i%>" cols="10" rows="10"></textarea>
		<%
			} 
		%>
		</td>
		<td>보기</td>
		<td><%=arrQtype[i]%></td>
		<td><%=arrDifficulty1[i]%></td>
		<td><%=arrId_q[i]%></td>
		<td><%=ex_order[i]%></td>
		<td><%=arrAllot[i]%></td>
	</tr>
	<% } %>
</table>
<p>

</form>

</body>

</html>
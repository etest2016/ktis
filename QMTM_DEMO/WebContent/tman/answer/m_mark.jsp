<%@ page contentType="text/html; charset=euc-kr"  %>
<%@ page import="qmtm.*, etest.webscore.*, etest.paper.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim();}

	int nr_q_update;
	try { nr_q_update = Integer.parseInt(request.getParameter("nr_q_update")); }
	catch (Exception ex) { nr_q_update = -9; }

	double allot_update;
	try { allot_update = Double.parseDouble(request.getParameter("allot_update")); }
	catch (Exception ex) { allot_update = -9; }

	double point_update;
	try { point_update = Double.parseDouble(request.getParameter("point_update")); }
	catch (Exception ex) { point_update = -9.0; }

	String yn_mark = request.getParameter("yn_mark");
	if (yn_mark == null) { yn_mark = ""; } else { yn_mark = yn_mark.trim(); }

	int ndx;
	try { ndx = Integer.parseInt(request.getParameter("ndx")); }
	catch (Exception ex) { ndx = 0; }

	if (id_exam.length() == 0) {
	  response.sendRedirect("m_info.jsp"); // 채점대상자를 선택하지 않은 상태
	}
%>
<%
	// from tables
	User_ExamInfoBean info = null;
	try {
	  info = User_ExamInfo.getBean(id_exam);
	}
	catch (Exception ex) {
	  out.println(ComLib.getExceptionMsg(ex, "back"));

	  if(true) return;
	}
	if (info == null) {
%>
		<Script language="JavaScript">
			alert("시험지 정보가 없습니다.");		
		</Script>
<%
	  if(true) return;
	}

	int all_qcount = info.getQcount();

	// from exam_ans table
	User_ExamAnsBean ans = null;
	try {
	  ans = User_ExamAns.getBean(userid, id_exam);
	}
	catch (Exception ex) {
	  out.println(ComLib.getExceptionMsg(ex, "back"));

	  if(true) return;
	}
	if (ans == null) {
%>
		<Script language="JavaScript">
			alert("시험에 응시하지 않았습니다.");		
		</Script>
<%
	  if(true) return;
	}

	// 단답형 문항중 자동채점으로 맞은 문제는 제외한다.
	String imsi_oxs = ans.getOxs();
	String imsi_points = ans.getPoints();

	if(imsi_oxs == null || imsi_oxs.equals("")) {
%>
		<Script language="JavaScript">
			alert("응시자 채점이 진행되지 않았습니다.\n\n수동채점을 하시기전에 답안지관리에서\n\n일괄채점 클릭하신후 선택한 응시자만 채점\n\n또는 모든 응시자 채점을 진행하셔야만\n\n수동채점을 진행하실 수 있습니다.");		
		</Script>
<%
	  if(true) return;
	}

	if(imsi_points == null || imsi_points.equals("")) {
		for (int i = 0; i < all_qcount; i++) {
			imsi_points = imsi_points + "{:}";
		}

		imsi_points = imsi_points.substring(0, imsi_points.length()-3);
	} 

	String[] arrImsiOxs = new String[all_qcount];

	if (imsi_oxs.length() > all_qcount) {
	  arrImsiOxs = imsi_oxs.split(QmTm.Q_GUBUN_re, -1);
	} else {
	  for (int i = 0; i < arrImsiOxs.length; i++) {
		arrImsiOxs[i] = "";
	  }
	}

	String[] arrImsiPoint = new String[all_qcount];

	if (imsi_points.length() > all_qcount) {
	  arrImsiPoint = imsi_points.split(QmTm.Q_GUBUN_re, -1);
	} else {
	  for (int i = 0; i < arrImsiPoint.length; i++) {
		arrImsiPoint[i] = "";
	  }
	}

	String sqlCorrect = "";
	for(int i = 0; i < all_qcount; i++) {
		if(arrImsiOxs[i].equals("O") && arrImsiPoint[i].equals("")) {
			sqlCorrect = sqlCorrect + "," + String.valueOf(i+1);
		}
	}

	if(!sqlCorrect.equals("")) {
		sqlCorrect = " and a.nr_q not in (" + sqlCorrect.substring(1,sqlCorrect.length()) + ") ";
	}

	// from exam_paper2 table etc. 문제세트
	User_ExamPaper2Bean[] qs = null;
	try {
	  qs = User_ExamPaper2.getBeansCorrect45(ans.getId_exam(), ans.getNr_set(), ans.getUserid(), sqlCorrect);
	}
	catch (Exception ex) {
	  out.println(ComLib.getExceptionMsg(ex, "back"));

	  if(true) return;
	}
	if (qs == null) {
%>
		<Script language="JavaScript">
			alert("단답형/논술형 문제가 없거나 수동채점할 문항이 없습니다.");		
		</Script>
<%
	  if(true) return;
	}

	// 채점결과 저장
	if (nr_q_update > 0 && allot_update >= 0 && point_update >= 0) {

	  try {
		// 저장
		User_AnswerMark.saveMarkedPoint(nr_q_update, point_update, allot_update, yn_mark, all_qcount, ans);
		// 저장된 결과를 다시 갖고 온다.
		try {
		  ans = User_ExamAns.getBean(userid, id_exam);
		}
		catch (Exception ex) {
		  out.println(ComLib.getExceptionMsg(ex, "back"));

		  if(true) return;
		}
	  }
	  catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	  }
	}
	else if (nr_q_update > 0 && allot_update >= 0 && yn_mark.equalsIgnoreCase("Y")) {

	  ans.setYn_mark("Y");

	  try {
		User_ExamAns.update(ans);
	  }
	  catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	  }
	}
%>
<%
	// prepare data to display

	int qcount = qs.length;
	String title = info.getTitle();
	int nr_q = qs[ndx].getNr_q();
	long id_q = qs[ndx].getId_q();
	double allot = qs[ndx].getAllotting();
	boolean hasRef = false; if (qs[ndx].getQ_no1() != 0) { hasRef = true; }
	String reftitle = qs[ndx].getReftitle();
	String refbody = qs[ndx].getRefbody();
	String q = qs[ndx].getQ();

	int id_valid_type = qs[ndx].getId_valid_type();
	int id_qtype = qs[ndx].getId_qtype();
	int cacount = qs[ndx].getCacount();
	String ca = qs[ndx].getCa();
	String caDisp = User_AnswerMark.getAnswerDisplay(id_valid_type, id_qtype, cacount, ca);

	String answer = ans.getAnswers();
	String[] arrAns = answer.split(QmTm.Q_GUBUN_re, -1);
	String ua;
	if (id_qtype <= 4) {
	  ua = arrAns[nr_q - 1];
	} else { // 5:논술형
	  ua = qs[ndx].getUserans();
	}

	String uaDisp = User_AnswerMark.getAnswerDisplay(9, id_qtype, cacount, ua);

	int[] arrNr_q = new int[qcount];
	double[] arrAllot = new double[qcount];
	for (int i = 0; i < qcount; i++) {
	  arrNr_q[i] = qs[i].getNr_q();
	  arrAllot[i] = qs[i].getAllotting();
	}

	String points = ans.getPoints();

	if(points == null || points.equals("")) {
		for (int i = 0; i < all_qcount; i++) {
			points = points + "{:}";
		}

		points = points.substring(0, points.length()-3);
	} 

	String[] arrPoint = new String[qcount];
	if (points.length() > qcount) {
	  arrPoint = points.split(QmTm.Q_GUBUN_re, -1);
	} else {
	  for (int i = 0; i < arrPoint.length; i++) {
		arrPoint[i] = "";
	  }
	}
	String now_point = arrPoint[arrNr_q[ndx] - 1];
	String[] arrColor = new String[qcount];
	for (int i = 0; i < arrColor.length; i++) {
	  if (i == ndx) arrColor[i] = "#e4f5fc";
	  else arrColor[i] = "#FFFFFF";
	}
%>

<html>
<head>
<title>응시자별 채점</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Pragma" content="no-cache">
<meta name="AUTHOR" content="CheongJH">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">

function init()
{
  if ("<%= yn_mark %>" == "Y") {
    if (parent.fraLeft.count > 1) {
      parent.fraLeft.tdMark[parent.fraLeft.index].innerHTML = "<font color='red'>완&nbsp;&nbsp;료</font>";
    } else {
      parent.fraLeft.tdMark.innerHTML = "<font color='red'>완&nbsp;&nbsp;료</font>";
    }
    alert("[<%= userid %>] : 채점이 완료되었습니다.\n\n좌측 목록에서 다음 채점대상자를 선택하세요 !!! ");
  }
}

function doCorrect()
{
  new_point.value = "<%= allot %>";
  move(<%= ndx %> + 1);
}

function doInCorrect()
{
  new_point.value = "0.0";
  move(<%= ndx %> + 1);
}

function doManual()
{
  move(<%= ndx %> + 1);
}

function move(move_to_ndx)
{
  var frm = document.frmData;
  frm.ndx.value = move_to_ndx;
  frm.point_update.value = "";

  if (new_point.value != "") {
    if (!checkPoint()) {
      return;
    }
    frm.point_update.value = new_point.value;
  }

  if (move_to_ndx >= (<%= qcount %> - 1)) {
    frm.ndx.value = <%= qcount %> - 1;
  }

  frm.action = "m_mark.jsp";
  frm.submit();
}

function checkPoint()
{
  var point = parseFloat(new_point.value);
  if (isNaN(point) || (point < 0 || point > <%= allot %>)) {
    alert("점수는 0 이상 <%= allot %> 이하로 입력하셔야 합니다");
    new_point.focus();
    new_point.select();
    return false;
  }
  new_point.value = point;
  return true;
}

function mark() {
  var frm = document.frmData;
  frm.yn_mark.value = "Y";
  move(<%= ndx %>);
}

</script>

</head>

<body onload="init()" leftmargin="0" topmargin="0" marginwidth="0" topmargin="20">

	<form name="frmData" method="post">

	<input type="hidden" name="id_exam" value="<%= id_exam %>">
	<input type="hidden" name="userid" value="<%= userid %>">
	<input type="hidden" name="nr_q_update" value="<%= nr_q %>"><!-- nr_q to update -->
	<input type="hidden" name="allot_update" value="<%= allot %>"><!-- allot to update -->

	<input type="hidden" name="point_update" value=""><!-- point to update -->
	<input type="hidden" name="yn_mark" value="N"><!-- Y:채점완료, N:채점미완료 -->
	<input type="hidden" name="ndx" value=""><!-- index of next display -->

	</form>
	
	<img src="../../images/sub2_webscore1.gif">
	<div class="box">

		[평가명] <span class="point_b"><%= title %></span> <br>
		[응시생] <span class="point_b"><%= userid %></span><br>
		[문제번호 <span class="point_b"><%= nr_q %></span> /  문제코드 <span class="point_b"><%= id_q %></span>] 
		<% if (hasRef) { /* 지문이 있으면 */ %>
		※ <%= reftitle %><br>
		<%= refbody %><br>
		<% } %>
		<%= q %>&nbsp;[배점 <%= allot %>점]<br>
		[정답] <%= caDisp %>	

	</div>
	<br>
	<TABLE width="100%" cellspacing="0" cellpadding="0" border="0">
		<TR>
			<TD valign="top">
				<!-- 응시자 답안 -->
				<img src="../../images/sub2_webscore8.gif">&nbsp;&nbsp;&nbsp;<b>[답안길이 : <%= ua.length() %>]</b><br>
				<textarea name="textarea" cols="85" rows="15" readonly style="padding: 15px 20px 15px 20px;"><%= ua %></textarea>
				<!-- 채점자 강평 -->
				<!--hr><img src="../../images/sub2_webscore9.gif"><br>
				<textarea cols="75" rows="8" name="comment" style="padding: 15px 20px 15px 20px;"></textarea-->
				<hr>
				<!-- 채점 -->
				<img src="../../images/sub2_webscore7.gif"><br>
				<div style="float: left">
					<img onclick="doCorrect()" src="../../images/bt3_true.gif" style="cursor: hand;">&nbsp;
					<img onclick="doInCorrect()" src="../../images/bt3_false.gif" style="cursor: hand;"> &nbsp;
				</div>
				<div style="float: left">
					<input type="text" class="input" name="new_point" value="<%= now_point %>" size="6" maxlength="5" onclick="this.select()" style="text-align: center;"> 점
				</div>
				<div style="float: left">
					&nbsp;<img onclick="doManual()" src="../../images/bt3_mark3.gif" style="cursor: hand;">
				</div>
			</td>
			<TD width="200" valign="top" style="padding-left: 20px;">
				<img src="../../images/sub2_webscore10.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tableD">
					<tr id="tr" align="center">
						<td>번호</td>
						<td>배점</td>
						<td>채점</td>
					</tr>
					<% for (int i = 0; i < qcount; i++) { %>
					<tr id="trData" align="center" bgcolor="<%= arrColor[i] %>">
						<td><a href="javascript: move(<%= i %>)"><u><font color="#0B66B0"><b><%= arrNr_q[i] %></b></font></u></a></td>
						<td><%= arrAllot[i] %></td>
						<td><font color="red">&nbsp;<%= arrPoint[arrNr_q[i] - 1] %>&nbsp;</font></td>
					</tr>
					<% } %>
				</table>
				<br>
				<table border="0" cellpadding="4" cellspacing="0" align="center">
					<tr>
					<% if (ndx > 0) { %><td><a href="javascript: move(<%= ndx %> - 1)" title="이전문제로 이동"><font color="#0B66B0">이전문제</font></a></td><% } %>
					<% if (ndx < qcount - 1) { %><td><a href="javascript: move(<%= ndx %> + 1)" title="다음문제로 이동"><font color="#0B66B0">다음문제</font></a></td><% } %>
					<% if (ndx == qcount - 1) { %><td><a href="javascript: mark()" title="좌측화면의 채점란을 완료로 바꿈"><font color="#0B66B0">채점완료</font></a></td><% } %>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	  
</body>
</html>



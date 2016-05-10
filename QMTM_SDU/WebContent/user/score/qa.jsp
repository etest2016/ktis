<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, etest.*, etest.score.*, etest.paper.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<%
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }	

	if (userid.length() == 0 || id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	// from exam_m and related tables

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
	<script type="text/javascript">
		alert("�������� �����ϴ�.");
		window.close();
	</script>
<%
		if(true) return ;
	}

	String title = info.getTitle();
	double totalAllot = info.getAllotting();
	int qcount = info.getQcount();

	// from exam_ans
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
	<script type="text/javascript">
		alert("�򰡿� �������� �ʾҽ��ϴ�.");
		window.close();
	</script>
<%
		if(true) return ;
	} 

	// exam_paper2, q, ref, exam_ans_non
	User_ExamPaper2Bean[] qs = null;

	try {
	  qs = User_ExamPaper2.getBeans(ans.getId_exam(), ans.getNr_set(), ans.getUserid());
	}
	catch (Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	if (qs == null) {
%>
	<script type="text/javascript">
		alert("�ش��ϴ� �򰡿� ���������� �����ϴ�.\n\n�����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
		window.close();
	</script>
<%
		if(true) return ;
	}
	if (qs.length != qcount) {
%>
	<script type="text/javascript">
		alert("�������� �������� �������� �������� �ٸ��ϴ�\n\n�����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
		window.close();
	</script>
<%
		if(true) return ;
	}

	String[] arrExlabel = info.getExlabel().split(",");

	String[] arrAnswer;
	String[] arrOX;
	String[] arrPoint;

	if (ans.getAnswers().length() >= qcount) {
	  arrAnswer = ans.getAnswers().split(User_QmTm.Q_GUBUN_re, -1);
	} else {
	  arrAnswer = new String[qcount];
	}

	if (ans.getOxs().length() >= qcount) {
	  arrOX = ans.getOxs().split(User_QmTm.Q_GUBUN_re, -1);
	} else {
	  arrOX = new String[qcount];
	}

	if (ans.getPoints().length() >= qcount) {
	  arrPoint = ans.getPoints().split(User_QmTm.Q_GUBUN_re, -1);
	} else {
	  arrPoint = new String[qcount];
	}

	if (arrAnswer.length != qs.length) {
%>
	<script type="text/javascript">
		alert("������� �������� �������� �������� �ٸ��ϴ�\n\n�����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
		window.close();
	</script>
<%
		if(true) return ;
	}

	String scoreDisplay = ""; // ����������ǥ��

	if (ans.getYn_end().equalsIgnoreCase("N")) { // ��� ������
	  scoreDisplay = "<font color='red'>��� ������</font>";
	} else if (ans.getOxs().length() == 0) { // ��� ä����
	  scoreDisplay = "<font color='red'>��� ä����</font>";
	} else { // ������� and ä����
	  if (ans.getScore_log().equals("-1")) { // �������� ��
		scoreDisplay = ans.getScore() + "";
	  } else { // �������� ��
		scoreDisplay = "" + ans.getScore();
		scoreDisplay += "(������:" + ans.getScore_bak() + ", ���� ���� ����:";
		char c = ans.getScore_log().charAt(0);
		scoreDisplay += ans.getScore_log().substring(1);
		if (c == '+') { scoreDisplay += " ����)"; }
		else { scoreDisplay += " ����)"; }
	  }
	}

	// ������ ǥ�ø� ���� ������

	boolean[] arrHasRef = new boolean[qcount]; // ��������
	String[] arrRefTitle = new String[qcount]; // �������� �� �ش繮����ȣ
	String[] arrRefBody = new String[qcount];  // ��������

	int[] arrQuestionNo = new int[qcount];     // ������ȣ
	String[] arrQuestion = new String[qcount]; // ��������
	String[] arrOPX_img = new String[qcount];  // ������ȣ�� ����̹��� (OX ����)

	boolean[] arrHasEx = new boolean[qcount];  // ��������
	int[] arrExcount = new int[qcount];        // ���� ����
	String[][] arrEx = new String[qcount][5];  // ����� + ���⳻��

	double[] arrAllot = new double[qcount];    // ����
	String[] arrCA = new String[qcount];       // ����ǥ��

	String[] arrUA_align = new String[qcount]; // �������� td align
	String[] arrUA_width = new String[qcount]; // �������� td width
	String[] arrUA = new String[qcount];       // ������ǥ��

	String[] arrOXP_color = new String[qcount]; // ä��ǥ�û���
	String[] arrOXP = new String[qcount];       // OXP ǥ��

	boolean[] arrHasExplain = new boolean[qcount]; // �ؼ�����
	String[] arrExplain = new String[qcount];      // �ؼ�

	String[] arrQtype = new String[qcount]; // ��������
	String[] arrCAx = new String[qcount];   // ����ä��ǥ���� ���� ǥ��
	String[] arrUAx = new String[qcount];   // ����ä��ǥ���� ����� ǥ��

	String[] arrTableID = new String[qcount];      // ���̱� ��� ���� table id

	// �ʱ�ȭ
	String id_ref = "";     // ����ID

	// looping

	for (int i = 0; i < qcount; i++)
	{
	  if (arrAnswer[i] == null) { arrAnswer[i] = ""; }
	  if (arrOX[i] == null) { arrOX[i] = ""; }
	  if (arrPoint[i] == null) { arrPoint[i] = ""; }

	  int id_qtype = qs[i].getId_qtype();
	  int id_valid_type = qs[i].getId_valid_type();
	  int cacount = qs[i].getCacount();
	  int[] arrEx_order = qs[i].getArrEx_order();
	  String correctAnswer = qs[i].getCa();

	  // ���̱�/���߱�
	  if(arrOX[i].equalsIgnoreCase("O")) { arrTableID[i] = "YesTab"; }
	  else { arrTableID[i] = "NoTab"; }

	  // ����ǥ��
	  if (id_ref.equalsIgnoreCase(qs[i].getId_ref())) {     // id_ref ������
		arrHasRef[i] = false;
	  } else if (qs[i].getId_ref().equalsIgnoreCase("0")) { // id_ref = 0 : ������
		arrHasRef[i] = false;
	  } else {                                              // id_ref �� ���� �Ǿ��� ������
		arrHasRef[i] = true;
		id_ref = qs[i].getId_ref();
		arrRefTitle[i] = "�� " + qs[i].getReftitle() + "[" + qs[i].getQ_no1() + "]" ;
		if (qs[i].getQ_no1() != qs[i].getQ_no2()) { // ���������� ����
		  arrRefTitle[i] += " ~ [" + qs[i].getQ_no2() + "]";
		}
		arrRefBody[i] = qs[i].getRefbody();
	  }

	  // ����ǥ��
	  arrQuestionNo[i] = qs[i].getNr_q();
	  arrQuestion[i] = qs[i].getQ();
	  arrOPX_img[i] = "../images/" + arrOX[i] + "04.gif";

	  // ����ǥ��
	  if (id_qtype <= 3) {
		arrHasEx[i] = true;
	  } else {
		arrHasEx[i] = false;
	  }
	  arrExcount[i] = qs[i].getExcount();
	  for (int j = 0; j < arrExcount[i]; j++) {
		arrEx[i][j] = arrExlabel[j] + " " + User_QmTm.delTag(qs[i].getArrEx()[j]);
	  }

	  // ����
	  arrAllot[i] = qs[i].getAllotting();

	  // ����ǥ��
	  arrCA[i] = User_QA.getAnswerDisplay(id_valid_type, id_qtype, cacount, arrEx_order, correctAnswer, arrExlabel);

	  if (id_qtype == 5) {
		arrCA[i] = "";
	  }

	  // �����Ȱ���
	  if (id_qtype == 5) { // �����
		arrUA_align[i] = "left"; arrUA_width[i] = "60%";
	  } else {
		arrUA_align[i] = "center"; arrUA_width[i] = "";
	  }
	  if (id_qtype == 5) { arrAnswer[i] = qs[i].getUserans(); }
	  arrUA[i] = User_QA.getAnswerDisplay(9, id_qtype, cacount, arrEx_order, arrAnswer[i], arrExlabel);

	  // ä��ǥ�� ����
	  if (arrOX[i].equalsIgnoreCase("O")) { // ����
		arrOXP_color[i] = "blue"; arrOXP[i] = arrOX[i].toUpperCase();
		arrPoint[i] = String.valueOf(arrAllot[i]);
	  } else if (arrOX[i].equalsIgnoreCase("X")) { // ����
		arrOXP_color[i] = "red"; arrOXP[i] = arrOX[i].toUpperCase();
		arrPoint[i] = "0";
	  } else if (arrOX[i].equalsIgnoreCase("P")) { // �κ�����
		arrOXP_color[i] = "#33CCCC"; arrOXP[i] = "��";
	  } else {
		arrOXP_color[i] = "gray"; arrOXP[i] = "";
		arrPoint[i] = "";
	  }

	  // �ؼ�����
	  if (qs[i].getExplain().length() > 0) {
		arrHasExplain[i] = true; arrExplain[i] = qs[i].getExplain();
	  } else {
		arrHasExplain[i] = false;
	  }

	  // ä��ǥ���հ���
	  if      (id_qtype == 1) arrQtype[i] = "OX��";
	  else if (id_qtype == 2) arrQtype[i] = "������";
	  else if (id_qtype == 3) arrQtype[i] = "���������";
	  else if (id_qtype == 4) arrQtype[i] = "�ܴ���";
	  else if (id_qtype == 5) arrQtype[i] = "�����";

	  if (id_qtype == 5) { // �����
		arrCAx[i] = "";
		if (arrUA[i].length() == 0) { arrUAx[i] = "������ ����"; }
		else { arrUAx[i] = "������ ����"; }
	  } else {
		arrCAx[i] = arrCA[i]; arrUAx[i] = arrUA[i];
	  }

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>������ID : [<%= userid %>] --- ���� �ؼ� �� ä��</title>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="../css/indie_style.css" type="text/css">
<style type="text/css">
  body      { font-size: 12 }
  table     { font-size: 12 }
</style>
<script type="text/javascript" src="../js/MM_script.js"></script>

<script type="text/javascript">
function init()
{
  self.moveTo(0,0) ;
  self.resizeTo(screen.availWidth,screen.availHeight) ;
}
</script>

</head>

<body bgcolor="#FFFFFF" onload="init()" oncontextmenu="return false;" ondragstart="return false;" onselectstart="return false;">

<form name="thisfrm">
  <input type='hidden' name='chkflag' value='all'>
  <input type='hidden' name='chkflag2' value='all'>
</form>

<!-- buttons -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="60">
  <tr>
    <td width="82%" valign="middle" class="form-h">
      <table width="228" border="0" cellspacing="1">
        <tr>
          <td width="45"><a href="javascript:viewCrtTab();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../images/bt1_1.gif',1)"><img src="../images/bt1_2.gif" width="45" height="22" border="0" name="Image6"></a></td><br>
          <td width="85"><a href="javascript:viewYes();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../images/bt1_3.gif',1)"><img src="../images/bt1_4.gif" width="85" height="22" border="0" name="Image1"></a></td>
          <td width="98"><a href="javascript:viewNo();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../images/bt1_5.gif',1)"><img src="../images/bt1_6.gif" width="98" height="22" border="0" name="Image2"></a></td>
        </tr>
      </table>
    </td>
    <td align="right" valign="bottom" width="26%">
      <!--<input type="image" name="cmdPrint" onclick="window.print();" src="../images/b-print.gif" width="42" height="51">-->
      <input type="image" name="cmdClose" onclick="window.close();" src="../images/b-exit.gif" width="42" height="51">
    </td>
  </tr>
</table>

<!-- spacer -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="14">
  <tr><td width="80%" align="center" background="../images/gab_dot.gif"></td></tr>
</table>

<!-- title, userID-->
<table align="center" width="80%" border="0" cellspacing="0" cellpadding="0" class="copy">
  <tr>
    <td width="60%">
      - <b><font color="#6666CC">�򰡸�</font></b> : <%= title %><br>
    </td>
    <td width="40%" valign="top" align="right">
      <b>- <font color="#6666CC">������ ID</font></b> : <%= userid %><br>
    </td>
  </tr>
</table><br>

<!-- ����, ������, ���� -->
<table align="center" width="80%" border="0" cellspacing="1" cellpadding="2" class="copy" bgcolor="#666666">
  <tr align="center">
    <td width="16%" bgcolor="#F7F7E8">����</td>
    <td width="16%" bgcolor="#FFFFFF"><%= totalAllot %></td>
    <td width="16%" bgcolor="#F7F7E8">������</td>
    <td width="16%" bgcolor="#FFFFFF"><%= qcount %></td>
    <td width="16%" bgcolor="#F7F7E8">��������</td>
    <td width="16%" bgcolor="#FFFFFF"><%= scoreDisplay %></td>
  </tr>
</table>

<!-- spacer -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="14">
  <tr><td width="80%" align="center" background="../images/gab_dot.gif"></td></tr>
</table>

<% for (int i = 0; i < qcount; i++) { /* �������� loop �� �����鼭 */ %>

<!-- ���� -->
<% if (arrHasRef[i]) { %>
<table border="0" width="80%" align="center" cellpadding="0" cellspacing="0" id="<%= arrTableID[i] %>" style="display:none">
  <tr><td colspan=2 height="15">&nbsp;</td></tr>
  <tr height="25">
    <td colspan="2" bgcolor="#6666CC">
      <font color='#FFFFFF'><%= arrRefTitle[i] %></font>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="right">
      <table bgcolor="#F0F0F0" width="100%" align="center" border="0" cellspacing="0" cellpadding="8" class="copy">
        <tr><td><%= arrRefBody[i] %></td></tr>
      </table>
    </td>
  </tr>
</table>
<% } %>
<!-- end of ���� -->

<!-- ���� �� ���� -->
<table border="0" width="80%" align="center" cellpadding="2" cellspacing="0" id="<%= arrTableID[i] %>" style="display:none">
  <tr><td colspan=2 height="15">&nbsp;</td></tr>
  <!-- ���� -->
  <tr>
    <td valign=top width="28" height="28" align="center">
      <table border="0" width="27" height="22" background="<%= arrOPX_img[i] %>">
        <tr>
          <td align="center" width="27" height="22">
            <font face=Arial color="#000000" size=3><b><%= arrQuestionNo[i] %></b></font>
          </td>
        </tr>
      </table>
    </td>
    <td bgcolor="#F5F5F5" valign="middle" align="left"><%= arrQuestion[i] %></td>
  </tr>
  <!-- ���� -->
  <% if (arrHasEx[i]) { %>
    <% for (int j = 0; j < arrExcount[i]; j++) { %>
      <tr>
        <td align="center" width="30" valign="top">&nbsp;</td>
        <td valign="top"><%= arrEx[i][j] %></td>
      </tr>
   <% } %>
 <% } %>
</table>
<!-- end of ���� �� ���� -->

<!-- ä����� -->
<table align="center" width="80%" class="copy" id="<%= arrTableID[i] %>" style="display:none">
  <tr>
    <td bgcolor="#FFFFFF" align="left" valign="top" width="18">
      <img src="../images/i-hint.gif" width="18" height="18">
    </td>
    <td bgcolor="#FFFFFF" align="left" valign="top">
      <b><font color="#6666CC">&nbsp;ä��</font></b>
    </td>
  </tr>
</table>
<table align="center" cellspacing=1 cellpadding=2 width=80% border=0 bgcolor="#CCCCCC" class="copy" id="<%= arrTableID[i] %>" style="display:none">
  <tr align=center bgcolor=#F7F7E8>
    <td><font color="#000000">&nbsp;&nbsp;����&nbsp;&nbsp;</font></td>
    <td><font color="#000000">&nbsp;&nbsp;����&nbsp;&nbsp;</font></td>
    <td><font color="#000000">&nbsp;&nbsp;����&nbsp;&nbsp;</font></td>
    <td width="<%= arrUA_width[i] %>"><font color="#000000">������</font></td>
    <td><font color="#000000">&nbsp;&nbsp;ä��&nbsp;&nbsp;</font></td>
  </tr>
  <tr align="center" bgcolor="#FFFFFF">
    <td><%= arrAllot[i] %></td>
    <td><%= arrPoint[i] %></td>
    <td><%= arrCA[i] %></td>
    <td align="<%= arrUA_align[i] %>"><%= arrUA[i] %></td>
    <td><font color="<%= arrOXP_color[i] %>"><b><%= arrOXP[i] %></b></font></td>
  </tr>
</table>

<!-- end of ä����� -->

<!-- �ؼ� -->
<% if (arrHasExplain[i]) { %>
<table border="0" width="80%" align="center" cellpadding="0" cellspacing="0" id="<%= arrTableID[i] %>" style="display:none">
  <tr><td height="15">&nbsp;</td></tr>
  <tr>
    <td bgcolor="#FFFFFF" align="left" valign="top">
      <img src="../images/i-answer.gif" width="17" height="18" border="0" align="middle">
      <font color="#6666CC"><b>&nbsp;�ؼ�</b></font>
    </td>
  </tr>
  <tr>
    <td align="right">
      <table bgcolor="#F0F0F0" width="100%" align="center" border="0" cellspacing="0" cellpadding="8" class="copy">
        <tr><td><%= arrExplain[i] %></td></tr>
      </table>
    </td>
  </tr>
</table>
<% } %>
<!-- �ؼ� -->

<% } /* end of for loop (��������) */ %>

<!-- ä��ǥ -->
<table align="center" width="80%" border="0" cellspacing="1" cellpadding="2" class="copy" bgcolor="#666666" id="crtTab" STYLE="display:">
  <tr>
    <td bgcolor="#F7F7E8" align="center">���׹�ȣ</td>
    <td bgcolor="#F7F7E8" align="center">��������</td>
    <td bgcolor="#F7F7E8" align="center">���δ��</td>
    <td bgcolor="#F7F7E8" align="center">&nbsp;&nbsp;����&nbsp;&nbsp;</td>
    <td bgcolor="#F7F7E8" align="center">&nbsp;&nbsp;ä��&nbsp;&nbsp;</td>
    <td bgcolor="#F7F7E8" align="center">&nbsp;&nbsp;����&nbsp;&nbsp;</td>
    <td bgcolor="#F7F7E8" align="center">���ε���</td>
  </tr>

  <% for (int i = 0; i < qcount; i++) { /* �������� loop �� �����鼭 */ %>
  <tr align="center" bgcolor="#FFFFFF">
    <td><%= arrQuestionNo[i] %></td>
    <td><%= arrQtype[i] %></td>
    <td><%= arrUAx[i] %></td>
    <td><%= arrCAx[i] %></td>
    <td><%= arrOXP[i] %></td>
    <td><%= arrAllot[i] %></td>
    <td><%= arrPoint[i] %></td>
  </tr>
  <% } %>

</table>
<!-- end of ä��ǥ -->

<!-- spaccer line -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="14">
  <tr><td width="80%" align="center" background="../images/gab_dot.gif"></td></tr>
</table>

<!-- �����ư -->
<table width="80%" align="center" border="0" cellspacing="0" cellpadding="0" height="60">
  <tr>
    <td width="82%" valign="middle" class="form-h">
      <table width="228" border="0" cellspacing="1">
        <tr>
          <td width="45"><a href="javascript:viewCrtTab();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../images/bt1_1.gif',1)"><img src="../images/bt1_2.gif" width="45" height="22" border="0" name="Image6"></a></td><br>
          <td width="85"><a href="javascript:viewYes();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../images/bt1_3.gif',1)"><img src="../images/bt1_4.gif" width="85" height="22" border="0" name="Image1"></a></td>
          <td width="98"><a href="javascript:viewNo();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../images/bt1_5.gif',1)"><img src="../images/bt1_6.gif" width="98" height="22" border="0" name="Image2"></a></td>
        </tr>
      </table>
    </td>
    <td align="right" valign="bottom" width="26%">
      <!--<input type="image" name="cmdPrint" onclick="window.print();" src="../images/b-print.gif" width="42" height="51">-->
      <input type="image" name="cmdClose" onclick="window.close();" src="../images/b-exit.gif" width="42" height="51">
    </td>
  </tr>
</table>
<!-- end of �����ư -->

</body>
</html>

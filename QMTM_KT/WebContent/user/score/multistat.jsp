<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="etest.*, etest.score.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("UTF-8");
%>
<%  // opener 가 없으면
	out.print("<script language='javascript'> if (!opener) { window.location.href = '/error/page_error.jsp'; }</script>");
%>

<%
	//String userid =	get_cookie(request, "userid");
	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (userid == "" || id_exam == "") {
	   response.sendRedirect("/error/page_error.jsp");    
	
		if(true) return ;
	}

%>
<%
	// From EXAM_M table

	User_StatExamBean exam;
	try {
	  exam = User_Stat.getUser_StatExamBean(id_exam);
	}
	catch (Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	// From S_T_RESULT table
	// 전과목기준 : id_subject : -1 , id_chapter : -1

	User_StatTotalBean total;
	try {
	  total = User_Stat.getUser_StatTotalBean(id_exam);
	}
	catch (Exception ex) {
	   response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
	if (total == null) {
%>
	<Script language="JavaScript">
		alert("[통계작업이 완료되지 않았습니다]\n\n** 운영자에게 연락 바랍니다.");
	</Script>
<%
		if(true) return;
	}

	// From S_P_RESULT table
	// 전과목기준 : id_subject : -1 , id_chapter : -1

	User_StatPersonBean person;
	try {
	  person = User_Stat.getUser_StatPersonBean(userid, id_exam);
	}
	catch (Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
	if (person == null) {
	  person = new User_StatPersonBean();
	  person.setP_rank(0);
	  person.setP_rank_pct(0);
	  person.setP_score(0);
	  person.setP_score_pct(0);
	}

%>

<%
// 그래프처리

int t_user_cnt = total.getT_user_cnt();
if (t_user_cnt == 0) {
%>
	<Script language="JavaScript">
		alert("[통계작업이 완료되지 않았습니다]\n\n** 운영자에게 연락 바랍니다.");
	</Script>
<%  
}
int[] pcnt = new int[10];
pcnt[0] = Math.round(100.0F * total.getA() / t_user_cnt);
pcnt[1] = Math.round(100.0F * total.getB() / t_user_cnt);
pcnt[2] = Math.round(100.0F * total.getC() / t_user_cnt);
pcnt[3] = Math.round(100.0F * total.getD() / t_user_cnt);
pcnt[4] = Math.round(100.0F * total.getE() / t_user_cnt);
pcnt[5] = Math.round(100.0F * total.getF() / t_user_cnt);
pcnt[6] = Math.round(100.0F * total.getG() / t_user_cnt);
pcnt[7] = Math.round(100.0F * total.getH() / t_user_cnt);
pcnt[8] = Math.round(100.0F * total.getI() / t_user_cnt);
pcnt[9] = Math.round(100.0F * total.getJ() / t_user_cnt);
%>

<html>
<head>
<title>성적통계</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../css/indie_style.css" type="text/css">

<style type="text/css">
<!--
.Q {font-family: 굴림; font-size: 9pt}
-->
</style>

<script language="JavaScript">
<!--

function init()
{
  self.moveTo(0,0) ;
  self.resizeTo(screen.availWidth,screen.availHeight) ;
}

function collapseBlurbs()
{
  var eElem, aDivs = document.all.tags("TABLE");
  var iDivsLength = aDivs.length;
  for(i=0; i<iDivsLength; i++) {
    eElem = aDivs[i];
    if (eElem.id.indexOf('T') != -1) eElem.style.display = "none";
  }
}

function expandBlurbs()
{
  var eElem, aDivs = document.all.tags("TABLE");
  var iDivsLength = aDivs.length;
  for(i=0; i<iDivsLength; i++) {
    eDiv = aDivs[i];
    if (eDiv.id.indexOf('T') != -1) eDiv.style.display = "";
  }
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
  var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
  if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document;
  if((p=n.indexOf("?"))>0&&parent.frames.length) {d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array;
  for(i=0;i<(a.length-2);i+=3) if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

//-->
</script>

</head>

<body bgcolor="#ffffff" onload="javascript:init(); MM_preloadImages('../images/static-1.gif')"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">

<table width="650" cellspacing="0" cellpadding="0" border="0" class="copy" bordercolor="#99CCCC" align="center">

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60">
        <tr height="30"><td colspan="2"></td></tr>
        <tr>
          <!--  그래프 감추기 그래프 보기 -->
          <td align="left" valign="middle" width="74%">
          <% if (exam.getYn_score_dis().equalsIgnoreCase("Y")) { %>
            <table width="163" border="0" cellspacing="0" style="display:none">
              <tr>
                <td width="61"><input type="image" name="grapehidden" value="grapehidden" onClick="javascript:collapseBlurbs();" src="../images/paper-b6.gif" WIDTH="87" HEIGHT="25"></td>
                <td width="1">&nbsp;</td>
                <td width="96"><input type="image" name="grapeView" value="grapeView" onClick="javascript:expandBlurbs();" src="../images/paper-b7.gif" WIDTH="75" HEIGHT="25"></td>
              </tr>
            </table>
          <% } %>
          </td>
          <!-- Print, Close button-->
          <td align="right" valign="bottom" width="26%">
            <input type="image" name="cmdClose" value="창닫기" onClick="javascript:window.close();" src="../images/b-exit.gif" width="42" height="51">
          </td>
        </tr>
      </table>
      <!-- spacing line -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="14">
        <tr><td width="100%" background="../images/gab_dot.gif"></td></tr>
      </table><br><br>
    </td>
  </tr>

  <tr>
    <td >
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="copy">
        <tr>
          <td width="60%">- <b><font color="#6666CC">시험명</font></b> : <b><%= exam.getTitle() %></b></td>
          <td width="40%" valign="top" align="right"><b>- <font color="#6666CC">응시자 ID</font></b> : <%= userid %></td>
        </tr>
        <tr>
          <td colspan="2">
            <br>
            <font color="#FF0099"><b>※</b></font> <font color="#666666">답안을 제출하지 않은경우 본인관련 항목은 0 으로 표시됩니다.</font><br>
            <br>
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td>
      <!-- 성적통계 -->
      <b><font color="#6699CC">■</font><font color="#6666CC"></font> <font color="#6666CC"></font></b>
      <b><font color="#6666CC">성 적 통 계</font></b>
      <table width="100%" cellspacing=1 cellpadding=2 class=copy bgcolor="#666666" >
        <tr bgcolor=#F7F7E8 align="center">
          <td>&nbsp;문제수&nbsp;</td>
          <td>&nbsp;배&nbsp;&nbsp;점&nbsp;</td>
          <td>본인득점</td>
          <td bgcolor="#F7F7E8">본인득점<br>백점환산</td>
          <% if (exam.getYn_p_rank().equalsIgnoreCase("Y")) { %><td>본인석차</td><% } %>
          <% if (exam.getYn_p_rank_pct().equalsIgnoreCase("Y")) { %><td>본인석차<br>[%] 순위</td><% } %>
          <% if (exam.getYn_t_user_cnt().equalsIgnoreCase("Y")) { %><td>응시자수</td><% } %>
          <% if (exam.getYn_t_avg().equalsIgnoreCase("Y")) { %><td>전체평균</td><% } %>
          <% if (exam.getYn_t_u_avg().equalsIgnoreCase("Y")) { %><td>상위<%= exam.getU_avg_basis() %> %<br>평균점수</td><% } %>
          <% if (exam.getYn_t_max().equalsIgnoreCase("Y")) { %><td>최고득점</td><% } %>
          <% if (exam.getYn_t_min().equalsIgnoreCase("Y")) { %><td>최저득점</td><% } %>
        </tr>
        <tr height="30" bgcolor=#FFFFFF align="center">
          <td><%= total.getQcount() %></td>
          <td><%= total.getAllotting() %></td>
          <td><%= person.getP_score() %></td>
          <td><%= person.getP_score_pct() %></td>
          <% if (exam.getYn_p_rank().equalsIgnoreCase("Y")) { %><td><%= person.getP_rank() %> 등</td><% } %>
          <% if (exam.getYn_p_rank_pct().equalsIgnoreCase("Y")) { %><td><%= person.getP_rank_pct() %></td><% } %>
          <% if (exam.getYn_t_user_cnt().equalsIgnoreCase("Y")) { %><td><%= total.getT_user_cnt() %> 명</td><% } %>
          <% if (exam.getYn_t_avg().equalsIgnoreCase("Y")) { %><td><%= total.getT_avg() %></td><% } %>
          <% if (exam.getYn_t_u_avg().equalsIgnoreCase("Y")) { %><td><%= total.getT_u_avg() %></td><% } %>
          <% if (exam.getYn_t_max().equalsIgnoreCase("Y")) { %><td><%= total.getT_max() %></td><% } %>
          <% if (exam.getYn_t_min().equalsIgnoreCase("Y")) { %><td><%= total.getT_min() %></td><% } %>
        </tr>
      </table>
    </td>
  </tr>

  <!-- 그래프 -->
  <tr>
    <td>
      <br>
      <font color="#999999">...................................................................................................................................................................................................................................................................................................</font>
      <table border="0" cellpadding="0" cellspacing="0" class="q" id="T4000" style="display:">
        <tr>
          <td height="50" valign="middle" colspan="13" align="center">
            <b><font color="#6666CC">점수대별 인원 분포도 [백점환산]</font></b>
          </td>
        </tr>
        <tr id="trGraph">
          <td width="50" align="center" valign="top">
            ▲<br><br>인<br>원<br><br>[%]
          </td>
          <td width="1" align="center" valign="bottom">
            <img src="../images/bar.jpg" width="1" height="120">
          </td>
          <% for (int i = 0; i < pcnt.length; i++) { %>
          <td width="50" align="center" valign="bottom">
          <%= pcnt[i] %>%<br><img src="../images/02.jpg" width="20" height="<%= pcnt[i] %>">
          </td>
          <% } %>
          <td width="100" align="center" valign="bottom">&nbsp;</td>
        </tr>
        <tr style="vertical-align:top">
          <td width=50 align=center valign=top></td>
          <td width=1 align=center valign=top><img src="../images/bar.jpg" width="1" height="1"></td>
          <% for (int i = 0; i < pcnt.length - 1; i++) { %>
          <td width=50 align=center valign=top>
            <img src="../images/bar.jpg" width="50" height="1"><br><br><%= i * 10 %>~<%= i * 10 + 9 %>
          </td>
          <% } %>
          <td width=50 align=center valign=top>
            <img src="../images/bar.jpg" width="50" height="1"><br><br><%= (pcnt.length - 1) * 10 %>~<%= pcnt.length * 10 %>
          </td>
          <td width=100 align=center valign=top>
            <img src="../images/bar.jpg" width=100 height="1"><br><br>점수대 [점] ▶
          </td>
        </tr>
      </table>
      <font color="#999999">...................................................................................................................................................................................................................................................................................................</font>
    </td>
  </tr>
</table>

</body>
</html>

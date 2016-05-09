<%@ page contentType="text/html; charset=euc-kr" %>

<%	
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	////////////////////////////////////////////////
	String userid = request.getParameter("userid");
	////////////////////////////////////////////////

%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<title></title>           

<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0

	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();

	var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)

	if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImage() { //v3.0

  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)

   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}

}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
 
//-->
</script>
</head>   

<%@ include file = "../include/include_top.jsp" %><img src='../images/title_guide.gif'>

<div class='sub'>   
  시험 응시방법
</div>
<div class='text'>
	아래와 같은 순서로 시험에 응시하시면 됩니다.<br><br>
	① 이용 안내 확인 (공지사항 및 주의사항 등)<br>
	<b><IMG height=8 src="space.gif" width=74 align=top>↓</b><br>
	② 시험응시 (‘시험응시’ 메뉴 클릭 후 해당 시험을 선택하여 응시)
	<br>
	<b><IMG height=8 src="space.gif" width=74 align=top>↓</b><br>
	③ 시험결과 조회 (‘시험결과조회’ 메뉴 클릭 후 해당 시험을 선택하여 조회)
</div>


<div class='sub'>Online Test에 응시하기 위한 권장 PC사양</div>
<div class='text'>
	<li> CPU : 1GMhz 이상 </li>
	<li> RAM : 최소 256메가 이상 </li>
	<li> 하드디스크 : 10G 이상 </li>
	<li> 화면크기 : 1024*768 이상</li>
	<li> PC운영체계 : 윈도우98, 2000, NT, Me, XP</li>
	<li> 인터넷 브라우져 :<font class='point'> Internet-explorer 5.5</font> 이상 (필수 사항) </li>
</div>
	
	  
<div class='sub'>시험 주의사항</div>
<div class='text'>
	<li>시험시험 응시전에 모든 프로그램을 종료하여 주십시오.<br>
	( 다른 프로그램을 실행시켜 놓았을 경우 시험 프로그램 에러가 발생할 수 있으며 이로 인한 피해를 입지 않도록 주의하시기 
	바랍니다. ) </li>
	<li>다음문제로 이동할 때 응시자가 체크한 답안은 바로 데이터 베이스에 저장이 되므로 예기치 못한 상황으로 시험이 중단되어도 
	이전에 체크한 답안은 데이터 베이스에 전송이 되어 있습니다.</li>
	<li>문제를 푸신 후 '다음문제' 버튼을 클릭하면 다음문제로 이동할 수 있습니다.</li>
	<li>응시중 제한 시간이 종료되면 응시종료 메시지가 뜨며 답안지가 자동 제출되오니 반드시 '남은시간'에 유의하여 제한시간이전에 
	시험을 종료해 주시기 바랍니다. </li>
	<li>네트워크 끊김현상이나 응시자PC 오류와 같은 돌발적인 상황으로 시험이 중단된 경우 당황하지 마시고 컴퓨터를 재부팅하거나 로그인을 다시하여 시험에 응시하시면 남은 문제를 이어서 푸실 수 있습니다. </li>
	<li>Microsoft Internet Explorer 버젼 5.0 이상을 이용하셔야 합니다.</li>
	<li><font class='point'>시험도중 특수키 및 메신저 등의 사용은 금지되며, 모든 사용 내역은 로그에 기록되어 부정행위로 간주될 수 있습니다.</font></li>
</div>
     
<div class='sub'>응시도중 에러가 발생했을때 대처 방안</div>
<div class='text'>
	① <strong>시험중 컴퓨터가 다운 됐을 경우</strong><br>
	<br>
	&nbsp;&nbsp;&nbsp;컴퓨터를 재부팅하거나 다른PC를 이용하여 다시 응시하여 주십시오. <br>
	&nbsp;&nbsp;&nbsp;이때 이미 작성하신 답안은 저장되어 있으므로 안 푼 문제부터 이어서 푸실 수가 있습니다.<br>
	<br>
	② <strong>문제화면이 나타나지 않을 경우</strong><br>
	<br>
	&nbsp;&nbsp;&nbsp;네트워크 상태가 원할하지 않아 문제데이터 수신이 제대로 되지 않은 경우 입니다.<br>
	&nbsp;&nbsp;&nbsp;화면 상단 오른쪽의 '새로고침' 버튼을 클릭하여 화면을 다시 불러오십시오. <br>
	<br>
	③ <strong>다음 문제 이동이나 답안지 제출이 안 되는 경우</strong><br>
	<br>
	&nbsp;&nbsp;&nbsp;네트워크 상태가 원할하지 않아 데이터베이스에 연결이 안되는 경우일 확률이 높습니다.<br>
	&nbsp;&nbsp;&nbsp;Help-Desk에 연락하여 조치하십시오.
</div>

<!--<a name='help'>
<div class='sub'>장애지원센터</div>
<div class='text'>
	<li> 전화: 02)3412-0766</li>
</div>-->

<div align='right' style='margin-right: 60px;'><a href='#top'><img src='../images/bt_top.gif'></a></div>
<%@ include file="../include/include_bottom.jsp" %>



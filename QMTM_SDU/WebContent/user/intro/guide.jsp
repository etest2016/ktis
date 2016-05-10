<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.ComLib" %>
<%
	String userid = "";

	userid = (String)session.getAttribute("current_userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Guide</title>
<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="../css/top.css" />
</head>
<body>

	<a name="top"></a>
	
	<jsp:include page="../include/include_top.jsp" flush="false">
		<jsp:param name="active_menu_item" value="guide" />
    </jsp:include>

	<div class="container">

		<h4>평가 응시방법</h4>

		<div class='text'>
			아래와 같은 순서로 평가에 응시하시면 됩니다.<br><br>
			
			① 로그인 (<strong><u>아이디: 사번</u></strong>)
			<br>
			<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↓</b><br>
			② 이용 안내 확인 (공지사항 및 주의사항 등)
			<br>
			<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↓</b><br>
			③ 평가응시 ('평가응시' 메뉴 클릭 후 해당 평가을 선택하여 응시)<br>
		</div>


		<h4>응시도중 에러가 발생했을때 대처 방안</h4>
		<div class='text'>
			① <strong>평가중 컴퓨터가 다운 됐을 경우</strong><br><br>
			&nbsp;&nbsp;&nbsp;컴퓨터를 재부팅하거나 다른PC를 이용하여 다시 응시하여 주십시오. <br>
			&nbsp;&nbsp;&nbsp;이때 이미 작성하신 답안은 저장되어 있으므로 안 푼 문제부터 이어서 푸실 수가 있습니다.<br>
			<br>
			② <strong>문제화면이 나타나지 않을 경우</strong><br><br>
			&nbsp;&nbsp;&nbsp;네트워크 상태가 원할하지 않아 문제데이터 수신이 제대로 되지 않은 경우 입니다.<br>
			&nbsp;&nbsp;&nbsp;화면 상단 오른쪽의 '새로고침' 버튼을 클릭하여 화면을 다시 불러오십시오. <br>
			<br>
			③ <strong>다음 문제 이동이나 답안지 제출이 안 되는 경우</strong><br><br>
			&nbsp;&nbsp;&nbsp;네트워크 상태가 원활하지 않아 연결이 안되는 경우일 확률이 높습니다.<br>
			&nbsp;&nbsp;&nbsp;Help-Desk에 연락하여 조치하십시오.
		</div>

		<h4>Online Test에 응시하기 위한 권장 PC사양</h4>
		<div class='text'>
			<ul>
				<li> CPU : 1GMhz 이상 </li>
				<li> RAM : 최소 256메가 이상 </li>
				<li> 하드디스크 : 10G 이상 </li>
				<li> 화면크기 : 1024*768 이상</li>
				<li> PC운영체계 : Windows XP 이상</li>
				<li> 인터넷 브라우져 :<font class='point'> Internet-explorer 8</font> 이상 (필수 사항) </li>
				<li> 음성파일 재생 : 윈도우 미디어플레이어 6.0 이상 (필수 사항)</li>
			</ul>
		</div>	
		<div align='right'><a href='#top'><img src='../images/bt_top.gif'></a></div>


	</div>

	<div class="container_bottom"><!--바닥 부분 레이아웃--></div>


</body>
</html>

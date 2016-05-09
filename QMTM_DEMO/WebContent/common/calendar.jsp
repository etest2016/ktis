<%
//******************************************************************************
//   프로그램 : calendar.jsp
//   모 듈 명 : 달력
//   설    명 : 달력
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-06-18
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<script language="JavaScript">
	// Date Picker 관련 JS 함수 모음

	var target, stime;

	function MiniCal(ctl) {	// 캘린더 호출 (ctl : 폼필드)
		target = ctl;
		
		x = event.clientX;
		y = event.clientY;

		minical.style.pixelTop	= y;
		minical.style.pixelLeft	= x;
		minical.style.display = (minical.style.display == "block") ? "none" : "block";
		var defDate = new Array;
		defDate[0] = 0;		// 캘린더 출력시 초기 연도 (0=현재)
		defDate[1] = 0;		// 캘린더 출력시 초기 월 (0=현재)
		defDate[2] = 0;		// 캘린더 출력시 초기 일 (0=현재) 
		if (target.value != '') {
			defDate = target.value.split('-');
			for (var i=0; i<defDate.length; i++) {
				defDate[i] = parseInt(defDate[i], 10);
			}
		}
		Show_cal(defDate[0],defDate[1],defDate[2]);	// 기본 표시 날짜 (Y, M, D)
	}

	function doOver() {	// 캘린더에 마우스 오버시
		var el = window.event.srcElement;
		cal_Day = el.title;
		el.style.borderTopColor = el.style.borderLeftColor = "buttonhighlight";
		el.style.borderRightColor = el.style.borderBottomColor = "buttonshadow";
		window.clearTimeout(stime);
	}

	function doClick() {	// 캘린더에서 마우스 클릭시
		cal_Day = window.event.srcElement.title;
		window.event.srcElement.style.borderColor = "red";
		if (cal_Day != '') {
			target.value = cal_Day;
		}
	}

	function doOut() {	// 마우스가 캘린더에서 벗어났을 경우
		var el = window.event.fromElement;
		cal_Day = el.title;
		el.style.borderColor = "white";
		stime=window.setTimeout("minical.style.display='none'", 200);
	}
	// Date Picker 관련 JS 함수 모음 끝
//---------------------------------------------------------------------------------------
</script>

<!-- 날짜선택기 관련 VBScript 함수 -->
<script language="VBScript">
' Datepicker 함수
Function ConvStr(strOrigin)		
	If Len(strOrigin) = 1 Then
		strDest = "0" & strOrigin 
	Else
		strDest = strOrigin
	End If
	
	ConvStr = strDest
End Function

Function Show_cal(sYear,sMonth,sDay)
	document.all.minical.innerHTML=""
	datToday=date()

	intThisYear = CInt("0" & sYear)		'초기 연도 넘겨받기
	intThisMonth = CInt("0" & sMonth)	'초기 월 넘겨받기
	intThisDay = CInt("0" & sDay)		'초기 일 넘겨받기

	If intThisYear = 0 Then intThisYear = Year(datToday)
	If intThisMonth = 0 Then intThisMonth = Month(datToday)
	If intThisDay = 0 Then intThisDay = day(datToday)

	If intThisMonth = 1 Then
		intPrevYear = intThisYear - 1
		intPrevMonth = 12
		intNextYear = intThisYear
		intNextMonth = 2
	ElseIf intThisMonth = 12 then
		intPrevYear = intThisYear
		intPrevMonth = 11
		intNextYear = intThisYear + 1
		intNextMonth = 1
	Else
		intPrevYear = intThisYear
		intPrevMonth = intThisMonth -1
		intNextYear = intThisYear
		intNextMonth = intThisMonth+1
	End If

	NowThisYear = Year(datToDay)		'현재 연도
	NowThisMonth = Month(datToday)		'현재 월
	NowThisDay = Day(datToday)		'현재 일

	datFirstDay = DateSerial(intThisYear, intThisMonth, 1) 			'넘겨받은 날짜의 월초기값 파악
	intFirstWeekday = Weekday(datFirstDay, vbSunday)			'넘겨받은 날짜의 주초기값 파악
	intSecondWeekday = intFirstWeekday
	intThirdWeekday = intFirstWeekday

	datThisDay = CDate(intThisYear & "-" & intThisMonth & "-" & intThisDay)
	intThisWeekday=Weekday(datThisDay)

	Select Case intThisWeekday
		Case 1	varThisWeekday = "일"
		Case 2	varThisWeekday = "월"
		Case 3	varThisWeekday = "화"
		Case 4	varThisWeekday = "수"
		Case 5	varThisWeekday = "목"
		Case 6	varThisWeekday = "금"
		Case 7	varThisWeekday = "토"
	End Select

	intPrintDay = 1 							'출력 초기일은 1부터
	secondPrintDay = 1
	thirdPrintDay = 1

	Stop_Flag=0

	If (intThisMonth=4) Or (intThisMonth=6) Or (intThisMonth=9) Or (intThisMonth=11) Then  '월의 마지막 날짜 산출
		intLastDay = 30
	ElseIf (intThisMonth=2) And (Not (intThisYear mod 4) = 0) Then
		intLastDay = 28
	ElseIf (intThisMonth=2) And ((intThisYear mod 4) = 0) Then
		If (intThisYear mod 100) = 0 Then
			If (intThisYear mod 400) = 0 Then
				intLastDay = 29
			Else
				intLastDay = 28
			End If
		Else
			intLastDay = 29
		End If
	Else
		intLastDay = 31
	End If

	If (intPrevMonth=4) Or (intPrevMonth=6) Or (intPrevMonth=9) Or (intPrevMonth=11) Then  '월의 마지막 날짜 산출
		intPrevLastDay = 30
	ElseIf (intPrevMonth=2) And (Not (intPrevYear mod 4) = 0) Then
		intPrevLastDay = 28
	ElseIf (intPrevMonth = 2) and (intPrevYear mod 4) = 0 Then
		if (intPrevYear mod 100) = 0 then
			If (intPrevYear mod 400) = 0 Then
				intPrevLastDay = 29
			Else
				intPrevLastDay = 28
			End If
		Else
			intPrevLastDay = 29
		End If
	Else
		intPrevLastDay = 31
	End if

	Stop_Flag = 0
	
	Cal_HTML = Cal_HTML& "<table border='0' cellspacing='0' cellpadding='0' width='160' onmouseover='doOver()' onmouseout='doOut()' onclick='doClick()'>"
	Cal_HTML = Cal_HTML& "<tr><td width='156' height='50' bgcolor='White' align='center'>"
	Cal_HTML = Cal_HTML& "<table bgCOLOR='#E6E6E6' border='0' cellspacing='2' cellpadding='2' width='156'>"
	Cal_HTML = Cal_HTML& "<tr>"
	Cal_HTML = Cal_HTML& "<td width='15' align=left  title='이전년도' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intPrevYear-1&","&intPrevMonth+1&",1)'><font COLOR='#777777' class='s'>◀</font></td>"
	Cal_HTML = Cal_HTML& "<td width='15' align=left  title='이전달' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intPrevYear&","&intPrevMonth&",1)'><font COLOR='#777777' class='s'>◀</font></td>"
	Cal_HTML = Cal_HTML& "<td width='117' align='center' class='s1'>" 
	Cal_HTML = Cal_HTML& intThisYear&"년 "&intThisMonth&"월" & "</td>"
	Cal_HTML = Cal_HTML& "<td width='15' align=right title='다음달' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intNextYear&","&intNextMonth&",1)'><font COLOR='#777777' class='s'>▶</font></td>"        
	Cal_HTML = Cal_HTML& "<td width='15' align=right title='다음년도' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intNextYear+1&","&intNextMonth-1&",1)'><font COLOR='#777777' class='s'>▶</font></td>"        
	Cal_HTML = Cal_HTML& "</tr></table>"		
	Cal_HTML = Cal_HTML& "<table border='0' cellspacing='2' cellpadding='2' width='156'>"
	Cal_HTML = Cal_HTML& "<tr align=center bgcolor=#eeeeee style='color:black;'>"
	Cal_HTML = Cal_HTML& "<td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>"
	Cal_HTML = Cal_HTML& "</tr>"

	For intLoopWeek = 1 To 6	'주단위 루프 시작, 최대 6주
		Cal_HTML = Cal_HTML & "<tr align=right valign=top bgcolor=white >"

		For intLoopDay = 1 To 7		'요일단위 루프 시작, 일요일부터

			If intThirdWeekDay > 1 Then '첫주시작일이 1보다 크면
				Cal_HTML = Cal_HTML & "<td>&nbsp;</td>"
				intThirdWeekDay = intThirdWeekDay - 1
			Else
				If thirdPrintDay > intLastDay Then	'입력날짜가 월의 마지막 날보다 크면
					Cal_HTML=Cal_HTML& "<td>&nbsp;</td>"
				Else					'입력날짜가 현재월에 해당되면
					' 만약 입력필드에 리턴되는 날짜값의 형식을 바꾸려면 아래 라인을 변경하면 된다!
					ResultStr = intThisYear & "-" & ConvStr(intThisMonth) & "-" & ConvStr(thirdPrintDay)
					Cal_HTML=Cal_HTML& "<td title='" & ResultStr & "' style='cursor: hand;border: 1px solid white;width:18; height:18;"
					
					If (intThisYear-NowThisYear=0) And (intThisMonth-NowThisMonth=0) And (thirdPrintDay-intThisDay=0) Then '오늘 날짜는 폰트를 다르게
						Cal_HTML = Cal_HTML & "background-color:"
					End If
					If intLoopDay=1 Then	'일요일이면 빨간 색으로
						Cal_HTML = Cal_HTML & "color:red;"
					Else ' 그외의 경우
						Cal_HTML = Cal_HTML & "color:black;"
					End If
					Cal_HTML = Cal_HTML & "'>" & thirdPrintDay
				End If
				thirdPrintDay = thirdPrintDay + 1	'날짜값을 1 증가
				If (thirdPrintDay > intLastDay) Then Stop_Flag = 1	'날짜값이 월말일보다 크면 루프문 탈출
			End If
			Cal_HTML = Cal_HTML & "</td>"
		Next
		Cal_HTML = Cal_HTML & "</tr>"
		
		If Stop_Flag = 1 Then Exit For	' 루프문을 실제로 빠져나감.
	Next
	Cal_HTML = Cal_HTML & "</table>"
	document.all.minical.innerHTML = Cal_HTML	'만들어진 HTML을 실제로 minical 레이어에 적용
END Function
</script>

<div id="minical" onclick="this.style.display='none'" oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="datepicker" style="position:absolute;"></div>
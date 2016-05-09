<%
//******************************************************************************
//   ���α׷� : calendar.jsp
//   �� �� �� : �޷�
//   ��    �� : �޷�
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-06-18
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<script language="JavaScript">
	// Date Picker ���� JS �Լ� ����

	var target, stime;

	function MiniCal(ctl) {	// Ķ���� ȣ�� (ctl : ���ʵ�)
		target = ctl;
		
		x = event.clientX;
		y = event.clientY;

		minical.style.pixelTop	= y;
		minical.style.pixelLeft	= x;
		minical.style.display = (minical.style.display == "block") ? "none" : "block";
		var defDate = new Array;
		defDate[0] = 0;		// Ķ���� ��½� �ʱ� ���� (0=����)
		defDate[1] = 0;		// Ķ���� ��½� �ʱ� �� (0=����)
		defDate[2] = 0;		// Ķ���� ��½� �ʱ� �� (0=����) 
		if (target.value != '') {
			defDate = target.value.split('-');
			for (var i=0; i<defDate.length; i++) {
				defDate[i] = parseInt(defDate[i], 10);
			}
		}
		Show_cal(defDate[0],defDate[1],defDate[2]);	// �⺻ ǥ�� ��¥ (Y, M, D)
	}

	function doOver() {	// Ķ������ ���콺 ������
		var el = window.event.srcElement;
		cal_Day = el.title;
		el.style.borderTopColor = el.style.borderLeftColor = "buttonhighlight";
		el.style.borderRightColor = el.style.borderBottomColor = "buttonshadow";
		window.clearTimeout(stime);
	}

	function doClick() {	// Ķ�������� ���콺 Ŭ����
		cal_Day = window.event.srcElement.title;
		window.event.srcElement.style.borderColor = "red";
		if (cal_Day != '') {
			target.value = cal_Day;
		}
	}

	function doOut() {	// ���콺�� Ķ�������� ����� ���
		var el = window.event.fromElement;
		cal_Day = el.title;
		el.style.borderColor = "white";
		stime=window.setTimeout("minical.style.display='none'", 200);
	}
	// Date Picker ���� JS �Լ� ���� ��
//---------------------------------------------------------------------------------------
</script>

<!-- ��¥���ñ� ���� VBScript �Լ� -->
<script language="VBScript">
' Datepicker �Լ�
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

	intThisYear = CInt("0" & sYear)		'�ʱ� ���� �Ѱܹޱ�
	intThisMonth = CInt("0" & sMonth)	'�ʱ� �� �Ѱܹޱ�
	intThisDay = CInt("0" & sDay)		'�ʱ� �� �Ѱܹޱ�

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

	NowThisYear = Year(datToDay)		'���� ����
	NowThisMonth = Month(datToday)		'���� ��
	NowThisDay = Day(datToday)		'���� ��

	datFirstDay = DateSerial(intThisYear, intThisMonth, 1) 			'�Ѱܹ��� ��¥�� ���ʱⰪ �ľ�
	intFirstWeekday = Weekday(datFirstDay, vbSunday)			'�Ѱܹ��� ��¥�� ���ʱⰪ �ľ�
	intSecondWeekday = intFirstWeekday
	intThirdWeekday = intFirstWeekday

	datThisDay = CDate(intThisYear & "-" & intThisMonth & "-" & intThisDay)
	intThisWeekday=Weekday(datThisDay)

	Select Case intThisWeekday
		Case 1	varThisWeekday = "��"
		Case 2	varThisWeekday = "��"
		Case 3	varThisWeekday = "ȭ"
		Case 4	varThisWeekday = "��"
		Case 5	varThisWeekday = "��"
		Case 6	varThisWeekday = "��"
		Case 7	varThisWeekday = "��"
	End Select

	intPrintDay = 1 							'��� �ʱ����� 1����
	secondPrintDay = 1
	thirdPrintDay = 1

	Stop_Flag=0

	If (intThisMonth=4) Or (intThisMonth=6) Or (intThisMonth=9) Or (intThisMonth=11) Then  '���� ������ ��¥ ����
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

	If (intPrevMonth=4) Or (intPrevMonth=6) Or (intPrevMonth=9) Or (intPrevMonth=11) Then  '���� ������ ��¥ ����
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
	Cal_HTML = Cal_HTML& "<td width='15' align=left  title='�����⵵' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intPrevYear-1&","&intPrevMonth+1&",1)'><font COLOR='#777777' class='s'>��</font></td>"
	Cal_HTML = Cal_HTML& "<td width='15' align=left  title='������' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intPrevYear&","&intPrevMonth&",1)'><font COLOR='#777777' class='s'>��</font></td>"
	Cal_HTML = Cal_HTML& "<td width='117' align='center' class='s1'>" 
	Cal_HTML = Cal_HTML& intThisYear&"�� "&intThisMonth&"��" & "</td>"
	Cal_HTML = Cal_HTML& "<td width='15' align=right title='������' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intNextYear&","&intNextMonth&",1)'><font COLOR='#777777' class='s'>��</font></td>"        
	Cal_HTML = Cal_HTML& "<td width='15' align=right title='�����⵵' style='cursor:hand;' OnClick='vbscript:call Show_cal("&intNextYear+1&","&intNextMonth-1&",1)'><font COLOR='#777777' class='s'>��</font></td>"        
	Cal_HTML = Cal_HTML& "</tr></table>"		
	Cal_HTML = Cal_HTML& "<table border='0' cellspacing='2' cellpadding='2' width='156'>"
	Cal_HTML = Cal_HTML& "<tr align=center bgcolor=#eeeeee style='color:black;'>"
	Cal_HTML = Cal_HTML& "<td>��</td><td>��</td><td>ȭ</td><td>��</td><td>��</td><td>��</td><td>��</td>"
	Cal_HTML = Cal_HTML& "</tr>"

	For intLoopWeek = 1 To 6	'�ִ��� ���� ����, �ִ� 6��
		Cal_HTML = Cal_HTML & "<tr align=right valign=top bgcolor=white >"

		For intLoopDay = 1 To 7		'���ϴ��� ���� ����, �Ͽ��Ϻ���

			If intThirdWeekDay > 1 Then 'ù�ֽ������� 1���� ũ��
				Cal_HTML = Cal_HTML & "<td>&nbsp;</td>"
				intThirdWeekDay = intThirdWeekDay - 1
			Else
				If thirdPrintDay > intLastDay Then	'�Է³�¥�� ���� ������ ������ ũ��
					Cal_HTML=Cal_HTML& "<td>&nbsp;</td>"
				Else					'�Է³�¥�� ������� �ش�Ǹ�
					' ���� �Է��ʵ忡 ���ϵǴ� ��¥���� ������ �ٲٷ��� �Ʒ� ������ �����ϸ� �ȴ�!
					ResultStr = intThisYear & "-" & ConvStr(intThisMonth) & "-" & ConvStr(thirdPrintDay)
					Cal_HTML=Cal_HTML& "<td title='" & ResultStr & "' style='cursor: hand;border: 1px solid white;width:18; height:18;"
					
					If (intThisYear-NowThisYear=0) And (intThisMonth-NowThisMonth=0) And (thirdPrintDay-intThisDay=0) Then '���� ��¥�� ��Ʈ�� �ٸ���
						Cal_HTML = Cal_HTML & "background-color:"
					End If
					If intLoopDay=1 Then	'�Ͽ����̸� ���� ������
						Cal_HTML = Cal_HTML & "color:red;"
					Else ' �׿��� ���
						Cal_HTML = Cal_HTML & "color:black;"
					End If
					Cal_HTML = Cal_HTML & "'>" & thirdPrintDay
				End If
				thirdPrintDay = thirdPrintDay + 1	'��¥���� 1 ����
				If (thirdPrintDay > intLastDay) Then Stop_Flag = 1	'��¥���� �����Ϻ��� ũ�� ������ Ż��
			End If
			Cal_HTML = Cal_HTML & "</td>"
		Next
		Cal_HTML = Cal_HTML & "</tr>"
		
		If Stop_Flag = 1 Then Exit For	' �������� ������ ��������.
	Next
	Cal_HTML = Cal_HTML & "</table>"
	document.all.minical.innerHTML = Cal_HTML	'������� HTML�� ������ minical ���̾ ����
END Function
</script>

<div id="minical" onclick="this.style.display='none'" oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="datepicker" style="position:absolute;"></div>
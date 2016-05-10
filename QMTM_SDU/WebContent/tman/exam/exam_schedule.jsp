<%
//******************************************************************************
//   프로그램 : exam_schedule.jsp
//   모 듈 명 : 시험 일정표 관리 페이지
//   설    명 : 시험 일정표 관리 페이지
//   테 이 블 : exam_m
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamScheduleBean, 
//             qmtm.tman.exam.ExamSchedule, java.util.Date, java.util.Calendar
//   작 성 일 : 2010-06-01
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.ExamScheduleBean, qmtm.tman.exam.ExamSchedule, java.util.Date, java.util.Calendar" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	Calendar gCal = Calendar.getInstance();

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String years = request.getParameter("years");
	if (years == null) { years = ""; } else { years = years.trim(); }

	String months = request.getParameter("months");
	if (months == null) { months = ""; } else { months = months.trim(); }

	int year, month;
	
	if(years.length() > 0 && months.length() > 0) {
		gCal.setTime(new Date());
		year = Integer.parseInt(years);
	    month = Integer.parseInt(months);
		if(month > 9) {
			months = String.valueOf(month);
		} else {
			months = "0" + String.valueOf(month);
		}
	} else {
		year = gCal.get(Calendar.YEAR);;
		month = gCal.get(Calendar.MONTH)+1;
		if(month > 9) {
			months = String.valueOf(month);
		} else {
			months = "0" + String.valueOf(month);
		}
	}

	ExamScheduleBean[] rst = null;
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
	<script language="javascript">
		function exam_view(id_exam) {
			$.posterPopup("exam_view.jsp?id_exam="+id_exam,"exam_view","width=850, height=700, scrollbars=yes, top=0, left=0");
	    }

		function exam_list() {
			location.href="exam_ing_list.jsp";
		}

	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="exam_schedule.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">시험 일정표 </div>
			<div class="location">시험관리 > <span> 시험 일정표 </span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr height="25" id="bt3">
				<td style="font: bold 16px dotum; color: #0099CC;">[ <%=year%>년 <%=month%>월 ]</td>
				<td align="right">
					<select name="years">
					<% for(int i=2007; i<2020; i++) { %>
					<option value="<%=i%>" <% if(year == i) { %> selected <% } %>><%=i%></option>
					<% } %>
					</select> 년
					<select name="months">
					<% for(int j=1; j<13; j++) { %>
					<option value="<%=j%>" <% if(month == j) { %> selected <% } %>><%=j%></option>
					<% } %>
					</select> 월&nbsp;&nbsp;<input type="submit" value="확인하기" class="form5">&nbsp;&nbsp;<input type="button" value="리스트 보기" class="form5" onClick="exam_list();">
				</td>
			</tr>
		</table>

		<table border="0" cellpadding="1" cellspacing="1" width="100%" bgcolor="#F1F1E3" >
			<tr bgcolor="#FFFFFF" align="center" height="40" style="height: 40px; text-align: center; background-image:url(../../../images/t_bt_schedule_yj1.gif); background-repeat: repeat-x;">
			<% for( int j=0; j<7;j++) { %>
				<TD align='center' bgcolor="#D5D5D5" style="border-bottom: 1px solid #D5D5DB; font: bold 11px gulim; color: #666666; padding-top: 4px;"><%= getDayOfWeek(j)%></TD>
	        <% } %>
			</TR>
		</TABLE>
        
		<%  String [][]cal = getTable(year,month); %>

		<table border="0" cellpadding="1" cellspacing="1" width="100%" bgcolor="#cccccc">
		 <% 
			// Object [][]dat = get(Calendar.DATE);
			for( int i=0; i<cal.length;i++) {
		 %>
		    <tr bgcolor="#FFFFFF" align="center" height="65">
				<% for( int j=0; j<cal[i].length;j++) { %>
				<TD valign="top" align="left" width="14.3%">
					<table border="0">
						<%
							String days = "";

							if(cal[i][j].length() == 1) {
								days = "0" + cal[i][j];
							} else {
								days = cal[i][j];
							}

							try {
								rst = ExamSchedule.getBeans2(String.valueOf(year), months, days, userid);
							} catch(Exception ex) {
								out.println(ComLib.getExceptionMsg(ex, "back"));

							    if(true) return;
							}							
						%>
						<% if(rst == null) { %>
						<tr>
							<td><%= cal[i][j]%></td>
						</tr>
						<% 
							} else {								
						%>
								<tr>
									<td><%= cal[i][j]%></td>
								</tr>
						<%
								for(int k = 0; k < rst.length; k++) {

									int counts = 0;

									try {
										counts = ExamSchedule.getCounts(rst[k].getId_exam());
									} catch(Exception ex) {
										out.println(ComLib.getExceptionMsg(ex, "back"));

										if(true) return;
									}
						%>
								
								<tr>
									<td>* <a href="javascript:exam_view('<%=rst[k].getId_exam()%>');"><%=rst[k].getTitle()%><BR>&nbsp;&nbsp;<font color=red>(대상자 : <%=counts%>명)</font></a></td>
								</tr>
						<%
								}
							}
						%>
					</table>
				</TD>
			    <%}%>
	        <% }%>
		    </TR> 
		 </TABLE>
  
<%!  
	public static Object getDayOfWeek(int i)
    {
        return new Object[]{ "일", "월", "화", "수", "목", "금", "토" }[i];
    }
%>

<%! 
    public static String[][] getTable(int year, int month)
    {
        Calendar cal = Calendar.getInstance();
       int date = cal.get(Calendar.DATE);

        cal.set(year, month - 1, 1);

        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        int firstDay = cal.get(Calendar.DAY_OF_WEEK);
        String temp[][] = new String[6][7];
        int daycount = 1;
        for (int i = 0; i < 6; i++)
        {
            for (int j = 0; j < 7; j++)
            {
                if (firstDay - 1 > 0 || daycount > lastDay)
                {
                    temp[i][j] = "";
                    firstDay--;
                    continue;
                }
              
                else
                {
                    temp[i][j] = String.valueOf( daycount );
				}

                
                daycount++;
          }
      }
        
      return temp;
  }
%>
				

	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</form>

</html>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.util.Date, java.util.Calendar" %>

<% 
	Calendar gCal = Calendar.getInstance();
	gCal.setTime(new Date());
    int year = gCal.get(Calendar.YEAR);
    int month = gCal.get(Calendar.MONTH)+1;
	int date = gCal.get(Calendar.DATE);
%> 
 
 <html>   
    <BODY id="tman">
 <hr color='white'><br>
    <font size='5' face='굴림체'><b><center>
    Today:<%=year%> 년 <%= month%>월 <%= date%> 일 
 <br><hr color='white'><br></b></font>
 <TABLE border='0' bgcolor='D7FFD2' width=35% height=10%> <TR>     
<%    for( int j=0; j<7;j++)
        {%>
  <b>
  <TD align='center' >
        <%= getDayOfWeek(j)%> &nbsp;
        </TD>
  </font></b>
  
        <%}%></TR></TABLE>

        
        
<%        Object [][]cal = getTable(year,month);
   
%>
 <TABLE border='0' bgcolor='#FFF9E7' width=35% height=35%> 
    <%
  // Object [][]dat = get(Calendar.DATE);  
  for( int i=0; i<cal.length;i++) {%>
  <TR>  
        <% for( int j=0; j<cal[i].length;j++)  {
   
  %>

<TD align='center' >
     <%= cal[i][j]%>  
   </TD>
   
   <%}%>
        <% }%>
  </TR> 


     
 
 
 </TABLE>
  
  <%!  public static Object getDayOfWeek(int i)
    {
        return new Object[]{ "일", "월", "화", "수", "목", "금", "토" }[i];
    }
   %>

<%! 
    public static Object[][] getTable(int year, int month)
    {
        Calendar cal = Calendar.getInstance();
       int date = cal.get(Calendar.DATE);

        cal.set(year, month - 1, 1);

        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        int firstDay = cal.get(Calendar.DAY_OF_WEEK);
        Object temp[][] = new Object[6][7];
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
    }%>

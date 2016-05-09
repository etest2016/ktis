<%@ page contentType="text/html; charset=euc-kr"%>

<table width='235' class='menu' border='0' cellpadding='0' cellspacing='0' background='../images/bg_left.gif'>
  <tr>
    <td background='../images/bg_left_.gif' valign='top'>
	  <%  if((userid == null) || (userid == "")) { %>
	  <a href='../intro/guide.jsp' onfocus='this.blur()'><img src='../images/menu01.gif'></a><br>
	  <a href="javascript:alert('시험응시 로그인하셔야 이용할 수 있습니다.')" onfocus='this.blur()'><img src='../images/menu02.gif'></a><br>
	  <a href="javascript:alert('시험결과조회는 로그인하셔야 이용할 수 있습니다.')" onfocus='this.blur()'><img src='../images/menu03.gif'></a><br>	  
	  <% } else { %>
	  <img src='../images/menu01.gif' onclick="location.href('../intro/guide.jsp?userid=<%=userid%>&username=<%=username%>');" style="cursor: hand;"><br>
	  <img src='../images/menu02.gif' onclick="location.href('../exam/mytest.jsp?userid=<%=userid%>');" style="cursor: hand;"><br>
	  <img src='../images/menu03.gif' onclick="location.href('../score/myScore.jsp?userid=<%=userid%>');" style="cursor:hand;"><br>
	  <% } %>
	  <BR><BR><BR>
	</td>
  </tr>
</table>
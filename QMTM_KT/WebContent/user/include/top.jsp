<%@ page contentType="text/html; charset=euc-kr"%>
<%
	////////////////////////////////////////////////
	String username = request.getParameter("username");
	////////////////////////////////////////////////
%>
<script language="JavaScript">
<!--
   
function func_check()
{
   if ( document.fradate.userid.value == "" || document.fradate.userid.value == null )
   {
       alert('사용자 ID 를 입력하세요...')
       return;
   }
   if ( document.fradate.pwd.value == "" || document.fradate.pwd.value == null )
   {
       alert('Password 를 입력하세요...')
       return;
   }

document.fradate.action = '../login.jsp';
document.fradate.method = 'post';
document.fradate.submit();
}

//엔터키이벤트 채크하기.
document.onkeyup = nohome ; 
function nohome(e) 
{
	if (event.keyCode == 13) {
		func_check();
	}
}

//-->
</script>  

<table border='0' cellpadding='0' cellspacing='0' height='160' width='100%'>
	<tr>
		<td width='290' valign="top"><img src='../images/top01.jpg'></td>	
		<td width='690' style="background-image:url('../images/top02.jpg'); background-repeat: no-repeat;">

			<!--로그인 시작-->	  
			<form name="fradate">

			<!--  login ---------------------------------------->
			<%  if((userid == null) || (userid == "")) { %>

			<table border='0' cellpadding='0' cellspacing='0' class='login'>
				<tr>
					<td>아이디 :&nbsp;</td>
					<td><input type="text" name="userid" class="text-field" size="12" maxlength="13" value="">&nbsp;&nbsp;</td>
					<td>비밀번호 :&nbsp; </td>
					<td><input type="password" name="pwd" class="text-field" size="12" maxlength="13" onChange="javascript: func_check()"  value="">&nbsp;&nbsp;</td>
					<td>
						<a href="javascript: func_check()" onClick="return false"><img src='../images/bt_login.gif'></a>
						<!--<img src='../images/bt_find.gif'>
						<img src='../images/bt_join.gif'>-->
					</td>
				</tr>
			</table>  


			<% } else { %>

			<table border='0' cellpadding='0' cellspacing='0' class='login'>
				<tr>
					<td colspan='4' width='440'>[ <%=userid%> ] 님의 방문을 환영합니다. 좋은 결과가 있길 바랍니다.</td>
					<td>
						<a href='../logout.jsp'><img src='../images/bt_logout.gif'></a>
					</td>
				</tr>
			</table>

		<% } %>
		</form>
		  
		</td>
		<td width='*' style="background-image:url('../images/bg_top.jpg'); background-repeat: repeat-x;">&nbsp;</td>
	</tr>
</table>

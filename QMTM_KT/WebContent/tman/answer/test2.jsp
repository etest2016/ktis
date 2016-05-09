<html>

<head>
<script>

function go(ing,end){

  document.all.div1.style.width = (ing+1)/end*100+"%";
  document.all.div2.innerHTML = parseInt((ing+1)/end*100,10)+"%진행중";
 //ing+1 하는이유는 (ing+1)/end*100  =0 이되면 에러가 나기 때문
}

</script>

</head>
<!-- 상태진행바가 위치할 HTMl소스 -->

<BODY id="tman">

<Table width="500" height="50" border="1" >

<tr>

 <td>
  <div id ="div2" align="center" style="margin-top:10;width:100%;height:30px;color:#FF00FF;font-size:11px;"></div>
  <div id ="div1" style="whdth:0px;height:30px;background-color:#6666FF;"></div>

 </td>

</tr>

</table> 

<%

int start = 0;
int end   = 100;
for( int i = start ; i < end ; i ++ ) {

 out.println("<script>go("+i+","+end+")</script>");


 //상태진행바의 진행 로직을 실행하는부분
 Thread.sleep(20);
 //로직 끝

 out.flush() ;

}

%>

</body>

</html>

<html>

<head>
<script>

function go(ing,end){

  document.all.div1.style.width = (ing+1)/end*100+"%";
  document.all.div2.innerHTML = parseInt((ing+1)/end*100,10)+"%������";
 //ing+1 �ϴ������� (ing+1)/end*100  =0 �̵Ǹ� ������ ���� ����
}

</script>

</head>
<!-- ��������ٰ� ��ġ�� HTMl�ҽ� -->

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


 //����������� ���� ������ �����ϴºκ�
 Thread.sleep(20);
 //���� ��

 out.flush() ;

}

%>

</body>

</html>

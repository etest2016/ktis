
/*
	IE5.0 이상 에서 Button 의 onmouseover / onmouseout 시의 color / cursor 지정
	<BODY> Tag 의 마지막 부분에 포함 시켜야 함.
	각각의 Button 배경색은 TAG 내에서 style/class 등을 이용하여 조정한다.

	사용법 : </BODY> Tag 직전에
	<SCRIPT LANGUAGE=javascript SRC="../js_src/IE_Button.js"></SCRIPT>
	</BODY>
*/

function ButtonMouseOver()
{
  var obj = window.event.srcElement;
  if (obj.type == "button")
  {
      obj.style.color = "red";
      obj.style.cursor = "hand";
  }
}

function ButtonMouseOut()
{
  var obj = window.event.srcElement;
  if (obj.type == "button")
  {
      obj.style.color = "navy";
  }
}

// 아래의 코드는 Button 이 <INPUT> Tag 에서 선언된 다음에 와야 함.

var obj = document.all.tags("INPUT");

for (var i = 0; i < obj.length; i++)
{

  if (obj[i].type == "button")
  {

    obj[i].onmouseover = ButtonMouseOver;   // Not ButtonMouseOver()
    obj[i].onmouseout = ButtonMouseOut;     // Not ButtonMouseOut()

    obj[i].style.fontFamily = "굴림체";
		obj[i].style.fontWeight = "bold";
    obj[i].style.height = "20";

//	  obj[i].style.borderStyle = "ridge";		// groove, ridge, inset, outset

	  obj[i].style.borderStyle = "solid";
	  obj[i].style.borderColor = "navy";
    obj[i].style.borderWidth = "1";
  }
}


/*
	IE5.0 �̻� ���� Button �� onmouseover / onmouseout ���� color / cursor ����
	<BODY> Tag �� ������ �κп� ���� ���Ѿ� ��.
	������ Button ������ TAG ������ style/class ���� �̿��Ͽ� �����Ѵ�.

	���� : </BODY> Tag ������
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

// �Ʒ��� �ڵ�� Button �� <INPUT> Tag ���� ����� ������ �;� ��.

var obj = document.all.tags("INPUT");

for (var i = 0; i < obj.length; i++)
{

  if (obj[i].type == "button")
  {

    obj[i].onmouseover = ButtonMouseOver;   // Not ButtonMouseOver()
    obj[i].onmouseout = ButtonMouseOut;     // Not ButtonMouseOut()

    obj[i].style.fontFamily = "����ü";
		obj[i].style.fontWeight = "bold";
    obj[i].style.height = "20";

//	  obj[i].style.borderStyle = "ridge";		// groove, ridge, inset, outset

	  obj[i].style.borderStyle = "solid";
	  obj[i].style.borderColor = "navy";
    obj[i].style.borderWidth = "1";
  }
}

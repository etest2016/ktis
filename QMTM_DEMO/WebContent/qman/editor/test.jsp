<html>
<head>
<title>�˻�</title>
</head>
<script language="javascript">

  var r, re;                   //������ �����մϴ�.
  var s = " ( ����  1)  ������ tk ( ����2)  ������                           tk( ����  3)  ������        tk ( ����  4)  ������ tk( ����   5) ������ tk";

  var c1 = "(";
  var c2 = "����";
  var c3 = ")";  

  var blanks = "\s*";
  
  re = c1+blanks+c2+blanks+c3;   

  var str1 = c1+c2+c3;

  var str2 = "����";

  s = aaa(str1,str2);
  
  function balnk_remove(str1,str2) {

	var str = "";

	str = s.replace(eval("/" +str1+ " /gi"), str2);  
	str = str.replace(eval("/" +str1+ "  /gi"), str2);  
	str = str.replace(eval("/" +str1+ "   /gi"), str2);  

	str = str.replace(eval("/ " +str1+ "/gi"), str2);  
    str = str.replace(eval("/ " +str1+ " /gi"), str2);  
    str = str.replace(eval("/ " +str1+ "  /gi"), str2);  
	str = str.replace(eval("/ " +str1+ "   /gi"), str2);  

    str = str.replace(eval("/  " +str1+ "/gi"), str2);
	str = str.replace(eval("/  " +str1+ " /gi"), str2);  
    str = str.replace(eval("/  " +str1+ "  /gi"), str2);
	str = str.replace(eval("/  " +str1+ "   /gi"), str2);

	str = str.replace(eval("/   " +str1+ "/gi"), str2);
	str = str.replace(eval("/   " +str1+ " /gi"), str2);
	str = str.replace(eval("/   " +str1+ "  /gi"), str2);
	str = str.replace(eval("/   " +str1+ "   /gi"), str2);

	return str;
  }
  
  alert(s);

  String.prototype.trim = function()
  {
	  return this.replace(/(^\s*)|(\s*$)/g, "");
  }

  //}

</script>
<body>


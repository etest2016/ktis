<html>
<head>
<title>검색</title>
</head>
<script language="javascript">

  var r, re;                   //변수를 선언합니다.
  var s = " ( 문제  1)  가나다 tk ( 문제2)  가나다                           tk( 문제  3)  가나다        tk ( 문제  4)  가나다 tk( 문제   5) 가나다 tk";

  var c1 = "(";
  var c2 = "문제";
  var c3 = ")";  

  var blanks = "\s*";
  
  re = c1+blanks+c2+blanks+c3;   

  var str1 = c1+c2+c3;

  var str2 = "문제";

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


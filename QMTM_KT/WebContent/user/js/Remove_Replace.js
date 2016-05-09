
// ��� ������ ����

function Remove_Spaces(argStr) {
  while (argStr.indexOf(" ") >= 0) {argStr = argStr.replace(" ", "");}
  return argStr;
}


// L_Trim : Remove Leading Spaces

function L_Trim(argStr) {
  while (argStr.indexOf(" ") == 0) {argStr = argStr.replace(" ", "");}    
  return argStr;  
}


// R_Trim : Remove Trailing Spaces

function R_Trim(argStr) {
  var intPos = argStr.length;
  while (argStr.indexOf(" ", intPos - 1) == intPos - 1) {intPos--;}  
  return argStr.substring(0, intPos);  
}


// LR_Trim : Remove Leading and Trailing Spaces

function LR_Trim(argStr) {
  return R_Trim(L_Trim(argStr));
}


// ��� ���ڸ� ġȯ
// ���� : ��� ',' �� ' ' �� ġȯ : Replace("a,bc,def", ",", " ") --> returns "a bc def"

function Replace_Chars(argStr, char1, char2) {
  while (argStr.indexOf(char1) >= 0) {argStr = argStr.replace(char1, char2);}
  return argStr;
}

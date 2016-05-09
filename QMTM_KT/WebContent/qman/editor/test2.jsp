var str: String = "You can store a wide (variety) of data types in an (array) element, (including) numbers, strings, objects, and even other arrays.";  

var pattern: RegExp = /(?<=\().*?(?=\))/g;  

findAry = str.match( pattern );  

trace( "reslut :", findAry );// reslut : variety,array,including 


var price: String = "jean = $300 computer = $5,000";  

findAry = findStr( price, "$", " " );  

trace( "reslut :", findAry );// reslut : 300,5,000  

var pattern2: RegExp = /(?<=\$)[0-9,]+/g;  

findAry = price.match( pattern2 );  

trace( "reslut :", findAry );// reslut : 300,5,000 

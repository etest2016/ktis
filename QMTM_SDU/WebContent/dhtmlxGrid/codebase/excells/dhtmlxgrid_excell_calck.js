//v.3.6 build 131108

/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
To use this component please contact sales@dhtmlx.com to obtain license
*/
document.write("<link rel='stylesheet' type='text/css' href='"+_css_prefix+"excells/dhtmlxgrid_calc.css'></link>");
function eXcell_calck(d){try{this.cell=d,this.grid=this.cell.parentNode.grid}catch(f){}this.edit=function(){this.val=this.getValue();var d=this.grid.getPosition(this.cell);this.obj=new calcX(d[0],d[1]+this.cell.offsetHeight,this,this.val)};this.getValue=function(){return this.grid._aplNFb(this.cell.innerHTML.toString()._dhx_trim(),this.cell._cellIndex)};this.detach=function(){this.obj&&(this.setValue(this.obj.inputZone.value),this.obj.removeSelf());this.obj=null;return this.val!=this.getValue()}}
eXcell_calck.prototype=new eXcell;eXcell_calck.prototype.setValue=function(d){if(!d||d.toString()._dhx_trim()=="")d="0";this.setCValue(this.grid._aplNF(d,this.cell._cellIndex),d)};
function calcX(d,f,g,e){this.top=f||0;this.left=d||0;this.onReturnSub=g||null;this.operandB=this.operandA=0;this.operatorA="";this.dotState=this.state=0;this.calckGo=function(){return eval(this.operandA+"*1"+this.operatorA+this.operandB+"*1")};this.isNumeric=function(a){return a.search(/[^1234567890]/gi)==-1?!0:!1};this.isOperation=function(a){return a.search(/[^\+\*\-\/]/gi)==-1?!0:!1};this.onCalcKey=function(a){that=this.calk;var b=this.innerHTML,c=that.inputZone;if((that.state==0||that.state==
2)&&that.isNumeric(b))c.value!="0"?c.value+=b:c.value=b;if((that.state==0||that.state==2)&&b=="."&&that.dotState==0)that.dotState=1,c.value+=b;if(b=="C")c.value=0,that.dotState=0,that.state=0;if(that.state==0&&that.isOperation(b))that.operatorA=b,that.operandA=c.value,that.state=1;if(that.state==2&&that.isOperation(b))that.operandB=c.value,c.value=that.calckGo(),that.operatorA=b,that.operandA=c.value,that.state=1;if(that.state==2&&b=="=")that.operandB=c.value,c.value=that.calckGo(),that.operatorA=
b,that.operandA=c.value,that.state=3;if(that.state==1&&that.isNumeric(b))c.value=b,that.state=2,that.dotState=0;if(that.state==3&&that.isNumeric(b))c.value=b,that.state=0;if(that.state==3&&that.isOperation(b))that.operatorA=b,that.operandA=c.value,that.state=1;if(b=="e"){c.value=Math.E;if(that.state==1)that.state=2;that.dotState=0}if(b=="p"){c.value=Math.PI;if(that.state==1)that.state=2;that.dotState=0}b=="Off"&&that.topNod.parentNode.removeChild(that.topNod);if(a||event)(a||event).cancelBubble=!0};
this.sendResult=function(){that=this.calk;if(that.state==2){var a=that.inputZone;that.operandB=a.value;a.value=that.calckGo();that.operatorA=b;that.operandA=a.value;that.state=3}var b=that.inputZone.value;that.topNod.parentNode.removeChild(that.topNod);that.onReturnSub.grid.editStop(!1)};this.removeSelf=function(){this.topNod.parentNode&&this.topNod.parentNode.removeChild(this.topNod)};this.keyDown=function(){this.className="calcPressed"};this.keyUp=function(){this.className="calcButton"};this.init_table=
function(){var a=this.topNod.childNodes[0];if(a&&a.tagName=="TABLE"){for(i=1;i<a.childNodes[0].childNodes.length;i++)for(j=0;j<a.childNodes[0].childNodes[i].childNodes.length;j++)a.childNodes[0].childNodes[i].childNodes[j].onclick=this.onCalcKey,a.childNodes[0].childNodes[i].childNodes[j].onmousedown=this.keyDown,a.childNodes[0].childNodes[i].childNodes[j].onmouseout=this.keyUp,a.childNodes[0].childNodes[i].childNodes[j].onmouseup=this.keyUp,a.childNodes[0].childNodes[i].childNodes[j].calk=this;this.inputZone=
this.topNod.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0];this.onReturnSub?(this.topNod.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].onclick=this.sendResult,this.topNod.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].calk=this):this.topNod.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].innerHTML=
""}};this.drawSelf=function(){var a=document.createElement("div");a.className="calcTable";a.style.position="absolute";a.style.top=this.top+"px";a.style.left=this.left+"px";a.innerHTML="<table cellspacing='0' id='calc_01' class='calcTable'><tr><td colspan='4'><table cellpadding='1' cellspacing='0' width='100%'><tr><td width='100%' style='overflow:hidden;'><input style='width:100%' class='calcInput' value='0' align='right' readonly='true' style='text-align:right'></td><td class='calkSubmit'>=</td></tr></table></td></tr><tr><td class='calcButton' width='25%'>Off</td><td class='calcButton' width='25%'>p</td><td class='calcButton' width='25%'>e</td><td class='calcButton' width='25%'>/</td></tr><tr><td class='calcButton'>7</td><td class='calcButton'>8</td><td class='calcButton'>9</td><td class='calcButton'>*</td></tr><tr><td class='calcButton'>4</td><td class='calcButton'>5</td><td class='calcButton'>6</td><td class='calcButton'>+</td></tr><tr><td class='calcButton'>1</td><td class='calcButton'>2</td><td class='calcButton'>3</td><td class='calcButton'>-</td></tr><tr><td class='calcButton'>0</td><td class='calcButton'>.</td><td class='calcButton'>C</td><td class='calcButton'>=</td></tr></table>";
a.onclick=function(a){(a||event).cancelBubble=!0};document.body.appendChild(a);this.topNod=a};this.drawSelf();this.init_table();if(e){var h=this.inputZone;h.value=e*1;this.operandA=e*1;this.state=3}return this};

//v.3.6 build 131108

/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
To use this component please contact sales@dhtmlx.com to obtain license
*/
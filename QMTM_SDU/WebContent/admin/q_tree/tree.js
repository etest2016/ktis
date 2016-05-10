/**************************************************************************
	JavaScript Tree - www.destroydrop.com/hjavascripts/tree/
	Version 0.96	

	This script can be used freely as long as all copyright messages are
	intact.
**************************************************************************/

// Arrays for nodes and icons
var nodes			= new Array();;
var openNodes	= new Array();
var icons			= new Array(6);

// Loads all icons that are used in the tree
function preloadIcons() {
	icons[0] = new Image();
	icons[0].src = "../../images/plus.gif";
	icons[1] = new Image();
	icons[1].src = "../../images/plusbottom.gif";
	icons[2] = new Image();
	icons[2].src = "../../images/minus.gif";
	icons[3] = new Image();
	icons[3].src = "../../images/minusbottom.gif";
	icons[4] = new Image();
	icons[4].src = "../../images/folder.gif";
	icons[5] = new Image();
	icons[5].src = "../../images/folderopen.gif";
	icons[6] = new Image();
	icons[6].src = "../../images/folder.gif";
	icons[7] = new Image();
	icons[7].src = "../../images/folderopen.gif";
	icons[8] = new Image();
	icons[8].src = "../../images/folder4.gif";
	icons[9] = new Image();
	icons[9].src = "../../images/folder4open.gif";
} 
// Create the tree
function createTree(arrName, startNode, openNode) {
	nodes = arrName;
	if (nodes.length > 0) {
		preloadIcons();
		if (startNode == null) startNode = 0;
		if (openNode != 0 || openNode != null) setOpenNodes(openNode);
	
		if (startNode !=0) {
			var nodeValues = nodes[getArrayId(startNode)].split("|");			
			if(nodeValues[4] == "S1") {
				document.write("<a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src=\"../../images/folderopen.gif\" align=\"absbottom\" alt=\"\" />" + nodeValues[2] + "</a><br />");
			} else {
				document.write("<a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src=\"../../images/folder4open.gif\" align=\"absbottom\" alt=\"\" />" + nodeValues[2] + "</a><br />");
			}
			//alert("<a href=\"" + nodeValues[3] + "\" target=\"fraMain\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");
		} else document.write("<img src=\"../../images/base.gif\" align=\"absbottom\" alt=\"\" /><a href=\"f_main.jsp\" target=\"fraMain\" />카테고리 조회</a><br />");
	
		var recursedNodes = new Array();
		addNode(startNode, recursedNodes);
	}
}
// Returns the position of a node in the array
function getArrayId(node) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==node) return i;
	}
}
// Puts in array nodes that will be open
function setOpenNodes(openNode) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==openNode) {
			openNodes.push(nodeValues[0]);
			setOpenNodes(nodeValues[1]);
		}
	} 
}
// Checks if a node is open
function isNodeOpen(node) {
	for (i=0; i<openNodes.length; i++)
		if (openNodes[i]==node) return true;
	return false;
}
// Checks if a node has any children
function hasChildNode(parentNode) {
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) return true;
	}
	return false;
}
// Checks if a node is the last sibling
function lastSibling (node, parentNode) {
	var lastChild = 0;
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode)
			lastChild = nodeValues[0];
	}
	if (lastChild==node) return true;
	return false;
}
// Adds a new node to the tree
function addNode(parentNode, recursedNodes) {	
	for (var i = 0; i < nodes.length; i++) {
		
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) {
			
			var ls	= lastSibling(nodeValues[0], nodeValues[1]);
			var hcn	= hasChildNode(nodeValues[0]);
			var ino = isNodeOpen(nodeValues[0]);

			// Write out line & empty icons
			for (g=0; g<recursedNodes.length; g++) {
				if (recursedNodes[g] == 1) document.write("<img src=\"../../images/line.gif\" align=\"absbottom\" alt=\"\" />");
				else  document.write("<img src=\"../../images/empty.gif\" align=\"absbottom\" alt=\"\" />");
			}

			// put in array line & empty icons
			if (ls) recursedNodes.push(0);
			else recursedNodes.push(1);

			// Write out join icons
			if (hcn) {
				if (ls) {
					document.write("<a href=\"javascript: oc('" + nodeValues[0] + "', 1, '" + nodeValues[4] + "');\"><img id=\"join" + nodeValues[0] + "\" src=\"../../images/");
					 	if (ino) document.write("minus");
						else document.write("plus");
					document.write("bottom.gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
				} else {
					document.write("<a href=\"javascript: oc('" + nodeValues[0] + "', 0, '" + nodeValues[4] + "');\"><img id=\"join" + nodeValues[0] + "\" src=\"../../images/");
						if (ino) document.write("minus");
						else document.write("plus");
					document.write(".gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
				}
			} else {
				if (ls) document.write("<img src=\"../../images/joinbottom.gif\" align=\"absbottom\" alt=\"\" />");
				else document.write("<img src=\"../../images/join.gif\" align=\"absbottom\" alt=\"\" />");
			}

			// Start link
			document.write("<a href=\"" + nodeValues[3] + "\" target=\"fraMain\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");
			
			// Write out folder & page icons
			if (hcn) {
				if(nodeValues[4] == "S1") {
					document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../../images/folder")
				} else {
					document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../../images/folder4")
				}
					if (ino) document.write("open");
				document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
			} else {
				if(nodeValues[4] == "S1") {
					document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../../images/folder.gif\" align=\"absbottom\" alt=\"Folder\" />");
				} else {
					document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../../images/folder4.gif\" align=\"absbottom\" alt=\"Folder\" />");
				}				
			}
			
			// Write out node name
			document.write(nodeValues[2]);

			// End link
			document.write("</a><br />");
			
			// If node has children write out divs and go deeper
			if (hcn) {
				document.write("<div id=\"div" + nodeValues[0] + "\"");
					if (!ino) document.write(" style=\"display: none;\"");
				document.write(">");
				addNode(nodeValues[0], recursedNodes);
				document.write("</div>");
			}
			
			// remove last line or empty icon 
			recursedNodes.pop();
		}
	}
}
// Opens or closes a node
function oc(node, bottom, values) {
	var theDiv = document.getElementById("div" + node);

	if(theDiv == null) {
		return;
	}

	var theJoin	= document.getElementById("join" + node);
	var theIcon = document.getElementById("icon" + node);
	
	if (theDiv.style.display == 'none') {
		if (bottom==1) theJoin.src = icons[3].src;
		else theJoin.src = icons[2].src;

		if(values == "S1") {
			theIcon.src = icons[7].src;
		} else {
			theIcon.src = icons[9].src;
		}
		
		theDiv.style.display = '';
	} else {
		if (bottom==1) theJoin.src = icons[1].src;
		else theJoin.src = icons[0].src;

		if(values == "S1") {
			theIcon.src = icons[6].src;
		} else {
			theIcon.src = icons[8].src;
		}

		theDiv.style.display = 'none';
	}
}
// Push and pop not implemented in IE
if(!Array.prototype.push) {
	function array_push() {
		for(var i=0;i<arguments.length;i++)
			this[this.length]=arguments[i];
		return this.length;
	}
	Array.prototype.push = array_push;
}
if(!Array.prototype.pop) {
	function array_pop(){
		lastElement = this[this.length-1];
		this.length = Math.max(this.length-1,0);
		return lastElement;
	}
	Array.prototype.pop = array_pop;
}

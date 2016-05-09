package qmtm.qman;

import java.io.*;
import org.htmlparser.*;
import org.htmlparser.lexer.*;
import org.htmlparser.nodes.*;

public class HtmlParser {

	public static String html_parser(String src, String img_path) {		

		StringBuffer html_src = new StringBuffer();
		
		html_src.append(src);

		StringBuffer src_res = new StringBuffer();

		try
		{
			Parser p = new Parser();
			
			p.setInputHTML(html_src.toString());

			Lexer lexer = p.getLexer();

			Node node = lexer.nextNode();

			while((node = lexer.nextNode()) != null)
		    {
			
				if(node instanceof TagNode)
				{
					 String isClosed = "";
				     TagNode tag = (TagNode)node;
					 if(tag.isEndTag()) isClosed = "/";

				     if(tag.getText().indexOf("IMG") != -1) {
						src_res.append(tag.toHtml());
					 }

					 if(tag.getText().indexOf("TABLE") != -1) {
						src_res.append(tag.toHtml());
					 }

					 if(tag.getText().indexOf("TR") != -1) {
						src_res.append(tag.toHtml());
					 }

					 if(tag.getText().indexOf("TD") != -1) {
						src_res.append(tag.toHtml());
					 }

					 if(tag.getText().indexOf("/TABLE") != -1) {
						src_res.append(tag.toHtml());
					 }
					 
					 if(tag.toHtml().indexOf("</P") != -1) {
						src_res.append(tag.toHtml());
					 }					 					 
					 
					 if(tag.toHtml().indexOf("<embed") != -1) {
						src_res.append(tag.toHtml());
					 }					 					

					 if(tag.getText().indexOf("o:title") != -1) {
						if(tag.getText().indexOf(".gif") != -1) {
							src_res.append("<img src=" + tag.getText().substring(tag.getText().indexOf(img_path),tag.getText().lastIndexOf(".gif")) + ".gif>");
						} else if(tag.getText().indexOf(".png") != -1) {
							src_res.append("<img src=" + tag.getText().substring(tag.getText().indexOf(img_path),tag.getText().lastIndexOf(".png")) + ".png>");
						} else if(tag.getText().indexOf(".jpg") != -1) {
							src_res.append("<img src=" + tag.getText().substring(tag.getText().indexOf(img_path),tag.getText().lastIndexOf(".jpg")) + ".jpg>");
						}
						//src_res.append("<img src=" + img_path + "/" + tag.getText().substring(20,35) + ".gif>");
					 }
				}
				else if(node instanceof TextNode)
			    {
					 TextNode txNode = (TextNode)node;
					 src_res.append(txNode.getText());
			    }
			}
			
		} catch(Exception ex) {
			ex.getMessage();
		}

		return src_res.toString();
	}
}
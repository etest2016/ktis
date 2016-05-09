package etest.scorehelp;

import java.sql.*;
import java.util.*;

public class Score_a
{
    public Score_a() {
	}

	public static void run_init() {
		String a = "1{:}2{:}3{:}2{:}2{:}1{:}3{|}1{:}그리이스 {:}{:}";
		System.out.println(a.replace("{:}", "xxxx"));
		String[] x = splitString(a, "{:}");

		System.out.println(x[0]);
		System.out.println(join(x, "{x}"));
	}


	public static String[] splitString(String pStr, String pDelim) {
		if (pStr == null || pStr.length() == 0 || pDelim == null || pDelim.length() == 0)
		{
			return null;
		}

		ArrayList tokens = new ArrayList();
		int idx = -1;
		int lastIndex = 0;
		idx = pStr.indexOf(pDelim);
		while (idx >= 0)
		{
			tokens.add(pStr.substring(lastIndex, idx));
			lastIndex = idx + pDelim.length();
			idx = pStr.indexOf(pDelim, lastIndex+1);
		}

		tokens.add(pStr.substring(lastIndex));
		return (String[])tokens.toArray(new String[tokens.size()]);
	}
}
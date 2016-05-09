package etest;

import java.sql.Timestamp;

public class User_CJH
{
    public static final String FD = "│";   // field 구분자   : ㅂ --> 한자 --> 4 of page 2
    public static final String RD = "┃";   // record 구분자  : ㅂ --> 한자 --> 2 of page 1

    public User_CJH() {
    }

    public static boolean isNowBetween(Timestamp from, Timestamp to)
    {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if (from != null && to != null && now.after(from) && now.before(to)) { return true; }
        else { return false; }
    }

    public static boolean isNowAfter(Timestamp from)
    {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if (from != null && now.after(from)) { return true; }
        else { return false; }
    }

    public static boolean isNowBefore(Timestamp to)
    {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if (to != null && now.before(to)) { return true; }
        else { return false; }
    }
    
}
